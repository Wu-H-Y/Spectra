// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchConfig _$MatchConfigFromJson(Map<String, dynamic> json) => _MatchConfig(
  pattern: json['pattern'] as String,
  type:
      $enumDecodeNullable(_$MatchPatternTypeEnumMap, json['type']) ??
      MatchPatternType.regex,
  fullUrl: json['fullUrl'] as bool? ?? true,
  includePatterns: (json['includePatterns'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  excludePatterns: (json['excludePatterns'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$MatchConfigToJson(_MatchConfig instance) =>
    <String, dynamic>{
      'pattern': instance.pattern,
      'type': _$MatchPatternTypeEnumMap[instance.type]!,
      'fullUrl': instance.fullUrl,
      'includePatterns': instance.includePatterns,
      'excludePatterns': instance.excludePatterns,
    };

const _$MatchPatternTypeEnumMap = {
  MatchPatternType.regex: 'regex',
  MatchPatternType.glob: 'glob',
};
