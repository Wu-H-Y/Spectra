import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_source.freezed.dart';
part 'content_source.g.dart';

/// 爬取内容的来源信息。
///
/// 跟踪内容提取自何处，用于归属
/// 和未来更新。
@freezed
sealed class ContentSource with _$ContentSource {
  /// 创建 [ContentSource] 实例。
  const factory ContentSource({
    /// 提取此内容的爬虫规则 ID。
    required String ruleId,

    /// 来源站点显示名称。
    required String siteName,

    /// 来源站点上的原始 URL。
    required String originalUrl,

    /// 内容被爬取的时间戳。
    required DateTime crawledAt,

    /// 来源站点图标/favicon URL。
    String? siteIcon,
  }) = _ContentSource;

  /// 从 JSON 创建 [ContentSource]。
  factory ContentSource.fromJson(Map<String, dynamic> json) =>
      _$ContentSourceFromJson(json);
}
