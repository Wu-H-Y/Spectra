import 'package:html/parser.dart' as html_parser;
import 'package:spectra/core/crawler/models/pipeline_node.dart';
import 'package:spectra/core/crawler/selector/css_selector.dart';
import 'package:spectra/core/crawler/selector/js_selector.dart';
import 'package:spectra/core/crawler/selector/jsonpath_selector.dart';
import 'package:spectra/core/crawler/selector/regex_selector.dart';
import 'package:spectra/core/crawler/selector/xpath_selector.dart';

/// Pipeline 执行结果。
class PipelineResult {
  /// 创建 Pipeline 结果。
  const PipelineResult({
    required this.values,
    this.errors = const [],
  });

  /// 提取的值列表。
  final List<String> values;

  /// 执行过程中的错误。
  final List<String> errors;

  /// 是否成功（有值且无错误）。
  bool get isSuccess => values.isNotEmpty && errors.isEmpty;

  /// 返回第一个值。
  String? get first => values.firstOrNull;

  /// 是否为空。
  bool get isEmpty => values.isEmpty;
}

/// Pipeline 变量上下文。
class PipelineContext {
  /// 创建 Pipeline 上下文。
  const PipelineContext({
    this.variables = const {},
    this.baseUrl,
  });

  /// 变量映射 (如 {{host}}, {{key}}, {{page}})。
  final Map<String, String> variables;

  /// 基础 URL（用于相对 URL 解析）。
  final String? baseUrl;

  /// 获取变量值。
  String? getVariable(String name) => variables[name];

  /// 创建带有额外变量的新上下文。
  PipelineContext withVariable(String key, String value) {
    return PipelineContext(
      variables: {...variables, key: value},
      baseUrl: baseUrl,
    );
  }

  /// 创建带有新基础 URL 的新上下文。
  PipelineContext withBaseUrl(String url) {
    return PipelineContext(
      variables: variables,
      baseUrl: url,
    );
  }
}

/// Pipeline 节点处理器。
///
/// 将 Pipeline 节点链式执行于输入值上。
class PipelineExecutor {
  /// 创建 Pipeline 执行器。
  PipelineExecutor()
      : _cssEvaluator = CssSelectorEvaluator(),
        _xpathEvaluator = XPathSelectorEvaluator(),
        _jsonPathEvaluator = JsonPathSelectorEvaluator(),
        _regexEvaluator = RegexSelectorEvaluator(),
        _jsEvaluator = JsSelectorEvaluator();

  final CssSelectorEvaluator _cssEvaluator;
  final XPathSelectorEvaluator _xpathEvaluator;
  final JsonPathSelectorEvaluator _jsonPathEvaluator;
  final RegexSelectorEvaluator _regexEvaluator;
  final JsSelectorEvaluator _jsEvaluator;

  /// 执行 Pipeline 节点链。
  ///
  /// [input] - 输入值（HTML 或文本）。
  /// [nodes] - Pipeline 节点列表。
  /// [context] - 变量上下文。
  ///
  /// 返回执行结果。
  PipelineResult execute(
    String input,
    List<PipelineNode> nodes, {
    PipelineContext? context,
  }) {
    var currentInput = input;
    final errors = <String>[];

    for (final node in nodes) {
      final result =
          _executeNode(currentInput, node, context ?? const PipelineContext());
      if (result.errors.isNotEmpty) {
        errors.addAll(result.errors);
      }
      if (result.values.isEmpty) {
        // 节点执行失败，返回当前结果
        return PipelineResult(values: [], errors: errors);
      }
      currentInput = result.values.first;
    }

    return PipelineResult(values: [currentInput], errors: errors);
  }

  /// 执行单节点。
  PipelineResult _executeNode(
    String input,
    PipelineNode node,
    PipelineContext context,
  ) {
    switch (node.type) {
      case PipelineNodeType.selector:
        return _executeSelector(input, node.operator, node.argument);
      case PipelineNodeType.extractor:
        return _executeExtractor(input, node.operator, node.argument);
      case PipelineNodeType.transform:
        return _executeTransform(
            input, node.operator, node.argument, context);
      case PipelineNodeType.aggregation:
        return _executeAggregation(input, node.operator, node.argument);
    }
  }

  /// 执行选择器节点。
  PipelineResult _executeSelector(
    String input,
    String operator,
    String? argument,
  ) {
    if (argument == null || argument.isEmpty) {
      return const PipelineResult(
          values: [], errors: ['选择器表达式不能为空']);
    }

    try {
      switch (operator) {
        case 'css':
          return _executeCss(input, argument);
        case 'xpath':
          return _executeXpath(input, argument);
        case 'jsonpath':
          return _executeJsonPath(input, argument);
        case 'regex':
          return _executeRegex(input, argument);
        case 'js':
          return _executeJs(input, argument);
        default:
          return PipelineResult(
              values: [], errors: ['未知选择器类型: $operator']);
      }
    } on Exception catch (e) {
      return PipelineResult(values: [], errors: ['选择器执行错误: $e']);
    }
  }

