// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AudioQuality _$AudioQualityFromJson(Map<String, dynamic> json) =>
    _AudioQuality(
      label: json['label'] as String,
      url: json['url'] as String,
      codec: json['codec'] as String?,
      bitrate: (json['bitrate'] as num?)?.toInt(),
      sampleRate: (json['sample_rate'] as num?)?.toInt(),
      fileSize: (json['file_size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AudioQualityToJson(_AudioQuality instance) =>
    <String, dynamic>{
      'label': instance.label,
      'url': instance.url,
      'codec': ?instance.codec,
      'bitrate': ?instance.bitrate,
      'sample_rate': ?instance.sampleRate,
      'file_size': ?instance.fileSize,
    };

_Lyrics _$LyricsFromJson(Map<String, dynamic> json) => _Lyrics(
  text: json['text'] as String?,
  lrc: json['lrc'] as String?,
  language: json['language'] as String?,
);

Map<String, dynamic> _$LyricsToJson(_Lyrics instance) => <String, dynamic>{
  'text': ?instance.text,
  'lrc': ?instance.lrc,
  'language': ?instance.language,
};

_MusicContent _$MusicContentFromJson(Map<String, dynamic> json) =>
    _MusicContent(
      id: json['id'] as String,
      title: json['title'] as String,
      source: ContentSource.fromJson(json['source'] as Map<String, dynamic>),
      cover: json['cover'] as String?,
      description: json['description'] as String?,
      artistInfo: json['artist_info'] == null
          ? null
          : Author.fromJson(json['artist_info'] as Map<String, dynamic>),
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
      audioUrl: json['audio_url'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      artist: json['artist'] as String?,
      album: json['album'] as String?,
      albumCover: json['album_cover'] as String?,
      qualities: (json['qualities'] as List<dynamic>?)
          ?.map((e) => AudioQuality.fromJson(e as Map<String, dynamic>))
          .toList(),
      lyrics: json['lyrics'] == null
          ? null
          : Lyrics.fromJson(json['lyrics'] as Map<String, dynamic>),
      mvUrl: json['mv_url'] as String?,
      copyright: json['copyright'] as String?,
    );

Map<String, dynamic> _$MusicContentToJson(_MusicContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source.toJson(),
      'cover': ?instance.cover,
      'description': ?instance.description,
      'artist_info': ?instance.artistInfo?.toJson(),
      'tags': ?instance.tags,
      'category': ?instance.category,
      'stats': ?instance.stats?.toJson(),
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'audio_url': ?instance.audioUrl,
      'duration': ?instance.duration,
      'artist': ?instance.artist,
      'album': ?instance.album,
      'album_cover': ?instance.albumCover,
      'qualities': ?instance.qualities?.map((e) => e.toJson()).toList(),
      'lyrics': ?instance.lyrics?.toJson(),
      'mv_url': ?instance.mvUrl,
      'copyright': ?instance.copyright,
    };
