import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Server control routes.
class ServerRoutes {
  /// Creates server routes.
  ServerRoutes({
    required this.isRunning,
    required this.port,
    required this.onStart,
    required this.onStop,
  });

  /// Whether the server is currently running.
  final bool Function() isRunning;

  /// The port the server is running on.
  final int Function() port;

  /// Callback when server should start.
  final Future<void> Function() onStart;

  /// Callback when server should stop.
  final Future<void> Function() onStop;

  /// Create router with all routes.
  Router get router => Router()
    // GET /api/server/status - Get server status
    ..get('/api/server/status', _getStatus)
    // POST /api/server/start - Start the server
    ..post('/api/server/start', _startServer)
    // POST /api/server/stop - Stop the server
    ..post('/api/server/stop', _stopServer);

  /// Get server status.
  Future<Response> _getStatus(Request request) async {
    final currentPort = port();
    return Response.ok(
      jsonEncode({
        'isRunning': isRunning(),
        'port': currentPort,
        'url': 'http://localhost:$currentPort',
      }),
      headers: {'content-type': 'application/json'},
    );
  }

  /// Start the server.
  Future<Response> _startServer(Request request) async {
    try {
      await onStart();
      return Response.ok(
        jsonEncode({
          'isRunning': isRunning(),
          'port': port(),
          'message': 'Server started',
        }),
        headers: {'content-type': 'application/json'},
      );
    } on Exception catch (e) {
      return Response.internalServerError(
        body: jsonEncode({
          'isRunning': false,
          'error': e.toString(),
        }),
        headers: {'content-type': 'application/json'},
      );
    }
  }

  /// Stop the server.
  Future<Response> _stopServer(Request request) async {
    try {
      await onStop();
      return Response.ok(
        jsonEncode({
          'isRunning': false,
          'message': 'Server stopped',
        }),
        headers: {'content-type': 'application/json'},
      );
    } on Exception catch (e) {
      return Response.internalServerError(
        body: jsonEncode({
          'isRunning': isRunning(),
          'error': e.toString(),
        }),
        headers: {'content-type': 'application/json'},
      );
    }
  }
}
