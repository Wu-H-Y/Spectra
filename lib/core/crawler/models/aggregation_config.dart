import 'package:freezed_annotation/freezed_annotation.dart';

part 'aggregation_config.freezed.dart';
part 'aggregation_config.g.dart';

/// 匹配策略。
enum MatchingStrategy {
  /// 精确匹配。
  exact,

  /// 模糊匹配 (Jaccard/Levenshtein)。
  fuzzy,

  /// 自定义 JS 表达式。
  custom,
}

/// 字段匹配类型。
enum MatchType {
  /// 精确匹配。
  exact,

  /// 模糊匹配。
  fuzzy,

  /// 标准化后精确匹配。
  normalized,
}

/// 多源聚合配置。
///
/// 用于配置跨源搜索结果的合并、去重和优选。
@freezed
sealed class AggregationConfig with _$AggregationConfig {
  const factory AggregationConfig({
    /// 匹配配置。
    required MatchingConfig matching,

    /// 是否启用聚合。
    @Default(true) bool enabled,

    /// 源权重 (0-100，用于自动优选)。
    @Default(50) int weight,
  }) = _AggregationConfig;

  factory AggregationConfig.fromJson(Map<String, dynamic> json) =>
      _$AggregationConfigFromJson(json);
}

/// 匹配配置。
@freezed
sealed class MatchingConfig with _$MatchingConfig {
  const factory MatchingConfig({
    /// 匹配策略。
    @Default(MatchingStrategy.fuzzy) MatchingStrategy strategy,

    /// 匹配维度列表。
    @Default(_defaultDimensions) List<MatchingDimension> dimensions,

    /// 综合阈值 (0.0-1.0)。
    @Default(0.85) double combinedThreshold,
  }) = _MatchingConfig;

  factory MatchingConfig.fromJson(Map<String, dynamic> json) =>
      _$MatchingConfigFromJson(json);
}

/// 默认匹配维度。
const _defaultDimensions = [
  MatchingDimension(
    field: 'title',
  ),
  MatchingDimension(
    field: 'author',
    weight: 0.8,
    threshold: 0.90,
  ),
];

/// 匹配维度。
@freezed
sealed class MatchingDimension with _$MatchingDimension {
  const factory MatchingDimension({
    /// 字段名。
    required String field,

    /// 匹配类型。
    @Default(MatchType.fuzzy) MatchType matchType,

    /// 权重 (0-1)。
    @Default(1.0) double weight,

    /// 相似度阈值 (fuzzy 类型)。
    @Default(0.96) double threshold,

    /// 标准化配置。
    NormalizationConfig? normalize,
  }) = _MatchingDimension;

  factory MatchingDimension.fromJson(Map<String, dynamic> json) =>
      _$MatchingDimensionFromJson(json);
}

/// 标准化配置。
@freezed
sealed class NormalizationConfig with _$NormalizationConfig {
  const factory NormalizationConfig({
    /// 转小写。
    @Default(true) bool lowercase,

    /// 去除标点。
    @Default(true) bool trimPunctuation,

    /// 去除空白。
    @Default(true) bool trimWhitespace,

    /// 繁体转简体。
    @Default(true) bool traditionalToSimplified,

    /// 全角转半角。
    @Default(true) bool fullWidthToHalfWidth,

    /// 去除元数据模式 (如 "(2024)", "【推荐】")。
    @Default(true) bool removeMetadata,

    /// 自定义替换规则。
    List<ReplacementRule>? replacements,
  }) = _NormalizationConfig;

  factory NormalizationConfig.fromJson(Map<String, dynamic> json) =>
      _$NormalizationConfigFromJson(json);
}

/// 替换规则。
@freezed
sealed class ReplacementRule with _$ReplacementRule {
  const factory ReplacementRule({
    /// 正则模式。
    required String pattern,

    /// 替换字符串。
    @Default('') String replacement,
  }) = _ReplacementRule;

  factory ReplacementRule.fromJson(Map<String, dynamic> json) =>
      _$ReplacementRuleFromJson(json);
}
