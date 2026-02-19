/// HTTP server module for web editor.
///
/// This module provides:
/// - HTTP server with CORS support
/// - REST API for rule CRUD operations
/// - WebSocket support for real-time communication
/// - Static file serving for the web editor
library;

export 'handlers/static_handler.dart';
export 'handlers/websocket_handler.dart';
export 'middleware/cors_middleware.dart' hide logMiddleware;
export 'routes/rules_routes.dart';
export 'routes/server_routes.dart';
export 'server_provider.dart';
