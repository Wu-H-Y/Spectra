// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_mapping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FieldMapping _$FieldMappingFromJson(Map<String, dynamic> json) =>
    _FieldMapping(
      field: json['field'] as String,
      selector: Selector.fromJson(json['selector'] as Map<String, dynamic>),
      defaultValue: json['defaultValue'] as String?,
      transforms: (json['transforms'] as List<dynamic>?)
          ?.map((e) => Transform.fromJson(e as Map<String, dynamic>))
          .toList(),
      required: json['required'] as bool? ?? false,
    );

Map<String, dynamic> _$FieldMappingToJson(_FieldMapping instance) =>
    <String, dynamic>{
      'field': instance.field,
      'selector': instance.selector,
      'defaultValue': instance.defaultValue,
      'transforms': instance.transforms,
      'required': instance.required,
    };
