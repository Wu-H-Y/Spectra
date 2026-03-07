import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:spectra/core/database/drift/tables/rules_v1.dart';

part 'app_database.g.dart';

/// Spectra 应用数据库
///
/// 使用 Drift (SQLite) 管理关系型数据
@DriftDatabase(tables: [RulesV1, SessionsV1])
class AppDatabase extends _$AppDatabase {
  /// 创建数据库实例
  ///
  /// [executor] 可选的数据库执行器，如果不提供则使用默认连接
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  /// 数据库初始化策略
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.addColumn(rulesV1, rulesV1.cookieJarEncrypted);
          await m.addColumn(rulesV1, rulesV1.kvStoreEncrypted);
        }
      },
    );
  }

  /// 打开数据库连接
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'spectra_db');
  }

  /// 按更新时间倒序读取全部规则。
  Future<List<RulesV1Data>> listRules() {
    return (select(rulesV1)..orderBy([
          (table) => OrderingTerm(
            expression: table.updatedAt,
            mode: OrderingMode.desc,
          ),
        ]))
        .get();
  }

  /// 按主键读取单条规则。
  Future<RulesV1Data?> getRuleById(int id) {
    return (select(
      rulesV1,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  /// 创建规则并返回持久化后的记录。
  Future<RulesV1Data> createRule({
    required String ruleId,
    required String name,
    required String irVersion,
    required String ruleEnvelopeJson,
    required bool enabled,
    String? description,
    String? displayConfigJson,
  }) async {
    final now = DateTime.now().toUtc();
    final id = await into(rulesV1).insert(
      RulesV1Companion.insert(
        ruleId: ruleId,
        name: name,
        description: Value(description),
        irVersion: irVersion,
        ruleEnvelopeJson: ruleEnvelopeJson,
        displayConfigJson: displayConfigJson == null
            ? const Value.absent()
            : Value(displayConfigJson),
        enabled: Value(enabled),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );

    return (await getRuleById(id))!;
  }

  /// 更新规则并返回最新记录。
  Future<RulesV1Data?> updateRule({
    required int id,
    required String ruleId,
    required String name,
    required String irVersion,
    required String ruleEnvelopeJson,
    required bool enabled,
    String? description,
    String? displayConfigJson,
  }) async {
    final now = DateTime.now().toUtc();
    final updatedRows =
        await (update(rulesV1)..where((table) => table.id.equals(id))).write(
          RulesV1Companion(
            ruleId: Value(ruleId),
            name: Value(name),
            description: Value(description),
            irVersion: Value(irVersion),
            ruleEnvelopeJson: Value(ruleEnvelopeJson),
            displayConfigJson: displayConfigJson == null
                ? const Value.absent()
                : Value(displayConfigJson),
            enabled: Value(enabled),
            updatedAt: Value(now),
          ),
        );

    if (updatedRows == 0) {
      return null;
    }

    return getRuleById(id);
  }

  /// 删除规则。
  Future<bool> deleteRuleById(int id) async {
    final deletedRows = await (delete(
      rulesV1,
    )..where((table) => table.id.equals(id))).go();
    return deletedRows > 0;
  }
}
