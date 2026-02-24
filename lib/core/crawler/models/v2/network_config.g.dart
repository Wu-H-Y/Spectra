// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NetworkConfig _$NetworkConfigFromJson(Map<String, dynamic> json) =>
    _NetworkConfig(
      strategy:
          $enumDecodeNullable(_$NetworkStrategyEnumMap, json['strategy']) ??
          NetworkStrategy.http,
      timeout: (json['timeout'] as num?)?.toInt() ?? 15000,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      cookies: (json['cookies'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      followRedirects: json['follow_redirects'] as bool? ?? true,
      maxRedirects: (json['max_redirects'] as num?)?.toInt() ?? 5,
      userAgent: json['user_agent'] as String?,
      referer: json['referer'] as String?,
      tlsFingerprint: json['tls_fingerprint'] == null
          ? null
          : TlsFingerprint.fromJson(
              json['tls_fingerprint'] as Map<String, dynamic>,
            ),
      interceptors: json['interceptors'] == null
          ? null
          : Interceptors.fromJson(json['interceptors'] as Map<String, dynamic>),
      proxy: json['proxy'] == null
          ? null
          : ProxyConfig.fromJson(json['proxy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkConfigToJson(_NetworkConfig instance) =>
    <String, dynamic>{
      'strategy': _$NetworkStrategyEnumMap[instance.strategy]!,
      'timeout': instance.timeout,
      'headers': ?instance.headers,
      'cookies': ?instance.cookies,
      'follow_redirects': instance.followRedirects,
      'max_redirects': instance.maxRedirects,
      'user_agent': ?instance.userAgent,
      'referer': ?instance.referer,
      'tls_fingerprint': ?instance.tlsFingerprint?.toJson(),
      'interceptors': ?instance.interceptors?.toJson(),
      'proxy': ?instance.proxy?.toJson(),
    };

const _$NetworkStrategyEnumMap = {
  NetworkStrategy.http: 'http',
  NetworkStrategy.webviewHeadless: 'webviewHeadless',
  NetworkStrategy.webviewInteract: 'webviewInteract',
};

_Interceptors _$InterceptorsFromJson(Map<String, dynamic> json) =>
    _Interceptors(
      onBeforeRequest: (json['on_before_request'] as List<dynamic>?)
          ?.map((e) => Interceptor.fromJson(e as Map<String, dynamic>))
          .toList(),
      onFallback: json['on_fallback'] == null
          ? null
          : FallbackConfig.fromJson(
              json['on_fallback'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$InterceptorsToJson(_Interceptors instance) =>
    <String, dynamic>{
      'on_before_request': ?instance.onBeforeRequest
          ?.map((e) => e.toJson())
          .toList(),
      'on_fallback': ?instance.onFallback?.toJson(),
    };

_Interceptor _$InterceptorFromJson(Map<String, dynamic> json) => _Interceptor(
  type: $enumDecode(_$InterceptorTypeEnumMap, json['type']),
  script: json['script'] as String?,
  headers: (json['headers'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
);

Map<String, dynamic> _$InterceptorToJson(_Interceptor instance) =>
    <String, dynamic>{
      'type': _$InterceptorTypeEnumMap[instance.type]!,
      'script': ?instance.script,
      'headers': ?instance.headers,
    };

const _$InterceptorTypeEnumMap = {
  InterceptorType.js: 'js',
  InterceptorType.headers: 'headers',
  InterceptorType.sign: 'sign',
};
