import 'package:freezed_annotation/freezed_annotation.dart';

part 'rule_graph.freezed.dart';

/// 规则图结构实体。
@freezed
sealed class RuleGraph with _$RuleGraph {
  /// 创建规则图结构。
  const factory RuleGraph({
    required List<Map<String, dynamic>> nodes,
    required List<Map<String, dynamic>> edges,
    required Map<String, dynamic> phaseEntrypoints,
  }) = _RuleGraph;

  const RuleGraph._();

  /// 从 JSON 构建图结构。
  factory RuleGraph.fromJson(Map<String, dynamic> json) {
    final nodes = (json['nodes'] as List<dynamic>? ?? <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .toList(growable: false);
    final edges = (json['edges'] as List<dynamic>? ?? <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .toList(growable: false);

    return RuleGraph(
      nodes: nodes,
      edges: edges,
      phaseEntrypoints:
          (json['phaseEntrypoints'] as Map<String, dynamic>?) ??
          <String, dynamic>{},
    );
  }

  /// 序列化为 JSON。
  Map<String, dynamic> toJson() {
    return {
      'nodes': nodes,
      'edges': edges,
      'phaseEntrypoints': phaseEntrypoints,
    };
  }
}
