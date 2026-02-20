import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/action.dart';
import 'package:spectra/core/crawler/models/detection_config.dart';
import 'package:spectra/core/crawler/models/extract_config.dart';
import 'package:spectra/core/crawler/models/match_config.dart';
import 'package:spectra/core/crawler/models/media_type.dart';
import 'package:spectra/core/crawler/models/request_config.dart';

part 'crawler_rule.freezed.dart';
part 'crawler_rule.g.dart';

/// 完整的爬虫规则定义。
@freezed
sealed class CrawlerRule with _$CrawlerRule {
  const factory CrawlerRule({
    /// 规则唯一标识符。
    required String id,

    /// 规则名称。
    required String name,

    /// 此规则提取的媒体类型。
    required MediaType mediaType,

    /// URL 匹配配置。
    required MatchConfig match,

    /// 提取配置。
    required ExtractConfig extract,

    /// 规则描述。
    String? description,

    /// 规则版本（语义化版本）。
    @Default('1.0.0') String version,

    /// HTTP 请求配置。
    @Default(RequestConfig()) RequestConfig request,

    /// 提取前要执行的动作。
    List<CrawlerAction>? beforeActions,

    /// 提取后要执行的动作。
    List<CrawlerAction>? afterActions,

    /// 反爬虫检测配置。
    DetectionConfig? detection,

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

    /// 创建时间戳。
    DateTime? createdAt,

    /// 最后更新时间戳。
    DateTime? updatedAt,
  }) = _CrawlerRule;

  factory CrawlerRule.fromJson(Map<String, dynamic> json) =>
      _$CrawlerRuleFromJson(json);
}
