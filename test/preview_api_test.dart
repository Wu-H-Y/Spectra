import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/database/drift/app_database.dart';
import 'package:spectra/core/server/server_provider.dart';

void main() {
  test(
    'preview open returns ws channel and preview-scoped selector callback',
    () async {
      Server.debugDatabaseFactory = () => AppDatabase(NativeDatabase.memory());

      final container = ProviderContainer();
      final serverSubscription = container.listen<ServerStatus>(
        serverProvider,
        (_, _) {},
      );
      addTearDown(serverSubscription.close);
      addTearDown(container.dispose);
      addTearDown(() => Server.debugDatabaseFactory = AppDatabase.new);

      final server = container.read(serverProvider.notifier);
      await server.start();
      addTearDown(server.stop);

      final status = container.read(serverProvider);
      final baseUri = Uri.parse('http://127.0.0.1:${status.port}');
      final wsUri = Uri.parse('ws://127.0.0.1:${status.port}/ws');
      final client = HttpClient();
      addTearDown(client.close);

      final statusResponse = await _sendJsonRequest(
        client: client,
        method: 'GET',
        uri: baseUri.resolve('/api/server/status'),
      );
      final serverToken = statusResponse.json['serverToken'] as String;

      final openResponse = await _sendJsonRequest(
        client: client,
        method: 'POST',
        uri: baseUri.resolve('/api/preview/open'),
        token: serverToken,
        body: {
          'sessionId': 'session_preview_test',
          'url': 'https://example.com/list',
        },
      );

      expect(openResponse.statusCode, 200);
      expect(openResponse.json['opened'], true);
      expect(openResponse.json['debugUrl'], 'https://example.com/list');

      final previewSessionId = openResponse.json['previewSessionId'] as String;
      expect(previewSessionId, startsWith('preview_'));
      expect(
        openResponse.json['wsChannel'],
        {'previewSessionId': previewSessionId},
      );

      final secondOpenResponse = await _sendJsonRequest(
        client: client,
        method: 'POST',
        uri: baseUri.resolve('/api/preview/open'),
        token: serverToken,
        body: {
          'sessionId': 'session_preview_test_other',
          'url': 'https://example.com/other',
        },
      );
      final otherPreviewSessionId =
          secondOpenResponse.json['previewSessionId'] as String;
      expect(otherPreviewSessionId, isNot(previewSessionId));

      final socket = await WebSocket.connect(wsUri.toString());
      final collector = _WsCollector(socket);
      addTearDown(collector.close);

      expect(await collector.nextType('connected'), isNotNull);

      socket.add(
        jsonEncode({
          'type': 'auth',
          'data': {'token': serverToken},
        }),
      );
      expect(await collector.nextType('auth_ok'), isNotNull);

      socket.add(
        jsonEncode({
          'type': 'subscribe',
          'data': {'previewSessionId': previewSessionId},
        }),
      );
      final subscribedMessage = await collector.nextType('subscribed');
      expect(subscribedMessage['data'], {'previewSessionId': previewSessionId});

      server
        ..debugPublishElementSelected(
          previewSessionId: otherPreviewSessionId,
          selector: '.item > a.other',
          selectorType: 'css',
          outerHtml: '<a class="other">Other</a>',
          textContent: 'Other',
        )
        ..debugPublishElementSelected(
          previewSessionId: previewSessionId,
          selector: '.item > a.title',
          selectorType: 'css',
          outerHtml: '<a class="title">Title A</a>',
          textContent: 'Title A',
        );

      final selected = await collector.nextType('element_selected');
      expect(selected['v'], 1);
      final selectedData = selected['data'] as Map<String, dynamic>;
      expect(selectedData['previewSessionId'], previewSessionId);
      expect(selectedData['previewSessionId'], isNot(otherPreviewSessionId));
      expect(selectedData['selector'], '.item > a.title');
      expect(selectedData['selectorType'], 'css');
      expect(selectedData['textContent'], 'Title A');
    },
  );
}

Future<({int statusCode, Map<String, dynamic> json})> _sendJsonRequest({
  required HttpClient client,
  required String method,
  required Uri uri,
  String? token,
  Map<String, dynamic>? body,
}) async {
  final request = await client.openUrl(method, uri);
  if (token != null) {
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
  }
  if (body != null) {
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(body));
  }

  final response = await request.close();
  final responseText = await response.transform(utf8.decoder).join();
  final jsonBody = jsonDecode(responseText) as Map<String, dynamic>;
  return (statusCode: response.statusCode, json: jsonBody);
}

class _WsCollector {
  _WsCollector(this._socket) {
    _subscription = _socket.listen((event) {
      if (event is! String) {
        return;
      }

      final message = jsonDecode(event) as Map<String, dynamic>;
      _messages.add(message);
      for (final waiter in List<_PendingMessage>.from(_waiters)) {
        if (!waiter.completer.isCompleted && waiter.matcher(message)) {
          waiter.completer.complete(message);
          _waiters.remove(waiter);
        }
      }
    });
  }

  final WebSocket _socket;
  late final StreamSubscription<dynamic> _subscription;
  final List<Map<String, dynamic>> _messages = [];
  final List<_PendingMessage> _waiters = [];

  Future<Map<String, dynamic>> nextType(String type) {
    return _nextMessage((message) => message['type'] == type);
  }

  Future<Map<String, dynamic>> _nextMessage(
    bool Function(Map<String, dynamic> message) matcher,
  ) {
    for (final message in _messages) {
      if (matcher(message)) {
        return Future.value(message);
      }
    }

    final completer = Completer<Map<String, dynamic>>();
    _waiters.add(_PendingMessage(matcher, completer));
    return completer.future.timeout(const Duration(seconds: 3));
  }

  Future<void> close() async {
    await _subscription.cancel();
    await _socket.close();
  }
}

class _PendingMessage {
  const _PendingMessage(this.matcher, this.completer);

  final bool Function(Map<String, dynamic> message) matcher;
  final Completer<Map<String, dynamic>> completer;
}