  /// 执行 CSS 选择器。
  PipelineResult _executeCss(String html, String selector) {
    final result = _cssEvaluator.extractAll(html, selector);
    return PipelineResult(values: result);
  }

  /// 执行 XPath 选择器。
  PipelineResult _executeXpath(String html, String xpath) {
    final result = _xpathEvaluator.extractAll(html, xpath);
    return PipelineResult(values: result);
  }

  /// 执行 JSONPath 选择器。
  PipelineResult _executeJsonPath(String jsonString, String jsonPath) {
    try {
      final json = _parseJson(jsonString);
      final result =
          _jsonPathEvaluator.extractAllAsString(json, jsonPath);
      return PipelineResult(values: result);
    } on Exception catch (e) {
      return PipelineResult(values: [], errors: ['JSON 解析错误: $e']);
    }
  }

  /// 执行正则表达式选择器。
  PipelineResult _executeRegex(String input, String pattern) {
    final result = _regexEvaluator.extractAll(input, pattern);
    return PipelineResult(values: result);
  }

  /// 执行 JavaScript 代码。
  PipelineResult _executeJs(String input, String code) {
    try {
      // JavaScript 执行使用 flutter_js
      final result = _jsEvaluator.evaluateExpression(code);
      if (result.isError) {
        return PipelineResult(
          values: [],
          errors: [result.errorMessage ?? 'JS 执行错误'],
        );
      }
      return PipelineResult(values: [result.stringValue]);
    } on Exception catch (e) {
      return PipelineResult(values: [], errors: ['JS 执行错误: $e']);
    }
  }

  /// 执行提取器节点。
  PipelineResult _executeExtractor(
    String input,
    String operator,
    String? argument,
  ) {
    try {
      // 解析 HTML
      final document = html_parser.parse(input);
      final elements = document.querySelectorAll('*');

      switch (operator) {
        case 'text':
          // 获取所有元素的文本
          final texts = elements
              .map((e) => e.text.trim())
              .where((t) => t.isNotEmpty)
              .toList();
          return PipelineResult(values: texts);

        case 'attr':
          if (argument == null || argument.isEmpty) {
            return const PipelineResult(
                values: [], errors: ['属性名不能为空']);
          }
          // 获取所有元素的指定属性
          final attrs = elements
              .map((e) => e.attributes[argument])
              .where((a) => a != null && a.isNotEmpty)
              .cast<String>()
              .toList();
          return PipelineResult(values: attrs);

        case 'html':
          // 获取所有元素的内部 HTML
          final htmls = elements
              .map((e) => e.innerHtml)
              .where((h) => h.isNotEmpty)
              .toList();
          return PipelineResult(values: htmls);

        case 'href':
          // 获取所有链接的 href
          final hrefs = elements
              .where((e) => e.attributes.containsKey('href'))
              .map((e) => e.attributes['href']!)
              .where((h) => h.isNotEmpty)
              .toList();
          return PipelineResult(values: hrefs);

        case 'src':
          // 获取所有 img/script 的 src
          final srcs = elements
              .where((e) => e.attributes.containsKey('src'))
              .map((e) => e.attributes['src']!)
              .where((s) => s.isNotEmpty)
              .toList();
          return PipelineResult(values: srcs);

        default:
          return PipelineResult(
              values: [], errors: ['未知提取器类型: $operator']);
      }
    } on Exception catch (e) {
      return PipelineResult(values: [], errors: ['提取器执行错误: $e']);
    }
  }

  /// 执行变换节点。
  PipelineResult _executeTransform(
    String input,
    String operator,
    String? argument,
    PipelineContext context,
  ) {
    var output = input;

    switch (operator) {
      case 'trim':
        output = input.trim();

      case 'lower':
        output = input.toLowerCase();

      case 'upper':
        output = input.toUpperCase();

      case 'replace':
        if (argument == null || !argument.contains('→')) {
          return const PipelineResult(
              values: [], errors: ['replace 需要 from→to 格式参数']);
        }
        final parts = argument.split('→');
        if (parts.length != 2) {
          return const PipelineResult(
              values: [], errors: ['replace 参数格式错误']);
        }
        output = input.replaceAll(parts[0], parts[1]);

      case 'regexreplace':
        if (argument == null || !argument.contains('→')) {
          return const PipelineResult(
              values: [], errors: ['regexreplace 需要 pattern→replacement 格式参数']);
        }
        final parts = argument.split('→');
        if (parts.length != 2) {
          return const PipelineResult(
              values: [], errors: ['regexreplace 参数格式错误']);
        }
        try {
          output = input.replaceAll(RegExp(parts[0]), parts[1]);
        } on Exception catch (e) {
          return PipelineResult(values: [], errors: ['正则表达式错误: $e']);
        }

      case 'url':
        output = _resolveUrl(input, context.baseUrl);

      case 'number':
        // 提取数字
        final match = RegExp(r'-?\d+(\.\d+)?').firstMatch(input);
        output = match?.group(0) ?? '';

      case 'date':
        // 日期格式化（简化处理）
        output = input.replaceAll(RegExp(r'[\s/]+'), '-');

      default:
        return PipelineResult(values: [], errors: ['未知变换类型: $operator']);
    }

    return PipelineResult(values: [output]);
  }

