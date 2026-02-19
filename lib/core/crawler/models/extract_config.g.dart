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
      'container': instance.container,
      'items': instance.items,
      'pagination': instance.pagination,
      'url': instance.url,
    };

_DetailExtract _$DetailExtractFromJson(Map<String, dynamic> json) =>
    _DetailExtract(
      urlFromList: json['urlFromList'] == null
          ? null
          : Selector.fromJson(json['urlFromList'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map((e) => FieldMapping.fromJson(e as Map<String, dynamic>))
          .toList(),
      chapters: json['chapters'] == null
          ? null
          : ChapterExtract.fromJson(json['chapters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailExtractToJson(_DetailExtract instance) =>
    <String, dynamic>{
      'urlFromList': instance.urlFromList,
      'items': instance.items,
      'chapters': instance.chapters,
    };

_ChapterExtract _$ChapterExtractFromJson(Map<String, dynamic> json) =>
    _ChapterExtract(
      container: Selector.fromJson(json['container'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map((e) => FieldMapping.fromJson(e as Map<String, dynamic>))
          .toList(),
      reverseOrder: json['reverseOrder'] as bool? ?? false,
    );

Map<String, dynamic> _$ChapterExtractToJson(_ChapterExtract instance) =>
    <String, dynamic>{
      'container': instance.container,
      'items': instance.items,
      'reverseOrder': instance.reverseOrder,
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
      'video': instance.video,
      'comic': instance.comic,
      'novel': instance.novel,
      'music': instance.music,
    };

_VideoExtract _$VideoExtractFromJson(Map<String, dynamic> json) =>
    _VideoExtract(
      playUrl: json['playUrl'] == null
          ? null
          : Selector.fromJson(json['playUrl'] as Map<String, dynamic>),
      qualities: json['qualities'] == null
          ? null
          : Selector.fromJson(json['qualities'] as Map<String, dynamic>),
      jsExtract: json['jsExtract'] as String?,
    );

Map<String, dynamic> _$VideoExtractToJson(_VideoExtract instance) =>
    <String, dynamic>{
      'playUrl': instance.playUrl,
      'qualities': instance.qualities,
      'jsExtract': instance.jsExtract,
    };

_ComicExtract _$ComicExtractFromJson(Map<String, dynamic> json) =>
    _ComicExtract(
      images: Selector.fromJson(json['images'] as Map<String, dynamic>),
      jsExtract: json['jsExtract'] as String?,
    );

Map<String, dynamic> _$ComicExtractToJson(_ComicExtract instance) =>
    <String, dynamic>{
      'images': instance.images,
      'jsExtract': instance.jsExtract,
    };

_NovelExtract _$NovelExtractFromJson(Map<String, dynamic> json) =>
    _NovelExtract(
      content: Selector.fromJson(json['content'] as Map<String, dynamic>),
      jsExtract: json['jsExtract'] as String?,
    );

Map<String, dynamic> _$NovelExtractToJson(_NovelExtract instance) =>
    <String, dynamic>{
      'content': instance.content,
      'jsExtract': instance.jsExtract,
    };

_MusicExtract _$MusicExtractFromJson(Map<String, dynamic> json) =>
    _MusicExtract(
      audioUrl: json['audioUrl'] == null
          ? null
          : Selector.fromJson(json['audioUrl'] as Map<String, dynamic>),
      lyrics: json['lyrics'] == null
          ? null
          : Selector.fromJson(json['lyrics'] as Map<String, dynamic>),
      jsExtract: json['jsExtract'] as String?,
    );

Map<String, dynamic> _$MusicExtractToJson(_MusicExtract instance) =>
    <String, dynamic>{
      'audioUrl': instance.audioUrl,
      'lyrics': instance.lyrics,
      'jsExtract': instance.jsExtract,
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
      'list': instance.list,
      'detail': instance.detail,
      'content': instance.content,
    };
