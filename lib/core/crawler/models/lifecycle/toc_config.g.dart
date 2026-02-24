// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toc_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TocConfig _$TocConfigFromJson(Map<String, dynamic> json) => _TocConfig(
  container: json['container'] as String,
  fields: (json['fields'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, Pipeline.fromJson(e as Map<String, dynamic>)),
  ),
  url: json['url'] as String?,
  reverseOrder: json['reverse_order'] as bool? ?? false,
  pagination: json['pagination'] == null
      ? null
      : PaginationConfig.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TocConfigToJson(_TocConfig instance) =>
    <String, dynamic>{
      'container': instance.container,
      'fields': instance.fields.map((k, e) => MapEntry(k, e.toJson())),
      'url': ?instance.url,
      'reverse_order': instance.reverseOrder,
      'pagination': ?instance.pagination?.toJson(),
    };
