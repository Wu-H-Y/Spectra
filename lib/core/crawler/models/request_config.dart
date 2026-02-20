import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_config.freezed.dart';
part 'request_config.g.dart';

/// HTTP 请求配置。
@freezed
sealed class RequestConfig with _$RequestConfig {
  const factory RequestConfig({
    /// HTTP 方法（GET、POST 等）。
    @Default('GET') String method,

    /// 请求头。
    Map<String, String>? headers,

    /// 请求体（用于 POST 请求）。
    String? body,

    /// 查询参数。
    Map<String, String>? query,

    /// 要发送的 Cookies。
    Map<String, String>? cookies,

    /// 请求超时时间（毫秒）。
    @Default(30000) int timeoutMs,

    /// 是否跟随重定向。
    @Default(true) bool followRedirects,

    /// 最大重定向次数。
    @Default(5) int maxRedirects,

    /// 用户代理字符串。
    String? userAgent,

    /// 是否使用移动端用户代理。
    @Default(false) bool mobileUserAgent,

    /// Referer 头值。
    String? referer,
  }) = _RequestConfig;

  factory RequestConfig.fromJson(Map<String, dynamic> json) =>
      _$RequestConfigFromJson(json);
}
