/// Web 编辑器的 HTTP 服务器模块。
///
/// 此模块提供：
/// - 带 CORS 支持的 HTTP 服务器
/// - 规则 CRUD 操作的 REST API
/// - 实时通信的 WebSocket 支持
/// - Web 编辑器的静态文件服务
library;

export 'handlers/static_handler.dart';
export 'handlers/websocket_handler.dart';
export 'middleware/cors_middleware.dart' hide logMiddleware;
export 'routes/rules_routes.dart';
export 'routes/server_routes.dart';
export 'server_provider.dart';
