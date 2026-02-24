// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ComicChapter _$ComicChapterFromJson(Map<String, dynamic> json) =>
    _ComicChapter(
      id: json['id'] as String,
      title: json['title'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      index: (json['index'] as num).toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ComicChapterToJson(_ComicChapter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'images': instance.images,
      'index': instance.index,
      'url': ?instance.url,
    };

_ComicContent _$ComicContentFromJson(Map<String, dynamic> json) =>
    _ComicContent(
      id: json['id'] as String,
      title: json['title'] as String,
      source: ContentSource.fromJson(json['source'] as Map<String, dynamic>),
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => ComicChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      status: $enumDecodeNullable(_$ComicStatusEnumMap, json['status']),
      lastChapter: json['last_chapter'] == null
          ? null
          : ComicChapter.fromJson(json['last_chapter'] as Map<String, dynamic>),
      readDirection:
          $enumDecodeNullable(_$ReadDirectionEnumMap, json['read_direction']) ??
          ReadDirection.ltr,
      ageRating: json['age_rating'] as String?,
      chapterCount: (json['chapter_count'] as num?)?.toInt(),
      totalImages: (json['total_images'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ComicContentToJson(_ComicContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source.toJson(),
      'chapters': instance.chapters.map((e) => e.toJson()).toList(),
      'cover': ?instance.cover,
      'description': ?instance.description,
      'author': ?instance.author?.toJson(),
      'tags': ?instance.tags,
      'category': ?instance.category,
      'stats': ?instance.stats?.toJson(),
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'status': ?_$ComicStatusEnumMap[instance.status],
      'last_chapter': ?instance.lastChapter?.toJson(),
      'read_direction': _$ReadDirectionEnumMap[instance.readDirection]!,
      'age_rating': ?instance.ageRating,
      'chapter_count': ?instance.chapterCount,
      'total_images': ?instance.totalImages,
    };

const _$ComicStatusEnumMap = {
  ComicStatus.ongoing: 'ongoing',
  ComicStatus.completed: 'completed',
  ComicStatus.hiatus: 'hiatus',
  ComicStatus.cancelled: 'cancelled',
};

const _$ReadDirectionEnumMap = {
  ReadDirection.ltr: 'ltr',
  ReadDirection.rtl: 'rtl',
  ReadDirection.vertical: 'vertical',
};
