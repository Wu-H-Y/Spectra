import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/media/models/author.dart';
import 'package:spectra/core/media/models/content_source.dart';
import 'package:spectra/core/media/models/content_stats.dart';

part 'base_content.freezed.dart';
part 'base_content.g.dart';

/// Base content model with shared fields for all media types.
///
/// This is the foundation for all specific content types.
/// Use the specific content types (VideoContent, ComicContent, etc.)
/// for type-safe media handling.
@freezed
sealed class BaseContent with _$BaseContent {
  /// Creates a [BaseContent] instance.
  const factory BaseContent({
    /// Unique identifier for this content.
    required String id,

    /// Content title.
    required String title,

    /// Source information (where content was crawled from).
    required ContentSource source, /// Cover/thumbnail image URL.
    String? cover,

    /// Description/summary.
    String? description,

    /// Author information.
    Author? author,

    /// List of tags/categories.
    List<String>? tags,

    /// Primary category name.
    String? category,

    /// Content statistics.
    ContentStats? stats,

    /// Original publish date.
    DateTime? createdAt,

    /// Last update date.
    DateTime? updatedAt,
  }) = _BaseContent;

  /// Creates [BaseContent] from JSON.
  factory BaseContent.fromJson(Map<String, dynamic> json) =>
      _$BaseContentFromJson(json);
}
