import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/crawl_rules.dart';

part 'app_database.g.dart';

/// Spectra 应用数据库
///
/// 使用 Drift (SQLite) 管理关系型数据
@DriftDatabase(tables: [CrawlRules])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  /// 数据库迁移
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // 未来版本迁移逻辑
      },
    );
  }

  /// 打开数据库连接
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'spectra_db');
  }
}
