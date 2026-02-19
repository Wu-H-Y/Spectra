import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/media/models/author.dart';
import 'package:spectra/core/media/models/content_source.dart';
import 'package:spectra/core/media/models/content_stats.dart';

part 'music_content.freezed.dart';
part 'music_content.g.dart';

/// Audio quality option.
@freezed
sealed class AudioQuality with _$AudioQuality {
  const factory AudioQuality({
    /// Quality label (e.g., "320kbps", "128kbps", "FLAC").
    required String label,

    /// Audio stream URL.
    required String url,

    /// Audio codec (e.g., "mp3", "aac", "flac").
    String? codec,

    /// Bitrate in kbps.
    int? bitrate,

    /// Sample rate in Hz.
    int? sampleRate,

    /// File size in bytes.
    int? fileSize,
  }) = _AudioQuality;

  factory AudioQuality.fromJson(Map<String, dynamic> json) =>
      _$AudioQualityFromJson(json);
}

/// Lyrics with optional LRC format support.
@freezed
sealed class Lyrics with _$Lyrics {
  const factory Lyrics({
    /// Plain text lyrics.
    String? text,

    /// LRC format lyrics with timestamps.
    String? lrc,

    /// Language code.
    String? language,
  }) = _Lyrics;

  factory Lyrics.fromJson(Map<String, dynamic> json) => _$LyricsFromJson(json);
}

/// Music/audio track content model.
@freezed
sealed class MusicContent with _$MusicContent {
  const factory MusicContent({
    /// Unique identifier.
    required String id,

    /// Track title.
    required String title,

    /// Source information.
    required ContentSource source, /// Cover/album art URL.
    String? cover,

    /// Description.
    String? description,

    /// Artist information.
    Author? artistInfo,

    /// Tags.
    List<String>? tags,

    /// Genre/category.
    String? category,

    /// Statistics.
    ContentStats? stats,

    /// Release date.
    DateTime? createdAt,

    /// Update date.
    DateTime? updatedAt,

    /// Primary audio playback URL.
    String? audioUrl,

    /// Duration in seconds.
    int? duration,

    /// Artist name(s) - can be comma-separated or array.
    String? artist,

    /// Album name.
    String? album,

    /// Album cover URL (if different from cover).
    String? albumCover,

    /// Available quality options.
    List<AudioQuality>? qualities,

    /// Lyrics.
    Lyrics? lyrics,

    /// Music video URL.
    String? mvUrl,

    /// Copyright information.
    String? copyright,
  }) = _MusicContent;

  factory MusicContent.fromJson(Map<String, dynamic> json) =>
      _$MusicContentFromJson(json);
}
