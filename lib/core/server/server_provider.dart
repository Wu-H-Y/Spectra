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
import 'package:spectra/core/server/preview_runner_adapter.dart';
import 'package:spectra/core/server/routes/preview_routes.dart';
import 'package:spectra/core/server/routes/rules_routes.dart';
import 'package:spectra/core/server/routes/server_routes.dart';
import 'package:spectra/core/server/runtime_session_coordinator.dart';
import 'package:spectra/shared/providers/talker_provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:web_socket/web_socket.dart';

export 'preview_runner_adapter.dart';

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
  late final AppDatabase _database = _databaseFactory();
  final String _serverToken = _generateServerToken();
  int _port = 8080;
  Talker? _talker;
  late RuntimeSessionCoordinator _runtimeSessionCoordinator;

  static const int _protocolVersion = 1;
  static const int _maxBufferedWsMessages = 128;
  static AppDatabase Function() _databaseFactory = AppDatabase.new;
  static PreviewSessionControllerFactory _previewSessionControllerFactory =
      defaultPreviewSessionControllerFactory;
  static PreviewRunnerAdapter Function() _previewRunnerAdapterFactory =
      _defaultPreviewRunnerAdapterFactory;

  /// 设置测试用数据库工厂。
  @visibleForTesting
  static AppDatabase Function() get debugDatabaseFactory => _databaseFactory;

  /// 设置测试用数据库工厂。
  @visibleForTesting
  static set debugDatabaseFactory(AppDatabase Function() factory) {
    _databaseFactory = factory;
  }

  /// 设置测试用预览 runner 工厂。
  @visibleForTesting
  static PreviewSessionControllerFactory
  get debugPreviewSessionControllerFactory => _previewSessionControllerFactory;

  /// 设置测试用预览 runner 工厂。
  @visibleForTesting
  static set debugPreviewSessionControllerFactory(
    PreviewSessionControllerFactory factory,
  ) {
    _previewSessionControllerFactory = factory;
  }

  /// 设置测试用预览 runner 适配器工厂。
  @visibleForTesting
  static PreviewRunnerAdapter Function() get debugPreviewRunnerAdapterFactory =>
      _previewRunnerAdapterFactory;

  /// 设置测试用预览 runner 适配器工厂。
  @visibleForTesting
  static set debugPreviewRunnerAdapterFactory(
    PreviewRunnerAdapter Function() factory,
  ) {
    _previewRunnerAdapterFactory = factory;
  }

  @override
  ServerStatus build() {
    _talker = ref.read(talkerProvider);
    _runtimeSessionCoordinator = _createRuntimeSessionCoordinator();
    ref.onDispose(() {
      unawaited(stop());
      unawaited(_database.close());
    });
    return const ServerStatus(isRunning: false, port: 8080);
  }

  /// 启动 HTTP 服务器。
  Future<void> start({int? port}) async {
    if (_server != null) {
      return;
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
    } catch (error, stackTrace) {
      _talker?.error('Failed to start server', error, stackTrace);
      rethrow;
    }
  }

  /// 停止 HTTP 服务器。
  Future<void> stop() async {
    if (_server == null) {
      return;
    }

    await _runtimeSessionCoordinator.closeAllPreviewSessions(
      reason: 'server_stop',
    );

    for (final ws in _webSocketConnections.keys.toList()) {
      await ws.close();
    }
    _webSocketConnections.clear();

    await _server?.close();
    _server = null;

    if (ref.mounted) {
      state = ServerStatus(isRunning: false, port: _port);
    }

    _talker?.info('Server stopped');
  }

  /// 检查服务器是否正在运行。
  bool get isRunning => _server != null;

  /// 获取当前端口。
  int get currentPort => _port;

  Future<int> _findAvailablePort() async {
    final socket = await ServerSocket.bind(InternetAddress.anyIPv4, 0);
    final port = socket.port;
    await socket.close();
    return port;
  }

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
      openPreview: _runtimeSessionCoordinator.openPreview,
      testSelector: _runtimeSessionCoordinator.testPreviewSelector,
    );

    final projectPath = Directory.current.path;
    final editorPath = '$projectPath/assets/editor';
    final staticHandler = editorAssetsExist(projectPath)
        ? createEditorStaticHandler(editorPath)
        : (request) => Response.notFound(
            body: Body.fromString('Editor not built'),
          );

    final app = RelicApp()
      ..use('/', _logMiddleware)
      ..use('/', _errorMiddleware)
      ..use('/', corsMiddleware())
      ..get('/ws', _handleWebSocket)
      ..attach('/api/server', serverRoutes.router)
      ..attach('/api/preview', previewRoutes.router)
      ..attach('/api/rules', rulesRoutes.router)
      ..fallback = staticHandler;

    return app;
  }

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
      } on Exception catch (error, stackTrace) {
        _talker?.error('WebSocket error', error, stackTrace);
      } finally {
        _webSocketConnections.remove(webSocket);
        _talker?.debug(
          'WebSocket disconnected, total: ${_webSocketConnections.length}',
        );
      }
    });
  }

  Future<void> _handleWebSocketMessage(
    RelicWebSocket sender,
    String message,
  ) async {
    try {
      final data = Map<String, dynamic>.from(
        jsonDecode(message) as Map<Object?, Object?>,
      );
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
      final payload = data['data'] is Map<Object?, Object?>
          ? Map<String, dynamic>.from(data['data'] as Map<Object?, Object?>)
          : null;
      final clientState = _webSocketConnections[sender];
      if (clientState == null) {
        return;
      }

      switch (type) {
        case 'auth':
          final token = payload?['token'];
          if (token is! String || token != _serverToken) {
            await _sendWsErrorAndClose(
              sender,
              code: 'unauthorized',
              message: '缺少或无效的 serverToken',
            );
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
            _sendWsError(
              sender,
              code: 'bad_request',
              message: '订阅过滤器必须是对象',
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
            _sendWsError(
              sender,
              code: 'bad_request',
              message: '取消订阅过滤器必须是对象',
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

        case 'start_selection':
          if (!clientState.isAuthenticated) {
            await _closeForUnauthorizedMessage(sender);
            return;
          }

          final previewSessionId = _extractPreviewSessionId(payload);
          if (previewSessionId == null) {
            _sendWsError(
              sender,
              code: 'bad_request',
              message: 'previewSessionId 不能为空',
            );
            return;
          }

          await _setPreviewSelectionMode(
            previewSessionId: previewSessionId,
            enabled: true,
          );

        case 'cancel_selection':
          if (!clientState.isAuthenticated) {
            await _closeForUnauthorizedMessage(sender);
            return;
          }

          final previewSessionId = _extractPreviewSessionId(payload);
          if (previewSessionId == null) {
            _sendWsError(
              sender,
              code: 'bad_request',
              message: 'previewSessionId 不能为空',
            );
            return;
          }

          await _setPreviewSelectionMode(
            previewSessionId: previewSessionId,
            enabled: false,
          );

        case 'ping':
          sender.sendText(
            jsonEncode({'v': _protocolVersion, 'type': 'pong'}),
          );

        default:
          _talker?.warning('Unknown WebSocket message type: $type');
      }
    } on PreviewRouteException catch (error) {
      _sendWsError(
        sender,
        code: error.type,
        message: error.message,
      );
    } on Exception catch (error, stackTrace) {
      _talker?.error('Error handling WebSocket message', error, stackTrace);
      _sendWsError(
        sender,
        code: 'internal_error',
        message: '处理 WebSocket 消息失败',
      );
    }
  }

  Future<void> _setPreviewSelectionMode({
    required String previewSessionId,
    required bool enabled,
  }) async {
    await _runtimeSessionCoordinator.setPreviewSelectionMode(
      previewSessionId: previewSessionId,
      enabled: enabled,
    );
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

  void _sendWsError(
    RelicWebSocket socket, {
    required String code,
    required String message,
  }) {
    socket.sendText(
      jsonEncode({
        'v': _protocolVersion,
        'type': 'error',
        'data': {'code': code, 'message': message},
      }),
    );
  }

  Future<void> _sendWsErrorAndClose(
    RelicWebSocket socket, {
    required String code,
    required String message,
  }) async {
    _sendWsError(socket, code: code, message: message);
    await socket.close();
  }

  String? _extractPreviewSessionId(Map<String, dynamic>? payload) {
    final value = payload?['previewSessionId'];
    if (value is! String || value.trim().isEmpty) {
      return null;
    }
    return value.trim();
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
      if (!clientState.isAuthenticated || !clientState.matches(buffered)) {
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

  void _publishPreviewSelectionState({
    required String previewSessionId,
    required String? sessionId,
    required bool isSelecting,
  }) {
    _publishWsMessage(
      {
        'v': _protocolVersion,
        'type': isSelecting ? 'selection_started' : 'selection_cancelled',
        'data': {'previewSessionId': previewSessionId},
      },
      sessionId: sessionId,
      previewSessionId: previewSessionId,
    );
  }

  void _publishElementSelected(
    PreviewElementSelectedEvent event, {
    required String? sessionId,
  }) {
    final optionalTextContent =
        (event.textContent != null && event.textContent!.isNotEmpty)
        ? <String, String>{'textContent': event.textContent!}
        : null;

    _publishWsMessage(
      {
        'v': _protocolVersion,
        'type': 'element_selected',
        'data': {
          'previewSessionId': event.previewSessionId,
          'selector': event.selector,
          'selectorType': event.selectorType,
          'outerHtml': event.outerHtml,
          ...?optionalTextContent,
          if (event.rect != null) 'rect': event.rect!.toJson(),
          if (event.xpath != null && event.xpath!.isNotEmpty)
            'xpath': event.xpath,
        },
      },
      sessionId: sessionId,
      previewSessionId: event.previewSessionId,
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
    PreviewSelectedElementRect? rect,
    String? xpath,
    String? sessionId,
  }) {
    _publishElementSelected(
      PreviewElementSelectedEvent(
        previewSessionId: previewSessionId,
        selector: selector,
        selectorType: selectorType,
        outerHtml: outerHtml,
        textContent: textContent,
        rect: rect,
        xpath: xpath,
      ),
      sessionId:
          sessionId ??
          _runtimeSessionCoordinator.sessionIdForPreviewSession(
            previewSessionId,
          ),
    );
  }

  Middleware get _logMiddleware {
    return (Handler innerHandler) {
      return (Request request) async {
        final stopwatch = Stopwatch()..start();
        final result = await innerHandler(request);
        stopwatch.stop();

        final statusCode = switch (result) {
          final Response response => response.statusCode,
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

  Middleware get _errorMiddleware {
    return (Handler innerHandler) {
      return (Request request) async {
        try {
          return await innerHandler(request);
        } on Exception catch (error, stackTrace) {
          _talker?.error('Error handling request', error, stackTrace);
          return Response.internalServerError(
            body: Body.fromString(
              jsonEncode({
                'error': 'Internal server error',
                'message': error.toString(),
              }),
              mimeType: MimeType.json,
            ),
          );
        }
      };
    };
  }

  RuntimeSessionCoordinator _createRuntimeSessionCoordinator() {
    return RuntimeSessionCoordinatorImpl(
      previewRunnerAdapter: _previewRunnerAdapterFactory(),
      projectRootPath: Directory.current.path,
      previewSessionIdGenerator: _previewSessionId,
      publishSelectionState: _publishPreviewSelectionState,
      publishElementSelected: _publishElementSelected,
      talker: _talker,
    );
  }

  static PreviewRunnerAdapter _defaultPreviewRunnerAdapterFactory() {
    return DefaultPreviewRunnerAdapter(
      controllerFactory: _previewSessionControllerFactory,
    );
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
