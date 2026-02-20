// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BaseContent _$BaseContentFromJson(Map<String, dynamic> json) => _BaseContent(
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
);

Map<String, dynamic> _$BaseContentToJson(_BaseContent instance) =>
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
    };
