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
  fileSize: (json['fileSize'] as num?)?.toInt(),
  format: json['format'] as String?,
  caption: json['caption'] as String?,
);

Map<String, dynamic> _$ImageInfoToJson(_ImageInfo instance) =>
    <String, dynamic>{
      'url': instance.url,
      'thumbnail': instance.thumbnail,
      'width': instance.width,
      'height': instance.height,
      'fileSize': instance.fileSize,
      'format': instance.format,
      'caption': instance.caption,
    };

_ImageContent _$ImageContentFromJson(Map<String, dynamic> json) =>
    _ImageContent(
      id: json['id'] as String,
      title: json['title'] as String,
      source: ContentSource.fromJson(json['source'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      isAlbum: json['isAlbum'] as bool,
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
      resolution: json['resolution'] as String?,
      isAIGenerated: json['isAIGenerated'] as bool?,
      aiModel: json['aiModel'] as String?,
    );

Map<String, dynamic> _$ImageContentToJson(_ImageContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source,
      'images': instance.images,
      'isAlbum': instance.isAlbum,
      'cover': instance.cover,
      'description': instance.description,
      'author': instance.author,
      'tags': instance.tags,
      'category': instance.category,
      'stats': instance.stats,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'resolution': instance.resolution,
      'isAIGenerated': instance.isAIGenerated,
      'aiModel': instance.aiModel,
    };
