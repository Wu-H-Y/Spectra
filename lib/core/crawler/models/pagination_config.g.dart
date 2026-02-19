// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginationConfig _$PaginationConfigFromJson(Map<String, dynamic> json) =>
    _PaginationConfig(
      type: $enumDecode(_$PaginationTypeEnumMap, json['type']),
      nextSelector: json['nextSelector'] == null
          ? null
          : Selector.fromJson(json['nextSelector'] as Map<String, dynamic>),
      urlTemplate: json['urlTemplate'] as String?,
      clickSelector: json['clickSelector'] == null
          ? null
          : Selector.fromJson(json['clickSelector'] as Map<String, dynamic>),
      scrollContainer: json['scrollContainer'] == null
          ? null
          : Selector.fromJson(json['scrollContainer'] as Map<String, dynamic>),
      maxPages: (json['maxPages'] as num?)?.toInt() ?? 0,
      delayMs: (json['delayMs'] as num?)?.toInt() ?? 1000,
      waitAfterLoadMs: (json['waitAfterLoadMs'] as num?)?.toInt() ?? 2000,
    );

Map<String, dynamic> _$PaginationConfigToJson(_PaginationConfig instance) =>
    <String, dynamic>{
      'type': _$PaginationTypeEnumMap[instance.type]!,
      'nextSelector': instance.nextSelector,
      'urlTemplate': instance.urlTemplate,
      'clickSelector': instance.clickSelector,
      'scrollContainer': instance.scrollContainer,
      'maxPages': instance.maxPages,
      'delayMs': instance.delayMs,
      'waitAfterLoadMs': instance.waitAfterLoadMs,
    };

const _$PaginationTypeEnumMap = {
  PaginationType.url: 'url',
  PaginationType.click: 'click',
  PaginationType.infiniteScroll: 'infiniteScroll',
};
