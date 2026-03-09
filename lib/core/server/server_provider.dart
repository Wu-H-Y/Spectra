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

/// 预览选中元素矩形。
class PreviewSelectedElementRect {
  /// 创建矩形信息。
  const PreviewSelectedElementRect({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  /// 左上角 X。
  final double x;

  /// 左上角 Y。
  final double y;

  /// 宽度。
  final double width;

  /// 高度。
  final double height;

  /// 转为 JSON。
  Map<String, double> toJson() {
    return {
      'x': x,
      'y': y,
      'width': width,
      'height': height,
    };
  }
}

/// 预览 runner 启动结果。
class PreviewSessionStartResult {
  /// 创建启动结果。
  const PreviewSessionStartResult({required this.debugUrl});

  /// 调试 URL。
  final String debugUrl;
}

/// 预览 runner 事件基类。
abstract class PreviewRunnerEvent {
  /// 创建 runner 事件。
  const PreviewRunnerEvent({required this.previewSessionId});

  /// 预览会话 ID。
  final String previewSessionId;
}

/// 预览元素选中事件。
class PreviewElementSelectedEvent extends PreviewRunnerEvent {
  /// 创建元素选中事件。
  const PreviewElementSelectedEvent({
    required super.previewSessionId,
    required this.selector,
    required this.selectorType,
    required this.outerHtml,
    this.textContent,
    this.rect,
    this.xpath,
  });

  /// 首选选择器。
  final String selector;

  /// 选择器类型。
  final String selectorType;

  /// outerHTML。
  final String outerHtml;

  /// 文本内容。
  final String? textContent;

  /// 矩形信息。
  final PreviewSelectedElementRect? rect;

  /// XPath 回退。
  final String? xpath;
}

/// 预览会话关闭事件。
class PreviewSessionClosedEvent extends PreviewRunnerEvent {
  /// 创建会话关闭事件。
  const PreviewSessionClosedEvent({
    required super.previewSessionId,
    required this.reason,
  });

  /// 关闭原因。
  final String reason;
}

/// 预览 runner 会话控制器。
abstract class PreviewSessionController {
  /// 预览 runner 事件流。
  Stream<PreviewRunnerEvent> get events;

  /// 启动会话。
  Future<PreviewSessionStartResult> start();

  /// 切换选择模式。
  Future<void> setSelectionMode({required bool enabled});

  /// 在当前页面测试选择器。
  Future<PreviewSelectorTestResult> testSelector({
    required String selectorType,
    required String expression,
  });

  /// 关闭会话。
  Future<void> close();
}

/// 预览 runner 控制器工厂。
typedef PreviewSessionControllerFactory =
    PreviewSessionController Function({
      required String previewSessionId,
      required String url,
      required String projectRootPath,
      Talker? talker,
    });

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
  static const int _maxConcurrentPreviewSessions = 2;
  static const Duration _previewSessionIdleTimeout = Duration(minutes: 5);
  static AppDatabase Function() _databaseFactory = AppDatabase.new;
  static PreviewSessionControllerFactory _previewSessionControllerFactory =
      _defaultPreviewSessionControllerFactory;

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

  @override
  ServerStatus build() {
    _talker = ref.read(talkerProvider);
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

    await _closeAllPreviewSessions(reason: 'server_stop');

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
      openPreview: _openPreviewSession,
      testSelector: _testPreviewSelector,
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
    final session = _previewSessions[previewSessionId];
    if (session == null) {
      throw const PreviewRouteException(
        statusCode: 404,
        type: 'preview_session_not_found',
        message: '预览会话不存在或已关闭',
      );
    }

    await session.controller.setSelectionMode(enabled: enabled);
    session.isSelecting = enabled;
    _touchPreviewSession(session);
    _publishPreviewSelectionState(
      previewSessionId: previewSessionId,
      sessionId: session.sessionId,
      isSelecting: enabled,
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

  Future<PreviewOpenResult> _openPreviewSession({
    required String url,
    String? sessionId,
  }) async {
    if (_previewSessions.length >= _maxConcurrentPreviewSessions) {
      throw const PreviewRouteException(
        statusCode: 429,
        type: 'preview_session_limit_reached',
        message: '已达到 Chromium 预览会话上限，请先关闭旧会话',
      );
    }

    final previewSessionId = _previewSessionId();
    final controller = _previewSessionControllerFactory(
      previewSessionId: previewSessionId,
      url: url,
      projectRootPath: Directory.current.path,
      talker: _talker,
    );
    final session =
        _PreviewSession(
            previewSessionId: previewSessionId,
            url: url,
            sessionId: sessionId,
            createdAt: DateTime.now().toUtc(),
            controller: controller,
          )
          ..eventSubscription = controller.events.listen(
            _handlePreviewRunnerEvent,
            onError: (Object error, StackTrace stackTrace) {
              _talker?.error(
                'Preview runner event stream failed',
                error,
                stackTrace,
              );
              unawaited(
                _closePreviewSession(
                  previewSessionId,
                  reason: 'runner_event_error',
                  notifyRunner: false,
                  publishSelectionCancelled: true,
                ),
              );
            },
          );

    try {
      final startResult = await controller.start();
      _previewSessions[previewSessionId] = session;
      _touchPreviewSession(session);
      _talker?.info('Preview session opened: $previewSessionId');

      return PreviewOpenResult(
        previewSessionId: previewSessionId,
        debugUrl: startResult.debugUrl,
        wsChannel: {'previewSessionId': previewSessionId},
      );
    } on PreviewRouteException {
      await session.cancelEventSubscription();
      await controller.close();
      rethrow;
    } on Exception catch (error, stackTrace) {
      await session.cancelEventSubscription();
      await controller.close();
      _talker?.error('Preview session open failed', error, stackTrace);
      throw const PreviewRouteException(
        statusCode: 500,
        type: 'preview_runner_error',
        message: '启动 Chromium 预览失败',
      );
    }
  }

  Future<PreviewSelectorTestResult> _testPreviewSelector({
    required String previewSessionId,
    required String selectorType,
    required String expression,
  }) async {
    final session = _previewSessions[previewSessionId];
    if (session == null) {
      throw const PreviewRouteException(
        statusCode: 404,
        type: 'preview_session_not_found',
        message: '预览会话不存在或已关闭',
      );
    }

    final normalizedType = selectorType.trim().toLowerCase();
    if (normalizedType != 'css' && normalizedType != 'xpath') {
      throw const PreviewRouteException(
        statusCode: 400,
        type: 'unsupported_selector_type',
        message: '预览选择器测试仅支持 CSS 或 XPath',
      );
    }

    final result = await session.controller.testSelector(
      selectorType: normalizedType,
      expression: expression,
    );
    _touchPreviewSession(session);
    return result;
  }

  void _handlePreviewRunnerEvent(PreviewRunnerEvent event) {
    final session = _previewSessions[event.previewSessionId];
    if (session == null) {
      return;
    }
    _touchPreviewSession(session);

    switch (event) {
      case PreviewElementSelectedEvent():
        session.isSelecting = false;
        _publishElementSelected(
          event,
          sessionId: session.sessionId,
        );
      case PreviewSessionClosedEvent():
        unawaited(
          _closePreviewSession(
            event.previewSessionId,
            reason: event.reason,
            notifyRunner: false,
            publishSelectionCancelled: true,
          ),
        );
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

  void _touchPreviewSession(_PreviewSession session) {
    session.lastActivityAt = DateTime.now().toUtc();
    session.idleTimer?.cancel();
    session.idleTimer = Timer(_previewSessionIdleTimeout, () {
      unawaited(
        _closePreviewSession(
          session.previewSessionId,
          reason: 'idle_timeout',
          publishSelectionCancelled: true,
        ),
      );
    });
  }

  Future<void> _closeAllPreviewSessions({required String reason}) async {
    for (final previewSessionId in _previewSessions.keys.toList()) {
      await _closePreviewSession(previewSessionId, reason: reason);
    }
  }

  Future<void> _closePreviewSession(
    String previewSessionId, {
    required String reason,
    bool notifyRunner = true,
    bool publishSelectionCancelled = false,
  }) async {
    final session = _previewSessions.remove(previewSessionId);
    if (session == null) {
      return;
    }

    session.idleTimer?.cancel();
    await session.eventSubscription?.cancel();
    if (publishSelectionCancelled && session.isSelecting) {
      _publishPreviewSelectionState(
        previewSessionId: previewSessionId,
        sessionId: session.sessionId,
        isSelecting: false,
      );
    }

    if (notifyRunner) {
      try {
        await session.controller.close();
      } on Exception catch (error, stackTrace) {
        _talker?.error('Failed to close preview runner', error, stackTrace);
      }
    }

    _talker?.info('Preview session closed: $previewSessionId ($reason)');
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
    _publishElementSelected(
      PreviewElementSelectedEvent(
        previewSessionId: previewSessionId,
        selector: selector,
        selectorType: selectorType,
        outerHtml: outerHtml,
        textContent: textContent,
      ),
      sessionId: sessionId ?? _previewSessions[previewSessionId]?.sessionId,
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

  static PreviewSessionController _defaultPreviewSessionControllerFactory({
    required String previewSessionId,
    required String url,
    required String projectRootPath,
    Talker? talker,
  }) {
    return _PreviewRunnerProcessSessionController(
      previewSessionId: previewSessionId,
      url: url,
      projectRootPath: projectRootPath,
      talker: talker,
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

class _PreviewSession {
  _PreviewSession({
    required this.previewSessionId,
    required this.url,
    required this.sessionId,
    required this.createdAt,
    required this.controller,
  }) : lastActivityAt = createdAt;

  final String previewSessionId;
  final String url;
  final String? sessionId;
  final DateTime createdAt;
  final PreviewSessionController controller;
  DateTime lastActivityAt;
  bool isSelecting = false;
  Timer? idleTimer;
  StreamSubscription<PreviewRunnerEvent>? eventSubscription;

  Future<void> cancelEventSubscription() async {
    await eventSubscription?.cancel();
    eventSubscription = null;
  }

  Future<void> dispose() async {
    idleTimer?.cancel();
    await cancelEventSubscription();
  }
}

class _PreviewRunnerProcessSessionController
    implements PreviewSessionController {
  _PreviewRunnerProcessSessionController({
    required this.previewSessionId,
    required this.url,
    required this.projectRootPath,
    this.talker,
  });

  static const Duration _commandTimeout = Duration(seconds: 10);
  static const Duration _startTimeout = Duration(seconds: 30);
  static const Duration _closeTimeout = Duration(seconds: 5);

  final String previewSessionId;
  final String url;
  final String projectRootPath;
  final Talker? talker;

  final StreamController<PreviewRunnerEvent> _eventsController =
      StreamController<PreviewRunnerEvent>.broadcast();
  final Map<String, Completer<Map<String, dynamic>>> _pendingCommands = {};
  final List<String> _stderrBuffer = [];
  int _nextCommandId = 0;
  Process? _process;
  bool _closed = false;
  bool _ready = false;
  bool _closedEventSent = false;
  Future<PreviewSessionStartResult>? _startFuture;

  @override
  Stream<PreviewRunnerEvent> get events => _eventsController.stream;

  @override
  Future<PreviewSessionStartResult> start() {
    return _startFuture ??= _startInternal();
  }

  Future<PreviewSessionStartResult> _startInternal() async {
    final runnerFile = File(_runnerScriptPath());
    if (!runnerFile.existsSync()) {
      throw const PreviewRouteException(
        statusCode: 500,
        type: 'preview_runner_missing',
        message: '找不到本地 Playwright 预览 runner',
      );
    }

    try {
      _process = await Process.start(
        Platform.isWindows ? 'node.exe' : 'node',
        [
          runnerFile.path,
          '--session-id',
          previewSessionId,
          '--url',
          url,
        ],
        workingDirectory: projectRootPath,
      );
    } on ProcessException catch (error) {
      throw PreviewRouteException(
        statusCode: 500,
        type: 'preview_runner_spawn_failed',
        message: '启动 Node 预览 runner 失败: ${error.message}',
      );
    }

    final readyCompleter = Completer<PreviewSessionStartResult>();
    _process!.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(
          (line) => _handleStdoutLine(line, readyCompleter),
          onError: (Object error, StackTrace stackTrace) {
            talker?.error('Preview runner stdout failed', error, stackTrace);
          },
        );
    _process!.stderr
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(_handleStderrLine);

    unawaited(
      _process!.exitCode.then((exitCode) {
        _handleProcessExit(exitCode, readyCompleter);
      }),
    );

    return readyCompleter.future.timeout(
      _startTimeout,
      onTimeout: () {
        throw const PreviewRouteException(
          statusCode: 500,
          type: 'preview_runner_start_timeout',
          message: '等待 Chromium 预览窗口启动超时',
        );
      },
    );
  }

  @override
  Future<void> setSelectionMode({required bool enabled}) async {
    await _sendCommand(
      'set_selection_mode',
      <String, dynamic>{'enabled': enabled},
    );
  }

  @override
  Future<PreviewSelectorTestResult> testSelector({
    required String selectorType,
    required String expression,
  }) async {
    final response = await _sendCommand(
      'test_selector',
      <String, dynamic>{
        'selectorType': selectorType,
        'expression': expression,
      },
    );
    final elements = (response['elements'] as List<dynamic>? ?? const [])
        .map((item) => Map<String, dynamic>.from(item as Map<Object?, Object?>))
        .map(
          (item) => PreviewSelectorMatchedElement(
            text: item['text'] as String? ?? '',
            html: item['html'] as String? ?? '',
          ),
        )
        .toList();

    return PreviewSelectorTestResult(
      success: response['success'] as bool? ?? false,
      count: response['count'] as int? ?? elements.length,
      elements: elements,
      error: response['error'] as String?,
    );
  }

  @override
  Future<void> close() async {
    if (_closed) {
      return;
    }
    _closed = true;

    try {
      if (_process != null) {
        try {
          await _sendCommand('close', const <String, dynamic>{});
        } on Exception {
          _process?.kill();
        }
        await _process!.exitCode.timeout(
          _closeTimeout,
          onTimeout: () {
            _process?.kill();
            return -1;
          },
        );
      }
    } finally {
      for (final completer in _pendingCommands.values) {
        if (!completer.isCompleted) {
          completer.completeError(
            const PreviewRouteException(
              statusCode: 500,
              type: 'preview_runner_closed',
              message: '预览 runner 已关闭',
            ),
          );
        }
      }
      _pendingCommands.clear();
      await _eventsController.close();
    }
  }

  Future<Map<String, dynamic>> _sendCommand(
    String command,
    Map<String, dynamic> payload,
  ) async {
    await start();
    final process = _process;
    if (process == null) {
      throw const PreviewRouteException(
        statusCode: 500,
        type: 'preview_runner_unavailable',
        message: '预览 runner 不可用',
      );
    }

    final commandId = 'cmd_${_nextCommandId++}';
    final completer = Completer<Map<String, dynamic>>();
    _pendingCommands[commandId] = completer;
    process.stdin.writeln(
      jsonEncode({
        'kind': 'command',
        'id': commandId,
        'command': command,
        ...payload,
      }),
    );

    return completer.future.timeout(
      _commandTimeout,
      onTimeout: () {
        _pendingCommands.remove(commandId);
        throw PreviewRouteException(
          statusCode: 500,
          type: 'preview_runner_command_timeout',
          message: '等待预览 runner 执行 $command 超时',
        );
      },
    );
  }

  void _handleStdoutLine(
    String line,
    Completer<PreviewSessionStartResult> readyCompleter,
  ) {
    if (line.trim().isEmpty) {
      return;
    }

    try {
      final message = Map<String, dynamic>.from(
        jsonDecode(line) as Map<Object?, Object?>,
      );
      final kind = message['kind'] as String?;
      switch (kind) {
        case 'ready':
          _ready = true;
          if (!readyCompleter.isCompleted) {
            readyCompleter.complete(
              PreviewSessionStartResult(
                debugUrl: message['debugUrl'] as String? ?? url,
              ),
            );
          }
        case 'response':
          final commandId = message['id'] as String?;
          if (commandId == null) {
            return;
          }
          final completer = _pendingCommands.remove(commandId);
          if (completer == null || completer.isCompleted) {
            return;
          }
          if (message['ok'] == true) {
            final result = message['result'];
            final payload = result is Map<Object?, Object?>
                ? Map<String, dynamic>.from(result)
                : <String, dynamic>{};
            completer.complete(payload);
          } else {
            completer.completeError(
              PreviewRouteException(
                statusCode: 500,
                type: 'preview_runner_command_failed',
                message: message['error'] as String? ?? '预览 runner 命令执行失败',
              ),
            );
          }
        case 'event':
          _handleRunnerEventMessage(message);
        default:
          talker?.warning('Unknown preview runner message: $line');
      }
    } on Exception catch (error, stackTrace) {
      talker?.error('Failed to parse preview runner stdout', error, stackTrace);
    }
  }

  void _handleRunnerEventMessage(Map<String, dynamic> message) {
    final event = message['event'] as String?;
    final data = message['data'] is Map<Object?, Object?>
        ? Map<String, dynamic>.from(message['data'] as Map<Object?, Object?>)
        : const <String, dynamic>{};
    switch (event) {
      case 'element_selected':
        final selector = data['selector'] as String? ?? '';
        final xpath = data['xpath'] as String?;
        final resolvedSelector = selector.isNotEmpty ? selector : xpath ?? '';
        final selectorType = selector.isNotEmpty ? 'css' : 'xpath';
        if (resolvedSelector.isEmpty) {
          return;
        }
        _eventsController.add(
          PreviewElementSelectedEvent(
            previewSessionId: previewSessionId,
            selector: resolvedSelector,
            selectorType: selectorType,
            outerHtml: data['outerHtml'] as String? ?? '',
            textContent: data['textContent'] as String?,
            rect: _parseRect(data['rect']),
            xpath: xpath,
          ),
        );
      case 'closed':
        _emitClosedEvent(data['reason'] as String? ?? 'runner_closed');
    }
  }

  PreviewSelectedElementRect? _parseRect(Object? rawRect) {
    if (rawRect is! Map<Object?, Object?>) {
      return null;
    }
    final rect = Map<String, dynamic>.from(rawRect);
    final x = (rect['x'] as num?)?.toDouble();
    final y = (rect['y'] as num?)?.toDouble();
    final width = (rect['width'] as num?)?.toDouble();
    final height = (rect['height'] as num?)?.toDouble();
    if (x == null || y == null || width == null || height == null) {
      return null;
    }

    return PreviewSelectedElementRect(
      x: x,
      y: y,
      width: width,
      height: height,
    );
  }

  void _handleStderrLine(String line) {
    if (_stderrBuffer.length >= 20) {
      _stderrBuffer.removeAt(0);
    }
    _stderrBuffer.add(line);
    talker?.debug(line);
  }

  void _handleProcessExit(
    int exitCode,
    Completer<PreviewSessionStartResult> readyCompleter,
  ) {
    if (!_ready && !readyCompleter.isCompleted) {
      readyCompleter.completeError(
        PreviewRouteException(
          statusCode: 500,
          type: 'preview_runner_start_failed',
          message: _stderrBuffer.isEmpty
              ? 'Chromium 预览 runner 启动失败（exitCode=$exitCode）'
              : _stderrBuffer.last,
        ),
      );
    }

    for (final completer in _pendingCommands.values) {
      if (!completer.isCompleted) {
        completer.completeError(
          PreviewRouteException(
            statusCode: 500,
            type: 'preview_runner_exited',
            message: '预览 runner 已退出（exitCode=$exitCode）',
          ),
        );
      }
    }
    _pendingCommands.clear();
    _emitClosedEvent('process_exit_$exitCode');
  }

  void _emitClosedEvent(String reason) {
    if (_closedEventSent || _eventsController.isClosed) {
      return;
    }
    _closedEventSent = true;
    _eventsController.add(
      PreviewSessionClosedEvent(
        previewSessionId: previewSessionId,
        reason: reason,
      ),
    );
  }

  String _runnerScriptPath() {
    return [
      projectRootPath,
      'tools',
      'preview-runner',
      'index.mjs',
    ].join(Platform.pathSeparator);
  }
}
