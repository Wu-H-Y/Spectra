import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_stats.freezed.dart';
part 'content_stats.g.dart';

/// 内容统计和互动指标。
///
/// 跟踪浏览量、点赞数、评分和其他互动数据。
@freezed
sealed class ContentStats with _$ContentStats {
  /// 创建 [ContentStats] 实例。
  const factory ContentStats({
    /// 浏览/播放次数。
    int? viewCount,

    /// 点赞/支持数。
    int? likeCount,

    /// 收藏/书签数。
    int? favoriteCount,

    /// 评论数。
    int? commentCount,

    /// 分享/转发数。
    int? shareCount,

    /// 评分（通常为 0-10 或 0-5 分制）。
    double? rating,

    /// 收到的评分数。
    int? ratingCount,
  }) = _ContentStats;

  /// 从 JSON 创建 [ContentStats]。
  factory ContentStats.fromJson(Map<String, dynamic> json) =>
      _$ContentStatsFromJson(json);
}
