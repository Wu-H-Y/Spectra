// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExploreMenu _$ExploreMenuFromJson(Map<String, dynamic> json) => _ExploreMenu(
  name: json['name'] as String,
  key: json['key'] as String,
  options: (json['options'] as List<dynamic>)
      .map((e) => ExploreOption.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ExploreMenuToJson(_ExploreMenu instance) =>
    <String, dynamic>{
      'name': instance.name,
      'key': instance.key,
      'options': instance.options.map((e) => e.toJson()).toList(),
    };

_ExploreOption _$ExploreOptionFromJson(Map<String, dynamic> json) =>
    _ExploreOption(
      name: json['name'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$ExploreOptionToJson(_ExploreOption instance) =>
    <String, dynamic>{'name': instance.name, 'value': instance.value};

_ExploreConfig _$ExploreConfigFromJson(Map<String, dynamic> json) =>
    _ExploreConfig(
      url: json['url'] as String,
      list: (json['list'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Pipeline.fromJson(e as Map<String, dynamic>)),
      ),
      menus: (json['menus'] as List<dynamic>?)
          ?.map((e) => ExploreMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationConfig.fromJson(
              json['pagination'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ExploreConfigToJson(_ExploreConfig instance) =>
    <String, dynamic>{
      'url': instance.url,
      'list': instance.list.map((k, e) => MapEntry(k, e.toJson())),
      'menus': ?instance.menus?.map((e) => e.toJson()).toList(),
      'pagination': ?instance.pagination?.toJson(),
    };
