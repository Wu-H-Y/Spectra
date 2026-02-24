// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fallback_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TriggerCondition _$TriggerConditionFromJson(Map<String, dynamic> json) =>
    _TriggerCondition(
      statusCode: (json['status_code'] as num?)?.toInt(),
      bodyRegex: json['body_regex'] as String?,
      headerPattern: json['header_pattern'] as String?,
    );

Map<String, dynamic> _$TriggerConditionToJson(_TriggerCondition instance) =>
    <String, dynamic>{
      'status_code': ?instance.statusCode,
      'body_regex': ?instance.bodyRegex,
      'header_pattern': ?instance.headerPattern,
    };

_FallbackConfig _$FallbackConfigFromJson(Map<String, dynamic> json) =>
    _FallbackConfig(
      trigger: (json['trigger'] as List<dynamic>)
          .map((e) => TriggerCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
      action: $enumDecode(_$FallbackActionEnumMap, json['action']),
      timeout: (json['timeout'] as num?)?.toInt() ?? 30000,
      syncCookies: json['sync_cookies'] as bool? ?? true,
      maxRetries: (json['max_retries'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$FallbackConfigToJson(_FallbackConfig instance) =>
    <String, dynamic>{
      'trigger': instance.trigger.map((e) => e.toJson()).toList(),
      'action': _$FallbackActionEnumMap[instance.action]!,
      'timeout': instance.timeout,
      'sync_cookies': instance.syncCookies,
      'max_retries': instance.maxRetries,
    };

const _$FallbackActionEnumMap = {
  FallbackAction.webviewSolve: 'webviewSolve',
  FallbackAction.switchProxy: 'switchProxy',
  FallbackAction.waitRetry: 'waitRetry',
  FallbackAction.abort: 'abort',
};
