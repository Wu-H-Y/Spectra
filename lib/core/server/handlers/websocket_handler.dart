import 'dart:async';
import 'dart:convert';

import 'package:talker_flutter/talker_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// WebSocket handler for real-time communication with the web editor.
class WebSocketHandler {
  /// Creates a WebSocket handler.
  WebSocketHandler({Talker? talker}) : _talker = talker;

  /// Talker instance for logging.
  final Talker? _talker;

  /// Active WebSocket connections.
  final Set<WebSocketChannel> _connections = {};

  /// Stream controller for broadcasting messages.
  final StreamController<String> _broadcastController =
      StreamController<String>.broadcast();

  /// Handle a WebSocket connection.
  Future<void> handle(WebSocketChannel webSocket) async {
    _connections.add(webSocket);

    // Subscribe to broadcast messages
    final subscription = _broadcastController.stream.listen((message) {
      webSocket.sink.add(message);
    });

    try {
      // Listen for incoming messages
      await for (final message in webSocket.stream) {
        _handleMessage(webSocket, message);
      }
    } on Exception catch (e, st) {
      _talker?.error('WebSocket error', e, st);
    } finally {
      await subscription.cancel();
      _connections.remove(webSocket);
      await webSocket.sink.close();
    }
  }

  /// Handle an incoming WebSocket message.
  void _handleMessage(WebSocketChannel sender, dynamic message) {
    try {
      final data = jsonDecode(message as String) as Map<String, dynamic>;
      final type = data['type'] as String?;
      final payload = data['data'];

      switch (type) {
        case 'element_selected':
          // Broadcast element selection to all clients
          broadcast(jsonEncode({
            'type': 'element_selected',
            'data': payload,
          }));

        case 'preview_request':
          // Handle preview request from web editor
          _handlePreviewRequest(sender, payload as Map<String, dynamic>?);

        case 'ping':
          sender.sink.add(jsonEncode({'type': 'pong'}));

        default:
          _talker?.warning('Unknown WebSocket message type: $type');
      }
    } on Exception catch (e, st) {
      _talker?.error('Error handling WebSocket message', e, st);
    }
  }

  /// Handle a preview request.
  void _handlePreviewRequest(
    WebSocketChannel sender,
    Map<String, dynamic>? payload,
  ) {
    if (payload == null) return;

    final url = payload['url'] as String?;
    if (url == null) return;

    // TODO(developer): Implement preview request handling
    // This would trigger the Flutter app to open a preview page

    sender.sink.add(jsonEncode({
      'type': 'preview_response',
      'data': {
        'status': 'accepted',
        'url': url,
      },
    }));
  }

  /// Broadcast a message to all connected clients.
  void broadcast(String message) {
    _broadcastController.add(message);
  }

  /// Send a message to a specific client.
  void send(WebSocketChannel client, String message) {
    client.sink.add(message);
  }

  /// Get the number of active connections.
  int get connectionCount => _connections.length;

  /// Close all connections.
  Future<void> closeAll() async {
    for (final connection in _connections) {
      await connection.sink.close();
    }
    _connections.clear();
    await _broadcastController.close();
  }
}
