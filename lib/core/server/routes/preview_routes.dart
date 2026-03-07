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

/// 预览相关路由。
class PreviewRoutes {
  /// 创建预览路由。
  const PreviewRoutes({
    required this.serverToken,
    required this.openPreview,
  });

  /// 当前服务端鉴权令牌。
  final String Function() serverToken;

  /// 打开预览会话。
  final PreviewOpenResult Function({
    required String url,
    String? sessionId,
  })
  openPreview;

  /// 创建包含预览接口的路由器。
  Router<Handler> get router => Router<Handler>()
    ..use('/', _authorizationMiddleware)
    ..post('/open', _openPreview);

  Handler _authorizationMiddleware(Handler innerHandler) {
    return (request) async {
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
      final rawBody = await request.readAsString(maxLength: 1024 * 1024);
      final decoded = jsonDecode(rawBody);
      if (decoded is! Map<String, dynamic>) {
        return _errorResponse(
          statusCode: 400,
          type: 'bad_request',
          message: '请求体必须是 JSON 对象',
        );
      }

      final parsed = _parseOpenPreviewRequest(decoded);
      if (parsed.error != null) {
        return parsed.error!;
      }

      final result = openPreview(
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
    }
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
