import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spectra/features/rules/domain/entities/rule_graph.dart';
import 'package:spectra/features/rules/domain/entities/rule_metadata.dart';

part 'rule.freezed.dart';

/// 规则领域实体。
@freezed
sealed class Rule with _$Rule {
  /// 创建规则实体。
  const factory Rule({
    required String id,
    required String name,
    required String irVersion,
    required RuleMetadata metadata,
    required RuleGraph graph,
    required Map<String, dynamic> normalizedOutputs,
    required Map<String, dynamic> capabilities,
    required Map<String, dynamic> rawEnvelope,
    Map<String, dynamic>? rateLimit,
    @Default(true) bool isEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Rule;

  const Rule._();

  /// 从 RuleEnvelope JSON 构建实体。
  factory Rule.fromEnvelope(Map<String, dynamic> envelope) {
    final metadata = RuleMetadata.fromJson(
      (envelope['metadata'] as Map<String, dynamic>?) ?? <String, dynamic>{},
    );
    return Rule(
      id: metadata.ruleId,
      name: metadata.name,
      irVersion: (envelope['irVersion'] as String?) ?? '',
      metadata: metadata,
      graph: RuleGraph.fromJson(
        (envelope['graph'] as Map<String, dynamic>?) ?? <String, dynamic>{},
      ),
      normalizedOutputs:
          (envelope['normalizedOutputs'] as Map<String, dynamic>?) ??
          <String, dynamic>{},
      capabilities:
          (envelope['capabilities'] as Map<String, dynamic>?) ??
          <String, dynamic>{},
      rateLimit: envelope['rateLimit'] as Map<String, dynamic>?,
      rawEnvelope: envelope,
    );
  }

  /// 序列化为 RuleEnvelope JSON。
  Map<String, dynamic> toEnvelopeJson() {
    return {
      'irVersion': irVersion,
      'metadata': metadata.toJson(),
      'graph': graph.toJson(),
      'normalizedOutputs': normalizedOutputs,
      'capabilities': capabilities,
      if (rateLimit != null) 'rateLimit': rateLimit,
    };
  }
}
