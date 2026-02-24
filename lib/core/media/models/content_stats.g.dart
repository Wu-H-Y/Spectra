// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentStats _$ContentStatsFromJson(Map<String, dynamic> json) =>
    _ContentStats(
      viewCount: (json['view_count'] as num?)?.toInt(),
      likeCount: (json['like_count'] as num?)?.toInt(),
      favoriteCount: (json['favorite_count'] as num?)?.toInt(),
      commentCount: (json['comment_count'] as num?)?.toInt(),
      shareCount: (json['share_count'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      ratingCount: (json['rating_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ContentStatsToJson(_ContentStats instance) =>
    <String, dynamic>{
      'view_count': ?instance.viewCount,
      'like_count': ?instance.likeCount,
      'favorite_count': ?instance.favoriteCount,
      'comment_count': ?instance.commentCount,
      'share_count': ?instance.shareCount,
      'rating': ?instance.rating,
      'rating_count': ?instance.ratingCount,
    };
