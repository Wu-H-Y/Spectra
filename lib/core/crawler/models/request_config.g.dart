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
      timeoutMs: (json['timeout_ms'] as num?)?.toInt() ?? 30000,
      followRedirects: json['follow_redirects'] as bool? ?? true,
      maxRedirects: (json['max_redirects'] as num?)?.toInt() ?? 5,
      userAgent: json['user_agent'] as String?,
      mobileUserAgent: json['mobile_user_agent'] as bool? ?? false,
      referer: json['referer'] as String?,
    );

Map<String, dynamic> _$RequestConfigToJson(_RequestConfig instance) =>
    <String, dynamic>{
      'method': instance.method,
      'headers': ?instance.headers,
      'body': ?instance.body,
      'query': ?instance.query,
      'cookies': ?instance.cookies,
      'timeout_ms': instance.timeoutMs,
      'follow_redirects': instance.followRedirects,
      'max_redirects': instance.maxRedirects,
      'user_agent': ?instance.userAgent,
      'mobile_user_agent': instance.mobileUserAgent,
      'referer': ?instance.referer,
    };
