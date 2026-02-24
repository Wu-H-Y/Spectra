// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Transform _$TransformFromJson(Map<String, dynamic> json) => _Transform(
  type: $enumDecode(_$TransformTypeEnumMap, json['type']),
  params: json['params'],
);

Map<String, dynamic> _$TransformToJson(_Transform instance) =>
    <String, dynamic>{
      'type': _$TransformTypeEnumMap[instance.type]!,
      'params': ?instance.params,
    };

const _$TransformTypeEnumMap = {
  TransformType.trim: 'trim',
  TransformType.number: 'number',
  TransformType.date: 'date',
  TransformType.url: 'url',
  TransformType.regex: 'regex',
  TransformType.replace: 'replace',
  TransformType.lowercase: 'lowercase',
  TransformType.uppercase: 'uppercase',
  TransformType.substring: 'substring',
  TransformType.split: 'split',
  TransformType.join: 'join',
  TransformType.map: 'map',
  TransformType.parseJson: 'parseJson',
  TransformType.formatNumber: 'formatNumber',
};
