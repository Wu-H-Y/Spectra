import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/media/models/author.dart';
import 'package:spectra/core/media/models/content_source.dart';
import 'package:spectra/core/media/models/content_stats.dart';

part 'base_content.freezed.dart';
part 'base_content.g.dart';

/// 所有媒体类型共享字段的基础内容模型。
///
/// 这是所有特定内容类型的基础。
/// 使用特定内容类型（VideoContent、ComicContent 等）
/// 进行类型安全的媒体处理。
@freezed
sealed class BaseContent with _$BaseContent {
  /// 创建 [BaseContent] 实例。
  const factory BaseContent({
    /// 此内容的唯一标识符。
    required String id,

    /// 内容标题。
    required String title,

    /// 来源信息（内容爬取的来源）。
    required ContentSource source,

    /// 封面/缩略图 URL。
    String? cover,

    /// 描述/摘要。
    String? description,

    /// 作者信息。
    Author? author,

    /// 标签/分类列表。
    List<String>? tags,

    /// 主要分类名称。
    String? category,

    /// 内容统计。
    ContentStats? stats,

    /// 原始发布日期。
    DateTime? createdAt,

    /// 最后更新日期。
    DateTime? updatedAt,
  }) = _BaseContent;

  /// 从 JSON 创建 [BaseContent]。
  factory BaseContent.fromJson(Map<String, dynamic> json) =>
      _$BaseContentFromJson(json);
}
