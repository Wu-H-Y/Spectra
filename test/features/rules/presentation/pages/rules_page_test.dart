import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/functional/failures.dart';
import 'package:spectra/core/i18n/strings.g.dart';
import 'package:spectra/features/rules/domain/entities/rule.dart';
import 'package:spectra/features/rules/domain/entities/rule_graph.dart';
import 'package:spectra/features/rules/domain/entities/rule_metadata.dart';
import 'package:spectra/features/rules/domain/repositories/rule_repository.dart';
import 'package:spectra/features/rules/presentation/pages/rules_page.dart';
import 'package:spectra/features/rules/presentation/providers/rules_provider.dart';

void main() {
  group('RulesPage', () {
    testWidgets('应显示空状态', (tester) async {
      final repository = _FakeRuleRepository();

      await tester.pumpWidget(_buildTestApp(repository: repository));
      await tester.pump();

      expect(find.text('暂无规则，请先导入规则文件'), findsOneWidget);
    });

    testWidgets('应展示 URL 导入入口并支持成功导入', (tester) async {
      final repository = _FakeRuleRepository();

      await tester.pumpWidget(_buildTestApp(repository: repository));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('rules-import-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('从 URL 导入'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('rules-import-url-field')),
        'https://example.com/rules/demo.min.json',
      );
      await tester.tap(find.byKey(const Key('rules-import-url-submit')));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(repository.importedUrls, [
        'https://example.com/rules/demo.min.json',
      ]);
      expect(find.textContaining('规则导入成功'), findsOneWidget);
      expect(find.text('演示规则'), findsOneWidget);
    });

    testWidgets('URL 导入失败后应显示错误对话框', (tester) async {
      final repository = _FakeRuleRepository(
        importUrlResult: left(const ValidationFailure('规则 URL 不合法，请检查后重试')),
      );

      await tester.pumpWidget(_buildTestApp(repository: repository));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('rules-import-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('从 URL 导入'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('rules-import-url-field')),
        'https://example.com/bad.json',
      );
      await tester.tap(find.byKey(const Key('rules-import-url-submit')));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('规则导入失败'), findsOneWidget);
      expect(find.text('规则 URL 不合法，请检查后重试'), findsOneWidget);
    });

    testWidgets('提供 initialImportUrl 时应自动打开 URL 导入对话框', (tester) async {
      final repository = _FakeRuleRepository();

      await tester.pumpWidget(
        _buildTestApp(
          repository: repository,
          initialImportUrl: 'https://example.com/deep-link.json',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('从 URL 导入'), findsWidgets);
      expect(find.text('https://example.com/deep-link.json'), findsOneWidget);
    });

    testWidgets('文件导入成功后应刷新列表', (tester) async {
      final repository = _FakeRuleRepository();

      await tester.pumpWidget(
        _buildTestApp(
          repository: repository,
          pickRuleFile: () async => 'fixtures/ir_v1_min.json',
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('rules-import-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('导入文件'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(repository.importedFiles, ['fixtures/ir_v1_min.json']);
      expect(find.text('演示规则'), findsOneWidget);
    });
  });
}

Widget _buildTestApp({
  required _FakeRuleRepository repository,
  String? initialImportUrl,
  Future<String?> Function()? pickRuleFile,
}) {
  return ProviderScope(
    overrides: [
      ruleRepositoryProvider.overrideWithValue(repository),
    ],
    child: TranslationProvider(
      child: MaterialApp(
        home: RulesPage(
          initialImportUrl: initialImportUrl,
          pickRuleFile: pickRuleFile,
        ),
      ),
    ),
  );
}

class _FakeRuleRepository implements RuleRepository {
  _FakeRuleRepository({
    Either<Failure, Rule>? importFileResult,
    Either<Failure, Rule>? importUrlResult,
  }) : _importFileResult = importFileResult,
       _importUrlResult = importUrlResult;

  final List<Rule> _rules = <Rule>[];
  final Either<Failure, Rule>? _importFileResult;
  final Either<Failure, Rule>? _importUrlResult;

  final List<String> importedFiles = <String>[];
  final List<String> importedUrls = <String>[];

  @override
  Future<List<Rule>> getAllRules() async => List<Rule>.unmodifiable(_rules);

  @override
  Future<Rule?> getRuleById(String id) async {
    for (final rule in _rules) {
      if (rule.id == id) {
        return rule;
      }
    }
    return null;
  }

  @override
  Future<Either<Failure, Rule>> importRuleFromFile(String filePath) async {
    importedFiles.add(filePath);
    return (_importFileResult ?? right(_demoRule()))..match((_) {}, _addRule);
  }

  @override
  Future<Either<Failure, Rule>> importRuleFromUrl(String url) async {
    importedUrls.add(url);
    return (_importUrlResult ?? right(_demoRule()))..match((_) {}, _addRule);
  }

  @override
  Future<Either<Failure, void>> validateRule(String ruleJson) async {
    return right(null);
  }

  void _addRule(Rule rule) {
    final existingIndex = _rules.indexWhere((item) => item.id == rule.id);
    if (existingIndex >= 0) {
      _rules[existingIndex] = rule;
      return;
    }
    _rules.add(rule);
  }

  Rule _demoRule() {
    return const Rule(
      id: 'demo.min',
      name: '演示规则',
      irVersion: '1.0.0',
      metadata: RuleMetadata(
        ruleId: 'demo.min',
        name: '演示规则',
        description: '用于测试的规则',
      ),
      graph: RuleGraph(
        nodes: <Map<String, dynamic>>[],
        edges: <Map<String, dynamic>>[],
        phaseEntrypoints: <String, dynamic>{},
      ),
      normalizedOutputs: <String, dynamic>{},
      capabilities: <String, dynamic>{
        'supportsPagination': false,
        'supportsConcurrency': false,
        'requiresAuth': false,
      },
      rawEnvelope: <String, dynamic>{
        'irVersion': '1.0.0',
      },
    );
  }
}
