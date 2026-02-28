import 'package:xml/xml.dart';
import 'package:xml/xpath.dart';

/// XPath 选择器求值结果。
class XPathSelectorResult {
  /// 创建 XPath 选择器结果。
  const XPathSelectorResult({
    required this.nodes,
    required this.texts,
    required this.attributes,
  });

  /// 匹配的节点。
  final List<XmlNode> nodes;

  /// 匹配节点的文本内容。
  final List<String> texts;

  /// 提取的属性值（如果指定了属性）。
  final List<String> attributes;
}

/// HTML/XML 内容的 XPath 选择器求值器。
///
/// 使用 `xml` 包解析 HTML/XML 并求值 XPath 表达式。
/// 支持 xml 包实现的 XPath 1.0 子集。
class XPathSelectorEvaluator {
  /// 将 HTML/XML 字符串解析为文档。
  ///
  /// xml 包可以解析格式良好的 HTML 和 XML。
  /// 对于格式不正确的 HTML，可能需要进行预处理。
  XmlDocument parseHtml(String html) {
    // 预处理 HTML 以处理常见问题
    final processed = _preprocessHtml(html);
    return XmlDocument.parse(processed);
  }

  /// 预处理 HTML 以处理常见的格式错误模式。
  String _preprocessHtml(String html) {
    // xml 包可以很好地处理大多数 HTML，
    // 如果需要可以添加预处理来处理边缘情况
    return html;
  }

  /// 对 HTML 内容求值 XPath 表达式。
  ///
  /// [html] - 要搜索的 HTML 内容。
  /// [expression] - XPath 表达式。
  /// [attribute] - 可选的属性名。
  /// [firstOnly] - 是否只返回第一个匹配。
  ///
  /// 返回包含匹配节点和提取值的 [XPathSelectorResult]。
  XPathSelectorResult evaluate(
    String html,
    String expression, {
    String? attribute,
    bool firstOnly = false,
  }) {
    final document = parseHtml(html);
    return evaluateDocument(
      document,
      expression,
      attribute: attribute,
      firstOnly: firstOnly,
    );
  }

  /// 对已解析的文档求值 XPath 表达式。
  ///
  /// [document] - 已解析的 XML/HTML 文档。
  /// [expression] - XPath 表达式。
  /// [attribute] - 可选的属性名。
  /// [firstOnly] - 是否只返回第一个匹配。
  ///
  /// 返回包含匹配节点和提取值的 [XPathSelectorResult]。
  XPathSelectorResult evaluateDocument(
    XmlDocument document,
    String expression, {
    String? attribute,
    bool firstOnly = false,
  }) {
    try {
      // ignore: experimental_member_use - XPath 是 xml 包的实验性功能
      final nodes = document.xpath(expression).toList();

      if (firstOnly && nodes.isNotEmpty) {
        return _extractFromNodes([nodes.first], attribute);
      }

      return _extractFromNodes(nodes, attribute);
    } on XmlException {
      // XPath 错误时返回空结果
      return const XPathSelectorResult(
        nodes: [],
        texts: [],
        attributes: [],
      );
    }
  }

  XPathSelectorResult _extractFromNodes(
    List<XmlNode> nodes,
    String? attribute,
  ) {
    final texts = <String>[];
    final attributes = <String>[];

    for (final node in nodes) {
      // 根据节点类型提取文本内容
      var text = '';
      if (node is XmlElement) {
        text = node.innerText.trim();
      } else if (node is XmlText) {
        text = node.value.trim();
      } else if (node is XmlAttribute) {
        text = node.value.trim();
      }
      texts.add(text);

      // 如果指定了属性则提取属性
      if (attribute != null && attribute.isNotEmpty) {
        if (node is XmlElement) {
          if (attribute == 'text') {
            attributes.add(text);
          } else if (attribute == 'html' || attribute == 'innerHtml') {
            attributes.add(_getInnerHtml(node));
          } else if (attribute == 'outerHtml') {
            attributes.add(_getOuterHtml(node));
          } else {
            final attrValue = node.getAttribute(attribute);
            if (attrValue != null) {
              attributes.add(attrValue);
            }
          }
        } else if (node is XmlAttribute && attribute == 'value') {
          attributes.add(node.value);
        }
      }
    }

    return XPathSelectorResult(
      nodes: nodes,
      texts: texts,
      attributes: attributes,
    );
  }

  String _getInnerHtml(XmlElement element) {
    final buffer = StringBuffer();
    for (final child in element.children) {
      buffer.write(child.toXmlString());
    }
    return buffer.toString();
  }

  String _getOuterHtml(XmlElement element) {
    return element.toXmlString();
  }

  /// 使用 XPath 从 HTML 中提取单个值。
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

  /// 使用 XPath 从 HTML 中提取所有值。
  ///
  /// 返回匹配的文本内容列表。
  List<String> extractAll(String html, String expression, {String? attribute}) {
    final result = evaluate(html, expression, attribute: attribute);

    if (attribute != null && attribute.isNotEmpty) {
      return result.attributes;
    }
    return result.texts;
  }

  /// 求值 XPath 并返回原始 XmlNode 列表。
  ///
  /// 当需要访问实际节点对象时很有用。
  List<XmlNode> query(String html, String expression) {
    final document = parseHtml(html);
    // ignore: experimental_member_use - XPath 是 xml 包的实验性功能
    return document.xpath(expression).toList();
  }

  /// 求值 XPath 并返回第一个匹配的节点。
  ///
  /// 如果没有找到匹配则返回 null。
  XmlNode? queryFirst(String html, String expression) {
    final document = parseHtml(html);
    // ignore: experimental_member_use - XPath 是 xml 包的实验性功能
    return document.xpath(expression).firstOrNull;
  }
}
