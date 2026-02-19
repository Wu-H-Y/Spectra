import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/media/models/author.dart';
import 'package:spectra/core/media/models/content_source.dart';
import 'package:spectra/core/media/models/content_stats.dart';

part 'image_content.freezed.dart';
part 'image_content.g.dart';

/// Image information.
@freezed
sealed class ImageInfo with _$ImageInfo {
  const factory ImageInfo({
    /// Image URL.
    required String url,

    /// Thumbnail/preview URL.
    String? thumbnail,

    /// Image width in pixels.
    int? width,

    /// Image height in pixels.
    int? height,

    /// File size in bytes.
    int? fileSize,

    /// Image format (e.g., "jpg", "png", "webp").
    String? format,

    /// Alt text/caption.
    String? caption,
  }) = _ImageInfo;

  factory ImageInfo.fromJson(Map<String, dynamic> json) =>
      _$ImageInfoFromJson(json);
}

/// Image/album content model.
@freezed
sealed class ImageContent with _$ImageContent {
  const factory ImageContent({
    /// Unique identifier.
    required String id,

    /// Title/caption.
    required String title,

    /// Source information.
    required ContentSource source,

    /// List of images (single for non-album, multiple for album).
    required List<ImageInfo> images,

    /// Whether this is an album (multiple images).
    required bool isAlbum,

    /// Cover/thumbnail URL.
    String? cover,

    /// Description.
    String? description,

    /// Author/photographer information.
    Author? author,

    /// Tags.
    List<String>? tags,

    /// Category.
    String? category,

    /// Statistics.
    ContentStats? stats,

    /// Upload date.
    DateTime? createdAt,

    /// Update date.
    DateTime? updatedAt,

    /// Image resolution string (e.g., "1920x1080").
    String? resolution,

    /// Whether this is AI-generated content.
    bool? isAIGenerated,

    /// AI model name if AI-generated (e.g., "Stable Diffusion", "Midjourney").
    String? aiModel,
  }) = _ImageContent;

  factory ImageContent.fromJson(Map<String, dynamic> json) =>
      _$ImageContentFromJson(json);
}
