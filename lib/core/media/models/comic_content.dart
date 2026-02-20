import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/media/models/author.dart';
import 'package:spectra/core/media/models/content_source.dart';
import 'package:spectra/core/media/models/content_stats.dart';

part 'comic_content.freezed.dart';
part 'comic_content.g.dart';

/// 漫画章节/话。
@freezed
sealed class ComicChapter with _$ComicChapter {
  const factory ComicChapter({
    /// 章节 ID。
    required String id,

    /// 章节标题。
    required String title,

    /// 按阅读顺序排列的图片 URL 列表。
    required List<String> images,

    /// 章节索引/编号。
    required int index,

    /// 章节 URL（如果为单独页面）。
    String? url,
  }) = _ComicChapter;

  factory ComicChapter.fromJson(Map<String, dynamic> json) =>
      _$ComicChapterFromJson(json);
}

/// 漫画内容状态。
enum ComicStatus {
  /// 正在更新。
  ongoing,

  /// 已完结。
  completed,

  /// 暂停/休载。
  hiatus,

  /// 取消/停更。
  cancelled,
}

/// 漫画阅读方向。
enum ReadDirection {
  /// 从左到右（西式风格）。
  ltr,

  /// 从右到左（日式漫画风格）。
  rtl,

  /// 从上到下（条漫风格）。
  vertical,
}

/// 漫画/日漫内容模型。
@freezed
sealed class ComicContent with _$ComicContent {
  const factory ComicContent({
    /// 唯一标识符。
    required String id,

    /// 漫画标题。
    required String title,

    /// 来源信息。
    required ContentSource source,

    /// 章节列表。
    required List<ComicChapter> chapters,

    /// 封面图片 URL。
    String? cover,

    /// 描述/摘要。
    String? description,

    /// 作者/画师信息。
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

    /// 漫画状态。
    ComicStatus? status,

    /// 最新章节信息。
    ComicChapter? lastChapter,

    /// 阅读方向。
    @Default(ReadDirection.ltr) ReadDirection readDirection,

    /// 年龄分级/限制。
    String? ageRating,

    /// 总章节数。
    int? chapterCount,

    /// 所有章节的总图片数。
    int? totalImages,
  }) = _ComicContent;

  factory ComicContent.fromJson(Map<String, dynamic> json) =>
      _$ComicContentFromJson(json);
}
