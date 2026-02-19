import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// CORS middleware for the HTTP server.
///
/// Allows cross-origin requests from any origin for development purposes.
/// In production, you should restrict allowedOrigins.
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
  int maxAge = 86400, // 24 hours
}) {
  return (Handler innerHandler) {
    return (Request request) async {
      // Handle preflight OPTIONS request
      if (request.method == 'OPTIONS') {
        return Response.ok(
          null,
          headers: _corsHeaders(
            allowedOrigins: allowedOrigins,
            allowedMethods: allowedMethods,
            allowedHeaders: allowedHeaders,
            allowCredentials: allowCredentials,
            maxAge: maxAge,
            requestOrigin: request.headers['origin'],
          ),
        );
      }

      // Process the actual request
      final response = await innerHandler(request);

      // Add CORS headers to the response
      return response.change(
        headers: {
          ...response.headers,
          ..._corsHeaders(
            allowedOrigins: allowedOrigins,
            allowedMethods: allowedMethods,
            allowedHeaders: allowedHeaders,
            allowCredentials: allowCredentials,
            maxAge: maxAge,
            requestOrigin: request.headers['origin'],
          ),
        },
      );
    };
  };
}

Map<String, String> _corsHeaders({
  required List<String> allowedOrigins,
  required List<String> allowedMethods,
  required List<String> allowedHeaders,
  required bool allowCredentials,
  required int maxAge,
  required String? requestOrigin,
}) {
  final headers = <String, String>{};

  // Handle origin
  if (allowedOrigins.contains('*')) {
    headers['Access-Control-Allow-Origin'] = '*';
  } else if (requestOrigin != null && allowedOrigins.contains(requestOrigin)) {
    headers['Access-Control-Allow-Origin'] = requestOrigin;
  }

  headers['Access-Control-Allow-Methods'] = allowedMethods.join(', ');
  headers['Access-Control-Allow-Headers'] = allowedHeaders.join(', ');

  if (allowCredentials) {
    headers['Access-Control-Allow-Credentials'] = 'true';
  }

  headers['Access-Control-Max-Age'] = maxAge.toString();

  return headers;
}

/// JSON content type middleware.
Middleware jsonContentTypeMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      final response = await innerHandler(request);
      return response.change(
        headers: {
          'content-type': 'application/json',
          ...response.headers,
        },
      );
    };
  };
}

/// Request logging middleware.
Middleware logMiddleware(void Function(String) logger) {
  return (Handler innerHandler) {
    return (Request request) async {
      final stopwatch = Stopwatch()..start();
      final response = await innerHandler(request);
      stopwatch.stop();

      logger(
        '${request.method} ${request.requestedUri.path} '
        '${response.statusCode} ${stopwatch.elapsedMilliseconds}ms',
      );

      return response;
    };
  };
}

/// Error handling middleware with Talker logging.
Middleware errorMiddleware({Talker? talker}) {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        return await innerHandler(request);
      } on Exception catch (e, st) {
        talker?.error('Error handling request', e, st);
        return Response.internalServerError(
          body: jsonEncode({
            'error': 'Internal server error',
            'message': e.toString(),
          }),
          headers: {'content-type': 'application/json'},
        );
      }
    };
  };
}
