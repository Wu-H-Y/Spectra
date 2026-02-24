import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/network_config/fallback_config.dart';
import 'package:spectra/core/crawler/models/network_config/proxy_config.dart';
import 'package:spectra/core/crawler/models/network_config/tls_fingerprint.dart';

part 'network_config.freezed.dart';
part 'network_config.g.dart';

/// 网络策略类型。
enum NetworkStrategy {
  /// 纯 HTTP 请求，无浏览器。
  http,

  /// 无头浏览器，自动处理 JS。
  webviewHeadless,

  /// 交互式浏览器，需要用户操作 (登录、验证码)。
  webviewInteract,
}

/// 网络请求配置。
///
/// 支持多种网络策略，从简单 HTTP 到完整浏览器模拟。
@freezed
sealed class NetworkConfig with _$NetworkConfig {
  const factory NetworkConfig({
    /// 网络策略。
    @Default(NetworkStrategy.http) NetworkStrategy strategy,

    /// 请求超时时间 (毫秒)。
    @Default(15000) int timeout,

    /// 默认请求头。
    Map<String, String>? headers,

    /// Cookie 管理。
    Map<String, String>? cookies,

    /// 是否跟随重定向。
    @Default(true) bool followRedirects,

    /// 最大重定向次数。
    @Default(5) int maxRedirects,

    /// User-Agent 字符串。
    String? userAgent,

    /// Referer 头值。
    String? referer,

    /// TLS 指纹配置。
    TlsFingerprint? tlsFingerprint,

    /// 请求拦截器配置。
    Interceptors? interceptors,

    /// 代理配置。
    ProxyConfig? proxy,
  }) = _NetworkConfig;

  factory NetworkConfig.fromJson(Map<String, dynamic> json) =>
      _$NetworkConfigFromJson(json);
}

/// 请求拦截器配置。
@freezed
sealed class Interceptors with _$Interceptors {
  const factory Interceptors({
    /// 请求前拦截器。
    List<Interceptor>? onBeforeRequest,

    /// 失败回退配置。
    FallbackConfig? onFallback,
  }) = _Interceptors;

  factory Interceptors.fromJson(Map<String, dynamic> json) =>
      _$InterceptorsFromJson(json);
}

/// 拦截器类型。
enum InterceptorType {
  /// JavaScript 脚本。
  js,

  /// 自定义请求头。
  headers,

  /// 签名计算。
  sign,
}

/// 单个拦截器。
@freezed
sealed class Interceptor with _$Interceptor {
  const factory Interceptor({
    /// 拦截器类型。
    required InterceptorType type,

    /// JavaScript 脚本 (type = js 时使用)。
    String? script,

    /// 自定义请求头 (type = headers 时使用)。
    Map<String, String>? headers,
  }) = _Interceptor;

  factory Interceptor.fromJson(Map<String, dynamic> json) =>
      _$InterceptorFromJson(json);
}
