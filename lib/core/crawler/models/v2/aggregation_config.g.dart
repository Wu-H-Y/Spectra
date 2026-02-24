// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aggregation_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AggregationConfig _$AggregationConfigFromJson(Map<String, dynamic> json) =>
    _AggregationConfig(
      matching: MatchingConfig.fromJson(
        json['matching'] as Map<String, dynamic>,
      ),
      enabled: json['enabled'] as bool? ?? true,
      weight: (json['weight'] as num?)?.toInt() ?? 50,
    );

Map<String, dynamic> _$AggregationConfigToJson(_AggregationConfig instance) =>
    <String, dynamic>{
      'matching': instance.matching.toJson(),
      'enabled': instance.enabled,
      'weight': instance.weight,
    };

_MatchingConfig _$MatchingConfigFromJson(
  Map<String, dynamic> json,
) => _MatchingConfig(
  strategy:
      $enumDecodeNullable(_$MatchingStrategyEnumMap, json['strategy']) ??
      MatchingStrategy.fuzzy,
  dimensions:
      (json['dimensions'] as List<dynamic>?)
          ?.map((e) => MatchingDimension.fromJson(e as Map<String, dynamic>))
          .toList() ??
      _defaultDimensions,
  combinedThreshold: (json['combined_threshold'] as num?)?.toDouble() ?? 0.85,
);

Map<String, dynamic> _$MatchingConfigToJson(_MatchingConfig instance) =>
    <String, dynamic>{
      'strategy': _$MatchingStrategyEnumMap[instance.strategy]!,
      'dimensions': instance.dimensions.map((e) => e.toJson()).toList(),
      'combined_threshold': instance.combinedThreshold,
    };

const _$MatchingStrategyEnumMap = {
  MatchingStrategy.exact: 'exact',
  MatchingStrategy.fuzzy: 'fuzzy',
  MatchingStrategy.custom: 'custom',
};

_MatchingDimension _$MatchingDimensionFromJson(Map<String, dynamic> json) =>
    _MatchingDimension(
      field: json['field'] as String,
      matchType:
          $enumDecodeNullable(_$MatchTypeEnumMap, json['match_type']) ??
          MatchType.fuzzy,
      weight: (json['weight'] as num?)?.toDouble() ?? 1.0,
      threshold: (json['threshold'] as num?)?.toDouble() ?? 0.96,
      normalize: json['normalize'] == null
          ? null
          : NormalizationConfig.fromJson(
              json['normalize'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$MatchingDimensionToJson(_MatchingDimension instance) =>
    <String, dynamic>{
      'field': instance.field,
      'match_type': _$MatchTypeEnumMap[instance.matchType]!,
      'weight': instance.weight,
      'threshold': instance.threshold,
      'normalize': ?instance.normalize?.toJson(),
    };

const _$MatchTypeEnumMap = {
  MatchType.exact: 'exact',
  MatchType.fuzzy: 'fuzzy',
  MatchType.normalized: 'normalized',
};

_NormalizationConfig _$NormalizationConfigFromJson(Map<String, dynamic> json) =>
    _NormalizationConfig(
      lowercase: json['lowercase'] as bool? ?? true,
      trimPunctuation: json['trim_punctuation'] as bool? ?? true,
      trimWhitespace: json['trim_whitespace'] as bool? ?? true,
      traditionalToSimplified:
          json['traditional_to_simplified'] as bool? ?? true,
      fullWidthToHalfWidth: json['full_width_to_half_width'] as bool? ?? true,
      removeMetadata: json['remove_metadata'] as bool? ?? true,
      replacements: (json['replacements'] as List<dynamic>?)
          ?.map((e) => ReplacementRule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NormalizationConfigToJson(
  _NormalizationConfig instance,
) => <String, dynamic>{
  'lowercase': instance.lowercase,
  'trim_punctuation': instance.trimPunctuation,
  'trim_whitespace': instance.trimWhitespace,
  'traditional_to_simplified': instance.traditionalToSimplified,
  'full_width_to_half_width': instance.fullWidthToHalfWidth,
  'remove_metadata': instance.removeMetadata,
  'replacements': ?instance.replacements?.map((e) => e.toJson()).toList(),
};

_ReplacementRule _$ReplacementRuleFromJson(Map<String, dynamic> json) =>
    _ReplacementRule(
      pattern: json['pattern'] as String,
      replacement: json['replacement'] as String? ?? '',
    );

Map<String, dynamic> _$ReplacementRuleToJson(_ReplacementRule instance) =>
    <String, dynamic>{
      'pattern': instance.pattern,
      'replacement': instance.replacement,
    };
