import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/media/models/author.dart';
import 'package:spectra/core/media/models/content_source.dart';
import 'package:spectra/core/media/models/content_stats.dart';

part 'comic_content.freezed.dart';
part 'comic_content.g.dart';

/// Comic chapter/episode.
@freezed
sealed class ComicChapter with _$ComicChapter {
  const factory ComicChapter({
    /// Chapter ID.
    required String id,

    /// Chapter title.
    required String title,

    /// List of image URLs in reading order.
    required List<String> images, /// Chapter index/number.
    required int index, /// Chapter URL (if separate page).
    String? url,
  }) = _ComicChapter;

  factory ComicChapter.fromJson(Map<String, dynamic> json) =>
      _$ComicChapterFromJson(json);
}

/// Comic content status.
enum ComicStatus {
  /// Currently updating.
  ongoing,

  /// Completed series.
  completed,

  /// On hiatus/break.
  hiatus,

  /// Cancelled/discontinued.
  cancelled,
}

/// Reading direction for comics.
enum ReadDirection {
  /// Left to right (Western style).
  ltr,

  /// Right to left (Japanese manga style).
  rtl,

  /// Top to bottom (Webtoon style).
  vertical,
}

/// Comic/manga content model.
@freezed
sealed class ComicContent with _$ComicContent {
  const factory ComicContent({
    /// Unique identifier.
    required String id,

    /// Comic title.
    required String title,

    /// Source information.
    required ContentSource source, /// Chapter list.
    required List<ComicChapter> chapters, /// Cover image URL.
    String? cover,

    /// Description/summary.
    String? description,

    /// Author/artist information.
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

    /// Comic status.
    ComicStatus? status,

    /// Latest chapter info.
    ComicChapter? lastChapter,

    /// Reading direction.
    @Default(ReadDirection.ltr) ReadDirection readDirection,

    /// Age rating/restriction.
    String? ageRating,

    /// Total chapter count.
    int? chapterCount,

    /// Total image count across all chapters.
    int? totalImages,
  }) = _ComicContent;

  factory ComicContent.fromJson(Map<String, dynamic> json) =>
      _$ComicContentFromJson(json);
}
