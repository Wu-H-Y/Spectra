/// HTTP 服务器的中间件
///
/// 包含 CORS、日志和错误处理中间件，适配 relic 框架。
library;

import 'dart:convert';

import 'package:relic/relic.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// CORS 中间件
///
/// 允许来自任何源的跨域请求用于开发目的。
/// 在生产环境中，应该限制 allowedOrigins。
Middleware corsMiddleware({
  List<String> allowedOrigins = const ['*'],
  List<String> allowedMethods = const [
    'GET',
    'POST',
    'PUT',
    'DELETE',
    'OPTIONS',
    'PATCH',
  ],
  List<String> allowedHeaders = const [
    'Origin',
    'Content-Type',
    'Accept',
    'Authorization',
    'X-Requested-With',
  ],
  bool allowCredentials = true,
  int maxAge = 86400, // 24 小时
}) {
  return (Handler innerHandler) {
    return (Request request) async {
      final corsHeaders = _buildCorsHeaders(
        allowedOrigins: allowedOrigins,
        allowedMethods: allowedMethods,
        allowedHeaders: allowedHeaders,
        allowCredentials: allowCredentials,
        maxAge: maxAge,
        requestOrigin: request.headers['origin']?.firstOrNull,
      );

      // 处理预检 OPTIONS 请求
      if (request.method == Method.options) {
        return Response.ok(
          body: Body.empty(),
          headers: Headers.fromMap(corsHeaders),
        );
      }

      // 处理实际请求
      final result = await innerHandler(request);

      // 向响应添加 CORS 头
      if (result is Response) {
        final existingHeaders = <String, Iterable<String>>{};
        result.headers.forEach((key, value) {
          existingHeaders[key] = value;
        });
        final mergedHeaders = <String, Iterable<String>>{
          ...existingHeaders,
          ...corsHeaders,
        };
        return Response(
          result.statusCode,
          headers: Headers.fromMap(mergedHeaders),
          body: result.body,
        );
      }
      return result;
    };
  };
}

Map<String, Iterable<String>> _buildCorsHeaders({
  required List<String> allowedOrigins,
  required List<String> allowedMethods,
  required List<String> allowedHeaders,
  required bool allowCredentials,
  required int maxAge,
  required String? requestOrigin,
}) {
  final headers = <String, Iterable<String>>{};

  // 处理源
  if (allowedOrigins.contains('*')) {
    headers['Access-Control-Allow-Origin'] = ['*'];
  } else if (requestOrigin != null && allowedOrigins.contains(requestOrigin)) {
    headers['Access-Control-Allow-Origin'] = [requestOrigin];
  }

  headers['Access-Control-Allow-Methods'] = [allowedMethods.join(', ')];
  headers['Access-Control-Allow-Headers'] = [allowedHeaders.join(', ')];

  if (allowCredentials) {
    headers['Access-Control-Allow-Credentials'] = ['true'];
  }

  headers['Access-Control-Max-Age'] = [maxAge.toString()];

  return headers;
}

/// 请求日志中间件
///
/// 记录所有请求的方法、路径、状态码和响应时间。
Middleware logMiddleware({required Talker talker}) {
  return (Handler innerHandler) {
    return (Request request) async {
      final stopwatch = Stopwatch()..start();
      final result = await innerHandler(request);
      stopwatch.stop();

      final statusCode = switch (result) {
        final Response r => r.statusCode,
        _ => 0,
      };

      talker.debug(
        '${request.method.name} ${request.url.path} '
        '$statusCode ${stopwatch.elapsedMilliseconds}ms',
      );

      return result;
    };
  };
}

/// 错误处理中间件
///
/// 捕获所有未处理的异常并返回 500 错误响应。
Middleware errorMiddleware({Talker? talker}) {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        return await innerHandler(request);
      } on Exception catch (e, st) {
        talker?.error('Error handling request', e, st);
        return Response.internalServerError(
          body: Body.fromString(
            jsonEncode({
              'error': 'Internal server error',
              'message': e.toString(),
            }),
            mimeType: MimeType.json,
          ),
        );
      }
    };
  };
}

/// JSON 内容类型中间件
///
/// 为所有响应添加 JSON 内容类型。
Middleware jsonContentTypeMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      final result = await innerHandler(request);
      if (result is Response) {
        final existingHeaders = <String, Iterable<String>>{};
        result.headers.forEach((key, value) {
          existingHeaders[key] = value;
        });
        final mergedHeaders = <String, Iterable<String>>{
          'content-type': ['application/json'],
          ...existingHeaders,
        };
        return Response(
          result.statusCode,
          headers: Headers.fromMap(mergedHeaders),
          body: result.body,
        );
      }
      return result;
    };
  };
}
