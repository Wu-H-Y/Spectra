import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_config.freezed.dart';
part 'request_config.g.dart';

/// HTTP request configuration.
@freezed
sealed class RequestConfig with _$RequestConfig {
  const factory RequestConfig({
    /// HTTP method (GET, POST, etc.).
    @Default('GET') String method,

    /// Request headers.
    Map<String, String>? headers,

    /// Request body (for POST requests).
    String? body,

    /// Query parameters.
    Map<String, String>? query,

    /// Cookies to send.
    Map<String, String>? cookies,

    /// Request timeout in milliseconds.
    @Default(30000) int timeoutMs,

    /// Whether to follow redirects.
    @Default(true) bool followRedirects,

    /// Maximum redirects to follow.
    @Default(5) int maxRedirects,

    /// User agent string.
    String? userAgent,

    /// Whether to use mobile user agent.
    @Default(false) bool mobileUserAgent,

    /// Referer header value.
    String? referer,
  }) = _RequestConfig;

  factory RequestConfig.fromJson(Map<String, dynamic> json) =>
      _$RequestConfigFromJson(json);
}
