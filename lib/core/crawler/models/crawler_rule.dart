import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/action.dart';
import 'package:spectra/core/crawler/models/detection_config.dart';
import 'package:spectra/core/crawler/models/extract_config.dart';
import 'package:spectra/core/crawler/models/match_config.dart';
import 'package:spectra/core/crawler/models/media_type.dart';
import 'package:spectra/core/crawler/models/request_config.dart';

part 'crawler_rule.freezed.dart';
part 'crawler_rule.g.dart';

/// Complete crawler rule definition.
@freezed
sealed class CrawlerRule with _$CrawlerRule {
  const factory CrawlerRule({
    /// Rule unique identifier.
    required String id,

    /// Rule name.
    required String name,

    /// Media type this rule extracts.
    required MediaType mediaType, /// URL matching configuration.
    required MatchConfig match, /// Extraction configuration.
    required ExtractConfig extract, /// Rule description.
    String? description,

    /// Rule version (semantic versioning).
    @Default('1.0.0') String version,

    /// HTTP request configuration.
    @Default(RequestConfig()) RequestConfig request,

    /// Actions to execute before extraction.
    List<CrawlerAction>? beforeActions,

    /// Actions to execute after extraction.
    List<CrawlerAction>? afterActions,

    /// Anti-crawl detection configuration.
    DetectionConfig? detection,

    /// Rule author.
    String? author,

    /// Rule source (official, third_party, user).
    @Default('user') String source,

    /// Rule icon URL.
    String? iconUrl,

    /// Rule tags.
    List<String>? tags,

    /// Whether rule is enabled.
    @Default(true) bool enabled,

    /// Creation timestamp.
    DateTime? createdAt,

    /// Last update timestamp.
    DateTime? updatedAt,
  }) = _CrawlerRule;

  factory CrawlerRule.fromJson(Map<String, dynamic> json) =>
      _$CrawlerRuleFromJson(json);
}
