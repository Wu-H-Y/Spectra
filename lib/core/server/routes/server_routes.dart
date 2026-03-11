import 'dart:convert';

import 'package:relic/relic.dart';

/// 服务器控制路由。
class ServerRoutes {
  /// 创建服务器路由。
  ServerRoutes({
    required this.isRunning,
    required this.port,
    required this.serverToken,
    required this.onStart,
    required this.onStop,
  });

  /// 服务器当前是否正在运行。
  final bool Function() isRunning;

  /// 服务器运行的端口。
  final int Function() port;

  /// 当前服务端鉴权令牌（Flutter host 完整权限）。
  final String Function() serverToken;

  /// 服务器启动时的回调。
  final Future<void> Function() onStart;

  /// 服务器停止时的回调。
  final Future<void> Function() onStop;

  /// 创建包含所有路由的路由器。
  ///
  /// 注意：此路由器会被挂载到 /api/server 路径下，
  /// 所以内部路由不需要 /api/server 前缀。
  Router<Handler> get router => Router<Handler>()
    // GET /status - 获取服务器状态（无需鉴权，但返回 attachToken）
    ..get('/status', _getStatus)
    // POST /start - 启动服务器（仅 Flutter host 可调用）
    ..post('/start', _wrapHostOnly(_startServer))
    // POST /stop - 停止服务器（仅 Flutter host 可调用）
    ..post('/stop', _wrapHostOnly(_stopServer));

  /// 包装 handler 以添加 host-only 验证。
  Handler _wrapHostOnly(Future<Response> Function(Request) handler) {
    return (request) async {
      final hostOnly = request.headers['x-host-only']?.firstOrNull;
      if (hostOnly != 'true') {
        return _errorResponse(
          statusCode: 403,
          type: 'forbidden',
          message: '此接口仅允许 Flutter 主机调用，Web 编辑器禁止访问',
        );
      }

      final authorization = request.headers.authorization;
      if (authorization is! BearerAuthorizationHeader ||
          authorization.token != serverToken()) {
        return _errorResponse(
          statusCode: 401,
          type: 'unauthorized',
          message: '缺少或无效的 serverToken',
        );
      }

      return handler(request);
    };
  }

  /// 获取服务器状态。
  ///
  /// 返回两种 token：
  /// - serverToken：Flutter host 完整权限
  /// - attachToken：Web editor 只读附着权限（仅用于 WS attach）
  Future<Response> _getStatus(Request request) async {
    final currentPort = port();
    return Response.ok(
      body: Body.fromString(
        jsonEncode({
          'isRunning': isRunning(),
          'port': currentPort,
          'url': 'http://localhost:$currentPort',
          'serverToken': serverToken(),
          // attachToken 仅用于 WebSocket attach，不用于 HTTP API
          // Web editor 使用此 token 进行只读诊断附着
          'attachToken': _generateAttachToken(),
        }),
        mimeType: MimeType.json,
      ),
    );
  }

  /// 生成 Web editor attach token。
  ///
  /// 此 token 仅用于 WebSocket 连接的只读诊断附着，
  /// 不具备发起 preview/execute 的权限。
  String _generateAttachToken() {
    // attachToken 是 serverToken 的子集，仅用于 WS attach
    // 服务端通过 token 前缀区分权限级别
    final token = serverToken();
    return 'attach_$token';
  }

  /// 生成错误响应。
  Response _errorResponse({
    required int statusCode,
    required String type,
    required String message,
  }) {
    return Response(
      statusCode,
      body: Body.fromString(
        jsonEncode({
          'error': {
            'type': type,
            'message': message,
            'requestId': _requestId(),
          },
        }),
        mimeType: MimeType.json,
      ),
    );
  }

  /// 生成请求 ID。
  String _requestId() {
    final now = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'req_${now.toRadixString(16)}';
  }

  /// 启动服务器。
  Future<Response> _startServer(Request request) async {
    try {
      await onStart();
      return Response.ok(
        body: Body.fromString(
          jsonEncode({
            'isRunning': isRunning(),
            'port': port(),
            'message': 'Server started',
          }),
          mimeType: MimeType.json,
        ),
      );
    } on Exception catch (e) {
      return Response.internalServerError(
        body: Body.fromString(
          jsonEncode({
            'isRunning': false,
            'error': e.toString(),
          }),
          mimeType: MimeType.json,
        ),
      );
    }
  }

  /// 停止服务器。
  Future<Response> _stopServer(Request request) async {
    try {
      await onStop();
      return Response.ok(
        body: Body.fromString(
          jsonEncode({
            'isRunning': false,
            'message': 'Server stopped',
          }),
          mimeType: MimeType.json,
        ),
      );
    } on Exception catch (e) {
      return Response.internalServerError(
        body: Body.fromString(
          jsonEncode({
            'isRunning': isRunning(),
            'error': e.toString(),
          }),
          mimeType: MimeType.json,
        ),
      );
    }
  }
}
