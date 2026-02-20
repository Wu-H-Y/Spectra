import 'package:flutter_js/flutter_js.dart';

import 'package:spectra/core/crawler/models/selector.dart';
import 'package:spectra/core/crawler/models/selector_type.dart';

/// JavaScript 表达式求值结果。
class JsSelectorResult {
  /// 创建 JS 选择器结果。
  const JsSelectorResult({
    required this.rawValue,
    required this.stringValue,
    this.isError = false,
    this.errorMessage,
  });

  /// 原始结果值。
  final dynamic rawValue;

  /// 字符串形式的结果。
  final String stringValue;

  /// 求值是否产生错误。
  final bool isError;

  /// 如果 isError 为 true 时的错误信息。
  final String? errorMessage;
}

/// JavaScript 表达式求值器。
///
/// 使用 `flutter_js` 包求值 JavaScript 表达式。
/// 这对于从嵌入的 JS 对象（如 `__playinfo__` 或 `window.__INITIAL_STATE__`）中提取数据很有用。
class JsSelectorEvaluator {
  JavascriptRuntime? _runtime;

  /// 获取或创建 JavaScript 运行时。
  ///
  /// 运行时在首次使用时延迟初始化。
  JavascriptRuntime get runtime {
    _runtime ??= getJavascriptRuntime();
    return _runtime!;
  }

  /// 释放 JavaScript 运行时。
  ///
  /// 当不再需要求值器时调用此方法。
  void dispose() {
    _runtime = null;
  }

  /// 求值 JavaScript 表达式。
  ///
  /// [expression] - 要求值的 JavaScript 表达式。
  ///
  /// 返回包含求值结果的 [JsSelectorResult]。
  JsSelectorResult evaluateExpression(String expression) {
    try {
      final result = runtime.evaluate(expression);
      return JsSelectorResult(
        rawValue: result.rawResult,
        stringValue: result.stringResult,
        isError: result.isError,
        errorMessage: result.isError ? result.stringResult : null,
      );
    } on Exception catch (e) {
      return JsSelectorResult(
        rawValue: null,
        stringValue: '',
        isError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 带上下文数据求值 JavaScript 表达式。
  ///
  /// 首先通过执行 contextScript 设置上下文，然后求值表达式。
  ///
  /// [contextScript] - 用于设置上下文的 JavaScript（例如解析 HTML、
  ///   将嵌入的 JSON 赋值给变量）。
  /// [expression] - 上下文设置后要求值的表达式。
  ///
  /// 返回包含求值结果的 [JsSelectorResult]。
  JsSelectorResult evaluateWithContext(
    String contextScript,
    String expression,
  ) {
    try {
      // 首先执行上下文脚本
      final contextResult = runtime.evaluate(contextScript);
      if (contextResult.isError) {
        return JsSelectorResult(
          rawValue: null,
          stringValue: '',
          isError: true,
          errorMessage: '上下文脚本错误: ${contextResult.stringResult}',
        );
      }

      // 然后求值表达式
      return evaluateExpression(expression);
    } on Exception catch (e) {
      return JsSelectorResult(
        rawValue: null,
        stringValue: '',
        isError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// 使用 JavaScript 表达式从 HTML 中提取数据。
  ///
  /// 这对于从 HTML 页面中提取嵌入的 JSON 数据很有用。
  ///
  /// [html] - HTML 内容。
  /// [selector] - 选择器配置。表达式应该是
  ///   提取所需数据的 JavaScript 表达式。
  ///
  /// 返回包含提取数据的 [JsSelectorResult]。
  JsSelectorResult evaluate(String html, Selector selector) {
    // 构建一个解析 HTML 并使其可用的上下文脚本
    final contextScript =
        '''
      // 将 HTML 存储在变量中
      var __html__ = ${_escapeJsString(html)};
    ''';

    return evaluateWithContext(contextScript, selector.expression);
  }

  /// 从 HTML 页面中提取嵌入的 JSON。
  ///
  /// 这是一个常见模式，网站在 script 标签中嵌入数据，
  /// 如 `window.__INITIAL_STATE__ = {...}` 或 `var __playinfo__ = {...}`。
  ///
  /// [html] - 要搜索的 HTML 内容。
  /// [variableName] - 要提取的 JavaScript 变量名。
  /// [selector] - 选择器配置。
  ///
  /// 返回包含提取的 JSON 数据的 [JsSelectorResult]。
  JsSelectorResult extractEmbeddedJson(
    String html,
    String variableName,
    Selector selector,
  ) {
    // 首先尝试在 HTML 中查找变量赋值
    final pattern = RegExp(
      r'(?:var|let|const|window\.)\s*' +
          RegExp.escape(variableName) +
          r'\s*=\s*(\{[\s\S]*?\});?\s*(?:</script>|$)',
    );

    final match = pattern.firstMatch(html);
    if (match == null) {
      return JsSelectorResult(
        rawValue: null,
        stringValue: '',
        isError: true,
        errorMessage: '在 HTML 中未找到变量 $variableName',
      );
    }

    // 提取 JSON 并使其可用于求值
    final jsonStr = match.group(1)!;
    final contextScript =
        '''
      var $variableName = $jsonStr;
    ''';

    return evaluateWithContext(contextScript, selector.expression);
  }

  /// 从 script 标签内容中提取 JSON。
  ///
  /// 用于提取 JSON-LD 或其他嵌入的 JSON 数据。
  ///
  /// [html] - HTML 内容。
  /// [scriptPattern] - 匹配 script 标签的正则模式。
  /// [jsonPattern] - 带有 JSON 捕获组的正则模式。
  ///
  /// 返回提取的 JSON 字符串，如果未找到则返回 null。
  String? extractJsonFromScript(
    String html,
    Pattern scriptPattern,
    Pattern jsonPattern,
  ) {
    // 查找 script 标签
    final scriptMatch = RegExp(scriptPattern.toString()).firstMatch(html);
    if (scriptMatch == null) return null;

    final scriptContent = scriptMatch.group(0)!;

    // 在 script 中查找 JSON
    final jsonMatch = RegExp(jsonPattern.toString()).firstMatch(scriptContent);
    if (jsonMatch == null) return null;

    return jsonMatch.group(1);
  }

  /// 求值从嵌入的 JSON 对象中提取数据的 JavaScript 表达式。
  ///
  /// [jsonString] - 要使其可用的 JSON 字符串。
  /// [expression] - 要求值的 JavaScript 表达式。
  /// [variableName] - 要将 JSON 赋值给的变量名。
  ///
  /// 返回包含提取数据的 [JsSelectorResult]。
  JsSelectorResult extractFromJson(
    String jsonString,
    String expression, {
    String variableName = '__data__',
  }) {
    final contextScript =
        '''
      var $variableName = $jsonString;
    ''';

    return evaluateWithContext(contextScript, expression);
  }

  String _escapeJsString(String s) {
    // ignore: lines_longer_than_80_chars - 单行转义更易读
    return "'${s.replaceAll(r'\', r'\\').replaceAll("'", r"\'").replaceAll('\n', r'\n').replaceAll('\r', r'\r').replaceAll('\t', r'\t')}'";
  }

  /// 使用 JavaScript 表达式提取单个值。
  ///
  /// 返回字符串形式的结果，如果求值失败则返回 null。
  String? extractFirst(String html, String expression) {
    final result = evaluate(
      html,
      Selector(
        type: SelectorType.js,
        expression: expression,
        firstOnly: true,
      ),
    );

    if (result.isError) return null;
    return result.stringValue;
  }
}
