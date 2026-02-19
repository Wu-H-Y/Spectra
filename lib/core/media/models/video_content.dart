import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/media/models/author.dart';
import 'package:spectra/core/media/models/content_source.dart';
import 'package:spectra/core/media/models/content_stats.dart';

part 'video_content.freezed.dart';
part 'video_content.g.dart';

/// Video quality option.
@freezed
sealed class VideoQuality with _$VideoQuality {
  const factory VideoQuality({
    /// Quality label (e.g., "1080p", "720p", "480p").
    required String label,

    /// Video stream URL.
    required String url,

    /// Video codec (e.g., "h264", "h265", "vp9").
    String? codec,

    /// Bitrate in kbps.
    int? bitrate,

    /// Resolution width.
    int? width,

    /// Resolution height.
    int? height,

    /// File size in bytes.
    int? fileSize,
  }) = _VideoQuality;

  factory VideoQuality.fromJson(Map<String, dynamic> json) =>
      _$VideoQualityFromJson(json);
}

/// Video chapter/episode.
@freezed
sealed class VideoChapter with _$VideoChapter {
  const factory VideoChapter({
    /// Chapter ID.
    required String id,

    /// Chapter title.
    required String title,

    /// Chapter index/number.
    required int index, /// Chapter URL (if separate page).
    String? url,

    /// Duration in seconds.
    int? duration,
  }) = _VideoChapter;

  factory VideoChapter.fromJson(Map<String, dynamic> json) =>
      _$VideoChapterFromJson(json);
}

/// Subtitle track.
@freezed
sealed class Subtitle with _$Subtitle {
  const factory Subtitle({
    /// Language code (e.g., "en", "zh", "ja").
    required String language,

    /// Subtitle URL (VTT, SRT, ASS format).
    required String url, /// Language display name.
    String? label,

    /// Whether this is the default subtitle.
    @Default(false) bool isDefault,
  }) = _Subtitle;

  factory Subtitle.fromJson(Map<String, dynamic> json) =>
      _$SubtitleFromJson(json);
}

/// Danmaku (bullet comment) configuration.
@freezed
sealed class DanmakuConfig with _$DanmakuConfig {
  const factory DanmakuConfig({
    /// Danmaku data URL (XML or JSON format).
    String? url,

    /// Raw danmaku data (if embedded).
    String? rawData,

    /// Whether danmaku is enabled.
    @Default(true) bool enabled,
  }) = _DanmakuConfig;

  factory DanmakuConfig.fromJson(Map<String, dynamic> json) =>
      _$DanmakuConfigFromJson(json);
}

/// Video content status.
enum VideoStatus {
  /// Currently airing/ongoing.
  ongoing,

  /// Completed series.
  completed,

  /// Not yet released.
  upcoming,
}

/// Video content model for movies, series, clips, etc.
@freezed
sealed class VideoContent with _$VideoContent {
  const factory VideoContent({
    /// Unique identifier.
    required String id,

    /// Video title.
    required String title,

    /// Source information.
    required ContentSource source, /// Cover image URL.
    String? cover,

    /// Description/summary.
    String? description,

    /// Author/uploader information.
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

    /// Video duration in seconds.
    int? duration,

    /// Primary playback URL.
    String? playUrl,

    /// Available quality options.
    List<VideoQuality>? qualities,

    /// Episode/chapter list.
    List<VideoChapter>? chapters,

    /// Preview/GIF URL.
    String? previewUrl,

    /// Subtitle tracks.
    List<Subtitle>? subtitles,

    /// Danmaku configuration.
    DanmakuConfig? danmaku,

    /// Video status.
    VideoStatus? status,

    /// Whether VIP subscription is required.
    @Default(false) bool isVip,

    /// Whether payment is required.
    @Default(false) bool isPaid,
  }) = _VideoContent;

  factory VideoContent.fromJson(Map<String, dynamic> json) =>
      _$VideoContentFromJson(json);
}
