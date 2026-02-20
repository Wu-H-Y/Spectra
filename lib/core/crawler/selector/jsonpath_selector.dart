import 'dart:convert';

import 'package:json_path/json_path.dart';

import 'package:spectra/core/crawler/models/selector.dart';
import 'package:spectra/core/crawler/models/selector_type.dart';

/// JSONPath 求值结果。
class JsonPathSelectorResult {
  /// 创建 JSONPath 选择器结果。
  const JsonPathSelectorResult({
    required this.matches,
    required this.values,
    required this.paths,
  });

  /// 所有 JSONPath 匹配。
  final List<JsonPathMatch> matches;

  /// 从匹配中提取的值。
  final List<dynamic> values;

  /// 匹配的 JSON Pointer 路径。
  final List<String> paths;
}

/// JSON 内容的 JSONPath 求值器。
///
/// 使用 `json_path` 包根据 RFC 9535 规范求值 JSONPath 表达式。
class JsonPathSelectorEvaluator {
  /// 将 JSON 字符串解析为动态值。
  dynamic parseJson(String jsonString) {
    return jsonDecode(jsonString);
  }

  /// 对 JSON 内容求值 JSONPath 表达式。
  ///
  /// [json] - JSON 内容（字符串或已解析的数据）。
  /// [selector] - 选择器配置。
  ///
  /// 返回包含匹配和提取值的 [JsonPathSelectorResult]。
  JsonPathSelectorResult evaluate(dynamic json, Selector selector) {
    // 如果是字符串则解析 JSON
    dynamic jsonData = json;
    if (json is String) {
      jsonData = parseJson(json);
    }

    // 从表达式创建 JSONPath
    final jsonPath = JsonPath(selector.expression);

    // 读取匹配
    final matches = jsonPath.read(jsonData).toList();

    if (selector.firstOnly && matches.isNotEmpty) {
      return _extractFromMatches([matches.first], selector.attribute);
    }

    return _extractFromMatches(matches, selector.attribute);
  }

  JsonPathSelectorResult _extractFromMatches(
    List<JsonPathMatch> matches,
    String? attribute,
  ) {
    final values = <dynamic>[];
    final paths = <String>[];

    for (final match in matches) {
      // 提取值
      dynamic value = match.value;

      // 如果指定了属性则应用属性提取
      if (attribute != null && attribute.isNotEmpty && value is Map) {
        value = value[attribute];
      }

      // 处理 json_path 包中的 Maybe 类型
      if (value.toString().startsWith('Just(')) {
        // 从 Maybe 中提取实际值
        values.add(value);
      } else {
        values.add(value);
      }

      // 提取路径
      paths.add(match.path);
    }

    return JsonPathSelectorResult(
      matches: matches,
      values: values,
      paths: paths,
    );
  }

  /// 使用 JSONPath 从 JSON 中提取第一个值。
  ///
  /// 返回第一个匹配的值，如果没有匹配则返回 null。
  dynamic extractFirst(dynamic json, String expression, {String? attribute}) {
    final result = evaluate(
      json,
      Selector(
        type: SelectorType.jsonpath,
        expression: expression,
        attribute: attribute,
        firstOnly: true,
      ),
    );

    return result.values.firstOrNull;
  }

  /// 使用 JSONPath 从 JSON 中提取所有值。
  ///
  /// 返回匹配的值列表。
  List<dynamic> extractAll(
    dynamic json,
    String expression, {
    String? attribute,
  }) {
    final result = evaluate(
      json,
      Selector(
        type: SelectorType.jsonpath,
        expression: expression,
        attribute: attribute,
      ),
    );

    return result.values;
  }

  /// 使用 JSONPath 从 JSON 中以字符串形式提取所有值。
  ///
  /// 返回转换为字符串的匹配值列表。
  List<String> extractAllAsString(
    dynamic json,
    String expression, {
    String? attribute,
  }) {
    final values = extractAll(json, expression, attribute: attribute);
    return values.map((v) => v?.toString() ?? '').toList();
  }

  /// 使用 JSONPath 从 JSON 中以字符串形式提取第一个值。
  ///
  /// 返回转换为字符串的第一个匹配值，如果没有匹配则返回 null。
  String? extractFirstAsString(
    dynamic json,
    String expression, {
    String? attribute,
  }) {
    final value = extractFirst(json, expression, attribute: attribute);
    return value?.toString();
  }

  /// 获取匹配的 JSON Pointer。
  ///
  /// 返回 JSON Pointer (RFC 6901) 路径字符串。
  String getPointer(JsonPathMatch match) {
    return match.pointer.toString();
  }
}
