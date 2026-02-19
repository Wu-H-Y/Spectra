import 'package:freezed_annotation/freezed_annotation.dart';

/// Selector type for content extraction.
@JsonEnum()
enum SelectorType {
  /// CSS selector (e.g., ".video-title", "#content").
  css,

  /// XPath expression (e.g., "//div[@class='title']").
  xpath,

  /// Regular expression pattern.
  regex,

  /// JSONPath expression (e.g., `$.data.items[*]`).
  jsonpath,

  /// JavaScript expression (e.g., "__playinfo__.dash.video[0].url").
  js,
}
