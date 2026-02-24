// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crawler_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CrawlerRule _$CrawlerRuleFromJson(Map<String, dynamic> json) => _CrawlerRule(
  id: json['id'] as String,
  name: json['name'] as String,
  mediaType: $enumDecode(_$MediaTypeEnumMap, json['media_type']),
  match: MatchConfig.fromJson(json['match'] as Map<String, dynamic>),
  extract: ExtractConfig.fromJson(json['extract'] as Map<String, dynamic>),
  description: json['description'] as String?,
  version: json['version'] as String? ?? '1.0.0',
  request: json['request'] == null
      ? const RequestConfig()
      : RequestConfig.fromJson(json['request'] as Map<String, dynamic>),
  beforeActions: (json['before_actions'] as List<dynamic>?)
      ?.map((e) => CrawlerAction.fromJson(e as Map<String, dynamic>))
      .toList(),
  afterActions: (json['after_actions'] as List<dynamic>?)
      ?.map((e) => CrawlerAction.fromJson(e as Map<String, dynamic>))
      .toList(),
  detection: json['detection'] == null
      ? null
      : DetectionConfig.fromJson(json['detection'] as Map<String, dynamic>),
  author: json['author'] as String?,
  source: json['source'] as String? ?? 'user',
  iconUrl: json['icon_url'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  enabled: json['enabled'] as bool? ?? true,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$CrawlerRuleToJson(
  _CrawlerRule instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'media_type': _$MediaTypeEnumMap[instance.mediaType]!,
  'match': instance.match.toJson(),
  'extract': instance.extract.toJson(),
  'description': ?instance.description,
  'version': instance.version,
  'request': instance.request.toJson(),
  'before_actions': ?instance.beforeActions?.map((e) => e.toJson()).toList(),
  'after_actions': ?instance.afterActions?.map((e) => e.toJson()).toList(),
  'detection': ?instance.detection?.toJson(),
  'author': ?instance.author,
  'source': instance.source,
  'icon_url': ?instance.iconUrl,
  'tags': ?instance.tags,
  'enabled': instance.enabled,
  'created_at': ?instance.createdAt?.toIso8601String(),
  'updated_at': ?instance.updatedAt?.toIso8601String(),
};

const _$MediaTypeEnumMap = {
  MediaType.video: 'video',
  MediaType.music: 'music',
  MediaType.novel: 'novel',
  MediaType.comic: 'comic',
  MediaType.image: 'image',
  MediaType.audio: 'audio',
  MediaType.rss: 'rss',
  MediaType.generic: 'generic',
};
