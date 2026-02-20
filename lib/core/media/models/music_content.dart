import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/media/models/author.dart';
import 'package:spectra/core/media/models/content_source.dart';
import 'package:spectra/core/media/models/content_stats.dart';

part 'music_content.freezed.dart';
part 'music_content.g.dart';

/// 音频质量选项。
@freezed
sealed class AudioQuality with _$AudioQuality {
  const factory AudioQuality({
    /// 质量标签（如 "320kbps"、"128kbps"、"FLAC"）。
    required String label,

    /// 音频流 URL。
    required String url,

    /// 音频编码（如 "mp3"、"aac"、"flac"）。
    String? codec,

    /// 码率（kbps）。
    int? bitrate,

    /// 采样率（Hz）。
    int? sampleRate,

    /// 文件大小（字节）。
    int? fileSize,
  }) = _AudioQuality;

  factory AudioQuality.fromJson(Map<String, dynamic> json) =>
      _$AudioQualityFromJson(json);
}

/// 歌词，支持可选 LRC 格式。
@freezed
sealed class Lyrics with _$Lyrics {
  const factory Lyrics({
    /// 纯文本歌词。
    String? text,

    /// 带时间戳的 LRC 格式歌词。
    String? lrc,

    /// 语言代码。
    String? language,
  }) = _Lyrics;

  factory Lyrics.fromJson(Map<String, dynamic> json) => _$LyricsFromJson(json);
}

/// 音乐/音轨内容模型。
@freezed
sealed class MusicContent with _$MusicContent {
  const factory MusicContent({
    /// 唯一标识符。
    required String id,

    /// 曲目标题。
    required String title,

    /// 来源信息。
    required ContentSource source,

    /// 封面/专辑封面 URL。
    String? cover,

    /// 描述。
    String? description,

    /// 艺术家信息。
    Author? artistInfo,

    /// 标签。
    List<String>? tags,

    /// 流派/分类。
    String? category,

    /// 统计信息。
    ContentStats? stats,

    /// 发布日期。
    DateTime? createdAt,

    /// 更新日期。
    DateTime? updatedAt,

    /// 主要音频播放 URL。
    String? audioUrl,

    /// 时长（秒）。
    int? duration,

    /// 艺术家名称（可能是逗号分隔或数组）。
    String? artist,

    /// 专辑名称。
    String? album,

    /// 专辑封面 URL（如果与 cover 不同）。
    String? albumCover,

    /// 可用的质量选项。
    List<AudioQuality>? qualities,

    /// 歌词。
    Lyrics? lyrics,

    /// 音乐视频 URL。
    String? mvUrl,

    /// 版权信息。
    String? copyright,
  }) = _MusicContent;

  factory MusicContent.fromJson(Map<String, dynamic> json) =>
      _$MusicContentFromJson(json);
}
