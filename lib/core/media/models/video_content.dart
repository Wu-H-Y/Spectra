import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/media/models/author.dart';
import 'package:spectra/core/media/models/content_source.dart';
import 'package:spectra/core/media/models/content_stats.dart';

part 'video_content.freezed.dart';
part 'video_content.g.dart';

/// 视频画质选项。
@freezed
sealed class VideoQuality with _$VideoQuality {
  const factory VideoQuality({
    /// 画质标签（如 "1080p"、"720p"、"480p"）。
    required String label,

    /// 视频流 URL。
    required String url,

    /// 视频编码（如 "h264"、"h265"、"vp9"）。
    String? codec,

    /// 码率（kbps）。
    int? bitrate,

    /// 分辨率宽度。
    int? width,

    /// 分辨率高度。
    int? height,

    /// 文件大小（字节）。
    int? fileSize,
  }) = _VideoQuality;

  factory VideoQuality.fromJson(Map<String, dynamic> json) =>
      _$VideoQualityFromJson(json);
}

/// 视频章节/剧集。
@freezed
sealed class VideoChapter with _$VideoChapter {
  const factory VideoChapter({
    /// 章节 ID。
    required String id,

    /// 章节标题。
    required String title,

    /// 章节索引/编号。
    required int index,

    /// 章节 URL（如果为单独页面）。
    String? url,

    /// 时长（秒）。
    int? duration,
  }) = _VideoChapter;

  factory VideoChapter.fromJson(Map<String, dynamic> json) =>
      _$VideoChapterFromJson(json);
}

/// 字幕轨道。
@freezed
sealed class Subtitle with _$Subtitle {
  const factory Subtitle({
    /// 语言代码（如 "en"、"zh"、"ja"）。
    required String language,

    /// 字幕 URL（VTT、SRT、ASS 格式）。
    required String url,

    /// 语言显示名称。
    String? label,

    /// 是否为默认字幕。
    @Default(false) bool isDefault,
  }) = _Subtitle;

  factory Subtitle.fromJson(Map<String, dynamic> json) =>
      _$SubtitleFromJson(json);
}

/// 弹幕配置。
@freezed
sealed class DanmakuConfig with _$DanmakuConfig {
  const factory DanmakuConfig({
    /// 弹幕数据 URL（XML 或 JSON 格式）。
    String? url,

    /// 原始弹幕数据（如果嵌入）。
    String? rawData,

    /// 是否启用弹幕。
    @Default(true) bool enabled,
  }) = _DanmakuConfig;

  factory DanmakuConfig.fromJson(Map<String, dynamic> json) =>
      _$DanmakuConfigFromJson(json);
}

/// 视频内容状态。
enum VideoStatus {
  /// 正在连载/更新中。
  ongoing,

  /// 已完结。
  completed,

  /// 尚未发布。
  upcoming,
}

/// 电影、剧集、短片等视频内容模型。
@freezed
sealed class VideoContent with _$VideoContent {
  const factory VideoContent({
    /// 唯一标识符。
    required String id,

    /// 视频标题。
    required String title,

    /// 来源信息。
    required ContentSource source,

    /// 封面图片 URL。
    String? cover,

    /// 描述/摘要。
    String? description,

    /// 作者/上传者信息。
    Author? author,

    /// 标签。
    List<String>? tags,

    /// 分类。
    String? category,

    /// 统计信息。
    ContentStats? stats,

    /// 发布日期。
    DateTime? createdAt,

    /// 更新日期。
    DateTime? updatedAt,

    /// 视频时长（秒）。
    int? duration,

    /// 主要播放 URL。
    String? playUrl,

    /// 可用的画质选项。
    List<VideoQuality>? qualities,

    /// 剧集/章节列表。
    List<VideoChapter>? chapters,

    /// 预览/GIF URL。
    String? previewUrl,

    /// 字幕轨道。
    List<Subtitle>? subtitles,

    /// 弹幕配置。
    DanmakuConfig? danmaku,

    /// 视频状态。
    VideoStatus? status,

    /// 是否需要 VIP 订阅。
    @Default(false) bool isVip,

    /// 是否需要付费。
    @Default(false) bool isPaid,
  }) = _VideoContent;

  factory VideoContent.fromJson(Map<String, dynamic> json) =>
      _$VideoContentFromJson(json);
}
