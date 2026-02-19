import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/field_mapping.dart';
import 'package:spectra/core/crawler/models/pagination_config.dart';
import 'package:spectra/core/crawler/models/selector.dart';

part 'extract_config.freezed.dart';
part 'extract_config.g.dart';

/// List page extraction configuration.
@freezed
sealed class ListExtract with _$ListExtract {
  const factory ListExtract({
    /// Selector for list item containers.
    required Selector container,

    /// Field mappings for each list item.
    required List<FieldMapping> items,

    /// Pagination configuration.
    PaginationConfig? pagination,

    /// URL for list page (optional, uses rule pattern if not specified).
    String? url,
  }) = _ListExtract;

  factory ListExtract.fromJson(Map<String, dynamic> json) =>
      _$ListExtractFromJson(json);
}

/// Detail page extraction configuration.
@freezed
sealed class DetailExtract with _$DetailExtract {
  const factory DetailExtract({
    /// Field mappings for detail page.
    required List<FieldMapping> items,

    /// Selector to get detail URL from list item.
    Selector? urlFromList,

    /// Chapter/episode extraction (for comics, novels, videos).
    ChapterExtract? chapters,
  }) = _DetailExtract;

  factory DetailExtract.fromJson(Map<String, dynamic> json) =>
      _$DetailExtractFromJson(json);
}

/// Chapter extraction configuration.
@freezed
sealed class ChapterExtract with _$ChapterExtract {
  const factory ChapterExtract({
    /// Selector for chapter list container.
    required Selector container,

    /// Field mappings for each chapter.
    required List<FieldMapping> items,

    /// Whether chapters are in reverse order (newest first).
    @Default(false) bool reverseOrder,
  }) = _ChapterExtract;

  factory ChapterExtract.fromJson(Map<String, dynamic> json) =>
      _$ChapterExtractFromJson(json);
}

/// Content extraction configuration (video, comic, novel content).
@freezed
sealed class ContentExtract with _$ContentExtract {
  const factory ContentExtract({
    /// Video extraction config.
    VideoExtract? video,

    /// Comic extraction config.
    ComicExtract? comic,

    /// Novel extraction config.
    NovelExtract? novel,

    /// Music extraction config.
    MusicExtract? music,
  }) = _ContentExtract;

  factory ContentExtract.fromJson(Map<String, dynamic> json) =>
      _$ContentExtractFromJson(json);
}

/// Video content extraction.
@freezed
sealed class VideoExtract with _$VideoExtract {
  const factory VideoExtract({
    /// Selector for video URL.
    Selector? playUrl,

    /// Selector for quality options.
    Selector? qualities,

    /// JavaScript to extract video info.
    String? jsExtract,
  }) = _VideoExtract;

  factory VideoExtract.fromJson(Map<String, dynamic> json) =>
      _$VideoExtractFromJson(json);
}

/// Comic content extraction.
@freezed
sealed class ComicExtract with _$ComicExtract {
  const factory ComicExtract({
    /// Selector for image URLs.
    required Selector images,

    /// JavaScript to extract images.
    String? jsExtract,
  }) = _ComicExtract;

  factory ComicExtract.fromJson(Map<String, dynamic> json) =>
      _$ComicExtractFromJson(json);
}

/// Novel content extraction.
@freezed
sealed class NovelExtract with _$NovelExtract {
  const factory NovelExtract({
    /// Selector for chapter content.
    required Selector content,

    /// JavaScript to extract content.
    String? jsExtract,
  }) = _NovelExtract;

  factory NovelExtract.fromJson(Map<String, dynamic> json) =>
      _$NovelExtractFromJson(json);
}

/// Music content extraction.
@freezed
sealed class MusicExtract with _$MusicExtract {
  const factory MusicExtract({
    /// Selector for audio URL.
    Selector? audioUrl,

    /// Selector for lyrics.
    Selector? lyrics,

    /// JavaScript to extract audio info.
    String? jsExtract,
  }) = _MusicExtract;

  factory MusicExtract.fromJson(Map<String, dynamic> json) =>
      _$MusicExtractFromJson(json);
}

/// Complete extraction configuration.
@freezed
sealed class ExtractConfig with _$ExtractConfig {
  const factory ExtractConfig({
    /// List page extraction.
    ListExtract? list,

    /// Detail page extraction.
    DetailExtract? detail,

    /// Content extraction.
    ContentExtract? content,
  }) = _ExtractConfig;

  factory ExtractConfig.fromJson(Map<String, dynamic> json) =>
      _$ExtractConfigFromJson(json);
}
