// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Selector _$SelectorFromJson(Map<String, dynamic> json) => _Selector(
  type: $enumDecode(_$SelectorTypeEnumMap, json['type']),
  expression: json['expression'] as String,
  attribute: json['attribute'] as String?,
  fallbacks: (json['fallbacks'] as List<dynamic>?)
      ?.map((e) => Selector.fromJson(e as Map<String, dynamic>))
      .toList(),
  firstOnly: json['firstOnly'] as bool? ?? false,
);

Map<String, dynamic> _$SelectorToJson(_Selector instance) => <String, dynamic>{
  'type': _$SelectorTypeEnumMap[instance.type]!,
  'expression': instance.expression,
  'attribute': instance.attribute,
  'fallbacks': instance.fallbacks,
  'firstOnly': instance.firstOnly,
};

const _$SelectorTypeEnumMap = {
  SelectorType.css: 'css',
  SelectorType.xpath: 'xpath',
  SelectorType.regex: 'regex',
  SelectorType.jsonpath: 'jsonpath',
  SelectorType.js: 'js',
};
