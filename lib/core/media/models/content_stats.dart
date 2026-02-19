import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_stats.freezed.dart';
part 'content_stats.g.dart';

/// Content statistics and engagement metrics.
///
/// Tracks view counts, likes, ratings, and other engagement data.
@freezed
sealed class ContentStats with _$ContentStats {
  /// Creates a [ContentStats] instance.
  const factory ContentStats({
    /// View/play count.
    int? viewCount,

    /// Like/upvote count.
    int? likeCount,

    /// Favorite/bookmark count.
    int? favoriteCount,

    /// Comment count.
    int? commentCount,

    /// Share/repost count.
    int? shareCount,

    /// Rating score (typically 0-10 or 0-5 scale).
    double? rating,

    /// Number of ratings received.
    int? ratingCount,
  }) = _ContentStats;

  /// Creates [ContentStats] from JSON.
  factory ContentStats.fromJson(Map<String, dynamic> json) =>
      _$ContentStatsFromJson(json);
}
