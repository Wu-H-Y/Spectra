// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NovelChapter _$NovelChapterFromJson(Map<String, dynamic> json) =>
    _NovelChapter(
      id: json['id'] as String,
      title: json['title'] as String,
      url: json['url'] as String?,
      content: json['content'] as String?,
      wordCount: (json['wordCount'] as num?)?.toInt(),
      index: (json['index'] as num).toInt(),
    );

Map<String, dynamic> _$NovelChapterToJson(_NovelChapter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'content': instance.content,
      'wordCount': instance.wordCount,
      'index': instance.index,
    };

_NovelContent _$NovelContentFromJson(Map<String, dynamic> json) =>
    _NovelContent(
      id: json['id'] as String,
      title: json['title'] as String,
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
      source: ContentSource.fromJson(json['source'] as Map<String, dynamic>),
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => NovelChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecodeNullable(_$NovelStatusEnumMap, json['status']),
      wordCount: (json['wordCount'] as num?)?.toInt(),
      lastChapter: json['lastChapter'] == null
          ? null
          : NovelChapter.fromJson(json['lastChapter'] as Map<String, dynamic>),
      chapterCount: (json['chapterCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NovelContentToJson(_NovelContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cover': instance.cover,
      'description': instance.description,
      'author': instance.author,
      'tags': instance.tags,
      'category': instance.category,
      'stats': instance.stats,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'source': instance.source,
      'chapters': instance.chapters,
      'status': _$NovelStatusEnumMap[instance.status],
      'wordCount': instance.wordCount,
      'lastChapter': instance.lastChapter,
      'chapterCount': instance.chapterCount,
    };

const _$NovelStatusEnumMap = {
  NovelStatus.ongoing: 'ongoing',
  NovelStatus.completed: 'completed',
  NovelStatus.hiatus: 'hiatus',
  NovelStatus.cancelled: 'cancelled',
};
