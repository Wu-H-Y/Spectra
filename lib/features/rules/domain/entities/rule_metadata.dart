import 'package:freezed_annotation/freezed_annotation.dart';

part 'rule_metadata.freezed.dart';

/// 规则元数据实体。
@freezed
sealed class RuleMetadata with _$RuleMetadata {
  /// 创建规则元数据。
  const factory RuleMetadata({
    required String ruleId,
    required String name,
    String? description,
  }) = _RuleMetadata;

  const RuleMetadata._();

  /// 从 JSON 构建规则元数据。
  factory RuleMetadata.fromJson(Map<String, dynamic> json) {
    return RuleMetadata(
      ruleId: (json['ruleId'] as String?)?.trim() ?? '',
      name: (json['name'] as String?)?.trim() ?? '',
      description: json['description'] as String?,
    );
  }

  /// 序列化为 JSON。
  Map<String, dynamic> toJson() {
    return {
      'ruleId': ruleId,
      'name': name,
      if (description != null) 'description': description,
    };
  }
}
