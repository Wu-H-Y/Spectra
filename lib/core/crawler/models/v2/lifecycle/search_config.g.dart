// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchConfig _$SearchConfigFromJson(Map<String, dynamic> json) =>
    _SearchConfig(
      url: json['url'] as String,
      list: (json['list'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Pipeline.fromJson(e as Map<String, dynamic>)),
      ),
      pagination: json['pagination'] == null
          ? null
          : PaginationConfig.fromJson(
              json['pagination'] as Map<String, dynamic>,
            ),
      encoding:
          $enumDecodeNullable(_$UrlEncodingEnumMap, json['encoding']) ??
          UrlEncoding.utf8,
    );

Map<String, dynamic> _$SearchConfigToJson(_SearchConfig instance) =>
    <String, dynamic>{
      'url': instance.url,
      'list': instance.list.map((k, e) => MapEntry(k, e.toJson())),
      'pagination': ?instance.pagination?.toJson(),
      'encoding': _$UrlEncodingEnumMap[instance.encoding]!,
    };

const _$UrlEncodingEnumMap = {
  UrlEncoding.utf8: 'utf8',
  UrlEncoding.gbk: 'gbk',
  UrlEncoding.gb2312: 'gb2312',
};
