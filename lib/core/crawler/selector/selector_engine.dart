import 'package:html/dom.dart' as dom;

import 'package:spectra/core/crawler/models/selector.dart';
import 'package:spectra/core/crawler/models/selector_type.dart';
import 'package:spectra/core/crawler/selector/css_selector.dart';
import 'package:spectra/core/crawler/selector/js_selector.dart';
import 'package:spectra/core/crawler/selector/jsonpath_selector.dart';
import 'package:spectra/core/crawler/selector/regex_selector.dart';
import 'package:spectra/core/crawler/selector/xpath_selector.dart';

/// 选择器求值结果。
class SelectorEngineResult {
  /// 创建选择器引擎结果。
  const SelectorEngineResult({
    required this.values,
    required this.usedSelector,
    required this.success,
    this.error,
  });

  /// 提取的值。
  final List<String> values;

  /// 使用的选择器（如果使用了回退，可能与输入不同）。
  final Selector usedSelector;

  /// 提取是否成功。
  final bool success;

  /// 如果提取失败时的错误信息。
  final String? error;

  /// 返回第一个提取的值，如果没有则返回 null。
  String? get first => values.firstOrNull;

  /// 如果提取了任何值则返回 true。
  bool get hasValues => values.isNotEmpty;
}

/// 选择器求值失败时抛出的异常。
class SelectorException implements Exception {
  /// 创建选择器异常。
  const SelectorException(this.message, {this.selector, this.cause});

  /// 错误信息。
  final String message;

  /// 导致错误的选择器。
  final Selector? selector;

  /// 底层原因。
  final Object? cause;

  @override
  String toString() {
    final buffer = StringBuffer('SelectorException: $message');
    if (selector != null) {
      buffer.write(' (selector: ${selector?.type}/${selector?.expression})');
    }
    if (cause != null) {
      buffer.write(' - caused by: $cause');
    }
    return buffer.toString();
  }
}

/// 支持多种选择器类型和回退的选择器引擎。
///
/// 这是求值选择器的主要入口点。它支持：
/// - CSS 选择器
/// - XPath 表达式
/// - 正则表达式
/// - JSONPath 表达式
/// - JavaScript 表达式
/// - 自动回退到备选选择器
class SelectorEngine {
  /// 创建选择器引擎。
  SelectorEngine({
    CssSelectorEvaluator? cssEvaluator,
    XPathSelectorEvaluator? xpathEvaluator,
    RegexSelectorEvaluator? regexEvaluator,
    JsonPathSelectorEvaluator? jsonPathEvaluator,
    JsSelectorEvaluator? jsEvaluator,
  }) : _cssEvaluator = cssEvaluator ?? CssSelectorEvaluator(),
       _xpathEvaluator = xpathEvaluator ?? XPathSelectorEvaluator(),
       _regexEvaluator = regexEvaluator ?? RegexSelectorEvaluator(),
       _jsonPathEvaluator = jsonPathEvaluator ?? JsonPathSelectorEvaluator(),
       _jsEvaluator = jsEvaluator ?? JsSelectorEvaluator();

  final CssSelectorEvaluator _cssEvaluator;
  final XPathSelectorEvaluator _xpathEvaluator;
  final RegexSelectorEvaluator _regexEvaluator;
  final JsonPathSelectorEvaluator _jsonPathEvaluator;
  final JsSelectorEvaluator _jsEvaluator;

  /// 对 HTML 内容求值选择器。
  ///
  /// 如果主选择器失败且定义了回退，则按顺序尝试每个回退直到成功。
  ///
  /// [html] - 要搜索的 HTML 内容。
  /// [selector] - 选择器配置。
  ///
  /// 返回包含提取值的 [SelectorEngineResult]。
  SelectorEngineResult evaluate(String html, Selector selector) {
    // 尝试主选择器
    var result = _evaluateSingle(html, selector);
    if (result.success) {
      return result;
    }

    // 尝试回退
    final fallbacks = selector.fallbacks;
    if (fallbacks != null && fallbacks.isNotEmpty) {
      for (final fallback in fallbacks) {
        result = _evaluateSingle(html, fallback);
        if (result.success) {
          return SelectorEngineResult(
            values: result.values,
            usedSelector: fallback,
            success: true,
          );
        }
      }
    }

    // 所有选择器都失败
    return SelectorEngineResult(
      values: [],
      usedSelector: selector,
      success: false,
      error: result.error,
    );
  }

  SelectorEngineResult _evaluateSingle(String html, Selector selector) {
    try {
      switch (selector.type) {
        case SelectorType.css:
          return _evaluateCss(html, selector);
        case SelectorType.xpath:
          return _evaluateXpath(html, selector);
        case SelectorType.regex:
          return _evaluateRegex(html, selector);
        case SelectorType.jsonpath:
          return _evaluateJsonPath(html, selector);
        case SelectorType.js:
          return _evaluateJs(html, selector);
      }
    } on Exception catch (e) {
      return SelectorEngineResult(
        values: [],
        usedSelector: selector,
        success: false,
        error: e.toString(),
      );
    }
  }

  SelectorEngineResult _evaluateCss(String html, Selector selector) {
    final result = _cssEvaluator.evaluate(html, selector);

    List<String> values;
    if (selector.attribute != null && selector.attribute!.isNotEmpty) {
      values = result.attributes;
    } else {
      values = result.texts;
    }

    return SelectorEngineResult(
      values: values,
      usedSelector: selector,
      success: values.isNotEmpty,
      error: values.isEmpty ? '未找到匹配' : null,
    );
  }

