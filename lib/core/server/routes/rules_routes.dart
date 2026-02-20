import 'dart:convert';

import 'package:relic/relic.dart';

import 'package:spectra/core/crawler/executor/executor.dart';

/// 规则 CRUD 操作路由。
class RulesRoutes {
  /// 创建规则路由。
  RulesRoutes({
    RuleParser? ruleParser,
  }) : _ruleParser = ruleParser ?? RuleParser();

  final RuleParser _ruleParser;

  /// 创建包含所有路由的路由器。
  Router<Handler> get router => Router<Handler>()
    // GET /api/rules - 列出所有规则
    ..get('/api/rules', _listRules)
    // GET /api/rules/:id - 获取单个规则
    ..get('/api/rules/:id', _getRule)
    // POST /api/rules - 创建新规则
    ..post('/api/rules', _createRule)
    // PUT /api/rules/:id - 更新已有规则
    ..put('/api/rules/:id', _updateRule)
    // DELETE /api/rules/:id - 删除规则
    ..delete('/api/rules/:id', _deleteRule)
    // POST /api/validate - 验证规则
    ..post('/api/validate', _validateRule)
    // POST /api/execute - 对 URL 执行规则
    ..post('/api/execute', _executeRule);

  /// 获取所有规则。
  Future<Response> _listRules(Request request) async {
    // TODO(developer): 实现实际的数据库查询
    return Response.ok(
      body: Body.fromString(
        jsonEncode([]),
        mimeType: MimeType.json,
      ),
    );
  }

