// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Author _$AuthorFromJson(Map<String, dynamic> json) => _Author(
  name: json['name'] as String,
  id: json['id'] as String?,
  avatar: json['avatar'] as String?,
  description: json['description'] as String?,
  followerCount: (json['followerCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$AuthorToJson(_Author instance) => <String, dynamic>{
  'name': instance.name,
  'id': instance.id,
  'avatar': instance.avatar,
  'description': instance.description,
  'followerCount': instance.followerCount,
};
