import 'package:freezed_annotation/freezed_annotation.dart';

part 'detection_config.freezed.dart';
part 'detection_config.g.dart';

/// 反爬虫检测配置。
@freezed
sealed class DetectionConfig with _$DetectionConfig {
  const factory DetectionConfig({
    /// 验证码检测配置。
    CaptchaDetection? captcha,

    /// 频率限制检测配置。
    RateLimitDetection? rateLimit,

    /// 登录检测配置。
    LoginDetection? login,

    /// Cloudflare 检测。
    @Default(true) bool detectCloudflare,

    /// 检测到时自动重试。
    @Default(true) bool autoRetry,

    /// 最大重试次数。
    @Default(3) int maxRetries,
  }) = _DetectionConfig;

  factory DetectionConfig.fromJson(Map<String, dynamic> json) =>
      _$DetectionConfigFromJson(json);
}

/// 验证码检测配置。
@freezed
sealed class CaptchaDetection with _$CaptchaDetection {
  const factory CaptchaDetection({
    /// 是否检测 reCAPTCHA。
    @Default(true) bool detectRecaptcha,

    /// 是否检测 hCaptcha。
    @Default(true) bool detectHcaptcha,

    /// 是否检测通用验证码图片。
    @Default(true) bool detectGeneric,

    /// 第三方验证码破解服务 API 密钥。
    String? solverApiKey,

    /// 破解服务类型（2captcha、anticaptcha 等）。
    String? solverService,
  }) = _CaptchaDetection;

  factory CaptchaDetection.fromJson(Map<String, dynamic> json) =>
      _$CaptchaDetectionFromJson(json);
}

/// 频率限制检测配置。
@freezed
sealed class RateLimitDetection with _$RateLimitDetection {
  const factory RateLimitDetection({
    /// 视为频率限制的 HTTP 状态码。
    @Default([429, 503, 520, 521, 522, 523, 524]) List<int> statusCodes,

    /// 表示频率限制的响应文本模式。
    List<String>? textPatterns,

    /// 请求之间的最小延迟（毫秒）。
    @Default(1000) int minDelayMs,

    /// 请求之间的最大延迟（毫秒）。
    @Default(5000) int maxDelayMs,

    /// 是否使用指数退避。
    @Default(true) bool exponentialBackoff,
  }) = _RateLimitDetection;

  factory RateLimitDetection.fromJson(Map<String, dynamic> json) =>
      _$RateLimitDetectionFromJson(json);
}

/// 登录检测配置。
@freezed
sealed class LoginDetection with _$LoginDetection {
  const factory LoginDetection({
    /// 是否检测登录页面。
    @Default(true) bool detectLoginPage,

    /// 表示登录页面的选择器。
    List<String>? loginSelectors,

    /// 需要登录时是否暂停。
    @Default(true) bool pauseOnLogin,
  }) = _LoginDetection;

  factory LoginDetection.fromJson(Map<String, dynamic> json) =>
      _$LoginDetectionFromJson(json);
}
