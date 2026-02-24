// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detection_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DetectionConfig _$DetectionConfigFromJson(Map<String, dynamic> json) =>
    _DetectionConfig(
      captcha: json['captcha'] == null
          ? null
          : CaptchaDetection.fromJson(json['captcha'] as Map<String, dynamic>),
      rateLimit: json['rate_limit'] == null
          ? null
          : RateLimitDetection.fromJson(
              json['rate_limit'] as Map<String, dynamic>,
            ),
      login: json['login'] == null
          ? null
          : LoginDetection.fromJson(json['login'] as Map<String, dynamic>),
      detectCloudflare: json['detect_cloudflare'] as bool? ?? true,
      autoRetry: json['auto_retry'] as bool? ?? true,
      maxRetries: (json['max_retries'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$DetectionConfigToJson(_DetectionConfig instance) =>
    <String, dynamic>{
      'captcha': ?instance.captcha?.toJson(),
      'rate_limit': ?instance.rateLimit?.toJson(),
      'login': ?instance.login?.toJson(),
      'detect_cloudflare': instance.detectCloudflare,
      'auto_retry': instance.autoRetry,
      'max_retries': instance.maxRetries,
    };

_CaptchaDetection _$CaptchaDetectionFromJson(Map<String, dynamic> json) =>
    _CaptchaDetection(
      detectRecaptcha: json['detect_recaptcha'] as bool? ?? true,
      detectHcaptcha: json['detect_hcaptcha'] as bool? ?? true,
      detectGeneric: json['detect_generic'] as bool? ?? true,
      solverApiKey: json['solver_api_key'] as String?,
      solverService: json['solver_service'] as String?,
    );

Map<String, dynamic> _$CaptchaDetectionToJson(_CaptchaDetection instance) =>
    <String, dynamic>{
      'detect_recaptcha': instance.detectRecaptcha,
      'detect_hcaptcha': instance.detectHcaptcha,
      'detect_generic': instance.detectGeneric,
      'solver_api_key': ?instance.solverApiKey,
      'solver_service': ?instance.solverService,
    };

_RateLimitDetection _$RateLimitDetectionFromJson(Map<String, dynamic> json) =>
    _RateLimitDetection(
      statusCodes:
          (json['status_codes'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [429, 503, 520, 521, 522, 523, 524],
      textPatterns: (json['text_patterns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      minDelayMs: (json['min_delay_ms'] as num?)?.toInt() ?? 1000,
      maxDelayMs: (json['max_delay_ms'] as num?)?.toInt() ?? 5000,
      exponentialBackoff: json['exponential_backoff'] as bool? ?? true,
    );

Map<String, dynamic> _$RateLimitDetectionToJson(_RateLimitDetection instance) =>
    <String, dynamic>{
      'status_codes': instance.statusCodes,
      'text_patterns': ?instance.textPatterns,
      'min_delay_ms': instance.minDelayMs,
      'max_delay_ms': instance.maxDelayMs,
      'exponential_backoff': instance.exponentialBackoff,
    };

_LoginDetection _$LoginDetectionFromJson(Map<String, dynamic> json) =>
    _LoginDetection(
      detectLoginPage: json['detect_login_page'] as bool? ?? true,
      loginSelectors: (json['login_selectors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      pauseOnLogin: json['pause_on_login'] as bool? ?? true,
    );

Map<String, dynamic> _$LoginDetectionToJson(_LoginDetection instance) =>
    <String, dynamic>{
      'detect_login_page': instance.detectLoginPage,
      'login_selectors': ?instance.loginSelectors,
      'pause_on_login': instance.pauseOnLogin,
    };
