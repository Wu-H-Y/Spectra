import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_source.freezed.dart';
part 'content_source.g.dart';

/// Source information for crawled content.
///
/// Tracks where content was extracted from for attribution
/// and future updates.
@freezed
sealed class ContentSource with _$ContentSource {
  /// Creates a [ContentSource] instance.
  const factory ContentSource({
    /// Crawler rule ID that extracted this content.
    required String ruleId,

    /// Source site display name.
    required String siteName,

    /// Original URL on the source site.
    required String originalUrl, /// Timestamp when content was crawled.
    required DateTime crawledAt, /// Source site icon/favicon URL.
    String? siteIcon,
  }) = _ContentSource;

  /// Creates [ContentSource] from JSON.
  factory ContentSource.fromJson(Map<String, dynamic> json) =>
      _$ContentSourceFromJson(json);
}
