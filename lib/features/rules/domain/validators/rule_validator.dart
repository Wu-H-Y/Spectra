import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

part 'rule_validator.freezed.dart';

/// 规则校验结果。
@freezed
sealed class RuleValidationResult with _$RuleValidationResult {
  /// 创建规则校验结果。
  const factory RuleValidationResult({
    required bool isValid,
    required List<String> errors,
  }) = _RuleValidationResult;
}

/// Rules IR v1 校验器。
class RuleValidator {
  /// 创建规则校验器。
  const RuleValidator();

  /// 解析并校验规则 JSON 字符串。
  RuleValidationResult validateJsonString(String rawJson) {
    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is! Map<String, dynamic>) {
        return const RuleValidationResult(
          isValid: false,
          errors: ['规则根节点必须是 JSON 对象'],
        );
      }
      return validateEnvelope(decoded);
    } on FormatException {
      return const RuleValidationResult(
        isValid: false,
        errors: ['无法解析规则文件，请确认文件完整性'],
      );
    }
  }

  /// 校验 RuleEnvelope。
  RuleValidationResult validateEnvelope(Map<String, dynamic> envelope) {
    final errors = <String>[];

    _validateIrVersion(envelope, errors);
    _validateMetadata(envelope, errors);
    _validateGraph(envelope, errors);
    _validateNormalizedOutputs(envelope, errors);
    _validateCapabilities(envelope, errors);

    return RuleValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  void _validateIrVersion(
    Map<String, dynamic> envelope,
    List<String> errors,
  ) {
    final irVersion = envelope['irVersion'];
    if (irVersion is! String || irVersion.trim().isEmpty) {
      errors.add('irVersion 缺失或为空');
      return;
    }

    try {
      final version = Version.parse(irVersion);
      if (version.major != 1) {
        errors.add('规则版本 $irVersion 不受支持，当前支持 IR v1');
      }
    } on FormatException {
      errors.add('irVersion 格式不正确，必须为语义化版本');
    }
  }

  void _validateMetadata(
    Map<String, dynamic> envelope,
    List<String> errors,
  ) {
    final metadata = envelope['metadata'];
    if (metadata is! Map<String, dynamic>) {
      errors.add('metadata 缺失或格式不正确');
      return;
    }

    final ruleId = metadata['ruleId'];
    if (ruleId is! String || ruleId.trim().isEmpty) {
      errors.add('metadata.ruleId 缺失或为空');
    }

    final name = metadata['name'];
    if (name is! String || name.trim().isEmpty) {
      errors.add('metadata.name 缺失或为空');
    }
  }

  void _validateGraph(
    Map<String, dynamic> envelope,
    List<String> errors,
  ) {
    final graph = envelope['graph'];
    if (graph is! Map<String, dynamic>) {
      errors.add('graph 缺失或格式不正确');
      return;
    }

    final nodes = graph['nodes'];
    if (nodes is! List<dynamic>) {
      errors.add('graph.nodes 必须是数组');
      return;
    }

    final edges = graph['edges'];
    if (edges is! List<dynamic>) {
      errors.add('graph.edges 必须是数组');
      return;
    }

    final nodeIds = <String>{};
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node is! Map<String, dynamic>) {
        errors.add('graph.nodes[$i] 必须是对象');
        continue;
      }

      final id = node['id'];
      if (id is! String || id.trim().isEmpty) {
        errors.add('graph.nodes[$i].id 缺失或为空');
        continue;
      }

      if (!nodeIds.add(id)) {
        errors.add('graph.nodes[$i].id 重复: $id');
      }
    }

    for (var i = 0; i < edges.length; i++) {
      final edge = edges[i];
      if (edge is! Map<String, dynamic>) {
        errors.add('graph.edges[$i] 必须是对象');
        continue;
      }

      _validateEdgeRef(
        edge: edge,
        field: 'from',
        edgeIndex: i,
        nodeIds: nodeIds,
        errors: errors,
      );
      _validateEdgeRef(
        edge: edge,
        field: 'to',
        edgeIndex: i,
        nodeIds: nodeIds,
        errors: errors,
      );
    }

    final phaseEntrypoints = graph['phaseEntrypoints'];
    if (phaseEntrypoints != null && phaseEntrypoints is! Map<String, dynamic>) {
      errors.add('graph.phaseEntrypoints 必须是对象');
    }
  }

  void _validateEdgeRef({
    required Map<String, dynamic> edge,
    required String field,
    required int edgeIndex,
    required Set<String> nodeIds,
    required List<String> errors,
  }) {
    final ref = edge[field];
    if (ref is! Map<String, dynamic>) {
      errors.add('graph.edges[$edgeIndex].$field 必须是对象');
      return;
    }

    final nodeId = ref['nodeId'];
    if (nodeId is! String || nodeId.trim().isEmpty) {
      errors.add('graph.edges[$edgeIndex].$field.nodeId 缺失或为空');
      return;
    }

    final portName = ref['portName'];
    if (portName is! String || portName.trim().isEmpty) {
      errors.add('graph.edges[$edgeIndex].$field.portName 缺失或为空');
    }

    if (!nodeIds.contains(nodeId)) {
      errors.add('graph.edges[$edgeIndex].$field.nodeId 引用了不存在节点: $nodeId');
    }
  }

  void _validateNormalizedOutputs(
    Map<String, dynamic> envelope,
    List<String> errors,
  ) {
    final normalizedOutputs = envelope['normalizedOutputs'];
    if (normalizedOutputs is! Map<String, dynamic>) {
      errors.add('normalizedOutputs 缺失或格式不正确');
    }
  }

  void _validateCapabilities(
    Map<String, dynamic> envelope,
    List<String> errors,
  ) {
    final capabilities = envelope['capabilities'];
    if (capabilities is! Map<String, dynamic>) {
      errors.add('capabilities 缺失或格式不正确');
      return;
    }

    _validateBoolField(capabilities, 'supportsPagination', errors);
    _validateBoolField(capabilities, 'supportsConcurrency', errors);
    _validateBoolField(capabilities, 'requiresAuth', errors);

    if (capabilities.containsKey('supportsJs')) {
      _validateBoolField(capabilities, 'supportsJs', errors);
    }
  }

  void _validateBoolField(
    Map<String, dynamic> map,
    String field,
    List<String> errors,
  ) {
    final value = map[field];
    if (value is! bool) {
      errors.add('capabilities.$field 必须是布尔值');
    }
  }
}
