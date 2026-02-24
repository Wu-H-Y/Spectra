// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProxyServer _$ProxyServerFromJson(Map<String, dynamic> json) => _ProxyServer(
  host: json['host'] as String,
  port: (json['port'] as num).toInt(),
  type: $enumDecode(_$ProxyTypeEnumMap, json['type']),
  username: json['username'] as String?,
  password: json['password'] as String?,
  weight: (json['weight'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$ProxyServerToJson(_ProxyServer instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'type': _$ProxyTypeEnumMap[instance.type]!,
      'username': ?instance.username,
      'password': ?instance.password,
      'weight': instance.weight,
    };

const _$ProxyTypeEnumMap = {
  ProxyType.http: 'http',
  ProxyType.https: 'https',
  ProxyType.socks5: 'socks5',
};

_ProxyConfig _$ProxyConfigFromJson(Map<String, dynamic> json) => _ProxyConfig(
  servers: (json['servers'] as List<dynamic>)
      .map((e) => ProxyServer.fromJson(e as Map<String, dynamic>))
      .toList(),
  rotation:
      $enumDecodeNullable(_$ProxyRotationEnumMap, json['rotation']) ??
      ProxyRotation.roundRobin,
  failover: json['failover'] as bool? ?? true,
  testUrl: json['test_url'] as String?,
);

Map<String, dynamic> _$ProxyConfigToJson(_ProxyConfig instance) =>
    <String, dynamic>{
      'servers': instance.servers.map((e) => e.toJson()).toList(),
      'rotation': _$ProxyRotationEnumMap[instance.rotation]!,
      'failover': instance.failover,
      'test_url': ?instance.testUrl,
    };

const _$ProxyRotationEnumMap = {
  ProxyRotation.roundRobin: 'roundRobin',
  ProxyRotation.random: 'random',
  ProxyRotation.weighted: 'weighted',
  ProxyRotation.fixed: 'fixed',
};
