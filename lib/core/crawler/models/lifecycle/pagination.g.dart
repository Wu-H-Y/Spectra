// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginationConfig _$PaginationConfigFromJson(Map<String, dynamic> json) =>
    _PaginationConfig(
      type:
          $enumDecodeNullable(_$PaginationTypeEnumMap, json['type']) ??
          PaginationType.url,
      nextSelector: json['next_selector'] as String?,
      pageParam: json['page_param'] as String? ?? 'page',
      startPage: (json['start_page'] as num?)?.toInt() ?? 1,
      maxPages: (json['max_pages'] as num?)?.toInt(),
      loadMoreSelector: json['load_more_selector'] as String?,
      scrollWaitMs: (json['scroll_wait_ms'] as num?)?.toInt() ?? 1000,
    );

Map<String, dynamic> _$PaginationConfigToJson(_PaginationConfig instance) =>
    <String, dynamic>{
      'type': _$PaginationTypeEnumMap[instance.type]!,
      'next_selector': ?instance.nextSelector,
      'page_param': instance.pageParam,
      'start_page': instance.startPage,
      'max_pages': ?instance.maxPages,
      'load_more_selector': ?instance.loadMoreSelector,
      'scroll_wait_ms': instance.scrollWaitMs,
    };

const _$PaginationTypeEnumMap = {
  PaginationType.url: 'url',
  PaginationType.click: 'click',
  PaginationType.scroll: 'scroll',
};
