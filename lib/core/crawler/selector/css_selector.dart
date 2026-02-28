import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;

/// CSS 选择器求值结果。
class CssSelectorResult {
  /// 创建 CSS 选择器结果。
  const CssSelectorResult({
    required this.elements,
    required this.texts,
    required this.attributes,
  });

  /// 匹配的元素。
  final List<dom.Element> elements;

  /// 匹配元素的文本内容。
  final List<String> texts;

  /// 提取的属性值（如果指定了属性）。
  final List<String> attributes;
}

/// HTML 内容的 CSS 选择器求值器。
///
/// 使用 `html` 包解析 HTML 并求值 CSS 选择器。
class CssSelectorEvaluator {
  /// 将 HTML 字符串解析为文档。
  dom.Document parseDocument(String html) {
    return html_parser.parse(html);
  }

  /// 将 HTML 片段解析为元素列表。
  List<dom.Node> parseFragment(String html) {
    return html_parser.parseFragment(html).nodes;
  }

  /// 对 HTML 内容求值 CSS 选择器。
  ///
  /// [html] - 要搜索的 HTML 内容。
  /// [expression] - CSS 选择器表达式。
  /// [attribute] - 可选的属性名。
  /// [firstOnly] - 是否只返回第一个匹配。
  ///
  /// 返回包含匹配元素和提取值的 [CssSelectorResult]。
  CssSelectorResult evaluate(
    String html,
    String expression, {
    String? attribute,
    bool firstOnly = false,
  }) {
    final document = parseDocument(html);
    return evaluateDocument(
      document,
      expression,
      attribute: attribute,
      firstOnly: firstOnly,
    );
  }

  /// 对已解析的文档求值 CSS 选择器。
  ///
  /// [document] - 已解析的 HTML 文档。
  /// [expression] - CSS 选择器表达式。
  /// [attribute] - 可选的属性名。
  /// [firstOnly] - 是否只返回第一个匹配。
  ///
  /// 返回包含匹配元素和提取值的 [CssSelectorResult]。
  CssSelectorResult evaluateDocument(
    dom.Document document,
    String expression, {
    String? attribute,
    bool firstOnly = false,
  }) {
    final elements = document.querySelectorAll(expression).toList();

    if (firstOnly && elements.isNotEmpty) {
      return _extractFromElements([elements.first], attribute);
    }

    return _extractFromElements(elements, attribute);
  }

  /// 对元素求值 CSS 选择器。
  ///
  /// [element] - 要在其中搜索的父元素。
  /// [expression] - CSS 选择器表达式。
  /// [attribute] - 可选的属性名。
  /// [firstOnly] - 是否只返回第一个匹配。
  ///
  /// 返回包含匹配元素和提取值的 [CssSelectorResult]。
  CssSelectorResult evaluateElement(
    dom.Element element,
    String expression, {
    String? attribute,
    bool firstOnly = false,
  }) {
    final elements = element.querySelectorAll(expression).toList();

    if (firstOnly && elements.isNotEmpty) {
      return _extractFromElements([elements.first], attribute);
    }

    return _extractFromElements(elements, attribute);
  }

  CssSelectorResult _extractFromElements(
    List<dom.Element> elements,
    String? attribute,
  ) {
    final texts = <String>[];
    final attributes = <String>[];

    for (final element in elements) {
      // 提取文本内容
      texts.add(element.text.trim());

      // 如果指定了属性则提取属性
      if (attribute != null && attribute.isNotEmpty) {
        if (attribute == 'text') {
          attributes.add(element.text.trim());
        } else if (attribute == 'html' || attribute == 'innerHtml') {
          attributes.add(element.innerHtml);
        } else if (attribute == 'outerHtml') {
          attributes.add(element.outerHtml);
        } else {
          final attrValue = element.attributes[attribute];
          if (attrValue != null) {
            attributes.add(attrValue);
          }
        }
      }
    }

    return CssSelectorResult(
      elements: elements,
      texts: texts,
      attributes: attributes,
    );
  }

  /// 使用 CSS 选择器从 HTML 中提取单个值。
  ///
  /// 返回第一个匹配的文本内容，如果没有匹配则返回 null。
  String? extractFirst(String html, String expression, {String? attribute}) {
    final result = evaluate(
      html,
      expression,
      attribute: attribute,
      firstOnly: true,
    );

    if (attribute != null && attribute.isNotEmpty) {
      return result.attributes.firstOrNull;
    }
    return result.texts.firstOrNull;
  }

  /// 使用 CSS 选择器从 HTML 中提取所有值。
  ///
  /// 返回匹配的文本内容列表。
  List<String> extractAll(String html, String expression, {String? attribute}) {
    final result = evaluate(html, expression, attribute: attribute);

    if (attribute != null && attribute.isNotEmpty) {
      return result.attributes;
    }
    return result.texts;
  }
}
