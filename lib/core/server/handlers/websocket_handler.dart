import 'dart:async';
import 'dart:convert';

import 'package:talker_flutter/talker_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// 用于与 Web 编辑器实时通信的 WebSocket 处理器。
class WebSocketHandler {
  /// 创建 WebSocket 处理器。
  WebSocketHandler({Talker? talker}) : _talker = talker;

  /// Talker 实例用于日志记录。
  final Talker? _talker;

  /// 活跃的 WebSocket 连接。
  final Set<WebSocketChannel> _connections = {};

  /// 用于广播消息的流控制器。
  final StreamController<String> _broadcastController =
      StreamController<String>.broadcast();

  /// 处理 WebSocket 连接。
  Future<void> handle(WebSocketChannel webSocket) async {
    _connections.add(webSocket);

    // 订阅广播消息
    final subscription = _broadcastController.stream.listen((message) {
      webSocket.sink.add(message);
    });

    try {
      // 监听传入消息
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

  /// 处理传入的 WebSocket 消息。
  void _handleMessage(WebSocketChannel sender, dynamic message) {
    try {
      final data = jsonDecode(message as String) as Map<String, dynamic>;
      final type = data['type'] as String?;
      final payload = data['data'];

      switch (type) {
        case 'element_selected':
          // 向所有客户端广播元素选择
          broadcast(
            jsonEncode({
              'type': 'element_selected',
              'data': payload,
            }),
          );

        case 'preview_request':
          // 处理来自 Web 编辑器的预览请求
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

  /// 处理预览请求。
  void _handlePreviewRequest(
    WebSocketChannel sender,
    Map<String, dynamic>? payload,
  ) {
    if (payload == null) return;

    final url = payload['url'] as String?;
    if (url == null) return;

    // TODO(developer): 实现预览请求处理
    // 这将触发 Flutter 应用打开预览页面

    sender.sink.add(
      jsonEncode({
        'type': 'preview_response',
        'data': {
          'status': 'accepted',
          'url': url,
        },
      }),
    );
  }

  /// 向所有连接的客户端广播消息。
  void broadcast(String message) {
    _broadcastController.add(message);
  }

  /// 向特定客户端发送消息。
  void send(WebSocketChannel client, String message) {
    client.sink.add(message);
  }

  /// 获取活跃连接数。
  int get connectionCount => _connections.length;

  /// 关闭所有连接。
  Future<void> closeAll() async {
    for (final connection in _connections) {
      await connection.sink.close();
    }
    _connections.clear();
    await _broadcastController.close();
  }
}