  /// 执行聚合节点。
  PipelineResult _executeAggregation(
    String input,
    String operator,
    String? argument,
  ) {
    // 输入可能是用分隔符连接的多个值
    final values = input
        .split(RegExp(r'[\n,\|]'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    switch (operator) {
      case 'first':
        return PipelineResult(
            values: values.isNotEmpty ? [values.first] : []);

      case 'last':
        return PipelineResult(
            values: values.isNotEmpty ? [values.last] : []);

      case 'join':
        final separator = argument ?? ',';
        return PipelineResult(values: [values.join(separator)]);

      case 'array':
        // 返回原始数组形式（用换行分隔）
        return PipelineResult(values: values);

      case 'flat':
        // 展平处理（递归拆分）
        final flattened = <String>[];
        for (final v in values) {
          flattened.addAll(v
              .split(RegExp(r'[\s,\|]+'))
              .where((s) => s.isNotEmpty));
        }
        return PipelineResult(values: flattened);

      default:
        return PipelineResult(values: [], errors: ['未知聚合类型: $operator']);
    }
  }

  /// 解析 JSON 字符串。
  dynamic _parseJson(String jsonString) {
    try {
      return jsonString.isEmpty ? <String, dynamic>{} : jsonString;
    } catch (e) {
      rethrow;
    }
  }

  /// 解析相对 URL。
  String _resolveUrl(String url, String? baseUrl) {
    if (url.isEmpty) return url;
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    if (baseUrl == null || baseUrl.isEmpty) return url;

    try {
      final base = Uri.parse(baseUrl);
      return base.resolve(url).toString();
    } on Exception catch (_) {
      return url;
    }
  }

  /// 释放资源。
  void dispose() {
    _jsEvaluator.dispose();
  }
}

/// 从字符串列表创建 Pipeline 并执行。
PipelineResult executePipeline(
  String input,
  List<String> nodeStrings, {
  PipelineContext? context,
}) {
  final nodes = nodeStrings.map(_parseNodeString).toList();
  final executor = PipelineExecutor();
  try {
    return executor.execute(input, nodes, context: context);
  } finally {
    executor.dispose();
  }
}

/// 解析节点字符串为 PipelineNode。
PipelineNode _parseNodeString(String str) {
  final match = RegExp(r'^@(\w+)(?::(.+))?$').firstMatch(str);
  if (match == null) {
    throw FormatException('无效的 Pipeline 节点: $str');
  }

  final operator = match.group(1)!;
  final argument = match.group(2);

  return PipelineNode(
    type: getNodeType(operator),
    operator: operator,
    argument: argument,
  );
}

/// 插值变量到 URL 模板。
///
/// 支持的变量:
/// - `{{host}}` - 基础域名
/// - `{{key}}` - 搜索关键词
/// - `{{page}}` - 页码
/// - `{{category}}` - 分类
/// - `{{id}}` - 资源 ID
///
/// [template] - URL 模板字符串。
/// [context] - 变量上下文。
///
/// 返回插值后的 URL。
String interpolateUrl(String template, PipelineContext context) {
  var url = template;

  // 替换所有 {{variable}} 模式的变量
  url = url.replaceAllMapped(
    RegExp(r'\{\{(\w+)\}\}'),
    (match) {
      final variable = match.group(1)!;
      return context.getVariable(variable) ?? match.group(0)!;
    },
  );

  // 如果仍然有未解析的变量，尝试从 baseUrl 提取 host
  if (url.contains('{{host}}') && context.baseUrl != null) {
    try {
      final uri = Uri.parse(context.baseUrl!);
      url = url.replaceAll('{{host}}', uri.host);
    } on Exception catch (_) {
      // 忽略解析错误
    }
  }

  return url;
}

/// 从基础 URL 提取 host。
String? extractHost(String? baseUrl) {
  if (baseUrl == null || baseUrl.isEmpty) return null;
  try {
    final uri = Uri.parse(baseUrl);
    return uri.host;
  } on Exception catch (_) {
    return null;
  }
}
