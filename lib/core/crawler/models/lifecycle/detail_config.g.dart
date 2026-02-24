// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DetailConfig _$DetailConfigFromJson(Map<String, dynamic> json) =>
    _DetailConfig(
      fields: (json['fields'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Pipeline.fromJson(e as Map<String, dynamic>)),
      ),
      url: json['url'] as String?,
      urlFromList: json['url_from_list'] as String?,
    );

Map<String, dynamic> _$DetailConfigToJson(_DetailConfig instance) =>
    <String, dynamic>{
      'fields': instance.fields.map((k, e) => MapEntry(k, e.toJson())),
      'url': ?instance.url,
      'url_from_list': ?instance.urlFromList,
    };
