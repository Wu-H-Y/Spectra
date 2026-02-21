import 'package:html/dom.dart' as dom;

/// 选择器生成结果。
class SelectorResult {
  /// 创建选择器生成结果。
  const SelectorResult({
    required this.css,
    required this.xpath,
    this.text,
    this.tagName,
    this.attributes,
  });

  /// CSS 选择器。
  final String css;

  /// XPath 选择器。
  final String xpath;

  /// 元素文本内容（截断）。
  final String? text;

  /// 标签名。
  final String? tagName;

  /// 属性映射。
  final Map<String, String>? attributes;
}

/// 选择器生成器。
///
/// 从 HTML 元素生成 CSS 和 XPath 选择器。
class SelectorGenerator {
  /// 从 HTML 元素生成选择器。
  ///
  /// [element] - HTML 元素。
  ///
  /// 返回选择器结果。
  static SelectorResult fromElement(dom.Element element) {
    return SelectorResult(
      css: generateCssSelector(element),
      xpath: generateXPath(element),
      text: _truncateText(element.text),
      tagName: element.localName,
      attributes: _extractAttributes(element),
    );
  }

  /// 从元素信息生成选择器。
  ///
  /// [tagName] - 标签名。
  /// [id] - 元素 ID。
  /// [classes] - CSS 类列表。
  /// [attributes] - 属性映射。
  /// [parentPath] - 父元素路径（用于 XPath）。
  /// [siblingIndex] - 同级索引。
  ///
  /// 返回选择器结果。
  static SelectorResult fromElementInfo({
    required String tagName,
    String? id,
    List<String>? classes,
    Map<String, String>? attributes,
    String? parentPath,
    int? siblingIndex,
    String? text,
  }) {
    final css = _buildCssSelector(
      tagName: tagName,
      id: id,
      classes: classes,
    );

    final xpath = _buildXPath(
      tagName: tagName,
      id: id,
      classes: classes,
      attributes: attributes,
      parentPath: parentPath,
      siblingIndex: siblingIndex,
    );

    return SelectorResult(
      css: css,
      xpath: xpath,
      text: text != null ? _truncateText(text) : null,
      tagName: tagName,
      attributes: attributes,
    );
  }

  /// 生成 CSS 选择器。
  static String generateCssSelector(dom.Element element) {
    return _buildCssSelector(
      tagName: element.localName ?? 'div',
      id: element.id,
      classes: element.classes.toList(),
    );
  }

  /// 生成 XPath 选择器。
  static String generateXPath(dom.Element element) {
    final path = <String>[];
    dom.Element? current = element;

    while (current != null) {
      final segment = _buildXPathSegment(current);
      path.insert(0, segment);

      final parent = current.parent;
      if (parent == null || parent.localName == 'html') {
        break;
      }
      current = parent;
    }

    path.insert(0, '/html');
    return path.join('/');
  }

  static String _buildCssSelector({
    required String tagName,
    String? id,
    List<String>? classes,
  }) {
    final buffer = StringBuffer(tagName);

    // 优先使用 ID
    if (id != null && id.isNotEmpty) {
      buffer.write('#${_escapeCssIdentifier(id)}');
      return buffer.toString();
    }

    // 使用有意义的类名
    final meaningfulClasses = _filterMeaningfulClasses(classes);
    if (meaningfulClasses.isNotEmpty) {
      for (final cls in meaningfulClasses.take(2)) {
        buffer.write('.${_escapeCssIdentifier(cls)}');
      }
      return buffer.toString();
    }

    return buffer.toString();
  }

  static String _buildXPath({
    required String tagName,
    String? id,
    List<String>? classes,
    Map<String, String>? attributes,
    String? parentPath,
    int? siblingIndex,
  }) {
    final buffer = StringBuffer('//');

    // 使用 ID 定位
    if (id != null && id.isNotEmpty) {
      buffer.write('*[@id="${_escapeXPathString(id)}"]');
      return buffer.toString();
    }

    buffer.write(tagName);

    // 使用有意义的类名
    final meaningfulClasses = _filterMeaningfulClasses(classes);
    if (meaningfulClasses.isNotEmpty) {
      final classConditions = meaningfulClasses
          .map((c) => 'contains(@class, "${_escapeXPathString(c)}")')
          .join(' and ');
      buffer.write('[$classConditions]');
    } else if (attributes != null && attributes.isNotEmpty) {
      // 使用其他属性
      final attrConditions = attributes.entries
          .where((e) => _isSignificantAttribute(e.key))
          .take(2)
          .map((e) => '@${e.key}="${_escapeXPathString(e.value)}"')
          .join(' and ');
      if (attrConditions.isNotEmpty) {
        buffer.write('[$attrConditions]');
      }
    }

    // 添加位置索引
    if (siblingIndex != null && siblingIndex > 0) {
      buffer.write('[$siblingIndex]');
    }

    return buffer.toString();
  }

