// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crawler_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CrawlerRule _$CrawlerRuleFromJson(Map<String, dynamic> json) => _CrawlerRule(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  mediaType: $enumDecode(_$MediaTypeEnumMap, json['mediaType']),
  version: json['version'] as String? ?? '1.0.0',
  match: MatchConfig.fromJson(json['match'] as Map<String, dynamic>),
  request: json['request'] == null
      ? const RequestConfig()
      : RequestConfig.fromJson(json['request'] as Map<String, dynamic>),
  extract: ExtractConfig.fromJson(json['extract'] as Map<String, dynamic>),
  beforeActions: (json['beforeActions'] as List<dynamic>?)
      ?.map((e) => CrawlerAction.fromJson(e as Map<String, dynamic>))
      .toList(),
  afterActions: (json['afterActions'] as List<dynamic>?)
      ?.map((e) => CrawlerAction.fromJson(e as Map<String, dynamic>))
      .toList(),
  detection: json['detection'] == null
      ? null
      : DetectionConfig.fromJson(json['detection'] as Map<String, dynamic>),
  author: json['author'] as String?,
  source: json['source'] as String? ?? 'user',
  iconUrl: json['iconUrl'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  enabled: json['enabled'] as bool? ?? true,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$CrawlerRuleToJson(_CrawlerRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'mediaType': _$MediaTypeEnumMap[instance.mediaType]!,
      'version': instance.version,
      'match': instance.match,
      'request': instance.request,
      'extract': instance.extract,
      'beforeActions': instance.beforeActions,
      'afterActions': instance.afterActions,
      'detection': instance.detection,
      'author': instance.author,
      'source': instance.source,
      'iconUrl': instance.iconUrl,
      'tags': instance.tags,
      'enabled': instance.enabled,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
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
