import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:relic/relic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spectra/core/database/drift/app_database.dart';
import 'package:spectra/core/server/handlers/static_handler.dart';
import 'package:spectra/core/server/middleware/cors_middleware.dart';
import 'package:spectra/core/server/routes/preview_routes.dart';
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
  final Map<RelicWebSocket, _WebSocketClientState> _webSocketConnections = {};
  final List<_BufferedWsMessage> _recentWsMessages = [];
  final Map<String, _PreviewSession> _previewSessions = {};
  late final AppDatabase _database = _databaseFactory();
  final String _serverToken = _generateServerToken();
  int _port = 8080;
  Talker? _talker;

  static const int _protocolVersion = 1;
  static const int _maxBufferedWsMessages = 128;
  static AppDatabase Function() _databaseFactory = AppDatabase.new;

  /// 设置测试用数据库工厂。
  @visibleForTesting
  static AppDatabase Function() get debugDatabaseFactory => _databaseFactory;

  /// 设置测试用数据库工厂。
  @visibleForTesting
  static set debugDatabaseFactory(AppDatabase Function() factory) {
    _databaseFactory = factory;
  }

  @override
  ServerStatus build() {
    _talker = ref.read(talkerProvider);
    ref.onDispose(() {
      unawaited(stop());
      unawaited(_database.close());
    });
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
    for (final ws in _webSocketConnections.keys.toList()) {
      await ws.close();
    }
    _webSocketConnections.clear();

    await _server?.close();
    _server = null;

    if (ref.mounted) {
      state = ServerStatus(
        isRunning: false,
        port: _port,
      );
    }

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
    final serverRoutes = ServerRoutes(
      isRunning: () => isRunning,
      port: () => currentPort,
      serverToken: () => _serverToken,
      onStart: start,
      onStop: stop,
    );
    final rulesRoutes = RulesRoutes(
      database: _database,
      serverToken: () => _serverToken,
      publishWsMessage: _publishWsMessage,
    );
    final previewRoutes = PreviewRoutes(
      serverToken: () => _serverToken,
      openPreview: _openPreviewSession,
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
      ..attach('/api/preview', previewRoutes.router)
      ..attach('/api/rules', rulesRoutes.router)
      // 静态文件（编辑器）
      ..fallback = staticHandler;

    return app;
  }

  /// WebSocket 处理器。
  Result _handleWebSocket(Request request) {
    return WebSocketUpgrade((webSocket) async {
      _webSocketConnections[webSocket] = _WebSocketClientState();
      _talker?.debug(
        'WebSocket connected, total: ${_webSocketConnections.length}',
      );

      try {
        webSocket.sendText(
          jsonEncode({'v': _protocolVersion, 'type': 'connected'}),
        );

        await for (final event in webSocket.events) {
          if (event is TextDataReceived) {
            await _handleWebSocketMessage(webSocket, event.text);
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
  Future<void> _handleWebSocketMessage(
    RelicWebSocket sender,
    String message,
  ) async {
    try {
      final data = jsonDecode(message) as Map<String, dynamic>;
      final version = data['v'];
      if (version != null && version != _protocolVersion) {
        sender.sendText(
          jsonEncode({
            'v': _protocolVersion,
            'type': 'error',
            'data': {
              'code': 'unsupported_version',
              'message': '仅支持 WebSocket 协议版本 1',
            },
          }),
        );
        await sender.close();
        return;
      }

      final type = data['type'] as String?;
      final payload = data['data'] as Map<String, dynamic>?;
      final clientState = _webSocketConnections[sender];
      if (clientState == null) {
        return;
      }

      switch (type) {
        case 'auth':
          final token = payload?['token'];
          if (token is! String || token != _serverToken) {
            sender.sendText(
              jsonEncode({
                'v': _protocolVersion,
                'type': 'error',
                'data': {
                  'code': 'unauthorized',
                  'message': '缺少或无效的 serverToken',
                },
              }),
            );
            await sender.close();
            return;
          }

          clientState.isAuthenticated = true;
          sender.sendText(
            jsonEncode({'v': _protocolVersion, 'type': 'auth_ok'}),
          );

        case 'subscribe':
          if (!clientState.isAuthenticated) {
            await _closeForUnauthorizedMessage(sender);
            return;
          }

          final filter = _WebSocketSubscription.fromPayload(payload);
          if (filter == null) {
            sender.sendText(
              jsonEncode({
                'v': _protocolVersion,
                'type': 'error',
                'data': {
                  'code': 'bad_request',
                  'message': '订阅过滤器必须是对象',
                },
              }),
            );
            return;
          }

          clientState.subscriptions.add(filter);
          sender.sendText(
            jsonEncode({
              'v': _protocolVersion,
              'type': 'subscribed',
              'data': filter.toJson(),
            }),
          );
          _replayBufferedMessages(sender, filter);

        case 'unsubscribe':
          if (!clientState.isAuthenticated) {
            await _closeForUnauthorizedMessage(sender);
            return;
          }

          final filter = _WebSocketSubscription.fromPayload(payload);
          if (filter == null) {
            sender.sendText(
              jsonEncode({
                'v': _protocolVersion,
                'type': 'error',
                'data': {
                  'code': 'bad_request',
                  'message': '取消订阅过滤器必须是对象',
                },
              }),
            );
            return;
          }

          clientState.subscriptions.remove(filter);
          sender.sendText(
            jsonEncode({
              'v': _protocolVersion,
              'type': 'unsubscribed',
              'data': filter.toJson(),
            }),
          );

        case 'ping':
          sender.sendText(
            jsonEncode({'v': _protocolVersion, 'type': 'pong'}),
          );

        default:
          _talker?.warning('Unknown WebSocket message type: $type');
      }
    } on Exception catch (e, st) {
      _talker?.error('Error handling WebSocket message', e, st);
    }
  }

  Future<void> _closeForUnauthorizedMessage(RelicWebSocket socket) async {
    socket.sendText(
      jsonEncode({
        'v': _protocolVersion,
        'type': 'error',
        'data': {
          'code': 'unauthorized',
          'message': '鉴权通过前只能发送 auth',
        },
      }),
    );
    await socket.close();
  }

  void _publishWsMessage(
    Map<String, dynamic> message, {
    String? sessionId,
    String? previewSessionId,
  }) {
    final encoded = jsonEncode(message);
    final data = message['data'];
    final runId = data is Map<String, dynamic>
        ? data['runId'] as String?
        : null;
    final buffered = _BufferedWsMessage(
      encodedMessage: encoded,
      runId: runId,
      sessionId: sessionId,
      previewSessionId: previewSessionId,
    );
    _recentWsMessages.add(buffered);
    if (_recentWsMessages.length > _maxBufferedWsMessages) {
      _recentWsMessages.removeAt(0);
    }

    for (final entry in _webSocketConnections.entries) {
      final clientState = entry.value;
      if (!clientState.isAuthenticated) {
        continue;
      }
      if (!clientState.matches(buffered)) {
        continue;
      }
      entry.key.sendText(encoded);
    }
  }

  void _replayBufferedMessages(
    RelicWebSocket socket,
    _WebSocketSubscription filter,
  ) {
    for (final message in _recentWsMessages) {
      if (filter.matches(message)) {
        socket.sendText(message.encodedMessage);
      }
    }
  }

  PreviewOpenResult _openPreviewSession({
    required String url,
    String? sessionId,
  }) {
    final previewSessionId = _previewSessionId();
    _previewSessions[previewSessionId] = _PreviewSession(
      previewSessionId: previewSessionId,
      url: url,
      sessionId: sessionId,
      createdAt: DateTime.now().toUtc(),
    );

    return PreviewOpenResult(
      previewSessionId: previewSessionId,
      debugUrl: url,
      wsChannel: {'previewSessionId': previewSessionId},
    );
  }

  /// 发布测试用元素选择消息。
  @visibleForTesting
  void debugPublishElementSelected({
    required String previewSessionId,
    required String selector,
    required String selectorType,
    required String outerHtml,
    String? textContent,
    String? sessionId,
  }) {
    final optionalTextContent = textContent == null
        ? null
        : <String, String>{'textContent': textContent};

    _publishWsMessage(
      {
        'v': _protocolVersion,
        'type': 'element_selected',
        'data': {
          'previewSessionId': previewSessionId,
          'selector': selector,
          'selectorType': selectorType,
          'outerHtml': outerHtml,
          ...?optionalTextContent,
        },
      },
      sessionId: sessionId ?? _previewSessions[previewSessionId]?.sessionId,
      previewSessionId: previewSessionId,
    );
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

  static String _generateServerToken() {
    final random = Random.secure();
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    final nonce = random.nextInt(1 << 32);
    return 'st_${timestamp.toRadixString(16)}${nonce.toRadixString(16)}';
  }

  String _previewSessionId() {
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'preview_${timestamp.toRadixString(16)}';
  }
}

class _WebSocketClientState {
  bool isAuthenticated = false;
  final Set<_WebSocketSubscription> subscriptions = {};

  bool matches(_BufferedWsMessage message) {
    if (subscriptions.isEmpty) {
      return false;
    }

    return subscriptions.any((subscription) => subscription.matches(message));
  }
}

@immutable
class _WebSocketSubscription {
  const _WebSocketSubscription({
    this.runId,
    this.sessionId,
    this.previewSessionId,
  });

  static _WebSocketSubscription? fromPayload(Map<String, dynamic>? payload) {
    if (payload == null) {
      return const _WebSocketSubscription();
    }

    bool isValidString(Object? value) {
      return value == null || value is String;
    }

    if (!isValidString(payload['runId']) ||
        !isValidString(payload['sessionId']) ||
        !isValidString(payload['previewSessionId'])) {
      return null;
    }

    return _WebSocketSubscription(
      runId: payload['runId'] as String?,
      sessionId: payload['sessionId'] as String?,
      previewSessionId: payload['previewSessionId'] as String?,
    );
  }

  final String? runId;
  final String? sessionId;
  final String? previewSessionId;

  bool matches(_BufferedWsMessage message) {
    if (runId != null && runId != message.runId) {
      return false;
    }
    if (sessionId != null && sessionId != message.sessionId) {
      return false;
    }
    if (previewSessionId != null &&
        previewSessionId != message.previewSessionId) {
      return false;
    }
    return true;
  }

  Map<String, dynamic> toJson() {
    return {
      if (runId != null) 'runId': runId,
      if (sessionId != null) 'sessionId': sessionId,
      if (previewSessionId != null) 'previewSessionId': previewSessionId,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is _WebSocketSubscription &&
        other.runId == runId &&
        other.sessionId == sessionId &&
        other.previewSessionId == previewSessionId;
  }

  @override
  int get hashCode => Object.hash(runId, sessionId, previewSessionId);
}

class _BufferedWsMessage {
  const _BufferedWsMessage({
    required this.encodedMessage,
    required this.runId,
    required this.sessionId,
    required this.previewSessionId,
  });

  final String encodedMessage;
  final String? runId;
  final String? sessionId;
  final String? previewSessionId;
}

class _PreviewSession {
  const _PreviewSession({
    required this.previewSessionId,
    required this.url,
    required this.sessionId,
    required this.createdAt,
  });

  final String previewSessionId;
  final String url;
  final String? sessionId;
  final DateTime createdAt;
}
