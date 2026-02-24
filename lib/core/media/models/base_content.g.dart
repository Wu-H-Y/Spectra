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
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$BaseContentToJson(_BaseContent instance) =>
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
    };
