// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crawler_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AggregationConfig _$AggregationConfigFromJson(Map<String, dynamic> json) =>
    _AggregationConfig(
      enabled: json['enabled'] as bool,
      weight: (json['weight'] as num).toInt(),
      matching: MatchingConfig.fromJson(
        json['matching'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AggregationConfigToJson(_AggregationConfig instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'weight': instance.weight,
      'matching': instance.matching.toJson(),
    };

_CrawlerRule _$CrawlerRuleFromJson(Map<String, dynamic> json) => _CrawlerRule(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  author: json['author'] as String,
  version: json['version'] as String,
  network: json['network'] == null
      ? null
      : NetworkConfig.fromJson(json['network'] as Map<String, dynamic>),
  aggregation: json['aggregation'] == null
      ? null
      : AggregationConfig.fromJson(json['aggregation'] as Map<String, dynamic>),
  lifecycle: Lifecycle.fromJson(json['lifecycle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CrawlerRuleToJson(_CrawlerRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'author': instance.author,
      'version': instance.version,
      'network': ?instance.network?.toJson(),
      'aggregation': ?instance.aggregation?.toJson(),
      'lifecycle': instance.lifecycle.toJson(),
    };

_MatchingConfig _$MatchingConfigFromJson(Map<String, dynamic> json) =>
    _MatchingConfig(
      strategy: json['strategy'] as String,
      dimensions: (json['dimensions'] as List<dynamic>)
          .map((e) => MatchingDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatchingConfigToJson(_MatchingConfig instance) =>
    <String, dynamic>{
      'strategy': instance.strategy,
      'dimensions': instance.dimensions.map((e) => e.toJson()).toList(),
    };

_MatchingDimension _$MatchingDimensionFromJson(Map<String, dynamic> json) =>
    _MatchingDimension(
      field: json['field'] as String,
      matchType: json['match_type'] as String,
      threshold: (json['threshold'] as num).toDouble(),
    );

Map<String, dynamic> _$MatchingDimensionToJson(_MatchingDimension instance) =>
    <String, dynamic>{
      'field': instance.field,
      'match_type': instance.matchType,
      'threshold': instance.threshold,
    };
