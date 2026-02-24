import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/media_type.dart';
import 'package:spectra/core/crawler/models/v2/aggregation_config.dart';
import 'package:spectra/core/crawler/models/v2/lifecycle/content_config.dart';
import 'package:spectra/core/crawler/models/v2/lifecycle/detail_config.dart';
import 'package:spectra/core/crawler/models/v2/lifecycle/explore_config.dart';
import 'package:spectra/core/crawler/models/v2/lifecycle/search_config.dart';
import 'package:spectra/core/crawler/models/v2/lifecycle/toc_config.dart';
import 'package:spectra/core/crawler/models/v2/network_config.dart';

part 'crawler_rule.freezed.dart';
part 'crawler_rule.g.dart';

/// 完整的爬虫规则定义 (v2 Pipeline 版本)。
///
/// 采用节点流 Pipeline 模型，支持五阶段生命周期:
/// Explore → Search → Detail → TOC → Content
@freezed
sealed class CrawlerRule with _$CrawlerRule {
  const factory CrawlerRule({
    /// 规则唯一标识符。
    required String id,

    /// 规则名称。
    required String name,

    /// 此规则提取的媒体类型。
    required MediaType mediaType,

    /// 规则描述。
    String? description,

    /// 规则版本（语义化版本）。
    @Default('2.0.0') String version,

    /// 规则作者。
    String? author,

    /// 规则来源（official、third_party、user）。
    @Default('user') String source,

    /// 规则图标 URL。
    String? iconUrl,

    /// 规则标签。
    List<String>? tags,

    /// 规则是否启用。
    @Default(true) bool enabled,

    /// 基础 URL（用于 {{host}} 变量）。
    String? baseUrl,

    /// 网络配置。
    @Default(NetworkConfig()) NetworkConfig network,

    /// 聚合配置。
    AggregationConfig? aggregation,

    /// 发现页/分类浏览配置。
    ExploreConfig? explore,

    /// 搜索配置。
    SearchConfig? search,

    /// 详情页配置。
    DetailConfig? detail,

    /// 目录/章节配置。
    TocConfig? toc,

    /// 正文/播放配置。
    ContentConfig? content,

    /// 创建时间戳。
    DateTime? createdAt,

    /// 最后更新时间戳。
    DateTime? updatedAt,
  }) = _CrawlerRule;

  factory CrawlerRule.fromJson(Map<String, dynamic> json) =>
      _$CrawlerRuleFromJson(json);
}
