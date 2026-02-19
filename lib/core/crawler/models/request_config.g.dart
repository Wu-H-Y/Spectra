// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequestConfig _$RequestConfigFromJson(Map<String, dynamic> json) =>
    _RequestConfig(
      method: json['method'] as String? ?? 'GET',
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      body: json['body'] as String?,
      query: (json['query'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      cookies: (json['cookies'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      timeoutMs: (json['timeoutMs'] as num?)?.toInt() ?? 30000,
      followRedirects: json['followRedirects'] as bool? ?? true,
      maxRedirects: (json['maxRedirects'] as num?)?.toInt() ?? 5,
      userAgent: json['userAgent'] as String?,
      mobileUserAgent: json['mobileUserAgent'] as bool? ?? false,
      referer: json['referer'] as String?,
    );

Map<String, dynamic> _$RequestConfigToJson(_RequestConfig instance) =>
    <String, dynamic>{
      'method': instance.method,
      'headers': instance.headers,
      'body': instance.body,
      'query': instance.query,
      'cookies': instance.cookies,
      'timeoutMs': instance.timeoutMs,
      'followRedirects': instance.followRedirects,
      'maxRedirects': instance.maxRedirects,
      'userAgent': instance.userAgent,
      'mobileUserAgent': instance.mobileUserAgent,
      'referer': instance.referer,
    };
