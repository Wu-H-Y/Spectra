import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/database/drift/app_database.dart';
import 'package:spectra/core/rust/api.dart';
import 'package:spectra/core/rust/frb_generated.dart';
import 'package:spectra/core/server/server_provider.dart';

void main() {
  test(
    'execute route returns runId and streams run-scoped events over ws',
    () async {
      RustLib.initMock(api: _MockExecuteRustApi());
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
      const runId = 'run_execute_ws_test';

      final firstSocket = await WebSocket.connect(wsUri.toString());
      final firstCollector = _WsCollector(firstSocket);
      addTearDown(firstCollector.close);

      expect(await firstCollector.nextType('connected'), isNotNull);

      firstSocket.add(
        jsonEncode({
          'type': 'auth',
          'data': {'token': serverToken},
        }),
      );
      expect(await firstCollector.nextType('auth_ok'), isNotNull);

      firstSocket.add(
        jsonEncode({
          'type': 'subscribe',
          'data': {'runId': runId},
        }),
      );
      final subscribedMessage = await firstCollector.nextType('subscribed');
      expect(subscribedMessage['data'], {'runId': runId});

      final executeResponse = await _sendJsonRequest(
        client: client,
        method: 'POST',
        uri: baseUri.resolve('/api/rules/execute'),
        token: serverToken,
        body: {
          'rule': _ruleEnvelope(
            ruleId: 'demo.execute',
            name: '执行规则',
            description: '用于 execute + ws 测试',
          ),
          'context': {
            'runId': runId,
            'traceId': 'trace_execute_ws_test',
            'sessionId': 'session_execute_ws_test',
          },
        },
      );

      expect(executeResponse.statusCode, 202);
      expect(executeResponse.json, {'runId': runId, 'status': 'accepted'});

      final startedMessage = await firstCollector.nextNodeEvent(
        runId,
        'run_started',
      );
      final finishedMessage = await firstCollector.nextNodeEvent(
        runId,
        'run_finished',
      );
      final startedData = startedMessage['data'] as Map<String, dynamic>;
      final finishedData = finishedMessage['data'] as Map<String, dynamic>;
      expect(startedData['seq'], 1);
      expect(finishedData['seq'], 2);
      expect(finishedData['success'], true);

      final replaySocket = await WebSocket.connect(wsUri.toString());
      final replayCollector = _WsCollector(replaySocket);
      addTearDown(replayCollector.close);

      expect(await replayCollector.nextType('connected'), isNotNull);

      replaySocket.add(
        jsonEncode({
          'type': 'auth',
          'data': {'token': serverToken},
        }),
      );
      expect(await replayCollector.nextType('auth_ok'), isNotNull);

      replaySocket.add(
        jsonEncode({
          'type': 'subscribe',
          'data': {'runId': runId},
        }),
      );
      expect(await replayCollector.nextType('subscribed'), isNotNull);

      final replayStarted = await replayCollector.nextNodeEvent(
        runId,
        'run_started',
      );
      final replayFinished = await replayCollector.nextNodeEvent(
        runId,
        'run_finished',
      );
      final replayStartedData = replayStarted['data'] as Map<String, dynamic>;
      final replayFinishedData = replayFinished['data'] as Map<String, dynamic>;
      expect(replayStartedData['seq'], 1);
      expect(replayFinishedData['seq'], 2);
    },
  );
}

Map<String, dynamic> _ruleEnvelope({
  required String ruleId,
  required String name,
  required String description,
}) {
  return {
    'irVersion': '1.0.0',
    'metadata': {
      'ruleId': ruleId,
      'name': name,
      'description': description,
    },
    'graph': {
      'nodes': <dynamic>[],
      'edges': <dynamic>[],
      'phaseEntrypoints': <String, dynamic>{},
    },
    'normalizedOutputs': <String, dynamic>{},
    'capabilities': {
      'supportsPagination': false,
      'supportsConcurrency': false,
      'requiresAuth': false,
    },
  };
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

  Future<Map<String, dynamic>> nextNodeEvent(String runId, String event) {
    return _nextMessage((message) {
      if (message['type'] != 'node_event') {
        return false;
      }
      final data = message['data'];
      return data is Map<String, dynamic> &&
          data['runId'] == runId &&
          data['event'] == event;
    });
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

class _MockExecuteRustApi extends RustLibApi {
  @override
  bool crateFfiPing() => true;

  @override
  Future<FfiExecuteContext> crateFfiFfiExecuteContextDefault() async =>
      const FfiExecuteContext();

  @override
  FfiValidationResult crateFfiValidateRule({required String envelopeJson}) {
    return const FfiValidationResult(valid: true, diagnostics: []);
  }

  @override
  Future<FfiExecuteResponse> crateFfiExecuteRule({
    required String envelopeJson,
    FfiExecuteContext? context,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    return FfiExecuteResponse(runId: context?.runId ?? 'mock-run');
  }
}
