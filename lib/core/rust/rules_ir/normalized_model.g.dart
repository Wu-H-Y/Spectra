// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normalized_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChapterItem _$ChapterItemFromJson(Map<String, dynamic> json) =>
    _ChapterItem(title: json['title'] as String, url: json['url'] as String?);

Map<String, dynamic> _$ChapterItemToJson(_ChapterItem instance) =>
    <String, dynamic>{'title': instance.title, 'url': ?instance.url};

_ContentModel _$ContentModelFromJson(Map<String, dynamic> json) =>
    _ContentModel(
      contentTextHtml: json['contentTextHtml'] as String?,
      contentTextPlain: json['contentTextPlain'] as String?,
      mediaAssets:
          (json['mediaAssets'] as List<dynamic>?)
              ?.map((e) => MediaAsset.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MediaAsset>[],
    );

Map<String, dynamic> _$ContentModelToJson(_ContentModel instance) =>
    <String, dynamic>{
      'contentTextHtml': ?instance.contentTextHtml,
      'contentTextPlain': ?instance.contentTextPlain,
      'mediaAssets': instance.mediaAssets.map((e) => e.toJson()).toList(),
    };

_DetailModel _$DetailModelFromJson(Map<String, dynamic> json) => _DetailModel(
  title: json['title'] as String,
  cover: json['cover'] as String?,
  author: json['author'] as String?,
  description: json['description'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$DetailModelToJson(_DetailModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'cover': ?instance.cover,
      'author': ?instance.author,
      'description': ?instance.description,
      'tags': instance.tags,
    };

_MediaAsset _$MediaAssetFromJson(Map<String, dynamic> json) => _MediaAsset(
  mediaType:
      $enumDecodeNullable(_$MediaTypeEnumMap, json['mediaType']) ??
      MediaType.video,
  url: json['url'] as String,
  title: json['title'] as String?,
  cover: json['cover'] as String?,
);

Map<String, dynamic> _$MediaAssetToJson(_MediaAsset instance) =>
    <String, dynamic>{
      'mediaType': _$MediaTypeEnumMap[instance.mediaType]!,
      'url': instance.url,
      'title': ?instance.title,
      'cover': ?instance.cover,
    };

const _$MediaTypeEnumMap = {
  MediaType.video: 'video',
  MediaType.music: 'music',
  MediaType.novel: 'novel',
  MediaType.comic: 'comic',
  MediaType.image: 'image',
};

_MediaExtension _$MediaExtensionFromJson(Map<String, dynamic> json) =>
    _MediaExtension(
      video: json['video'] == null
          ? null
          : MediaSpec.fromJson(json['video'] as Map<String, dynamic>),
      music: json['music'] == null
          ? null
          : MediaSpec.fromJson(json['music'] as Map<String, dynamic>),
      novel: json['novel'] == null
          ? null
          : MediaSpec.fromJson(json['novel'] as Map<String, dynamic>),
      comic: json['comic'] == null
          ? null
          : MediaSpec.fromJson(json['comic'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : MediaSpec.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MediaExtensionToJson(_MediaExtension instance) =>
    <String, dynamic>{
      'video': ?instance.video?.toJson(),
      'music': ?instance.music?.toJson(),
      'novel': ?instance.novel?.toJson(),
      'comic': ?instance.comic?.toJson(),
      'image': ?instance.image?.toJson(),
    };

_MediaSpec _$MediaSpecFromJson(Map<String, dynamic> json) => _MediaSpec(
  extra:
      (json['extra'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
);

Map<String, dynamic> _$MediaSpecToJson(_MediaSpec instance) =>
    <String, dynamic>{'extra': instance.extra};

_NormalizedModel _$NormalizedModelFromJson(Map<String, dynamic> json) =>
    _NormalizedModel(
      search: json['search'] == null
          ? null
          : SearchModel.fromJson(json['search'] as Map<String, dynamic>),
      detail: json['detail'] == null
          ? null
          : DetailModel.fromJson(json['detail'] as Map<String, dynamic>),
      toc: json['toc'] == null
          ? null
          : TocModel.fromJson(json['toc'] as Map<String, dynamic>),
      content: json['content'] == null
          ? null
          : ContentModel.fromJson(json['content'] as Map<String, dynamic>),
      media: json['media'] == null
          ? null
          : MediaExtension.fromJson(json['media'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NormalizedModelToJson(_NormalizedModel instance) =>
    <String, dynamic>{
      'search': ?instance.search?.toJson(),
      'detail': ?instance.detail?.toJson(),
      'toc': ?instance.toc?.toJson(),
      'content': ?instance.content?.toJson(),
      'media': ?instance.media?.toJson(),
    };

_SearchItem _$SearchItemFromJson(Map<String, dynamic> json) => _SearchItem(
  title: json['title'] as String,
  url: json['url'] as String,
  cover: json['cover'] as String?,
  author: json['author'] as String?,
);

Map<String, dynamic> _$SearchItemToJson(_SearchItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'cover': ?instance.cover,
      'author': ?instance.author,
    };

_SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => _SearchModel(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => SearchItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SearchItem>[],
);

Map<String, dynamic> _$SearchModelToJson(_SearchModel instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};

_TocModel _$TocModelFromJson(Map<String, dynamic> json) => _TocModel(
  chapters:
      (json['chapters'] as List<dynamic>?)
          ?.map((e) => ChapterItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ChapterItem>[],
);

Map<String, dynamic> _$TocModelToJson(_TocModel instance) => <String, dynamic>{
  'chapters': instance.chapters.map((e) => e.toJson()).toList(),
};
