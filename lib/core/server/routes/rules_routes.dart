import 'dart:async';
import 'dart:convert';

import 'package:relic/relic.dart';
import 'package:spectra/core/database/drift/app_database.dart';
import 'package:spectra/core/database/drift/rule_storage_cipher.dart';
import 'package:spectra/core/rust/api.dart';

/// Rules 路由的 WS 发布器。
typedef RulesWsPublisher = void Function(
  Map<String, dynamic> message, {
  String? sessionId,
  String? previewSessionId,
});

/// 规则 CRUD 路由。
class RulesRoutes {
  /// 创建规则路由。
  RulesRoutes({
    required this.database,
    required this.serverToken,
    RuleStorageCipher? storageCipher,
    this.publishWsMessage = _noopPublishWsMessage,
  }) : storageCipher =
           storageCipher ??
           RuleStorageCipher(
             keyProvider: InMemoryRuleMasterKeyProvider(
               _ruleStorageMasterKey,
             ).loadMasterKey,
           );

  static const _idParam = IntPathParam(#id);
  static const _ruleStorageMasterKey = <int>[
    115,
    112,
    101,
    99,
    116,
    114,
    97,
    46,
    114,
    117,
    108,
    101,
    46,
    115,
    116,
    111,
    114,
    97,
    103,
    101,
    46,
    109,
    97,
    115,
    116,
    101,
    114,
    46,
    118,
    49,
    33,
    33,
  ];

  /// Drift 数据库实例。
  final AppDatabase database;

  /// 规则级加密存储器。
  final RuleStorageCipher storageCipher;

  /// 当前 server token。
  final String Function() serverToken;

  /// 发布 WebSocket 消息。
  final RulesWsPublisher publishWsMessage;

  /// 创建包含所有规则接口的路由器。
  Router<Handler> get router => Router<Handler>()
    ..use('/', _authorizationMiddleware)
    ..get('/', _listRules)
    ..get('/:id', _getRule)
    ..post('/', _createRule)
    ..post('/execute', _executeRule)
    ..post('/validate', _validateRule)
    ..put('/:id', _updateRule)
    ..delete('/:id', _deleteRule);

  Handler _authorizationMiddleware(Handler innerHandler) {
    return (request) async {
      // 检查 host-only 标记（仅 /execute 需要）
      final path = request.url.path;
      if (path.endsWith('/execute')) {
        final hostOnly = request.headers['x-host-only']?.firstOrNull;
        if (hostOnly != 'true') {
          return _errorResponse(
            statusCode: 403,
            type: 'forbidden',
            message: '此接口仅允许 Flutter 主机调用，Web 编辑器禁止访问',
          );
        }
      }

      final authorization = request.headers.authorization;
      if (authorization is! BearerAuthorizationHeader ||
          authorization.token != serverToken()) {
        return _errorResponse(
          statusCode: 401,
          type: 'unauthorized',
          message: '缺少或无效的 serverToken',
        );
      }

      return innerHandler(request);
    };
  }

  Future<Response> _listRules(Request request) async {
    final items = await database.listRules();
    return _jsonResponse({
      'items': items
          .map(
            (item) => {
              'id': item.id,
              'ruleId': item.ruleId,
              'name': item.name,
              'irVersion': item.irVersion,
              'updatedAt': item.updatedAt.toUtc().toIso8601String(),
            },
          )
          .toList(),
      'total': items.length,
    });
  }

  Future<Response> _getRule(Request request) async {
    final rule = await database.getRuleById(
      request.pathParameters.get(_idParam),
    );
    if (rule == null) {
      return _errorResponse(
        statusCode: 404,
        type: 'not_found',
        message: '规则不存在',
      );
    }

    return _jsonResponse(_serializeRule(rule));
  }

  Future<Response> _createRule(Request request) async {
    final body = await _readRuleRequest(request);
    if (body.error != null) {
      return body.error!;
    }

    try {
      final createdRule = await database.createRule(
        ruleId: body.ruleId!,
        name: body.name!,
        description: body.description,
        irVersion: body.irVersion!,
        ruleEnvelopeJson: body.ruleEnvelopeJson!,
        displayConfigJson: body.displayConfigJson,
        enabled: body.enabled!,
      );
      return _jsonResponse(
        {
          'id': createdRule.id,
          'createdAt': createdRule.createdAt.toUtc().toIso8601String(),
        },
        statusCode: 201,
      );
    } on Exception catch (error) {
      return _writeFailureResponse(error);
    }
  }

  Future<Response> _updateRule(Request request) async {
    final id = request.pathParameters.get(_idParam);
    final existingRule = await database.getRuleById(id);
    if (existingRule == null) {
      return _errorResponse(
        statusCode: 404,
        type: 'not_found',
        message: '规则不存在',
      );
    }

    final body = await _readRuleRequest(
      request,
      defaultEnabled: existingRule.enabled,
    );
    if (body.error != null) {
      return body.error!;
    }

    try {
      final updatedRule = await database.updateRule(
        id: id,
        ruleId: body.ruleId!,
        name: body.name!,
        description: body.description,
        irVersion: body.irVersion!,
        ruleEnvelopeJson: body.ruleEnvelopeJson!,
        displayConfigJson: body.displayConfigJson,
        enabled: body.enabled!,
      );
      if (updatedRule == null) {
        return _errorResponse(
          statusCode: 404,
          type: 'not_found',
          message: '规则不存在',
        );
      }

      return _jsonResponse({
        'id': updatedRule.id,
        'updatedAt': updatedRule.updatedAt.toUtc().toIso8601String(),
      });
    } on Exception catch (error) {
      return _writeFailureResponse(error);
    }
  }

  Future<Response> _deleteRule(Request request) async {
    final id = request.pathParameters.get(_idParam);
    final deleted = await database.deleteRuleById(id);
    if (!deleted) {
      return _errorResponse(
        statusCode: 404,
        type: 'not_found',
        message: '规则不存在',
      );
    }

    return _jsonResponse({'id': id, 'deleted': true});
  }

  Future<Response> _validateRule(Request request) async {
    final body = await _readRuleRequest(request);
    if (body.error != null) {
      return body.error!;
    }

    try {
      final validation = validateRule(envelopeJson: body.ruleEnvelopeJson!);
      if (validation.valid) {
        return _jsonResponse({
          'valid': true,
          'diagnostics': <Object?>[],
        });
      }

      final details = validation.diagnostics.map((diag) {
        final detail = <String, Object?>{
          'code': diag.code,
          'path': diag.path,
          'message': diag.message,
        };
        if (diag.nodeId != null) {
          detail['nodeId'] = diag.nodeId;
        }
        return detail;
      }).toList();

      return _errorResponse(
        statusCode: 400,
        type: 'bad_request',
        message: '规则校验失败',
        details: details,
      );
    } on Exception catch (error) {
      return _writeFailureResponse(error);
    }
  }

  Future<Response> _executeRule(Request request) async {
    final parsed = await _readExecuteRequest(request);
    if (parsed.error != null) {
      return parsed.error!;
    }

    final runId = parsed.runId ?? _runId();
    final traceId = parsed.traceId;
    final sessionId = parsed.sessionId;
    final previewSessionId = parsed.previewSessionId;
    final envelopeJson = jsonEncode(parsed.rule);

    publishWsMessage(
      _nodeEventEnvelope(
        event: 'run_started',
        runId: runId,
        seq: 1,
        traceId: traceId,
      ),
      sessionId: sessionId,
      previewSessionId: previewSessionId,
    );

    unawaited(
      _runExecuteRule(
        envelopeJson: envelopeJson,
        ruleId: parsed.ruleId!,
        runId: runId,
        traceId: traceId,
        channelCapacity: parsed.channelCapacity,
        sessionId: sessionId,
        previewSessionId: previewSessionId,
      ),
    );

    return _jsonResponse(
      {
        'runId': runId,
        'status': 'accepted',
      },
      statusCode: 202,
    );
  }

  Future<void> _runExecuteRule({
    required String envelopeJson,
    required String ruleId,
    required String runId,
    required String? traceId,
    required int? channelCapacity,
    required String? sessionId,
    required String? previewSessionId,
  }) async {
    final persistedKvEncrypted = await database.getRuleKvStoreEncryptedByRuleId(
      ruleId,
    );
    final persistedCookieEncrypted = await database
        .getRuleCookieJarEncryptedByRuleId(ruleId);
    String? persistedKvJson;
    String? persistedCookieJarJson;
    if (persistedKvEncrypted != null) {
      persistedKvJson = await storageCipher.decrypt(
        ruleId: ruleId,
        encryptedPayload: persistedKvEncrypted,
      );
    }
    if (persistedCookieEncrypted != null) {
      persistedCookieJarJson = await storageCipher.decrypt(
        ruleId: ruleId,
        encryptedPayload: persistedCookieEncrypted,
      );
    }

    final response = await executeRule(
      envelopeJson: envelopeJson,
      context: FfiExecuteContext(
        runId: runId,
        traceId: traceId,
        channelCapacity: channelCapacity,
        ruleId: ruleId,
        ruleKvJson: persistedKvJson,
        cookieJarJson: persistedCookieJarJson,
      ),
    );

    if (response.error == null) {
      final nextKvEncrypted = response.ruleKvJson == null
          ? null
          : await storageCipher.encrypt(
              ruleId: ruleId,
              plaintext: response.ruleKvJson!,
            );
      await database.updateRuleKvStoreEncryptedByRuleId(
        ruleId: ruleId,
        kvStoreEncrypted: nextKvEncrypted,
      );

      final nextCookieEncrypted = response.cookieJarJson == null
          ? null
          : await storageCipher.encrypt(
              ruleId: ruleId,
              plaintext: response.cookieJarJson!,
            );
      await database.updateRuleCookieJarEncryptedByRuleId(
        ruleId: ruleId,
        cookieJarEncrypted: nextCookieEncrypted,
      );
    }

    publishWsMessage(
      _nodeEventEnvelope(
        event: 'run_finished',
        runId: runId,
        seq: 2,
        traceId: traceId,
        success: response.error == null,
      ),
      sessionId: sessionId,
      previewSessionId: previewSessionId,
    );
  }

  Future<_ParsedRuleRequest> _readRuleRequest(
    Request request, {
    bool defaultEnabled = true,
  }) async {
    try {
      final rawBody = await request.readAsString(maxLength: 1024 * 1024);
      final decoded = jsonDecode(rawBody);
      if (decoded is! Map<String, dynamic>) {
        return _ParsedRuleRequest(
          error: _errorResponse(
            statusCode: 400,
            type: 'bad_request',
            message: '请求体必须是 JSON 对象',
          ),
        );
      }

      final rule = decoded['rule'];
      if (rule is! Map<String, dynamic>) {
        return _ParsedRuleRequest(
          error: _validationError(
            path: 'rule',
            message: '缺少规则数据',
          ),
        );
      }

      final metadata = rule['metadata'];
      if (metadata is! Map<String, dynamic>) {
        return _ParsedRuleRequest(
          error: _validationError(
            path: 'rule.metadata',
            message: '缺少规则元数据',
          ),
        );
      }

      final ruleId = _requireString(
        metadata,
        key: 'ruleId',
        path: 'rule.metadata.ruleId',
      );
      if (ruleId.error != null) {
        return _ParsedRuleRequest(error: ruleId.error);
      }

      final name = _requireString(
        metadata,
        key: 'name',
        path: 'rule.metadata.name',
      );
      if (name.error != null) {
        return _ParsedRuleRequest(error: name.error);
      }

      final irVersion = _requireString(
        rule,
        key: 'irVersion',
        path: 'rule.irVersion',
      );
      if (irVersion.error != null) {
        return _ParsedRuleRequest(error: irVersion.error);
      }

      final descriptionValue = metadata['description'];
      if (descriptionValue != null && descriptionValue is! String) {
        return _ParsedRuleRequest(
          error: _validationError(
            path: 'rule.metadata.description',
            message: 'description 必须是字符串或 null',
          ),
        );
      }

      final enabledValue = decoded['enabled'];
      if (enabledValue != null && enabledValue is! bool) {
        return _ParsedRuleRequest(
          error: _validationError(
            path: 'enabled',
            message: 'enabled 必须是布尔值',
          ),
        );
      }

      final displayConfigJson = decoded.containsKey('displayConfig')
          ? jsonEncode(decoded['displayConfig'])
          : null;

      return _ParsedRuleRequest(
        ruleId: ruleId.value,
        name: name.value,
        description: descriptionValue as String?,
        irVersion: irVersion.value,
        ruleEnvelopeJson: jsonEncode(rule),
        displayConfigJson: displayConfigJson,
        enabled: enabledValue as bool? ?? defaultEnabled,
      );
    } on FormatException {
      return _ParsedRuleRequest(
        error: _errorResponse(
          statusCode: 400,
          type: 'bad_request',
          message: '请求体不是合法 JSON',
        ),
      );
    }
  }

  Future<_ParsedExecuteRequest> _readExecuteRequest(Request request) async {
    try {
      final rawBody = await request.readAsString(maxLength: 1024 * 1024);
      final decoded = jsonDecode(rawBody);
      if (decoded is! Map<String, dynamic>) {
        return _ParsedExecuteRequest(
          error: _errorResponse(
            statusCode: 400,
            type: 'bad_request',
            message: '请求体必须是 JSON 对象',
          ),
        );
      }

      final rule = decoded['rule'];
      if (rule is! Map<String, dynamic>) {
        return _ParsedExecuteRequest(
          error: _validationError(
            path: 'rule',
            message: '缺少规则数据',
          ),
        );
      }

      final metadata = rule['metadata'];
      if (metadata is! Map<String, dynamic>) {
        return _ParsedExecuteRequest(
          error: _validationError(
            path: 'rule.metadata',
            message: '缺少规则元数据',
          ),
        );
      }

      final ruleId = _requireString(
        metadata,
        key: 'ruleId',
        path: 'rule.metadata.ruleId',
      );
      if (ruleId.error != null) {
        return _ParsedExecuteRequest(error: ruleId.error);
      }

      final context = decoded['context'];
      if (context != null && context is! Map<String, dynamic>) {
        return _ParsedExecuteRequest(
          error: _validationError(
            path: 'context',
            message: 'context 必须是对象或 null',
          ),
        );
      }

      final contextMap = context as Map<String, dynamic>?;
      final runId = _readOptionalString(
        contextMap,
        key: 'runId',
        path: 'context.runId',
      );
      if (runId.error != null) {
        return _ParsedExecuteRequest(error: runId.error);
      }

      final traceId = _readOptionalString(
        contextMap,
        key: 'traceId',
        path: 'context.traceId',
      );
      if (traceId.error != null) {
        return _ParsedExecuteRequest(error: traceId.error);
      }

      final sessionId = _readOptionalString(
        contextMap,
        key: 'sessionId',
        path: 'context.sessionId',
      );
      if (sessionId.error != null) {
        return _ParsedExecuteRequest(error: sessionId.error);
      }

      final previewSessionId = _readOptionalString(
        contextMap,
        key: 'previewSessionId',
        path: 'context.previewSessionId',
      );
      if (previewSessionId.error != null) {
        return _ParsedExecuteRequest(error: previewSessionId.error);
      }

      final channelCapacity = _readOptionalInt(
        contextMap,
        key: 'channelCapacity',
        path: 'context.channelCapacity',
      );
      if (channelCapacity.error != null) {
        return _ParsedExecuteRequest(error: channelCapacity.error);
      }

      return _ParsedExecuteRequest(
        rule: rule,
        ruleId: ruleId.value,
        runId: runId.value,
        traceId: traceId.value,
        sessionId: sessionId.value,
        previewSessionId: previewSessionId.value,
        channelCapacity: channelCapacity.value,
      );
    } on FormatException {
      return _ParsedExecuteRequest(
        error: _errorResponse(
          statusCode: 400,
          type: 'bad_request',
          message: '请求体不是合法 JSON',
        ),
      );
    }
  }

  _RequiredStringResult _requireString(
    Map<String, dynamic> source, {
    required String key,
    required String path,
  }) {
    final value = source[key];
    if (value is! String || value.trim().isEmpty) {
      return _RequiredStringResult(
        error: _validationError(path: path, message: '$key 不能为空'),
      );
    }
    return _RequiredStringResult(value: value.trim());
  }

  _OptionalStringResult _readOptionalString(
    Map<String, dynamic>? source, {
    required String key,
    required String path,
  }) {
    if (source == null || !source.containsKey(key) || source[key] == null) {
      return const _OptionalStringResult();
    }

    final value = source[key];
    if (value is! String || value.trim().isEmpty) {
      return _OptionalStringResult(
        error: _validationError(path: path, message: '$key 必须是非空字符串'),
      );
    }

    return _OptionalStringResult(value: value.trim());
  }

  _OptionalIntResult _readOptionalInt(
    Map<String, dynamic>? source, {
    required String key,
    required String path,
  }) {
    if (source == null || !source.containsKey(key) || source[key] == null) {
      return const _OptionalIntResult();
    }

    final value = source[key];
    if (value is! int) {
      return _OptionalIntResult(
        error: _validationError(path: path, message: '$key 必须是整数'),
      );
    }

    return _OptionalIntResult(value: value);
  }

  Map<String, dynamic> _nodeEventEnvelope({
    required String event,
    required String runId,
    required int seq,
    required String? traceId,
    bool? success,
  }) {
    final data = <String, dynamic>{
      'event': event,
      'runId': runId,
      'seq': seq,
    };
    if (traceId != null) {
      data['traceId'] = traceId;
    }
    if (success != null) {
      data['success'] = success;
    }

    return {
      'v': 1,
      'type': 'node_event',
      'data': data,
    };
  }

  Response _writeFailureResponse(Exception error) {
    final message = error.toString();
    if (message.contains('UNIQUE constraint failed')) {
      return _errorResponse(
        statusCode: 400,
        type: 'bad_request',
        message: 'ruleId 已存在',
      );
    }

    return _errorResponse(
      statusCode: 500,
      type: 'internal_error',
      message: '服务端内部错误',
    );
  }

  Map<String, dynamic> _serializeRule(RulesV1Data rule) {
    return {
      'id': rule.id,
      'ruleId': rule.ruleId,
      'rule': jsonDecode(rule.ruleEnvelopeJson),
      'displayConfig': rule.displayConfigJson == null
          ? null
          : jsonDecode(rule.displayConfigJson!),
      'enabled': rule.enabled,
      'createdAt': rule.createdAt.toUtc().toIso8601String(),
      'updatedAt': rule.updatedAt.toUtc().toIso8601String(),
    };
  }

  Response _validationError({
    required String path,
    required String message,
  }) {
    return _errorResponse(
      statusCode: 400,
      type: 'bad_request',
      message: message,
      details: [
        {
          'path': path,
          'code': 'REQUIRED_FIELD',
          'message': message,
        },
      ],
    );
  }

  Response _jsonResponse(
    Map<String, dynamic> body, {
    int statusCode = 200,
  }) {
    return Response(
      statusCode,
      body: Body.fromString(
        jsonEncode(body),
        mimeType: MimeType.json,
      ),
    );
  }

  Response _errorResponse({
    required int statusCode,
    required String type,
    required String message,
    List<Map<String, dynamic>> details = const [],
  }) {
    return _jsonResponse(
      {
        'error': {
          'type': type,
          'message': message,
          'requestId': _requestId(),
          'details': details,
        },
      },
      statusCode: statusCode,
    );
  }

  String _requestId() {
    final now = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'req_${now.toRadixString(16)}';
  }

  String _runId() {
    final now = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'run_${now.toRadixString(16)}';
  }

  static void _noopPublishWsMessage(
    Map<String, dynamic> _, {
    String? sessionId,
    String? previewSessionId,
  }) {}
}

class _ParsedRuleRequest {
  const _ParsedRuleRequest({
    this.ruleId,
    this.name,
    this.description,
    this.irVersion,
    this.ruleEnvelopeJson,
    this.displayConfigJson,
    this.enabled,
    this.error,
  });

  final String? ruleId;
  final String? name;
  final String? description;
  final String? irVersion;
  final String? ruleEnvelopeJson;
  final String? displayConfigJson;
  final bool? enabled;
  final Response? error;
}

class _RequiredStringResult {
  const _RequiredStringResult({this.value, this.error});

  final String? value;
  final Response? error;
}

class _OptionalStringResult {
  const _OptionalStringResult({this.value, this.error});

  final String? value;
  final Response? error;
}

class _OptionalIntResult {
  const _OptionalIntResult({this.value, this.error});

  final int? value;
  final Response? error;
}

class _ParsedExecuteRequest {
  const _ParsedExecuteRequest({
    this.rule,
    this.ruleId,
    this.runId,
    this.traceId,
    this.sessionId,
    this.previewSessionId,
    this.channelCapacity,
    this.error,
  });

  final Map<String, dynamic>? rule;
  final String? ruleId;
  final String? runId;
  final String? traceId;
  final String? sessionId;
  final String? previewSessionId;
  final int? channelCapacity;
  final Response? error;
}