  SelectorEngineResult _evaluateXpath(String html, Selector selector) {
    final result = _xpathEvaluator.evaluate(html, selector);

    List<String> values;
    if (selector.attribute != null && selector.attribute!.isNotEmpty) {
      values = result.attributes;
    } else {
      values = result.texts;
    }

    return SelectorEngineResult(
      values: values,
      usedSelector: selector,
      success: values.isNotEmpty,
      error: values.isEmpty ? '未找到匹配' : null,
    );
  }

  SelectorEngineResult _evaluateRegex(String html, Selector selector) {
    final result = _regexEvaluator.evaluate(html, selector);

    return SelectorEngineResult(
      values: result.groups,
      usedSelector: selector,
      success: result.groups.isNotEmpty,
      error: result.groups.isEmpty ? '未找到匹配' : null,
    );
  }

  SelectorEngineResult _evaluateJsonPath(String html, Selector selector) {
    final result = _jsonPathEvaluator.evaluate(html, selector);

    final values = result.values.map((v) => v?.toString() ?? '').toList();

    return SelectorEngineResult(
      values: values,
      usedSelector: selector,
      success: values.isNotEmpty,
      error: values.isEmpty ? '未找到匹配' : null,
    );
  }

  SelectorEngineResult _evaluateJs(String html, Selector selector) {
    final result = _jsEvaluator.evaluate(html, selector);

    if (result.isError) {
      return SelectorEngineResult(
        values: [],
        usedSelector: selector,
        success: false,
        error: result.errorMessage,
      );
    }

    return SelectorEngineResult(
      values: [result.stringValue],
      usedSelector: selector,
      success: true,
    );
  }

  /// 对已解析的 HTML 文档求值选择器。
  ///
  /// [document] - 已解析的 HTML 文档。
  /// [selector] - 选择器配置。
  ///
  /// 返回包含提取值的 [SelectorEngineResult]。
  SelectorEngineResult evaluateDocument(
    dom.Document document,
    Selector selector,
  ) {
    // 对于文档级别的求值，我们需要将
    // 文档序列化回 HTML 以用于大多数选择器类型
    final html = document.documentElement?.outerHtml ?? '';
    return evaluate(html, selector);
  }

  /// 对已解析的 HTML 元素求值选择器。
  ///
  /// [element] - 要在其中搜索的 HTML 元素。
  /// [selector] - 选择器配置。
  ///
  /// 返回包含提取值的 [SelectorEngineResult]。
  SelectorEngineResult evaluateElement(
    dom.Element element,
    Selector selector,
  ) {
    final html = element.outerHtml;
    return evaluate(html, selector);
  }

  /// 使用 CSS 选择器从 HTML 中提取单个值。
  ///
  /// 简单 CSS 提取的便捷方法。
  String? extractCssFirst(String html, String expression, {String? attribute}) {
    return _cssEvaluator.extractFirst(html, expression, attribute: attribute);
  }

  /// 使用 CSS 选择器从 HTML 中提取所有值。
  ///
  /// 简单 CSS 提取的便捷方法。
  List<String> extractCssAll(
    String html,
    String expression, {
    String? attribute,
  }) {
    return _cssEvaluator.extractAll(html, expression, attribute: attribute);
  }

  /// 使用 XPath 从 HTML 中提取单个值。
  ///
  /// 简单 XPath 提取的便捷方法。
  String? extractXpathFirst(
    String html,
    String expression, {
    String? attribute,
  }) {
    return _xpathEvaluator.extractFirst(html, expression, attribute: attribute);
  }

  /// 使用 XPath 从 HTML 中提取所有值。
  ///
  /// 简单 XPath 提取的便捷方法。
  List<String> extractXpathAll(
    String html,
    String expression, {
    String? attribute,
  }) {
    return _xpathEvaluator.extractAll(html, expression, attribute: attribute);
  }

  /// 使用正则表达式从文本中提取单个值。
  ///
  /// 简单正则提取的便捷方法。
  String? extractRegexFirst(String text, String pattern, {String? group}) {
    return _regexEvaluator.extractFirst(text, pattern, group: group);
  }

  /// 使用正则表达式从文本中提取所有值。
  ///
  /// 简单正则提取的便捷方法。
  List<String> extractRegexAll(String text, String pattern, {String? group}) {
    return _regexEvaluator.extractAll(text, pattern, group: group);
  }

  /// 使用 JSONPath 从 JSON 中提取单个值。
  ///
  /// 简单 JSONPath 提取的便捷方法。
  String? extractJsonPathFirst(
    dynamic json,
    String expression, {
    String? attribute,
  }) {
    return _jsonPathEvaluator.extractFirstAsString(
      json,
      expression,
      attribute: attribute,
    );
  }

  /// 使用 JSONPath 从 JSON 中提取所有值。
  ///
  /// 简单 JSONPath 提取的便捷方法。
  List<String> extractJsonPathAll(
    dynamic json,
    String expression, {
    String? attribute,
  }) {
    return _jsonPathEvaluator.extractAllAsString(
      json,
      expression,
      attribute: attribute,
    );
  }

  /// 释放选择器引擎并释放资源。
  void dispose() {
    _jsEvaluator.dispose();
  }
}
