// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmulationOption _$EmulationOptionFromJson(Map<String, dynamic> json) =>
    _EmulationOption(
      emulation: $enumDecodeNullable(_$EmulationEnumMap, json['emulation']),
      emulationOs: $enumDecodeNullable(
        _$EmulationOSEnumMap,
        json['emulation_os'],
      ),
      skipHttp2: json['skip_http2'] as bool?,
      skipHeaders: json['skip_headers'] as bool?,
    );

Map<String, dynamic> _$EmulationOptionToJson(_EmulationOption instance) =>
    <String, dynamic>{
      'emulation': ?_$EmulationEnumMap[instance.emulation],
      'emulation_os': ?_$EmulationOSEnumMap[instance.emulationOs],
      'skip_http2': ?instance.skipHttp2,
      'skip_headers': ?instance.skipHeaders,
    };

const _$EmulationEnumMap = {
  Emulation.chrome131: 'chrome131',
  Emulation.chrome132: 'chrome132',
  Emulation.chrome133: 'chrome133',
  Emulation.chrome134: 'chrome134',
  Emulation.chrome135: 'chrome135',
  Emulation.chrome136: 'chrome136',
  Emulation.chrome120: 'chrome120',
  Emulation.chrome124: 'chrome124',
  Emulation.chrome126: 'chrome126',
  Emulation.chrome127: 'chrome127',
  Emulation.chrome128: 'chrome128',
  Emulation.chrome129: 'chrome129',
  Emulation.chrome130: 'chrome130',
  Emulation.safari18: 'safari18',
  Emulation.safari182: 'safari182',
  Emulation.safari183: 'safari183',
  Emulation.safari185: 'safari185',
  Emulation.safari26: 'safari26',
  Emulation.safariIos1811: 'safariIos1811',
  Emulation.firefox133: 'firefox133',
  Emulation.firefox135: 'firefox135',
  Emulation.firefox136: 'firefox136',
  Emulation.firefox139: 'firefox139',
  Emulation.firefox142: 'firefox142',
  Emulation.firefox143: 'firefox143',
  Emulation.firefox144: 'firefox144',
  Emulation.firefox145: 'firefox145',
  Emulation.firefox146: 'firefox146',
  Emulation.firefox147: 'firefox147',
  Emulation.edge127: 'edge127',
  Emulation.edge131: 'edge131',
  Emulation.edge134: 'edge134',
  Emulation.edge135: 'edge135',
  Emulation.edge136: 'edge136',
  Emulation.edge137: 'edge137',
  Emulation.edge138: 'edge138',
  Emulation.edge139: 'edge139',
  Emulation.edge140: 'edge140',
  Emulation.edge141: 'edge141',
  Emulation.edge142: 'edge142',
  Emulation.edge143: 'edge143',
  Emulation.edge144: 'edge144',
  Emulation.edge145: 'edge145',
  Emulation.okHttp314: 'okHttp314',
  Emulation.okHttp412: 'okHttp412',
  Emulation.okHttp5: 'okHttp5',
};

const _$EmulationOSEnumMap = {
  EmulationOS.windows: 'windows',
  EmulationOS.macOs: 'macOs',
  EmulationOS.linux: 'linux',
  EmulationOS.android: 'android',
  EmulationOS.ios: 'ios',
};

_FallbackConfig _$FallbackConfigFromJson(Map<String, dynamic> json) =>
    _FallbackConfig(
      triggerStatus: (json['trigger_status'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      triggerKeywords: (json['trigger_keywords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      action: json['action'] as String,
    );

Map<String, dynamic> _$FallbackConfigToJson(_FallbackConfig instance) =>
    <String, dynamic>{
      'trigger_status': instance.triggerStatus,
      'trigger_keywords': instance.triggerKeywords,
      'action': instance.action,
    };

_NetworkConfig _$NetworkConfigFromJson(Map<String, dynamic> json) =>
    _NetworkConfig(
      strategy: json['strategy'] as String,
      emulation: json['emulation'] == null
          ? null
          : EmulationOption.fromJson(json['emulation'] as Map<String, dynamic>),
      connectTimeout: json['connect_timeout'] == null
          ? null
          : BigInt.parse(json['connect_timeout'] as String),
      readTimeout: json['read_timeout'] == null
          ? null
          : BigInt.parse(json['read_timeout'] as String),
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      proxy: json['proxy'] == null
          ? null
          : RuleProxyConfig.fromJson(json['proxy'] as Map<String, dynamic>),
      fallback: json['fallback'] == null
          ? null
          : FallbackConfig.fromJson(json['fallback'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkConfigToJson(_NetworkConfig instance) =>
    <String, dynamic>{
      'strategy': instance.strategy,
      'emulation': ?instance.emulation?.toJson(),
      'connect_timeout': ?instance.connectTimeout?.toString(),
      'read_timeout': ?instance.readTimeout?.toString(),
      'headers': ?instance.headers,
      'proxy': ?instance.proxy?.toJson(),
      'fallback': ?instance.fallback?.toJson(),
    };

_RuleProxyConfig _$RuleProxyConfigFromJson(Map<String, dynamic> json) =>
    _RuleProxyConfig(
      enabled: json['enabled'] as bool,
      http: json['http'] as String?,
      https: json['https'] as String?,
      socks5: json['socks5'] as String?,
    );

Map<String, dynamic> _$RuleProxyConfigToJson(_RuleProxyConfig instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'http': ?instance.http,
      'https': ?instance.https,
      'socks5': ?instance.socks5,
    };
