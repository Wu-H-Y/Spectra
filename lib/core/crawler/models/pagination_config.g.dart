// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginationConfig _$PaginationConfigFromJson(Map<String, dynamic> json) =>
    _PaginationConfig(
      type: $enumDecode(_$PaginationTypeEnumMap, json['type']),
      nextSelector: json['next_selector'] == null
          ? null
          : Selector.fromJson(json['next_selector'] as Map<String, dynamic>),
      urlTemplate: json['url_template'] as String?,
      clickSelector: json['click_selector'] == null
          ? null
          : Selector.fromJson(json['click_selector'] as Map<String, dynamic>),
      scrollContainer: json['scroll_container'] == null
          ? null
          : Selector.fromJson(json['scroll_container'] as Map<String, dynamic>),
      maxPages: (json['max_pages'] as num?)?.toInt() ?? 0,
      delayMs: (json['delay_ms'] as num?)?.toInt() ?? 1000,
      waitAfterLoadMs: (json['wait_after_load_ms'] as num?)?.toInt() ?? 2000,
    );

Map<String, dynamic> _$PaginationConfigToJson(_PaginationConfig instance) =>
    <String, dynamic>{
      'type': _$PaginationTypeEnumMap[instance.type]!,
      'next_selector': ?instance.nextSelector?.toJson(),
      'url_template': ?instance.urlTemplate,
      'click_selector': ?instance.clickSelector?.toJson(),
      'scroll_container': ?instance.scrollContainer?.toJson(),
      'max_pages': instance.maxPages,
      'delay_ms': instance.delayMs,
      'wait_after_load_ms': instance.waitAfterLoadMs,
    };

const _$PaginationTypeEnumMap = {
  PaginationType.url: 'url',
  PaginationType.click: 'click',
  PaginationType.infiniteScroll: 'infiniteScroll',
};
