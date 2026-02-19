import 'package:freezed_annotation/freezed_annotation.dart';

/// Media content type for crawler rules.
@JsonEnum()
enum MediaType {
  /// Video content (movies, series, clips).
  video,

  /// Music/audio tracks.
  music,

  /// Novel/fiction text content.
  novel,

  /// Comic/manga content.
  comic,

  /// Images and albums.
  image,

  /// Audio content (podcasts, audiobooks).
  audio,

  /// RSS/Atom feeds.
  rss,

  /// Generic content (any type).
  generic,
}
