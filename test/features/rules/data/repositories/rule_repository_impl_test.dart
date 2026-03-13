import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:spectra/core/database/drift/app_database.dart';
import 'package:spectra/core/functional/failures.dart';
import 'package:spectra/features/rules/data/datasources/local/rules_dao.dart';
import 'package:spectra/features/rules/data/repositories/rule_repository_impl.dart';

void main() {
  group('RuleRepositoryImpl', () {
    test('应成功导入合法规则文件并写入数据库', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = RuleRepositoryImpl(rulesDao: RulesDao(database));
      addTearDown(database.close);

      final result = await repository.importRuleFromFile(
        'fixtures/ir_v1_min.json',
      );
      final list = await repository.getAllRules();
      final rule = result.getOrElse((_) {
        fail('导入合法规则不应失败');
      });

      expect(rule.id, 'demo.min');
      expect(list, hasLength(1));
      expect(list.single.name, '最小规则');
    });

    test('应成功从 URL 导入合法规则并写入数据库', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final fixture = await File('fixtures/ir_v1_min.json').readAsString();
      final repository = RuleRepositoryImpl(
        rulesDao: RulesDao(database),
        fetchRuleJson: (uri) async {
          expect(uri.toString(), 'https://example.com/rules/demo.min.json');
          return fixture;
        },
      );
      addTearDown(database.close);

      final result = await repository.importRuleFromUrl(
        'https://example.com/rules/demo.min.json',
      );
      final list = await repository.getAllRules();
      final rule = result.getOrElse((_) {
        fail('从 URL 导入合法规则不应失败');
      });

      expect(rule.id, 'demo.min');
      expect(list, hasLength(1));
      expect(list.single.name, '最小规则');
    });

    test('应拒绝不支持的文件扩展名', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = RuleRepositoryImpl(rulesDao: RulesDao(database));
      addTearDown(database.close);

      final tempFile = File('fixtures/invalid.txt');
      await tempFile.writeAsString('{"irVersion":"1.0.0"}');
      addTearDown(tempFile.delete);

      final result = await repository.importRuleFromFile(tempFile.path);

      expect(result.isLeft(), isTrue);
      expect(
        result.swap().getOrElse((_) => const UnknownFailure('未知错误')),
        isA<ValidationFailure>(),
      );
    });

    test('应拒绝不存在的规则文件', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = RuleRepositoryImpl(rulesDao: RulesDao(database));
      addTearDown(database.close);

      final result = await repository.importRuleFromFile('fixtures/404.json');

      expect(result.isLeft(), isTrue);
      expect(
        result.swap().getOrElse((_) => const UnknownFailure('未知错误')),
        isA<ParseFailure>(),
      );
    });

    test('应拒绝无效 JSON 文件', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = RuleRepositoryImpl(rulesDao: RulesDao(database));
      addTearDown(database.close);

      final tempFile = File('fixtures/invalid_json.json');
      await tempFile.writeAsString('{invalid json}');
      addTearDown(tempFile.delete);

      final result = await repository.importRuleFromFile(tempFile.path);

      expect(result.isLeft(), isTrue);
      result.match(
        (failure) {
          expect(failure, isA<ParseFailure>());
          expect(failure.message, contains('无法解析规则文件'));
        },
        (_) => fail('无效 JSON 不应导入成功'),
      );
    });

    test('应拒绝不支持的 IR 版本', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = RuleRepositoryImpl(rulesDao: RulesDao(database));
      addTearDown(database.close);

      final tempFile = File('fixtures/unsupported_ir_v2.json');
      await tempFile.writeAsString(
        await File(
          'fixtures/ir_v1_min.json',
        ).readAsString().then((raw) => raw.replaceFirst('"1.0.0"', '"2.0.0"')),
      );
      addTearDown(tempFile.delete);

      final result = await repository.importRuleFromFile(tempFile.path);

      expect(result.isLeft(), isTrue);
      result.match(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('当前支持 IR v1'));
        },
        (_) => fail('不支持的 IR 版本不应导入成功'),
      );
    });

    test('应拒绝 localhost 规则 URL', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = RuleRepositoryImpl(
        rulesDao: RulesDao(database),
        fetchRuleJson: (_) async {
          fail('命中本地地址时不应发起网络请求');
        },
      );
      addTearDown(database.close);

      final result = await repository.importRuleFromUrl(
        'http://localhost/rules/demo.min.json',
      );

      expect(result.isLeft(), isTrue);
      result.match(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('规则 URL 不合法'));
        },
        (_) => fail('localhost URL 不应导入成功'),
      );
    });

    test('应拒绝回环地址规则 URL', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = RuleRepositoryImpl(
        rulesDao: RulesDao(database),
        fetchRuleJson: (_) async {
          fail('命中回环地址时不应发起网络请求');
        },
      );
      addTearDown(database.close);

      final result = await repository.importRuleFromUrl(
        'http://127.0.0.1/rules/demo.min.json',
      );

      expect(result.isLeft(), isTrue);
      result.match(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('规则 URL 不合法'));
        },
        (_) => fail('回环地址 URL 不应导入成功'),
      );
    });

    test('应将非成功响应映射为网络错误', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = RuleRepositoryImpl(
        rulesDao: RulesDao(database),
        fetchRuleJson: (_) async {
          throw const HttpException('status=500');
        },
      );
      addTearDown(database.close);

      final result = await repository.importRuleFromUrl(
        'https://example.com/rules/demo.min.json',
      );

      expect(result.isLeft(), isTrue);
      result.match(
        (failure) {
          expect(failure, isA<NetworkFailure>());
        },
        (_) => fail('非成功响应不应导入成功'),
      );
    });

    test('应将超时映射为网络错误', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = RuleRepositoryImpl(
        rulesDao: RulesDao(database),
        fetchRuleJson: (_) async {
          throw const SocketException('timed out');
        },
      );
      addTearDown(database.close);

      final result = await repository.importRuleFromUrl(
        'https://example.com/rules/demo.min.json',
      );

      expect(result.isLeft(), isTrue);
      result.match(
        (failure) {
          expect(failure, isA<NetworkFailure>());
        },
        (_) => fail('超时错误不应导入成功'),
      );
    });

    test('应拒绝返回无效 JSON 的规则 URL', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = RuleRepositoryImpl(
        rulesDao: RulesDao(database),
        fetchRuleJson: (_) async => '{bad json}',
      );
      addTearDown(database.close);

      final result = await repository.importRuleFromUrl(
        'https://example.com/rules/demo.min.json',
      );

      expect(result.isLeft(), isTrue);
      result.match(
        (failure) {
          expect(failure, isA<ParseFailure>());
          expect(failure.message, contains('无法解析规则文件'));
        },
        (_) => fail('无效 JSON URL 不应导入成功'),
      );
    });

    test('应拒绝返回不支持 IR 版本的规则 URL', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final fixture = await File('fixtures/ir_v1_min.json').readAsString();
      final repository = RuleRepositoryImpl(
        rulesDao: RulesDao(database),
        fetchRuleJson: (_) async => fixture.replaceFirst('"1.0.0"', '"2.0.0"'),
      );
      addTearDown(database.close);

      final result = await repository.importRuleFromUrl(
        'https://example.com/rules/demo.min.json',
      );

      expect(result.isLeft(), isTrue);
      result.match(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('当前支持 IR v1'));
        },
        (_) => fail('不支持的 IR 版本 URL 不应导入成功'),
      );
    });

    test('应拒绝图结构引用错误的规则文件', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = RuleRepositoryImpl(rulesDao: RulesDao(database));
      addTearDown(database.close);

      final result = await repository.importRuleFromFile(
        'fixtures/ir_v1_invalid_edge.json',
      );

      expect(result.isLeft(), isTrue);
      result.match(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('graph.edges'));
        },
        (_) => fail('非法图结构规则不应导入成功'),
      );
    });

    test('validateRule 应返回 Either 结果', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = RuleRepositoryImpl(rulesDao: RulesDao(database));
      addTearDown(database.close);

      final valid = await File('fixtures/ir_v1_min.json').readAsString();
      const invalid = '{bad json}';

      final validResult = await repository.validateRule(valid);
      final invalidResult = await repository.validateRule(invalid);

      expect(validResult, equals(const Right<Failure, void>(null)));
      expect(invalidResult.isLeft(), isTrue);
    });
  });
}
