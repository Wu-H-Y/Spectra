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
      fileSize: (json['file_size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VideoQualityToJson(_VideoQuality instance) =>
    <String, dynamic>{
      'label': instance.label,
      'url': instance.url,
      'codec': ?instance.codec,
      'bitrate': ?instance.bitrate,
      'width': ?instance.width,
      'height': ?instance.height,
      'file_size': ?instance.fileSize,
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
      'url': ?instance.url,
      'duration': ?instance.duration,
    };

_Subtitle _$SubtitleFromJson(Map<String, dynamic> json) => _Subtitle(
  language: json['language'] as String,
  url: json['url'] as String,
  label: json['label'] as String?,
  isDefault: json['is_default'] as bool? ?? false,
);

Map<String, dynamic> _$SubtitleToJson(_Subtitle instance) => <String, dynamic>{
  'language': instance.language,
  'url': instance.url,
  'label': ?instance.label,
  'is_default': instance.isDefault,
};

_DanmakuConfig _$DanmakuConfigFromJson(Map<String, dynamic> json) =>
    _DanmakuConfig(
      url: json['url'] as String?,
      rawData: json['raw_data'] as String?,
      enabled: json['enabled'] as bool? ?? true,
    );

Map<String, dynamic> _$DanmakuConfigToJson(_DanmakuConfig instance) =>
    <String, dynamic>{
      'url': ?instance.url,
      'raw_data': ?instance.rawData,
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
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      duration: (json['duration'] as num?)?.toInt(),
      playUrl: json['play_url'] as String?,
      qualities: (json['qualities'] as List<dynamic>?)
          ?.map((e) => VideoQuality.fromJson(e as Map<String, dynamic>))
          .toList(),
      chapters: (json['chapters'] as List<dynamic>?)
          ?.map((e) => VideoChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      previewUrl: json['preview_url'] as String?,
      subtitles: (json['subtitles'] as List<dynamic>?)
          ?.map((e) => Subtitle.fromJson(e as Map<String, dynamic>))
          .toList(),
      danmaku: json['danmaku'] == null
          ? null
          : DanmakuConfig.fromJson(json['danmaku'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$VideoStatusEnumMap, json['status']),
      isVip: json['is_vip'] as bool? ?? false,
      isPaid: json['is_paid'] as bool? ?? false,
    );

Map<String, dynamic> _$VideoContentToJson(_VideoContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source.toJson(),
      'cover': ?instance.cover,
      'description': ?instance.description,
      'author': ?instance.author?.toJson(),
      'tags': ?instance.tags,
      'category': ?instance.category,
      'stats': ?instance.stats?.toJson(),
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'duration': ?instance.duration,
      'play_url': ?instance.playUrl,
      'qualities': ?instance.qualities?.map((e) => e.toJson()).toList(),
      'chapters': ?instance.chapters?.map((e) => e.toJson()).toList(),
      'preview_url': ?instance.previewUrl,
      'subtitles': ?instance.subtitles?.map((e) => e.toJson()).toList(),
      'danmaku': ?instance.danmaku?.toJson(),
      'status': ?_$VideoStatusEnumMap[instance.status],
      'is_vip': instance.isVip,
      'is_paid': instance.isPaid,
    };

const _$VideoStatusEnumMap = {
  VideoStatus.ongoing: 'ongoing',
  VideoStatus.completed: 'completed',
  VideoStatus.upcoming: 'upcoming',
};
