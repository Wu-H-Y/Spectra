// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extract_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListExtract _$ListExtractFromJson(Map<String, dynamic> json) => _ListExtract(
  container: Selector.fromJson(json['container'] as Map<String, dynamic>),
  items: (json['items'] as List<dynamic>)
      .map((e) => FieldMapping.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : PaginationConfig.fromJson(json['pagination'] as Map<String, dynamic>),
  url: json['url'] as String?,
);

Map<String, dynamic> _$ListExtractToJson(_ListExtract instance) =>
    <String, dynamic>{
      'container': instance.container.toJson(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'pagination': ?instance.pagination?.toJson(),
      'url': ?instance.url,
    };

_DetailExtract _$DetailExtractFromJson(Map<String, dynamic> json) =>
    _DetailExtract(
      items: (json['items'] as List<dynamic>)
          .map((e) => FieldMapping.fromJson(e as Map<String, dynamic>))
          .toList(),
      urlFromList: json['url_from_list'] == null
          ? null
          : Selector.fromJson(json['url_from_list'] as Map<String, dynamic>),
      chapters: json['chapters'] == null
          ? null
          : ChapterExtract.fromJson(json['chapters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailExtractToJson(_DetailExtract instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'url_from_list': ?instance.urlFromList?.toJson(),
      'chapters': ?instance.chapters?.toJson(),
    };

_ChapterExtract _$ChapterExtractFromJson(Map<String, dynamic> json) =>
    _ChapterExtract(
      container: Selector.fromJson(json['container'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map((e) => FieldMapping.fromJson(e as Map<String, dynamic>))
          .toList(),
      reverseOrder: json['reverse_order'] as bool? ?? false,
    );

Map<String, dynamic> _$ChapterExtractToJson(_ChapterExtract instance) =>
    <String, dynamic>{
      'container': instance.container.toJson(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'reverse_order': instance.reverseOrder,
    };

_ContentExtract _$ContentExtractFromJson(Map<String, dynamic> json) =>
    _ContentExtract(
      video: json['video'] == null
          ? null
          : VideoExtract.fromJson(json['video'] as Map<String, dynamic>),
      comic: json['comic'] == null
          ? null
          : ComicExtract.fromJson(json['comic'] as Map<String, dynamic>),
      novel: json['novel'] == null
          ? null
          : NovelExtract.fromJson(json['novel'] as Map<String, dynamic>),
      music: json['music'] == null
          ? null
          : MusicExtract.fromJson(json['music'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentExtractToJson(_ContentExtract instance) =>
    <String, dynamic>{
      'video': ?instance.video?.toJson(),
      'comic': ?instance.comic?.toJson(),
      'novel': ?instance.novel?.toJson(),
      'music': ?instance.music?.toJson(),
    };

_VideoExtract _$VideoExtractFromJson(Map<String, dynamic> json) =>
    _VideoExtract(
      playUrl: json['play_url'] == null
          ? null
          : Selector.fromJson(json['play_url'] as Map<String, dynamic>),
      qualities: json['qualities'] == null
          ? null
          : Selector.fromJson(json['qualities'] as Map<String, dynamic>),
      jsExtract: json['js_extract'] as String?,
    );

Map<String, dynamic> _$VideoExtractToJson(_VideoExtract instance) =>
    <String, dynamic>{
      'play_url': ?instance.playUrl?.toJson(),
      'qualities': ?instance.qualities?.toJson(),
      'js_extract': ?instance.jsExtract,
    };

_ComicExtract _$ComicExtractFromJson(Map<String, dynamic> json) =>
    _ComicExtract(
      images: Selector.fromJson(json['images'] as Map<String, dynamic>),
      jsExtract: json['js_extract'] as String?,
    );

Map<String, dynamic> _$ComicExtractToJson(_ComicExtract instance) =>
    <String, dynamic>{
      'images': instance.images.toJson(),
      'js_extract': ?instance.jsExtract,
    };

_NovelExtract _$NovelExtractFromJson(Map<String, dynamic> json) =>
    _NovelExtract(
      content: Selector.fromJson(json['content'] as Map<String, dynamic>),
      jsExtract: json['js_extract'] as String?,
    );

Map<String, dynamic> _$NovelExtractToJson(_NovelExtract instance) =>
    <String, dynamic>{
      'content': instance.content.toJson(),
      'js_extract': ?instance.jsExtract,
    };

_MusicExtract _$MusicExtractFromJson(Map<String, dynamic> json) =>
    _MusicExtract(
      audioUrl: json['audio_url'] == null
          ? null
          : Selector.fromJson(json['audio_url'] as Map<String, dynamic>),
      lyrics: json['lyrics'] == null
          ? null
          : Selector.fromJson(json['lyrics'] as Map<String, dynamic>),
      jsExtract: json['js_extract'] as String?,
    );

Map<String, dynamic> _$MusicExtractToJson(_MusicExtract instance) =>
    <String, dynamic>{
      'audio_url': ?instance.audioUrl?.toJson(),
      'lyrics': ?instance.lyrics?.toJson(),
      'js_extract': ?instance.jsExtract,
    };

_ExtractConfig _$ExtractConfigFromJson(Map<String, dynamic> json) =>
    _ExtractConfig(
      list: json['list'] == null
          ? null
          : ListExtract.fromJson(json['list'] as Map<String, dynamic>),
      detail: json['detail'] == null
          ? null
          : DetailExtract.fromJson(json['detail'] as Map<String, dynamic>),
      content: json['content'] == null
          ? null
          : ContentExtract.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExtractConfigToJson(_ExtractConfig instance) =>
    <String, dynamic>{
      'list': ?instance.list?.toJson(),
      'detail': ?instance.detail?.toJson(),
      'content': ?instance.content?.toJson(),
    };
