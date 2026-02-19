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
      rateLimit: json['rateLimit'] == null
          ? null
          : RateLimitDetection.fromJson(
              json['rateLimit'] as Map<String, dynamic>,
            ),
      login: json['login'] == null
          ? null
          : LoginDetection.fromJson(json['login'] as Map<String, dynamic>),
      detectCloudflare: json['detectCloudflare'] as bool? ?? true,
      autoRetry: json['autoRetry'] as bool? ?? true,
      maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$DetectionConfigToJson(_DetectionConfig instance) =>
    <String, dynamic>{
      'captcha': instance.captcha,
      'rateLimit': instance.rateLimit,
      'login': instance.login,
      'detectCloudflare': instance.detectCloudflare,
      'autoRetry': instance.autoRetry,
      'maxRetries': instance.maxRetries,
    };

_CaptchaDetection _$CaptchaDetectionFromJson(Map<String, dynamic> json) =>
    _CaptchaDetection(
      detectRecaptcha: json['detectRecaptcha'] as bool? ?? true,
      detectHcaptcha: json['detectHcaptcha'] as bool? ?? true,
      detectGeneric: json['detectGeneric'] as bool? ?? true,
      solverApiKey: json['solverApiKey'] as String?,
      solverService: json['solverService'] as String?,
    );

Map<String, dynamic> _$CaptchaDetectionToJson(_CaptchaDetection instance) =>
    <String, dynamic>{
      'detectRecaptcha': instance.detectRecaptcha,
      'detectHcaptcha': instance.detectHcaptcha,
      'detectGeneric': instance.detectGeneric,
      'solverApiKey': instance.solverApiKey,
      'solverService': instance.solverService,
    };

_RateLimitDetection _$RateLimitDetectionFromJson(Map<String, dynamic> json) =>
    _RateLimitDetection(
      statusCodes:
          (json['statusCodes'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [429, 503, 520, 521, 522, 523, 524],
      textPatterns: (json['textPatterns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      minDelayMs: (json['minDelayMs'] as num?)?.toInt() ?? 1000,
      maxDelayMs: (json['maxDelayMs'] as num?)?.toInt() ?? 5000,
      exponentialBackoff: json['exponentialBackoff'] as bool? ?? true,
    );

Map<String, dynamic> _$RateLimitDetectionToJson(_RateLimitDetection instance) =>
    <String, dynamic>{
      'statusCodes': instance.statusCodes,
      'textPatterns': instance.textPatterns,
      'minDelayMs': instance.minDelayMs,
      'maxDelayMs': instance.maxDelayMs,
      'exponentialBackoff': instance.exponentialBackoff,
    };

_LoginDetection _$LoginDetectionFromJson(Map<String, dynamic> json) =>
    _LoginDetection(
      detectLoginPage: json['detectLoginPage'] as bool? ?? true,
      loginSelectors: (json['loginSelectors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      pauseOnLogin: json['pauseOnLogin'] as bool? ?? true,
    );

Map<String, dynamic> _$LoginDetectionToJson(_LoginDetection instance) =>
    <String, dynamic>{
      'detectLoginPage': instance.detectLoginPage,
      'loginSelectors': instance.loginSelectors,
      'pauseOnLogin': instance.pauseOnLogin,
    };
