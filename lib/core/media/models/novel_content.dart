import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/media/models/author.dart';
import 'package:spectra/core/media/models/content_source.dart';
import 'package:spectra/core/media/models/content_stats.dart';

part 'novel_content.freezed.dart';
part 'novel_content.g.dart';

/// Novel chapter.
@freezed
sealed class NovelChapter with _$NovelChapter {
  const factory NovelChapter({
    /// Chapter ID.
    required String id,

    /// Chapter title.
    required String title,

    /// Chapter index/number.
    required int index, /// Chapter URL (if separate page).
    String? url,

    /// Chapter text content.
    String? content,

    /// Word count for this chapter.
    int? wordCount,
  }) = _NovelChapter;

  factory NovelChapter.fromJson(Map<String, dynamic> json) =>
      _$NovelChapterFromJson(json);
}

/// Novel content status.
enum NovelStatus {
  /// Currently updating.
  ongoing,

  /// Completed series.
  completed,

  /// On hiatus/break.
  hiatus,

  /// Cancelled/discontinued.
  cancelled,
}

/// Novel/fiction content model.
@freezed
sealed class NovelContent with _$NovelContent {
  const factory NovelContent({
    /// Unique identifier.
    required String id,

    /// Novel title.
    required String title,

    /// Source information.
    required ContentSource source, /// Chapter list.
    required List<NovelChapter> chapters, /// Cover image URL.
    String? cover,

    /// Description/summary.
    String? description,

    /// Author information.
    Author? author,

    /// Tags.
    List<String>? tags,

    /// Category.
    String? category,

    /// Statistics.
    ContentStats? stats,

    /// Publish date.
    DateTime? createdAt,

    /// Update date.
    DateTime? updatedAt,

    /// Novel status.
    NovelStatus? status,

    /// Total word count.
    int? wordCount,

    /// Latest chapter info.
    NovelChapter? lastChapter,

    /// Total chapter count.
    int? chapterCount,
  }) = _NovelContent;

  factory NovelContent.fromJson(Map<String, dynamic> json) =>
      _$NovelContentFromJson(json);
}
