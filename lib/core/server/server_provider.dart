import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:relic/relic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spectra/core/server/handlers/static_handler.dart';
import 'package:spectra/core/server/middleware/cors_middleware.dart';
import 'package:spectra/core/server/routes/rules_routes.dart';
import 'package:spectra/core/server/routes/server_routes.dart';
import 'package:spectra/shared/providers/talker_provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:web_socket/web_socket.dart';

part 'server_provider.g.dart';

/// 服务器状态信息。
class ServerStatus {
  /// 创建服务器状态。
  const ServerStatus({
    required this.isRunning,
    required this.port,
    this.url,
  });

  /// 服务器当前是否正在运行。
  final bool isRunning;

  /// 服务器运行的端口。
  final int port;

  /// 访问服务器的 URL。
  final String? url;

  /// 复制并更新值。
  ServerStatus copyWith({
    bool? isRunning,
    int? port,
    String? url,
  }) {
    return ServerStatus(
      isRunning: isRunning ?? this.isRunning,
      port: port ?? this.port,
      url: url ?? this.url,
    );
  }
}

/// HTTP 服务器 Provider。
@riverpod
class Server extends _$Server {
  RelicServer? _server;
  final Set<RelicWebSocket> _webSocketConnections = {};
  int _port = 8080;
  Talker? _talker;

  @override
  ServerStatus build() {
    _talker = ref.read(talkerProvider);
    return const ServerStatus(
      isRunning: false,
      port: 8080,
    );
  }

  /// 启动 HTTP 服务器。
  Future<void> start({int? port}) async {
    if (_server != null) {
      return; // 已在运行
    }

    _port = port ?? await _findAvailablePort();

    try {
      final app = _createApp();
      _server = await app.serve(
        address: InternetAddress.anyIPv4,
        port: _port,
      );

      state = ServerStatus(
        isRunning: true,
        port: _port,
        url: 'http://localhost:$_port',
      );

      _talker?.info('Server running at http://localhost:$_port');
    } catch (e, st) {
      _talker?.error('Failed to start server', e, st);
      rethrow;
    }
  }

  /// 停止 HTTP 服务器。
  Future<void> stop() async {
    if (_server == null) {
      return; // 未在运行
    }

    // 关闭所有 WebSocket 连接
    for (final ws in _webSocketConnections) {
      await ws.close();
    }
    _webSocketConnections.clear();

    await _server?.close();
    _server = null;

    state = ServerStatus(
      isRunning: false,
      port: _port,
    );

    _talker?.info('Server stopped');
  }

  /// 检查服务器是否正在运行。
  bool get isRunning => _server != null;

  /// 获取当前端口。
  int get currentPort => _port;

  /// 查找可用端口。
  Future<int> _findAvailablePort() async {
    final socket = await ServerSocket.bind(InternetAddress.anyIPv4, 0);
    final port = socket.port;
    await socket.close();
    return port;
  }

  /// 创建 Relic 应用。
  RelicApp _createApp() {
    final rulesRoutes = RulesRoutes();
    final serverRoutes = ServerRoutes(
      isRunning: () => isRunning,
      port: () => currentPort,
      onStart: start,
      onStop: stop,
    );

    // 为编辑器创建静态文件处理器
    final projectPath = Directory.current.path;
    final editorPath = '$projectPath/assets/editor';
    final staticHandler = editorAssetsExist(projectPath)
        ? createEditorStaticHandler(editorPath)
        : (request) => Response.notFound(
            body: Body.fromString('Editor not built'),
          );

    final app = RelicApp()
      // 添加中间件
      ..use('/', _logMiddleware)
      ..use('/', _errorMiddleware)
      ..use('/', corsMiddleware())
      // WebSocket 路由
      ..get('/ws', _handleWebSocket)
      // API 路由
      ..attach('/api/server', serverRoutes.router)
      ..attach('/api', rulesRoutes.router)
      // 静态文件（编辑器）
      ..fallback = staticHandler;

    return app;
  }

  /// WebSocket 处理器。
  Result _handleWebSocket(Request request) {
    return WebSocketUpgrade((webSocket) async {
      _webSocketConnections.add(webSocket);
      _talker?.debug(
        'WebSocket connected, total: ${_webSocketConnections.length}',
      );

      try {
        webSocket.sendText(jsonEncode({'type': 'connected'}));

        await for (final event in webSocket.events) {
          if (event is TextDataReceived) {
            _handleWebSocketMessage(webSocket, event.text);
          }
        }
      } on Exception catch (e, st) {
        _talker?.error('WebSocket error', e, st);
      } finally {
        _webSocketConnections.remove(webSocket);
        _talker?.debug(
          'WebSocket disconnected, total: ${_webSocketConnections.length}',
        );
      }
    });
  }

  /// 处理 WebSocket 消息。
  void _handleWebSocketMessage(RelicWebSocket sender, String message) {
    try {
      final data = jsonDecode(message) as Map<String, dynamic>;
      final type = data['type'] as String?;
      final payload = data['data'];

      switch (type) {
        case 'element_selected':
          // 向所有客户端广播元素选择
          _broadcast(
            jsonEncode({
              'type': 'element_selected',
              'data': payload,
            }),
          );

        case 'preview_request':
          // 处理预览请求
          _handlePreviewRequest(sender, payload as Map<String, dynamic>?);

        case 'ping':
          sender.sendText(jsonEncode({'type': 'pong'}));

        default:
          _talker?.warning('Unknown WebSocket message type: $type');
      }
    } on Exception catch (e, st) {
      _talker?.error('Error handling WebSocket message', e, st);
    }
  }

  /// 处理预览请求。
  void _handlePreviewRequest(
    RelicWebSocket sender,
    Map<String, dynamic>? payload,
  ) {
    if (payload == null) return;

    final url = payload['url'] as String?;
    if (url == null) return;

    sender.sendText(
      jsonEncode({
        'type': 'preview_response',
        'data': {
          'status': 'accepted',
          'url': url,
        },
      }),
    );
  }

  /// 向所有客户端广播消息。
  void _broadcast(String message) {
    for (final ws in _webSocketConnections) {
      ws.sendText(message);
    }
  }

  /// 日志中间件 - 记录所有请求。
  Middleware get _logMiddleware {
    return (Handler innerHandler) {
      return (Request request) async {
        final stopwatch = Stopwatch()..start();
        final result = await innerHandler(request);
        stopwatch.stop();

        final statusCode = switch (result) {
          final Response r => r.statusCode,
          _ => 0,
        };

        _talker?.debug(
          '${request.method.name} ${request.url.path} '
          '$statusCode ${stopwatch.elapsedMilliseconds}ms',
        );

        return result;
      };
    };
  }

  /// 错误处理中间件。
  Middleware get _errorMiddleware {
    return (Handler innerHandler) {
      return (Request request) async {
        try {
          return await innerHandler(request);
        } on Exception catch (e, st) {
          _talker?.error('Error handling request', e, st);
          return Response.internalServerError(
            body: Body.fromString(
              jsonEncode({
                'error': 'Internal server error',
                'message': e.toString(),
              }),
              mimeType: MimeType.json,
            ),
          );
        }
      };
    };
  }
}
