import 'package:drift/drift.dart'
    show DoUpdate, OrderingMode, OrderingTerm, Value;
import 'package:spectra/core/database/drift/app_database.dart';

/// 规则本地数据访问对象。
class RulesDao {
  /// 创建规则 DAO。
  RulesDao(this._database);

  final AppDatabase _database;

  /// 按更新时间倒序读取规则列表。
  Future<List<RulesV1Data>> listRules() {
    return (_database.select(_database.rulesV1)..orderBy([
          (table) => OrderingTerm(
            expression: table.updatedAt,
            mode: OrderingMode.desc,
          ),
        ]))
        .get();
  }

  /// 监听规则列表变化。
  Stream<List<RulesV1Data>> watchRules() {
    return (_database.select(_database.rulesV1)..orderBy([
          (table) => OrderingTerm(
            expression: table.updatedAt,
            mode: OrderingMode.desc,
          ),
        ]))
        .watch();
  }

  /// 按 ruleId 查询规则。
  Future<RulesV1Data?> findByRuleId(String ruleId) {
    return (_database.select(
      _database.rulesV1,
    )..where((table) => table.ruleId.equals(ruleId))).getSingleOrNull();
  }

  /// 按主键查询规则。
  Future<RulesV1Data?> findById(int id) {
    return (_database.select(
      _database.rulesV1,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  /// 按 ruleId 插入或更新规则。
  Future<int> upsertRule({
    required String ruleId,
    required String name,
    required String irVersion,
    required String ruleEnvelopeJson,
    required bool enabled,
    String? description,
    String? displayConfigJson,
  }) async {
    final now = DateTime.now().toUtc();
    await _database
        .into(_database.rulesV1)
        .insert(
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
          onConflict: DoUpdate(
            target: [_database.rulesV1.ruleId],
            (old) => RulesV1Companion(
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
          ),
        );

    final row = await findByRuleId(ruleId);
    return row!.id;
  }
}
