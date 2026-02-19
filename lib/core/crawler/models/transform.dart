import 'package:freezed_annotation/freezed_annotation.dart';

part 'transform.freezed.dart';
part 'transform.g.dart';

/// Transform type for data transformation.
@JsonEnum()
enum TransformType {
  /// Remove leading/trailing whitespace.
  trim,

  /// Parse as number.
  number,

  /// Parse as date/datetime.
  date,

  /// Normalize URL (resolve relative URLs).
  url,

  /// Regex replacement.
  regex,

  /// String replacement.
  replace,

  /// Convert to lowercase.
  lowercase,

  /// Convert to uppercase.
  uppercase,

  /// Extract substring (start, end indices).
  substring,

  /// Split string by delimiter.
  split,

  /// Join array with delimiter.
  join,

  /// Map values (find/replace dictionary).
  map,

  /// Parse JSON string.
  parseJson,

  /// Format number with suffix (1K, 1M, etc.).
  formatNumber,
}

/// Data transformation configuration.
@freezed
sealed class Transform with _$Transform {
  const factory Transform({
    /// Transform type.
    required TransformType type,

    /// Parameter for the transform (varies by type).
    /// - regex: pattern (with optional replacement)
    /// - replace: {find: string, replace: string}
    /// - date: format string (e.g., "yyyy-MM-dd")
    /// - url: base URL for resolving relative URLs
    /// - substring: {start: int, end: int?}
    /// - split: delimiter
    /// - join: delimiter
    /// - map: {key1: value1, key2: value2}
    dynamic params,
  }) = _Transform;

  factory Transform.fromJson(Map<String, dynamic> json) =>
      _$TransformFromJson(json);
}
