import 'dart:convert';

import 'package:relic/relic.dart';

/// 预览打开结果。
class PreviewOpenResult {
  /// 创建预览打开结果。
  const PreviewOpenResult({
    required this.previewSessionId,
    required this.debugUrl,
    required this.wsChannel,
  });

  /// 预览会话 ID。
  final String previewSessionId;

  /// 调试 URL。
  final String debugUrl;

  /// WebSocket 过滤通道。
  final Map<String, dynamic> wsChannel;
}

/// 预览匹配元素样本。
class PreviewSelectorMatchedElement {
  /// 创建预览匹配元素样本。
  const PreviewSelectorMatchedElement({
    required this.text,
    required this.html,
  });

  /// 元素文本。
  final String text;

  /// 元素 HTML。
  final String html;

  /// 转为 JSON。
  Map<String, String> toJson() {
    return {'text': text, 'html': html};
  }
}

/// 预览选择器测试结果。
class PreviewSelectorTestResult {
  /// 创建预览选择器测试结果。
  const PreviewSelectorTestResult({
    required this.success,
    required this.count,
    required this.elements,
    this.error,
  });

  /// 是否成功。
  final bool success;

  /// 匹配数量。
  final int count;

  /// 匹配样本。
  final List<PreviewSelectorMatchedElement> elements;

  /// 错误信息。
  final String? error;
}

/// 预览路由异常。
class PreviewRouteException implements Exception {
  /// 创建预览路由异常。
  const PreviewRouteException({
    required this.statusCode,
    required this.type,
    required this.message,
    this.details = const [],
  });

  /// HTTP 状态码。
  final int statusCode;

  /// 错误类型。
  final String type;

  /// 错误消息。
  final String message;

  /// 错误详情。
  final List<Map<String, dynamic>> details;
}

/// 预览会话打开处理器。
typedef PreviewOpenHandler = Future<PreviewOpenResult> Function({
  required String url,
  String? sessionId,
});

/// 预览选择器测试处理器。
typedef PreviewSelectorTestHandler = Future<PreviewSelectorTestResult>
    Function({
      required String previewSessionId,
      required String selectorType,
      required String expression,
    });

/// 预览相关路由。
class PreviewRoutes {
  /// 创建预览路由。
  const PreviewRoutes({
    required this.serverToken,
    required this.openPreview,
    required this.testSelector,
  });

  /// 当前服务端鉴权令牌。
  final String Function() serverToken;

  /// 打开预览会话。
  final PreviewOpenHandler openPreview;

  /// 测试预览选择器。
  final PreviewSelectorTestHandler testSelector;

  /// 创建包含预览接口的路由器。
  Router<Handler> get router => Router<Handler>()
    ..use('/', _authorizationMiddleware)
    ..post('/open', _openPreview)
    ..post('/test-selector', _testSelector);

