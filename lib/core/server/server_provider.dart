import 'dart:async';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart' show webSocketHandler;
import 'package:spectra/core/server/handlers/static_handler.dart';
import 'package:spectra/core/server/handlers/websocket_handler.dart';
import 'package:spectra/core/server/middleware/cors_middleware.dart';
import 'package:spectra/core/server/routes/rules_routes.dart';
import 'package:spectra/core/server/routes/server_routes.dart';
import 'package:spectra/shared/providers/talker_provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'server_provider.g.dart';

/// Server status information.
class ServerStatus {
  /// Creates server status.
  const ServerStatus({
    required this.isRunning,
    required this.port,
    this.url,
  });

  /// Whether the server is currently running.
  final bool isRunning;

  /// The port the server is running on.
  final int port;

  /// The URL to access the server.
  final String? url;

  /// Copy with new values.
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

/// Provider for the HTTP server.
@riverpod
class Server extends _$Server {
  HttpServer? _server;
  WebSocketHandler? _webSocketHandler;
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

  /// Start the HTTP server.
  Future<void> start({int? port}) async {
    if (_server != null) {
      return; // Already running
    }

    _port = port ?? await _findAvailablePort();
    _webSocketHandler = WebSocketHandler(talker: _talker);

    final app = await _createApp();

    try {
      _server = await shelf_io.serve(
        app,
        InternetAddress.anyIPv4,
        _port,
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

  /// Stop the HTTP server.
  Future<void> stop() async {
    if (_server == null) {
      return; // Not running
    }

    await _webSocketHandler?.closeAll();
    await _server?.close(force: true);
    _server = null;
    _webSocketHandler = null;

    state = ServerStatus(
      isRunning: false,
      port: _port,
    );

    _talker?.info('Server stopped');
  }

  /// Check if server is running.
  bool get isRunning => _server != null;

  /// Get current port.
  int get currentPort => _port;

  /// Find an available port.
  Future<int> _findAvailablePort() async {
    final socket = await ServerSocket.bind(InternetAddress.anyIPv4, 0);
    final port = socket.port;
    await socket.close();
    return port;
  }

  /// Create the Shelf application.
  Future<Handler> _createApp() async {
    const rulesRoutes = RulesRoutes();
    final serverRoutes = ServerRoutes(
      isRunning: () => isRunning,
      port: () => currentPort,
      onStart: start,
      onStop: stop,
    );

    // Create WebSocket handler
    final wsHandler = webSocketHandler(
      (WebSocketChannel webSocket, String? _) {
        // Fire and forget: WebSocket handling is async by design.
        // ignore: discarded_futures
        _webSocketHandler?.handle(webSocket);
      },
    );

    // Create static file handler for editor
    final projectPath = Directory.current.path;
    final editorPath = '$projectPath/assets/editor';
    final staticHandler = editorAssetsExist(projectPath)
        ? createEditorStaticHandler(editorPath)
        : (request) => Response.notFound('Editor not built');

    // Combine all routes
    final apiRouter = Cascade()
        .add(serverRoutes.router.call)
        .add(rulesRoutes.router.call)
        .add(wsHandler)
        .handler;

    // Main handler with middleware
    final handler = const Pipeline()
        .addMiddleware(_logMiddleware)
        .addMiddleware(_errorMiddleware)
        .addMiddleware(corsMiddleware())
        .addHandler((request) async {
          final path = request.requestedUri.path;

          // API routes
          if (path.startsWith('/api') || path == '/ws') {
            return apiRouter(request);
          }

          // Static files (editor)
          return staticHandler(request);
        });

    return handler;
  }

  /// Log middleware - logs all requests.
  Middleware get _logMiddleware {
    return (Handler innerHandler) {
      return (Request request) async {
        final stopwatch = Stopwatch()..start();
        final response = await innerHandler(request);
        stopwatch.stop();

        _talker?.debug(
          '${request.method} ${request.requestedUri.path} '
          '${response.statusCode} ${stopwatch.elapsedMilliseconds}ms',
        );

        return response;
      };
    };
  }

  /// Error handling middleware.
  Middleware get _errorMiddleware {
    return (Handler innerHandler) {
      return (Request request) async {
        try {
          return await innerHandler(request);
        } on Exception catch (e, st) {
          _talker?.error('Error handling request', e, st);
          return Response.internalServerError(
            body: 'Internal server error: $e',
          );
        }
      };
    };
  }
}
