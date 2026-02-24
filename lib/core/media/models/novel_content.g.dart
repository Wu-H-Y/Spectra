// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NovelChapter _$NovelChapterFromJson(Map<String, dynamic> json) =>
    _NovelChapter(
      id: json['id'] as String,
      title: json['title'] as String,
      index: (json['index'] as num).toInt(),
      url: json['url'] as String?,
      content: json['content'] as String?,
      wordCount: (json['word_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NovelChapterToJson(_NovelChapter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'index': instance.index,
      'url': ?instance.url,
      'content': ?instance.content,
      'word_count': ?instance.wordCount,
    };

_NovelContent _$NovelContentFromJson(Map<String, dynamic> json) =>
    _NovelContent(
      id: json['id'] as String,
      title: json['title'] as String,
      source: ContentSource.fromJson(json['source'] as Map<String, dynamic>),
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => NovelChapter.fromJson(e as Map<String, dynamic>))
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
      status: $enumDecodeNullable(_$NovelStatusEnumMap, json['status']),
      wordCount: (json['word_count'] as num?)?.toInt(),
      lastChapter: json['last_chapter'] == null
          ? null
          : NovelChapter.fromJson(json['last_chapter'] as Map<String, dynamic>),
      chapterCount: (json['chapter_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NovelContentToJson(_NovelContent instance) =>
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
      'status': ?_$NovelStatusEnumMap[instance.status],
      'word_count': ?instance.wordCount,
      'last_chapter': ?instance.lastChapter?.toJson(),
      'chapter_count': ?instance.chapterCount,
    };

const _$NovelStatusEnumMap = {
  NovelStatus.ongoing: 'ongoing',
  NovelStatus.completed: 'completed',
  NovelStatus.hiatus: 'hiatus',
  NovelStatus.cancelled: 'cancelled',
};