  /// Host-only 鉴权中间件。
  ///
  /// 预览/执行接口仅允许 Flutter 主机调用，Web 编辑器禁止调用。
  /// 通过检查 `X-Host-Only` 头来验证请求来源。
  Handler _authorizationMiddleware(Handler innerHandler) {
    return (request) async {
      // 检查 host-only 标记
      final hostOnly = request.headers['x-host-only']?.firstOrNull;
      if (hostOnly != 'true') {
        return _errorResponse(
          statusCode: 403,
          type: 'forbidden',
          message: '此接口仅允许 Flutter 主机调用，Web 编辑器禁止访问',
        );
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

  Future<Response> _openPreview(Request request) async {
    try {
      final decoded = await _readJsonBody(request);
      final parsed = _parseOpenPreviewRequest(decoded);
      if (parsed.error != null) {
        return parsed.error!;
      }

      final result = await openPreview(
        url: parsed.url!,
        sessionId: parsed.sessionId,
      );

      return _jsonResponse({
        'opened': true,
        'previewSessionId': result.previewSessionId,
        'debugUrl': result.debugUrl,
        'wsChannel': result.wsChannel,
      });
    } on FormatException {
      return _errorResponse(
        statusCode: 400,
        type: 'bad_request',
        message: '请求体不是合法 JSON',
      );
    } on PreviewRouteException catch (error) {
      return _errorResponse(
        statusCode: error.statusCode,
        type: error.type,
        message: error.message,
        details: error.details,
      );
    }
  }

  Future<Response> _testSelector(Request request) async {
    try {
      final decoded = await _readJsonBody(request);
      final parsed = _parseTestSelectorRequest(decoded);
      if (parsed.error != null) {
        return parsed.error!;
      }

      final result = await testSelector(
        previewSessionId: parsed.previewSessionId!,
        selectorType: parsed.selectorType!,
        expression: parsed.expression!,
      );

      return _jsonResponse({
        'success': result.success,
        'count': result.count,
        'elements': result.elements.map((item) => item.toJson()).toList(),
        if (result.error != null) 'error': result.error,
        'matched': result.count,
        'samples': result.elements
            .map((item) => item.text.isNotEmpty ? item.text : item.html)
            .toList(),
      });
    } on FormatException {
      return _errorResponse(
        statusCode: 400,
        type: 'bad_request',
        message: '请求体不是合法 JSON',
      );
    } on PreviewRouteException catch (error) {
      return _errorResponse(
        statusCode: error.statusCode,
        type: error.type,
        message: error.message,
        details: error.details,
      );
    }
  }

  Future<Map<String, dynamic>> _readJsonBody(Request request) async {
    final rawBody = await request.readAsString(maxLength: 1024 * 1024);
    final decoded = jsonDecode(rawBody);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('请求体必须是 JSON 对象');
    }
    return decoded;
  }

  _ParsedOpenPreviewRequest _parseOpenPreviewRequest(
    Map<String, dynamic> body,
  ) {
    final url = body['url'];
    if (url is! String || url.trim().isEmpty) {
      return _ParsedOpenPreviewRequest(
        error: _validationError(path: 'url', message: 'url 不能为空'),
      );
    }

    final sessionId = body['sessionId'];
    if (sessionId != null &&
        (sessionId is! String || sessionId.trim().isEmpty)) {
      return _ParsedOpenPreviewRequest(
        error: _validationError(
          path: 'sessionId',
          message: 'sessionId 必须是非空字符串或 null',
        ),
      );
    }

    return _ParsedOpenPreviewRequest(
      url: url.trim(),
      sessionId: sessionId is String ? sessionId.trim() : null,
    );
  }

  _ParsedTestSelectorRequest _parseTestSelectorRequest(
    Map<String, dynamic> body,
  ) {
    final previewSessionId = body['previewSessionId'];
    if (previewSessionId is! String || previewSessionId.trim().isEmpty) {
      return _ParsedTestSelectorRequest(
        error: _validationError(
          path: 'previewSessionId',
          message: 'previewSessionId 不能为空',
        ),
      );
    }

    final selector = body['selector'];
    String? selectorType;
    String? expression;
    if (selector is String) {
      selectorType = 'css';
      expression = selector.trim();
    } else if (selector is Map<String, dynamic>) {
      final rawType = selector['type'];
      final rawExpression = selector['expression'];
      if (rawType is String) {
        selectorType = rawType.trim();
      }
      if (rawExpression is String) {
        expression = rawExpression.trim();
      }
    }

    if (selectorType == null || selectorType.isEmpty) {
      return _ParsedTestSelectorRequest(
        error: _validationError(
          path: 'selector.type',
          message: 'selector.type 不能为空',
        ),
      );
    }

    if (expression == null || expression.isEmpty) {
      return _ParsedTestSelectorRequest(
        error: _validationError(
          path: 'selector.expression',
          message: 'selector.expression 不能为空',
        ),
      );
    }

    return _ParsedTestSelectorRequest(
      previewSessionId: previewSessionId.trim(),
      selectorType: selectorType,
      expression: expression,
    );
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
}

class _ParsedOpenPreviewRequest {
  const _ParsedOpenPreviewRequest({
    this.url,
    this.sessionId,
    this.error,
  });

  final String? url;
  final String? sessionId;
  final Response? error;
}

class _ParsedTestSelectorRequest {
  const _ParsedTestSelectorRequest({
    this.previewSessionId,
    this.selectorType,
    this.expression,
    this.error,
  });

  final String? previewSessionId;
  final String? selectorType;
  final String? expression;
  final Response? error;
}
