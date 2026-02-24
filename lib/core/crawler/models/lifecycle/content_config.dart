import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/pipeline_node.dart';

part 'content_config.freezed.dart';
part 'content_config.g.dart';

/// 内容提取策略。
enum ContentStrategy {
  /// 解析页面内容。
  parse,

  /// 嗅探媒体 URL。
  sniff,
}

/// 媒体类型。
enum MediaContentType {
  /// 视频内容。
  video,

  /// 漫画/图片内容。
  comic,

  /// 小说/文本内容。
  novel,

  /// 音乐/音频内容。
  music,
}

/// 媒体嗅探配置。
@freezed
sealed class SniffConfig with _$SniffConfig {
  const factory SniffConfig({
    /// 匹配正则列表。
    required List<String> matchRegex,

    /// 排除正则列表。
    List<String>? excludeRegex,

    /// 嗅探超时时间 (毫秒)。
    @Default(15000) int timeout,

    /// 后处理 JavaScript 脚本。
    String? script,
  }) = _SniffConfig;

  factory SniffConfig.fromJson(Map<String, dynamic> json) =>
      _$SniffConfigFromJson(json);
}

/// 内容提取配置。
///
/// 用于提取正文/播放内容。
@freezed
sealed class ContentConfig with _$ContentConfig {
  const factory ContentConfig({
    /// 媒体内容类型。
    required MediaContentType type,

    /// 内容页 URL 模板 (支持 {{id}}, {{chapterId}} 变量)。
    String? url,

    /// 提取策略。
    @Default(ContentStrategy.parse) ContentStrategy strategy,

    /// 解析字段提取 Pipeline (strategy = parse)。
    Map<String, Pipeline>? fields,

    /// 嗅探配置 (strategy = sniff)。
    SniffConfig? sniff,
  }) = _ContentConfig;

  factory ContentConfig.fromJson(Map<String, dynamic> json) =>
      _$ContentConfigFromJson(json);
}
