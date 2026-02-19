import 'package:freezed_annotation/freezed_annotation.dart';

part 'detection_config.freezed.dart';
part 'detection_config.g.dart';

/// Anti-crawl detection configuration.
@freezed
sealed class DetectionConfig with _$DetectionConfig {
  const factory DetectionConfig({
    /// Captcha detection config.
    CaptchaDetection? captcha,

    /// Rate limit detection config.
    RateLimitDetection? rateLimit,

    /// Login detection config.
    LoginDetection? login,

    /// Cloudflare detection config.
    @Default(true) bool detectCloudflare,

    /// Auto-retry on detection.
    @Default(true) bool autoRetry,

    /// Maximum retry attempts.
    @Default(3) int maxRetries,
  }) = _DetectionConfig;

  factory DetectionConfig.fromJson(Map<String, dynamic> json) =>
      _$DetectionConfigFromJson(json);
}

/// Captcha detection configuration.
@freezed
sealed class CaptchaDetection with _$CaptchaDetection {
  const factory CaptchaDetection({
    /// Whether to detect reCAPTCHA.
    @Default(true) bool detectRecaptcha,

    /// Whether to detect hCaptcha.
    @Default(true) bool detectHcaptcha,

    /// Whether to detect generic captcha images.
    @Default(true) bool detectGeneric,

    /// Third-party captcha solver API key.
    String? solverApiKey,

    /// Solver service type (2captcha, anticaptcha, etc.).
    String? solverService,
  }) = _CaptchaDetection;

  factory CaptchaDetection.fromJson(Map<String, dynamic> json) =>
      _$CaptchaDetectionFromJson(json);
}

/// Rate limit detection configuration.
@freezed
sealed class RateLimitDetection with _$RateLimitDetection {
  const factory RateLimitDetection({
    /// HTTP status codes to treat as rate limited.
    @Default([429, 503, 520, 521, 522, 523, 524]) List<int> statusCodes,

    /// Response text patterns indicating rate limit.
    List<String>? textPatterns,

    /// Minimum delay between requests (ms).
    @Default(1000) int minDelayMs,

    /// Maximum delay between requests (ms).
    @Default(5000) int maxDelayMs,

    /// Whether to use exponential backoff.
    @Default(true) bool exponentialBackoff,
  }) = _RateLimitDetection;

  factory RateLimitDetection.fromJson(Map<String, dynamic> json) =>
      _$RateLimitDetectionFromJson(json);
}

/// Login detection configuration.
@freezed
sealed class LoginDetection with _$LoginDetection {
  const factory LoginDetection({
    /// Whether to detect login pages.
    @Default(true) bool detectLoginPage,

    /// Selectors indicating login page.
    List<String>? loginSelectors,

    /// Whether to pause on login required.
    @Default(true) bool pauseOnLogin,
  }) = _LoginDetection;

  factory LoginDetection.fromJson(Map<String, dynamic> json) =>
      _$LoginDetectionFromJson(json);
}
