import 'package:freezed_annotation/freezed_annotation.dart';

part 'pipeline_node.freezed.dart';
part 'pipeline_node.g.dart';

/// Pipeline 节点类型。
enum PipelineNodeType {
  /// 选择器节点 (css, xpath, jsonpath, regex, js)
  selector,

  /// 提取节点 (text, attr, html, href, src)
  extractor,

  /// 变换节点 (trim, replace, url, lower, upper, number, date)
  transform,

  /// 聚合节点 (first, last, join, array, flat)
  aggregation,
}

/// Pipeline 节点定义。
///
/// 每个节点代表一个原子操作，按顺序链式执行。
/// 前一个节点的输出是后一个节点的输入。
@freezed
sealed class PipelineNode with _$PipelineNode {
  const factory PipelineNode({
    /// 节点类型。
    required PipelineNodeType type,

    /// 操作符名称 (不带 @ 前缀)。
    required String operator,

    /// 操作参数 (如 @css:.title 中的 ".title")。
    String? argument,

    /// 节点描述 (用于可视化编辑器)。
    String? description,
  }) = _PipelineNode;

  factory PipelineNode.fromJson(Map<String, dynamic> json) =>
      _$PipelineNodeFromJson(json);
}

/// Pipeline 定义 - 一组按顺序执行的节点。
///
/// 可以表示为字符串数组或解析后的节点对象列表。
/// 字符串格式: `["@css:.title", "@text", "@trim"]`
@freezed
sealed class Pipeline with _$Pipeline {
  const factory Pipeline({
    /// 节点列表。
    required List<PipelineNode> nodes,

    /// 输出字段名。
    String? outputField,
  }) = _Pipeline;

  factory Pipeline.fromJson(Map<String, dynamic> json) =>
      _$PipelineFromJson(json);
}

/// Pipeline 解析工具扩展。
extension PipelineParsing on Pipeline {
  /// 将 Pipeline 转换为字符串数组格式。
  ///
  /// 示例: `["@css:.title", "@text", "@trim"]`
  List<String> toStringList() {
    return nodes.map((node) {
      if (node.argument != null) {
        return '@${node.operator}:${node.argument}';
      }
      return '@${node.operator}';
    }).toList();
  }

  /// 从字符串数组解析 Pipeline。
  static Pipeline fromStringList(List<String> list) {
    final nodes = list.map((str) {
      final match = RegExp(r'^@(\w+)(?::(.+))?$').firstMatch(str);
      if (match == null) {
        throw FormatException('Invalid pipeline node: $str');
      }

      final operator = match.group(1)!;
      final argument = match.group(2);

      return PipelineNode(
        type: _getNodeType(operator),
        operator: operator,
        argument: argument,
      );
    }).toList();

    return Pipeline(nodes: nodes);
  }

  static PipelineNodeType _getNodeType(String operator) {
    return switch (operator) {
      'css' ||
      'xpath' ||
      'jsonpath' ||
      'regex' ||
      'js' => PipelineNodeType.selector,
      'text' ||
      'attr' ||
      'html' ||
      'href' ||
      'src' => PipelineNodeType.extractor,
      'trim' ||
      'replace' ||
      'regexreplace' ||
      'url' ||
      'lower' ||
      'upper' ||
      'number' ||
      'date' => PipelineNodeType.transform,
      'first' ||
      'last' ||
      'join' ||
      'array' ||
      'flat' => PipelineNodeType.aggregation,
      _ => PipelineNodeType.transform,
    };
  }
}
