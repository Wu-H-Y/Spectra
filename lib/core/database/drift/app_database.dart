import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:spectra/core/database/drift/tables/crawl_rules.dart';

part 'app_database.g.dart';

/// Spectra 应用数据库
///
/// 使用 Drift (SQLite) 管理关系型数据
@DriftDatabase(tables: [CrawlRules])
class AppDatabase extends _$AppDatabase {
  /// 创建数据库实例
  ///
  /// [executor] 可选的数据库执行器，如果不提供则使用默认连接
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  /// 数据库迁移
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // 未来版本迁移逻辑
      },
    );
  }

  /// 打开数据库连接
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'spectra_db');
  }
}
