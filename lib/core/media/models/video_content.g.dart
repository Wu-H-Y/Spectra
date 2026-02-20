// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoQuality _$VideoQualityFromJson(Map<String, dynamic> json) =>
    _VideoQuality(
      label: json['label'] as String,
      url: json['url'] as String,
      codec: json['codec'] as String?,
      bitrate: (json['bitrate'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      fileSize: (json['fileSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VideoQualityToJson(_VideoQuality instance) =>
    <String, dynamic>{
      'label': instance.label,
      'url': instance.url,
      'codec': instance.codec,
      'bitrate': instance.bitrate,
      'width': instance.width,
      'height': instance.height,
      'fileSize': instance.fileSize,
    };

_VideoChapter _$VideoChapterFromJson(Map<String, dynamic> json) =>
    _VideoChapter(
      id: json['id'] as String,
      title: json['title'] as String,
      index: (json['index'] as num).toInt(),
      url: json['url'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VideoChapterToJson(_VideoChapter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'index': instance.index,
      'url': instance.url,
      'duration': instance.duration,
    };

_Subtitle _$SubtitleFromJson(Map<String, dynamic> json) => _Subtitle(
  language: json['language'] as String,
  url: json['url'] as String,
  label: json['label'] as String?,
  isDefault: json['isDefault'] as bool? ?? false,
);

Map<String, dynamic> _$SubtitleToJson(_Subtitle instance) => <String, dynamic>{
  'language': instance.language,
  'url': instance.url,
  'label': instance.label,
  'isDefault': instance.isDefault,
};

_DanmakuConfig _$DanmakuConfigFromJson(Map<String, dynamic> json) =>
    _DanmakuConfig(
      url: json['url'] as String?,
      rawData: json['rawData'] as String?,
      enabled: json['enabled'] as bool? ?? true,
    );

Map<String, dynamic> _$DanmakuConfigToJson(_DanmakuConfig instance) =>
    <String, dynamic>{
      'url': instance.url,
      'rawData': instance.rawData,
      'enabled': instance.enabled,
    };

_VideoContent _$VideoContentFromJson(Map<String, dynamic> json) =>
    _VideoContent(
      id: json['id'] as String,
      title: json['title'] as String,
      source: ContentSource.fromJson(json['source'] as Map<String, dynamic>),
      cover: json['cover'] as String?,
      description: json['description'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      category: json['category'] as String?,
      stats: json['stats'] == null
          ? null
          : ContentStats.fromJson(json['stats'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      duration: (json['duration'] as num?)?.toInt(),
      playUrl: json['playUrl'] as String?,
      qualities: (json['qualities'] as List<dynamic>?)
          ?.map((e) => VideoQuality.fromJson(e as Map<String, dynamic>))
          .toList(),
      chapters: (json['chapters'] as List<dynamic>?)
          ?.map((e) => VideoChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      previewUrl: json['previewUrl'] as String?,
      subtitles: (json['subtitles'] as List<dynamic>?)
          ?.map((e) => Subtitle.fromJson(e as Map<String, dynamic>))
          .toList(),
      danmaku: json['danmaku'] == null
          ? null
          : DanmakuConfig.fromJson(json['danmaku'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$VideoStatusEnumMap, json['status']),
      isVip: json['isVip'] as bool? ?? false,
      isPaid: json['isPaid'] as bool? ?? false,
    );

Map<String, dynamic> _$VideoContentToJson(_VideoContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source,
      'cover': instance.cover,
      'description': instance.description,
      'author': instance.author,
      'tags': instance.tags,
      'category': instance.category,
      'stats': instance.stats,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'duration': instance.duration,
      'playUrl': instance.playUrl,
      'qualities': instance.qualities,
      'chapters': instance.chapters,
      'previewUrl': instance.previewUrl,
      'subtitles': instance.subtitles,
      'danmaku': instance.danmaku,
      'status': _$VideoStatusEnumMap[instance.status],
      'isVip': instance.isVip,
      'isPaid': instance.isPaid,
    };

const _$VideoStatusEnumMap = {
  VideoStatus.ongoing: 'ongoing',
  VideoStatus.completed: 'completed',
  VideoStatus.upcoming: 'upcoming',
};
