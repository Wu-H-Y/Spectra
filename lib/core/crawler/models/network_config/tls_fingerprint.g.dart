// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tls_fingerprint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TlsFingerprint _$TlsFingerprintFromJson(Map<String, dynamic> json) =>
    _TlsFingerprint(
      browser:
          $enumDecodeNullable(_$BrowserTypeEnumMap, json['browser']) ??
          BrowserType.chrome120,
      useImpersonate: json['use_impersonate'] as bool? ?? true,
    );

Map<String, dynamic> _$TlsFingerprintToJson(_TlsFingerprint instance) =>
    <String, dynamic>{
      'browser': _$BrowserTypeEnumMap[instance.browser]!,
      'use_impersonate': instance.useImpersonate,
    };

const _$BrowserTypeEnumMap = {
  BrowserType.chrome110: 'chrome110',
  BrowserType.chrome120: 'chrome120',
  BrowserType.chrome130: 'chrome130',
  BrowserType.firefox110: 'firefox110',
  BrowserType.safari156: 'safari156',
  BrowserType.safari17: 'safari17',
  BrowserType.edge101: 'edge101',
};
