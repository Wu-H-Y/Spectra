// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SniffConfig _$SniffConfigFromJson(Map<String, dynamic> json) => _SniffConfig(
  matchRegex: (json['match_regex'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  excludeRegex: (json['exclude_regex'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  timeout: (json['timeout'] as num?)?.toInt() ?? 15000,
  script: json['script'] as String?,
);

Map<String, dynamic> _$SniffConfigToJson(_SniffConfig instance) =>
    <String, dynamic>{
      'match_regex': instance.matchRegex,
      'exclude_regex': ?instance.excludeRegex,
      'timeout': instance.timeout,
      'script': ?instance.script,
    };

_ContentConfig _$ContentConfigFromJson(Map<String, dynamic> json) =>
    _ContentConfig(
      type: $enumDecode(_$MediaContentTypeEnumMap, json['type']),
      url: json['url'] as String?,
      strategy:
          $enumDecodeNullable(_$ContentStrategyEnumMap, json['strategy']) ??
          ContentStrategy.parse,
      fields: (json['fields'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Pipeline.fromJson(e as Map<String, dynamic>)),
      ),
      sniff: json['sniff'] == null
          ? null
          : SniffConfig.fromJson(json['sniff'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentConfigToJson(_ContentConfig instance) =>
    <String, dynamic>{
      'type': _$MediaContentTypeEnumMap[instance.type]!,
      'url': ?instance.url,
      'strategy': _$ContentStrategyEnumMap[instance.strategy]!,
      'fields': ?instance.fields?.map((k, e) => MapEntry(k, e.toJson())),
      'sniff': ?instance.sniff?.toJson(),
    };

const _$MediaContentTypeEnumMap = {
  MediaContentType.video: 'video',
  MediaContentType.comic: 'comic',
  MediaContentType.novel: 'novel',
  MediaContentType.music: 'music',
};

const _$ContentStrategyEnumMap = {
  ContentStrategy.parse: 'parse',
  ContentStrategy.sniff: 'sniff',
};
