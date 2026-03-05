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
}