  static String _buildXPathSegment(dom.Element element) {
    final tagName = element.localName ?? '*';

    // 使用 ID
    final id = element.id;
    if (id.isNotEmpty) {
      return '*[@id="${_escapeXPathString(id)}"]';
    }

    // 使用类名
    final classes = _filterMeaningfulClasses(element.classes.toList());
    if (classes.isNotEmpty) {
      final classConditions = classes
          .map((c) => 'contains(@class, "${_escapeXPathString(c)}")')
          .join(' and ');
      return '$tagName[$classConditions]';
    }

    // 使用位置
    final index = _getElementIndex(element);
    if (index > 1) {
      return '$tagName[$index]';
    }

    return tagName;
  }

  static int _getElementIndex(dom.Element element) {
    final parent = element.parent;
    if (parent == null) return 1;

    final tagName = element.localName;
    var index = 1;

    for (final child in parent.children) {
      if (child == element) return index;
      if (child.localName == tagName) index++;
    }

    return 1;
  }

  static List<String> _filterMeaningfulClasses(List<String>? classes) {
    if (classes == null || classes.isEmpty) return [];

    // 过滤掉无意义的类名（通常是框架生成的）
    final ignoredPatterns = [
      RegExp('^css-'), // emotion
      RegExp('^sc-'), // styled-components
      RegExp('^_'), // 私有类
      RegExp(r'^[a-z]{1,2}$'), // 单字母或双字母
      RegExp(r'active$'),
      RegExp(r'focus$'),
      RegExp(r'hover$'),
      RegExp(r'disabled$'),
      RegExp(r'selected$'),
    ];

    return classes.where((cls) {
      return !ignoredPatterns.any((p) => p.hasMatch(cls));
    }).toList();
  }

  static bool _isSignificantAttribute(String name) {
    const significant = {
      'name',
      'data-testid',
      'data-test',
      'data-cy',
      'data-id',
      'aria-label',
      'title',
      'role',
      'type',
      'placeholder',
      'href',
      'src',
    };
    return significant.contains(name.toLowerCase());
  }

  static Map<String, String> _extractAttributes(dom.Element element) {
    final result = <String, String>{};
    for (final attr in element.attributes.entries) {
      result[attr.key.toString()] = attr.value;
    }
    return result;
  }

  static String _truncateText(String? text) {
    if (text == null) return '';
    final cleaned = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (cleaned.length <= 100) return cleaned;
    return '${cleaned.substring(0, 100)}...';
  }

  static String _escapeCssIdentifier(String s) {
    // 转义 CSS 标识符中的特殊字符
    return s.replaceAllMapped(
      RegExp(r'[^\w-]'),
      (m) => '\\${m[0]}',
    );
  }

  static String _escapeXPathString(String s) {
    // 转义 XPath 字符串中的引号
    if (!s.contains('"')) return s;
    if (!s.contains("'")) return "'$s'";
    // 包含两种引号，使用 concat
    return "concat('${s.replaceAll("'", "', \"'\", '")}')";
  }
}

/// 元素选择模式状态。
enum SelectionMode {
  /// 未选择。
  none,

  /// 正在选择元素。
  selecting,

  /// 已选择元素。
  selected,
}

/// 选中的元素信息。
class SelectedElement {
  /// 创建选中元素信息。
  const SelectedElement({
    required this.selector,
    required this.selectorType,
    required this.outerHtml,
    this.textContent,
    this.rect,
  });

  /// 选择器。
  final String selector;

  /// 选择器类型（css 或 xpath）。
  final String selectorType;

  /// 外部 HTML。
  final String outerHtml;

  /// 文本内容。
  final String? textContent;

  /// 元素位置矩形。
  final ElementRect? rect;

  /// 转换为 JSON 映射。
  Map<String, dynamic> toJson() {
    return {
      'selector': selector,
      'selectorType': selectorType,
      'outerHtml': outerHtml,
      'textContent': textContent,
      'rect': rect?.toJson(),
    };
  }
}

/// 元素位置矩形。
class ElementRect {
  /// 创建元素位置矩形。
  const ElementRect({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  /// 从 JSON 创建。
  factory ElementRect.fromJson(Map<String, dynamic> json) {
    return ElementRect(
      x: (json['x'] as num?)?.toDouble() ?? 0,
      y: (json['y'] as num?)?.toDouble() ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 0,
      height: (json['height'] as num?)?.toDouble() ?? 0,
    );
  }

  /// X 坐标。
  final double x;

  /// Y 坐标。
  final double y;

  /// 宽度。
  final double width;

  /// 高度。
  final double height;

  /// 转换为 JSON 映射。
  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'width': width,
      'height': height,
    };
  }
}
