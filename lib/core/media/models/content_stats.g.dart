// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentStats _$ContentStatsFromJson(Map<String, dynamic> json) =>
    _ContentStats(
      viewCount: (json['viewCount'] as num?)?.toInt(),
      likeCount: (json['likeCount'] as num?)?.toInt(),
      favoriteCount: (json['favoriteCount'] as num?)?.toInt(),
      commentCount: (json['commentCount'] as num?)?.toInt(),
      shareCount: (json['shareCount'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      ratingCount: (json['ratingCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ContentStatsToJson(_ContentStats instance) =>
    <String, dynamic>{
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'favoriteCount': instance.favoriteCount,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'rating': instance.rating,
      'ratingCount': instance.ratingCount,
    };
