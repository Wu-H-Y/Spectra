import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_config.freezed.dart';
part 'match_config.g.dart';

/// URL 匹配配置。
@freezed
sealed class MatchConfig with _$MatchConfig {
  const factory MatchConfig({
    /// URL 模式（正则或 glob 模式）。
    required String pattern,

    /// 模式类型（正则或 glob）。
    @Default(MatchPatternType.regex) MatchPatternType type,

    /// 是否匹配完整 URL 还是只匹配路径。
    @Default(true) bool fullUrl,

    /// 要匹配的额外 URL 模式列表。
    List<String>? includePatterns,

    /// 要排除的 URL 模式列表。
    List<String>? excludePatterns,
  }) = _MatchConfig;

  factory MatchConfig.fromJson(Map<String, dynamic> json) =>
      _$MatchConfigFromJson(json);
}

/// URL 匹配的模式类型。
@JsonEnum()
enum MatchPatternType {
  /// 正则表达式模式。
  regex,

  /// Glob 模式（例如 "*.example.com/*"）。
  glob,
}
