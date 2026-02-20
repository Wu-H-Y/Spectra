import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/selector_type.dart';

part 'selector.freezed.dart';
part 'selector.g.dart';

/// 从 HTML/JSON 提取内容的选择器。
///
/// 支持多种选择器类型，并提供回退选项。
@freezed
sealed class Selector with _$Selector {
  const factory Selector({
    /// 选择器类型（css、xpath、regex、jsonpath、js）。
    required SelectorType type,

    /// 选择器表达式。
    required String expression,

    /// 要提取的属性（例如 "href"、"src"、"text"）。
    /// 使用 "text" 或留空表示文本内容。
    /// 使用 "html" 表示内部 HTML。
    String? attribute,

    /// 主选择器失败时的回退选择器。
    List<Selector>? fallbacks,

    /// 是否只返回第一个匹配。
    @Default(false) bool firstOnly,
  }) = _Selector;

  factory Selector.fromJson(Map<String, dynamic> json) =>
      _$SelectorFromJson(json);
}

/// CSS 选择器简写。
const SelectorType css = SelectorType.css;

/// XPath 选择器简写。
const SelectorType xpath = SelectorType.xpath;

/// 正则选择器简写。
const SelectorType regex = SelectorType.regex;

/// JSONPath 选择器简写。
const SelectorType jsonpath = SelectorType.jsonpath;

/// JavaScript 选择器简写。
const SelectorType js = SelectorType.js;
