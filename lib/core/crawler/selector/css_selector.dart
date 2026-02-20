import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;

import 'package:spectra/core/crawler/models/selector.dart';
import 'package:spectra/core/crawler/models/selector_type.dart';

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
  /// [selector] - 选择器配置。
  ///
  /// 返回包含匹配元素和提取值的 [CssSelectorResult]。
  CssSelectorResult evaluate(String html, Selector selector) {
    final document = parseDocument(html);
    return evaluateDocument(document, selector);
  }

  /// 对已解析的文档求值 CSS 选择器。
  ///
  /// [document] - 已解析的 HTML 文档。
  /// [selector] - 选择器配置。
  ///
  /// 返回包含匹配元素和提取值的 [CssSelectorResult]。
  CssSelectorResult evaluateDocument(dom.Document document, Selector selector) {
    final elements = document.querySelectorAll(selector.expression).toList();

    if (selector.firstOnly && elements.isNotEmpty) {
      return _extractFromElements([elements.first], selector.attribute);
    }

    return _extractFromElements(elements, selector.attribute);
  }

  /// 对元素求值 CSS 选择器。
  ///
  /// [element] - 要在其中搜索的父元素。
  /// [selector] - 选择器配置。
  ///
  /// 返回包含匹配元素和提取值的 [CssSelectorResult]。
  CssSelectorResult evaluateElement(
    dom.Element element,
    Selector selector,
  ) {
    final elements = element.querySelectorAll(selector.expression).toList();

    if (selector.firstOnly && elements.isNotEmpty) {
      return _extractFromElements([elements.first], selector.attribute);
    }

    return _extractFromElements(elements, selector.attribute);
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
      Selector(
        type: SelectorType.css,
        expression: expression,
        attribute: attribute,
        firstOnly: true,
      ),
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
    final result = evaluate(
      html,
      Selector(
        type: SelectorType.css,
        expression: expression,
        attribute: attribute,
      ),
    );

    if (attribute != null && attribute.isNotEmpty) {
      return result.attributes;
    }
    return result.texts;
  }
}
