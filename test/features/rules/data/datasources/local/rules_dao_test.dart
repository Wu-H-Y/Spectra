import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spectra/core/database/drift/app_database.dart';
import 'package:spectra/features/rules/data/datasources/local/rules_dao.dart';

void main() {
  group('RulesDao', () {
    test('应支持按 ruleId 插入或更新规则', () async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final dao = RulesDao(database);

      final firstId = await dao.upsertRule(
        ruleId: 'demo.rule',
        name: '演示规则',
        irVersion: '1.0.0',
        ruleEnvelopeJson: jsonEncode({
          'metadata': {'ruleId': 'demo.rule'},
        }),
        enabled: true,
      );

      final secondId = await dao.upsertRule(
        ruleId: 'demo.rule',
        name: '演示规则-更新',
        irVersion: '1.0.1',
        ruleEnvelopeJson: jsonEncode({
          'metadata': {'ruleId': 'demo.rule'},
        }),
        enabled: false,
      );

      final rules = await dao.listRules();

      expect(firstId, secondId);
      expect(rules, hasLength(1));
      expect(rules.single.name, '演示规则-更新');
      expect(rules.single.enabled, isFalse);
      expect(rules.single.irVersion, '1.0.1');
    });
  });
}
