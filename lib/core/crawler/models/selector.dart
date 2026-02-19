import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/selector_type.dart';

part 'selector.freezed.dart';
part 'selector.g.dart';

/// Selector for extracting content from HTML/JSON.
///
/// Supports multiple selector types with fallback options.
@freezed
sealed class Selector with _$Selector {
  const factory Selector({
    /// Selector type (css, xpath, regex, jsonpath, js).
    required SelectorType type,

    /// Selector expression.
    required String expression,

    /// Attribute to extract (e.g., "href", "src", "text").
    /// Use "text" or leave empty for text content.
    /// Use "html" for inner HTML.
    String? attribute,

    /// Fallback selectors if primary fails.
    List<Selector>? fallbacks,

    /// Whether to return first match only.
    @Default(false) bool firstOnly,
  }) = _Selector;

  factory Selector.fromJson(Map<String, dynamic> json) =>
      _$SelectorFromJson(json);
}

/// CSS selector shorthand.
const SelectorType css = SelectorType.css;

/// XPath selector shorthand.
const SelectorType xpath = SelectorType.xpath;

/// Regex selector shorthand.
const SelectorType regex = SelectorType.regex;

/// JSONPath selector shorthand.
const SelectorType jsonpath = SelectorType.jsonpath;

/// JavaScript selector shorthand.
const SelectorType js = SelectorType.js;
