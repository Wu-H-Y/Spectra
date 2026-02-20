import 'package:freezed_annotation/freezed_annotation.dart';

/// 内容提取的选择器类型。
@JsonEnum()
enum SelectorType {
  /// CSS 选择器（例如 ".video-title", "#content"）。
  css,

  /// XPath 表达式（例如 "//div[@class='title']"）。
  xpath,

  /// 正则表达式模式。
  regex,

  /// JSONPath 表达式（例如 `$.data.items[*]`）。
  jsonpath,

  /// JavaScript 表达式（例如 "__playinfo__.dash.video[0].url"）。
  js,
}
