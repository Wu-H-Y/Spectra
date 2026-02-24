// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageInfo _$ImageInfoFromJson(Map<String, dynamic> json) => _ImageInfo(
  url: json['url'] as String,
  thumbnail: json['thumbnail'] as String?,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  fileSize: (json['file_size'] as num?)?.toInt(),
  format: json['format'] as String?,
  caption: json['caption'] as String?,
);

Map<String, dynamic> _$ImageInfoToJson(_ImageInfo instance) =>
    <String, dynamic>{
      'url': instance.url,
      'thumbnail': ?instance.thumbnail,
      'width': ?instance.width,
      'height': ?instance.height,
      'file_size': ?instance.fileSize,
      'format': ?instance.format,
      'caption': ?instance.caption,
    };

_ImageContent _$ImageContentFromJson(Map<String, dynamic> json) =>
    _ImageContent(
      id: json['id'] as String,
      title: json['title'] as String,
      source: ContentSource.fromJson(json['source'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      isAlbum: json['is_album'] as bool,
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
      resolution: json['resolution'] as String?,
      isAIGenerated: json['is_a_i_generated'] as bool?,
      aiModel: json['ai_model'] as String?,
    );

Map<String, dynamic> _$ImageContentToJson(_ImageContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source.toJson(),
      'images': instance.images.map((e) => e.toJson()).toList(),
      'is_album': instance.isAlbum,
      'cover': ?instance.cover,
      'description': ?instance.description,
      'author': ?instance.author?.toJson(),
      'tags': ?instance.tags,
      'category': ?instance.category,
      'stats': ?instance.stats?.toJson(),
      'created_at': ?instance.createdAt?.toIso8601String(),
      'updated_at': ?instance.updatedAt?.toIso8601String(),
      'resolution': ?instance.resolution,
      'is_a_i_generated': ?instance.isAIGenerated,
      'ai_model': ?instance.aiModel,
    };
