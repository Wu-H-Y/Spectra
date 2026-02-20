import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/media/models/author.dart';
import 'package:spectra/core/media/models/content_source.dart';
import 'package:spectra/core/media/models/content_stats.dart';

part 'novel_content.freezed.dart';
part 'novel_content.g.dart';

/// 小说章节。
@freezed
sealed class NovelChapter with _$NovelChapter {
  const factory NovelChapter({
    /// 章节 ID。
    required String id,

    /// 章节标题。
    required String title,

    /// 章节索引/编号。
    required int index,

    /// 章节 URL（如果为单独页面）。
    String? url,

    /// 章节文本内容。
    String? content,

    /// 本章字数。
    int? wordCount,
  }) = _NovelChapter;

  factory NovelChapter.fromJson(Map<String, dynamic> json) =>
      _$NovelChapterFromJson(json);
}

/// 小说内容状态。
enum NovelStatus {
  /// 正在更新。
  ongoing,

  /// 已完结。
  completed,

  /// 暂停/休载。
  hiatus,

  /// 取消/停更。
  cancelled,
}

/// 小说/虚构内容模型。
@freezed
sealed class NovelContent with _$NovelContent {
  const factory NovelContent({
    /// 唯一标识符。
    required String id,

    /// 小说标题。
    required String title,

    /// 来源信息。
    required ContentSource source,

    /// 章节列表。
    required List<NovelChapter> chapters,

    /// 封面图片 URL。
    String? cover,

    /// 描述/摘要。
    String? description,

    /// 作者信息。
    Author? author,

    /// 标签。
    List<String>? tags,

    /// 分类。
    String? category,

    /// 统计信息。
    ContentStats? stats,

    /// 发布日期。
    DateTime? createdAt,

    /// 更新日期。
    DateTime? updatedAt,

    /// 小说状态。
    NovelStatus? status,

    /// 总字数。
    int? wordCount,

    /// 最新章节信息。
    NovelChapter? lastChapter,

    /// 总章节数。
    int? chapterCount,
  }) = _NovelContent;

  factory NovelContent.fromJson(Map<String, dynamic> json) =>
      _$NovelContentFromJson(json);
}
