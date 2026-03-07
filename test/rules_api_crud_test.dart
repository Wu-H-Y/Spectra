import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:relic/relic.dart';
import 'package:spectra/core/database/drift/app_database.dart';
import 'package:spectra/core/rust/api.dart';
import 'package:spectra/core/rust/frb_generated.dart';
import 'package:spectra/core/server/routes/rules_routes.dart';
import 'package:spectra/core/server/routes/server_routes.dart';

void main() {
  group('Rules API CRUD', () {
    test('supports status auth and full CRUD flow', () async {
      final database = AppDatabase(NativeDatabase.memory());
      const serverToken = 'st_test_token';
      late RelicServer server;

      final serverRoutes = ServerRoutes(
        isRunning: () => true,
        port: () => server.port,
        serverToken: () => serverToken,
        onStart: () async {},
        onStop: () async {},
      );
      final rulesRoutes = RulesRoutes(
        database: database,
        serverToken: () => serverToken,
      );

      final app = RelicApp()
        ..attach('/api/server', serverRoutes.router)
        ..attach('/api/rules', rulesRoutes.router);

      server = await app.serve(
        address: InternetAddress.loopbackIPv4,
        port: 0,
      );

      addTearDown(() async {
        await server.close(force: true);
        await database.close();
      });

      final client = HttpClient();
      addTearDown(client.close);

      final baseUri = Uri.parse('http://127.0.0.1:${server.port}');

      final unauthorizedList = await _sendJsonRequest(
        client: client,
        method: 'GET',
        uri: baseUri.resolve('/api/rules'),
      );
      expect(unauthorizedList.statusCode, 401);

      final statusResponse = await _sendJsonRequest(
        client: client,
        method: 'GET',
        uri: baseUri.resolve('/api/server/status'),
      );
      expect(statusResponse.statusCode, 200);
      expect(statusResponse.json['serverToken'], serverToken);

      final createBody = {
        'rule': _ruleEnvelope(
          ruleId: 'demo.min',
          name: '最小规则',
          description: '用于 CRUD 测试',
        ),
        'displayConfig': {'layout': 'grid'},
        'enabled': true,
      };

      final createResponse = await _sendJsonRequest(
        client: client,
        method: 'POST',
        uri: baseUri.resolve('/api/rules'),
        token: serverToken,
        body: createBody,
      );
      expect(createResponse.statusCode, 201);

      final createdId = createResponse.json['id'];
      expect(createdId, isA<int>());
      expect(createResponse.json['createdAt'], isA<String>());

      final listResponse = await _sendJsonRequest(
        client: client,
        method: 'GET',
        uri: baseUri.resolve('/api/rules'),
        token: serverToken,
      );
      expect(listResponse.statusCode, 200);
      expect(listResponse.json['total'], 1);
      final items = (listResponse.json['items'] as List<Object?>)
          .cast<Map<String, dynamic>>();
      expect(items, hasLength(1));
      expect(items.first['id'], createdId);
      expect(items.first['ruleId'], 'demo.min');
      expect(items.first['name'], '最小规则');
      expect(items.first['irVersion'], '1.0.0');

      final getResponse = await _sendJsonRequest(
        client: client,
        method: 'GET',
        uri: baseUri.resolve('/api/rules/$createdId'),
        token: serverToken,
      );
      expect(getResponse.statusCode, 200);
      final rule = getResponse.json['rule'] as Map<String, dynamic>;
      final metadata = rule['metadata'] as Map<String, dynamic>;
      expect(getResponse.json['id'], createdId);
      expect(getResponse.json['ruleId'], 'demo.min');
      expect(getResponse.json['enabled'], true);
      expect(getResponse.json['displayConfig'], {'layout': 'grid'});
      expect(metadata['name'], '最小规则');

      await Future<void>.delayed(const Duration(milliseconds: 5));

      final updateResponse = await _sendJsonRequest(
        client: client,
        method: 'PUT',
        uri: baseUri.resolve('/api/rules/$createdId'),
        token: serverToken,
        body: {
          'rule': _ruleEnvelope(
            ruleId: 'demo.min.updated',
            name: '最小规则-更新',
            description: '更新后的描述',
          ),
          'displayConfig': {'layout': 'list'},
          'enabled': false,
        },
      );
      expect(updateResponse.statusCode, 200);
      expect(updateResponse.json['id'], createdId);
      expect(updateResponse.json['updatedAt'], isA<String>());

      final getUpdatedResponse = await _sendJsonRequest(
        client: client,
        method: 'GET',
        uri: baseUri.resolve('/api/rules/$createdId'),
        token: serverToken,
      );
      expect(getUpdatedResponse.statusCode, 200);
      final updatedRule =
          getUpdatedResponse.json['rule'] as Map<String, dynamic>;
      final updatedMetadata = updatedRule['metadata'] as Map<String, dynamic>;
      expect(getUpdatedResponse.json['ruleId'], 'demo.min.updated');
      expect(getUpdatedResponse.json['enabled'], false);
      expect(getUpdatedResponse.json['displayConfig'], {'layout': 'list'});
      expect(updatedMetadata['name'], '最小规则-更新');
      expect(updatedMetadata['description'], '更新后的描述');

      final deleteResponse = await _sendJsonRequest(
        client: client,
        method: 'DELETE',
        uri: baseUri.resolve('/api/rules/$createdId'),
        token: serverToken,
      );
      expect(deleteResponse.statusCode, 200);
      expect(deleteResponse.json, {'id': createdId, 'deleted': true});

      final finalListResponse = await _sendJsonRequest(
        client: client,
        method: 'GET',
        uri: baseUri.resolve('/api/rules'),
        token: serverToken,
      );
      expect(finalListResponse.statusCode, 200);
      expect(finalListResponse.json['items'], isEmpty);
      expect(finalListResponse.json['total'], 0);
    });
  });

  test('validate route returns structured diagnostics', () async {
    final database = AppDatabase(NativeDatabase.memory());
    const serverToken = 'st_validate_token';
    late RelicServer server;

    RustLib.initMock(api: _MockValidationRustApi());

    final serverRoutes = ServerRoutes(
      isRunning: () => true,
      port: () => server.port,
      serverToken: () => serverToken,
      onStart: () async {},
      onStop: () async {},
    );
    final rulesRoutes = RulesRoutes(
      database: database,
      serverToken: () => serverToken,
    );

    final app = RelicApp()
      ..attach('/api/server', serverRoutes.router)
      ..attach('/api/rules', rulesRoutes.router);

    server = await app.serve(
      address: InternetAddress.loopbackIPv4,
      port: 0,
    );

    addTearDown(() async {
      await server.close(force: true);
      await database.close();
    });

    final client = HttpClient();
    addTearDown(client.close);

    final baseUri = Uri.parse('http://127.0.0.1:${server.port}');
    final ruleEnvelope =
        jsonDecode(
              await File('fixtures/ir_v1_invalid_edge.json').readAsString(),
            )
            as Map<String, dynamic>;

    final validationResponse = await _sendJsonRequest(
      client: client,
      method: 'POST',
      uri: baseUri.resolve('/api/rules/validate'),
      token: serverToken,
      body: {'rule': ruleEnvelope},
    );

    expect(validationResponse.statusCode, 400);
    final error = validationResponse.json['error'] as Map<String, dynamic>;
    expect(error['message'], '规则校验失败');
    final details = (error['details'] as List<Object?>)
        .cast<Map<String, dynamic>>();
    expect(details, hasLength(1));
    expect(details.first['code'], 'UNKNOWN_NODE');
    expect(details.first['path'], 'graph.edges[1].from.nodeId');
    expect(details.first['nodeId'], 'ghost_node');
  });
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

class _MockValidationRustApi extends RustLibApi {
  @override
  FfiValidationResult crateFfiValidateRule({required String envelopeJson}) {
    if (envelopeJson.contains('ghost_node')) {
      return const FfiValidationResult(
        valid: false,
        diagnostics: [
          FfiDiagnostic(
            code: 'UNKNOWN_NODE',
            path: 'graph.edges[1].from.nodeId',
            message: '引用了不存在的节点 `ghost_node`',
            nodeId: 'ghost_node',
          ),
        ],
      );
    }

    return const FfiValidationResult(valid: true, diagnostics: []);
  }

  @override
  bool crateFfiPing() => true;

  @override
  Future<FfiExecuteContext> crateFfiFfiExecuteContextDefault() async =>
      const FfiExecuteContext();

  @override
  Future<FfiExecuteResponse> crateFfiExecuteRule({
    required String envelopeJson,
    FfiExecuteContext? context,
  }) async {
    return FfiExecuteResponse(runId: context?.runId ?? 'mock-run');
  }
}
