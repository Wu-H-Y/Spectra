// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lifecycle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentConfig _$ContentConfigFromJson(Map<String, dynamic> json) =>
    _ContentConfig(
      pipeline: PipelineGraph.fromJson(
        json['pipeline'] as Map<String, dynamic>,
      ),
      sniffMedia: json['sniff_media'] as bool,
    );

Map<String, dynamic> _$ContentConfigToJson(_ContentConfig instance) =>
    <String, dynamic>{
      'pipeline': instance.pipeline.toJson(),
      'sniff_media': instance.sniffMedia,
    };

_DetailConfig _$DetailConfigFromJson(Map<String, dynamic> json) =>
    _DetailConfig(
      pipeline: PipelineGraph.fromJson(
        json['pipeline'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$DetailConfigToJson(_DetailConfig instance) =>
    <String, dynamic>{'pipeline': instance.pipeline.toJson()};

_ExploreConfig _$ExploreConfigFromJson(Map<String, dynamic> json) =>
    _ExploreConfig(
      url: json['url'] as String,
      pipeline: PipelineGraph.fromJson(
        json['pipeline'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ExploreConfigToJson(_ExploreConfig instance) =>
    <String, dynamic>{
      'url': instance.url,
      'pipeline': instance.pipeline.toJson(),
    };

_Lifecycle _$LifecycleFromJson(Map<String, dynamic> json) => _Lifecycle(
  explore: json['explore'] == null
      ? null
      : ExploreConfig.fromJson(json['explore'] as Map<String, dynamic>),
  search: json['search'] == null
      ? null
      : SearchConfig.fromJson(json['search'] as Map<String, dynamic>),
  detail: json['detail'] == null
      ? null
      : DetailConfig.fromJson(json['detail'] as Map<String, dynamic>),
  toc: json['toc'] == null
      ? null
      : TocConfig.fromJson(json['toc'] as Map<String, dynamic>),
  content: json['content'] == null
      ? null
      : ContentConfig.fromJson(json['content'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LifecycleToJson(_Lifecycle instance) =>
    <String, dynamic>{
      'explore': ?instance.explore?.toJson(),
      'search': ?instance.search?.toJson(),
      'detail': ?instance.detail?.toJson(),
      'toc': ?instance.toc?.toJson(),
      'content': ?instance.content?.toJson(),
    };

_SearchConfig _$SearchConfigFromJson(Map<String, dynamic> json) =>
    _SearchConfig(
      url: json['url'] as String,
      pipeline: PipelineGraph.fromJson(
        json['pipeline'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SearchConfigToJson(_SearchConfig instance) =>
    <String, dynamic>{
      'url': instance.url,
      'pipeline': instance.pipeline.toJson(),
    };

_TocConfig _$TocConfigFromJson(Map<String, dynamic> json) => _TocConfig(
  pipeline: PipelineGraph.fromJson(json['pipeline'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TocConfigToJson(_TocConfig instance) =>
    <String, dynamic>{'pipeline': instance.pipeline.toJson()};
