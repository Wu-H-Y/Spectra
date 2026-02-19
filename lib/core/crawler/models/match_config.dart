import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_config.freezed.dart';
part 'match_config.g.dart';

/// URL matching configuration.
@freezed
sealed class MatchConfig with _$MatchConfig {
  const factory MatchConfig({
    /// URL pattern (regex or glob pattern).
    required String pattern,

    /// Pattern type (regex or glob).
    @Default(MatchPatternType.regex) MatchPatternType type,

    /// Whether to match full URL or just path.
    @Default(true) bool fullUrl,

    /// List of additional URL patterns to match.
    List<String>? includePatterns,

    /// List of URL patterns to exclude.
    List<String>? excludePatterns,
  }) = _MatchConfig;

  factory MatchConfig.fromJson(Map<String, dynamic> json) =>
      _$MatchConfigFromJson(json);
}

/// Pattern type for URL matching.
@JsonEnum()
enum MatchPatternType {
  /// Regular expression pattern.
  regex,

  /// Glob pattern (e.g., "*.example.com/*").
  glob,
}
