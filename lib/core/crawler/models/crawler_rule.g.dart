// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crawler_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CrawlerRule _$CrawlerRuleFromJson(Map<String, dynamic> json) => _CrawlerRule(
  id: json['id'] as String,
  name: json['name'] as String,
  mediaType: $enumDecode(_$MediaTypeEnumMap, json['media_type']),
  description: json['description'] as String?,
  version: json['version'] as String? ?? '2.0.0',
  author: json['author'] as String?,
  source: json['source'] as String? ?? 'user',
  iconUrl: json['icon_url'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  enabled: json['enabled'] as bool? ?? true,
  baseUrl: json['base_url'] as String?,
  network: json['network'] == null
      ? const NetworkConfig()
      : NetworkConfig.fromJson(json['network'] as Map<String, dynamic>),
  aggregation: json['aggregation'] == null
      ? null
      : AggregationConfig.fromJson(json['aggregation'] as Map<String, dynamic>),
  explore: json['explore'] == null
      ? null
      : ExploreConfig.fromJson(json['explore'] as Map<String, dynamic>),
  search: json['search'] == null
      ? null
      : SearchConfig.fromJson(json['search'] as Map<String, dynamic>),
  detail: json['detail'] == null
      ? null
      : DetailConfig.fromJson(json['detail'] as Map<String, dynamic>),
  toc: json['toc'] == null
      ? null
      : TocConfig.fromJson(json['toc'] as Map<String, dynamic>),
  content: json['content'] == null
      ? null
      : ContentConfig.fromJson(json['content'] as Map<String, dynamic>),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$CrawlerRuleToJson(_CrawlerRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'media_type': _$MediaTypeEnumMap[instance.mediaType]!,
      'description': ?instance.description,
      'version': instance.version,
      'author': ?instance.author,
      'source': instance.source,
      'icon_url': ?instance.iconUrl,
      'tags': ?instance.tags,
      'enabled': instance.enabled,
      'base_url': ?instance.baseUrl,
      'network': instance.network.toJson(),
      'aggregation': ?instance.aggregation?.toJson(),
      'explore': ?instance.explore?.toJson(),
      'search': ?instance.search?.toJson(),
      'detail': ?instance.detail?.toJson(),
      'toc': ?instance.toc?.toJson(),
      'content': ?instance.content?.toJson(),
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