  /// 根据 ID 获取单个规则。
  Future<Response> _getRule(Request request) async {
    final id = request.rawPathParameters[#id];
    // TODO(developer): 实现实际的数据库查询
    return Response.notFound(
      body: Body.fromString(
        jsonEncode({'error': 'Rule not found', 'id': id}),
        mimeType: MimeType.json,
      ),
    );
  }

  /// 创建新规则。
  Future<Response> _createRule(Request request) async {
    try {
      final body = await request.readAsString();
      final result = _ruleParser.parseAndValidate(body);

      if (!result.isSuccess) {
        return Response.badRequest(
          body: Body.fromString(
            jsonEncode({
              'valid': false,
              'errors': result.errors,
            }),
            mimeType: MimeType.json,
          ),
        );
      }

      // TODO(developer): 保存到数据库

      return Response.ok(
        body: Body.fromString(
          _ruleParser.toJsonString(result.rule!),
          mimeType: MimeType.json,
        ),
      );
    } on FormatException catch (e) {
      return Response.badRequest(
        body: Body.fromString(
          jsonEncode({'error': 'Invalid JSON', 'message': e.message}),
          mimeType: MimeType.json,
        ),
      );
    } on Exception catch (e) {
      return Response.badRequest(
        body: Body.fromString(
          jsonEncode({'error': 'Invalid request', 'message': e.toString()}),
          mimeType: MimeType.json,
        ),
      );
    }
  }

  /// 更新已有规则。
  Future<Response> _updateRule(Request request) async {
    try {
      final body = await request.readAsString();
      final result = _ruleParser.parseAndValidate(body);

      if (!result.isSuccess) {
        return Response.badRequest(
          body: Body.fromString(
            jsonEncode({
              'valid': false,
              'errors': result.errors,
            }),
            mimeType: MimeType.json,
          ),
        );
      }

      // TODO(developer): 在数据库中更新

      return Response.ok(
        body: Body.fromString(
          _ruleParser.toJsonString(result.rule!),
          mimeType: MimeType.json,
        ),
      );
    } on FormatException catch (e) {
      return Response.badRequest(
        body: Body.fromString(
          jsonEncode({'error': 'Invalid JSON', 'message': e.message}),
          mimeType: MimeType.json,
        ),
      );
    } on Exception catch (e) {
      return Response.badRequest(
        body: Body.fromString(
          jsonEncode({'error': 'Invalid request', 'message': e.toString()}),
          mimeType: MimeType.json,
        ),
      );
    }
  }

  /// 删除规则。
  Future<Response> _deleteRule(Request request) async {
    final id = request.rawPathParameters[#id];
    // TODO(developer): 实现实际的数据库删除

    return Response.ok(
      body: Body.fromString(
        jsonEncode({'deleted': true, 'id': id}),
        mimeType: MimeType.json,
      ),
    );
  }

  /// 验证规则。
  Future<Response> _validateRule(Request request) async {
    try {
      final body = await request.readAsString();
      final result = _ruleParser.parseAndValidate(body);

      return Response.ok(
        body: Body.fromString(
          jsonEncode({
            'valid': result.isSuccess,
            'errors': result.errors,
            'rule': result.rule?.toJson(),
          }),
          mimeType: MimeType.json,
        ),
      );
    } on FormatException catch (e) {
      return Response.badRequest(
        body: Body.fromString(
          jsonEncode({
            'valid': false,
            'errors': [
              {'path': '', 'message': 'Invalid JSON: ${e.message}'},
            ],
          }),
          mimeType: MimeType.json,
        ),
      );
    } on Exception catch (e) {
      return Response.badRequest(
        body: Body.fromString(
          jsonEncode({
            'valid': false,
            'errors': [
              {'path': '', 'message': e.toString()},
            ],
          }),
          mimeType: MimeType.json,
        ),
      );
    }
  }

  /// 对 URL 执行规则。
  Future<Response> _executeRule(Request request) async {
    try {
      final body = await request.readAsString();
      final data = jsonDecode(body) as Map<String, dynamic>;

      final ruleJson = data['rule'] as Map<String, dynamic>?;
      final url = data['url'] as String?;
      final html = data['html'] as String?;
      final extractionType = data['type'] as String? ?? 'list';

      if (ruleJson == null) {
        return Response.badRequest(
          body: Body.fromString(
            jsonEncode({
              'error': 'Missing required field: rule',
            }),
            mimeType: MimeType.json,
          ),
        );
      }

      // 解析并验证规则
      final parseResult = _ruleParser.parseJson(ruleJson);
      if (!parseResult.isSuccess) {
        return Response.badRequest(
          body: Body.fromString(
            jsonEncode({
              'success': false,
              'errors': parseResult.errors,
            }),
            mimeType: MimeType.json,
          ),
        );
      }

      final rule = parseResult.rule!;

      // 目前返回模拟执行结果
      // 完整执行需要从 URL 获取 HTML
      if (html == null && url == null) {
        return Response.badRequest(
          body: Body.fromString(
            jsonEncode({
              'error': 'Either url or html must be provided',
            }),
            mimeType: MimeType.json,
          ),
        );
      }

      // TODO(developer): 实现完整执行：
      // 1. 如需要则从 URL 获取 HTML
      // 2. 执行 before actions
      // 3. 根据类型运行提取
      // 4. 执行 after actions
      // 5. 返回提取的数据

      return Response.ok(
        body: Body.fromString(
          jsonEncode({
            'success': true,
            'executionId': DateTime.now().millisecondsSinceEpoch.toString(),
            'ruleId': rule.id,
            'ruleName': rule.name,
            'mediaType': rule.mediaType.name,
            'extractionType': extractionType,
            'data': <dynamic>[],
            'extractedCount': 0,
            'errors': <String>[],
          }),
          mimeType: MimeType.json,
        ),
      );
    } on FormatException catch (e) {
      return Response.badRequest(
        body: Body.fromString(
          jsonEncode({
            'success': false,
            'error': 'Invalid JSON: ${e.message}',
          }),
          mimeType: MimeType.json,
        ),
      );
    } on Exception catch (e) {
      return Response.internalServerError(
        body: Body.fromString(
          jsonEncode({
            'success': false,
            'error': e.toString(),
          }),
          mimeType: MimeType.json,
        ),
      );
    }
  }
}
