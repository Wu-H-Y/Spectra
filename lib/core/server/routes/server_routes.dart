import 'dart:convert';

import 'package:relic/relic.dart';

/// 服务器控制路由。
class ServerRoutes {
  /// 创建服务器路由。
  ServerRoutes({
    required this.isRunning,
    required this.port,
    required this.onStart,
    required this.onStop,
  });

  /// 服务器当前是否正在运行。
  final bool Function() isRunning;

  /// 服务器运行的端口。
  final int Function() port;

  /// 服务器启动时的回调。
  final Future<void> Function() onStart;

  /// 服务器停止时的回调。
  final Future<void> Function() onStop;

  /// 创建包含所有路由的路由器。
  Router<Handler> get router => Router<Handler>()
    // GET /api/server/status - 获取服务器状态
    ..get('/api/server/status', _getStatus)
    // POST /api/server/start - 启动服务器
    ..post('/api/server/start', _startServer)
    // POST /api/server/stop - 停止服务器
    ..post('/api/server/stop', _stopServer);

  /// 获取服务器状态。
  Future<Response> _getStatus(Request request) async {
    final currentPort = port();
    return Response.ok(
      body: Body.fromString(
        jsonEncode({
          'isRunning': isRunning(),
          'port': currentPort,
          'url': 'http://localhost:$currentPort',
        }),
        mimeType: MimeType.json,
      ),
    );
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
