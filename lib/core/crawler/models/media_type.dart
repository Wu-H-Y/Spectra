import 'package:freezed_annotation/freezed_annotation.dart';

/// 爬虫规则的媒体内容类型。
@JsonEnum()
enum MediaType {
  /// 视频内容（电影、剧集、短片）。
  video,

  /// 音乐/音轨。
  music,

  /// 小说/虚构文本内容。
  novel,

  /// 漫画/日漫内容。
  comic,

  /// 图片和相册。
  image,

  /// 音频内容（播客、有声书）。
  audio,

  /// RSS/Atom 订阅源。
  rss,

  /// 通用内容（任何类型）。
  generic,
}
