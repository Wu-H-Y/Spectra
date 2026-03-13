import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:spectra/features/rules/domain/validators/rule_validator.dart';

void main() {
  group('RuleValidator', () {
    late RuleValidator validator;

    setUp(() {
      validator = const RuleValidator();
    });

    test('应通过 IR v1 最小规则校验', () async {
      final json =
          jsonDecode(
                await File('fixtures/ir_v1_min.json').readAsString(),
              )
              as Map<String, dynamic>;

      final result = validator.validateEnvelope(json);

      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('应拒绝无法解析的 JSON 字符串', () {
      const raw = '{invalid json}';

      final result = validator.validateJsonString(raw);

      expect(result.isValid, isFalse);
      expect(result.errors, contains('无法解析规则文件，请确认文件完整性'));
    });

    test('应拒绝不支持的主版本', () async {
      final json =
          jsonDecode(
                await File('fixtures/ir_v1_min.json').readAsString(),
              )
              as Map<String, dynamic>;
      json['irVersion'] = '2.0.0';

      final result = validator.validateEnvelope(json);

      expect(result.isValid, isFalse);
      expect(result.errors.single, contains('当前支持 IR v1'));
    });

    test('应拒绝缺失 metadata.ruleId 的规则', () async {
      final json =
          jsonDecode(
                await File('fixtures/ir_v1_min.json').readAsString(),
              )
              as Map<String, dynamic>;
      (json['metadata']! as Map<String, dynamic>).remove('ruleId');

      final result = validator.validateEnvelope(json);

      expect(result.isValid, isFalse);
      expect(
        result.errors.any((error) => error.contains('metadata.ruleId')),
        isTrue,
      );
    });

    test('应拒绝缺失 graph.nodes 的规则', () async {
      final json =
          jsonDecode(
                await File('fixtures/ir_v1_min.json').readAsString(),
              )
              as Map<String, dynamic>;
      (json['graph']! as Map<String, dynamic>).remove('nodes');

      final result = validator.validateEnvelope(json);

      expect(result.isValid, isFalse);
      expect(
        result.errors.any((error) => error.contains('graph.nodes')),
        isTrue,
      );
    });

    test('应拒绝边引用不存在节点', () async {
      final json =
          jsonDecode(
                await File('fixtures/ir_v1_invalid_edge.json').readAsString(),
              )
              as Map<String, dynamic>;

      final result = validator.validateEnvelope(json);

      expect(result.isValid, isFalse);
      expect(
        result.errors.any((error) => error.contains('graph.edges')),
        isTrue,
      );
    });
  });
}
