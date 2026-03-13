import 'dart:convert';

import 'package:spectra/core/database/drift/app_database.dart';
import 'package:spectra/features/rules/domain/entities/rule.dart';

/// 规则数据模型转换器。
class RuleModel {
  /// 从数据库记录转换为领域实体。
  static Rule fromDatabase(RulesV1Data data) {
    final envelope = jsonDecode(data.ruleEnvelopeJson) as Map<String, dynamic>;
    final rule = Rule.fromEnvelope(envelope);

    return Rule(
      id: rule.id,
      name: rule.name,
      irVersion: rule.irVersion,
      metadata: rule.metadata,
      graph: rule.graph,
      normalizedOutputs: rule.normalizedOutputs,
      capabilities: rule.capabilities,
      rateLimit: rule.rateLimit,
      rawEnvelope: rule.rawEnvelope,
      isEnabled: data.enabled,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
