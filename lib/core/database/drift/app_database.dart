import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:spectra/core/database/drift/tables/crawl_rules.dart';

part 'app_database.g.dart';

/// Spectra 应用数据库
///
/// 使用 Drift (SQLite) 管理关系型数据
@DriftDatabase(tables: [CrawlRules, CachedContent])
class AppDatabase extends _$AppDatabase {
  /// 创建数据库实例
  ///
  /// [executor] 可选的数据库执行器，如果不提供则使用默认连接
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  /// 数据库迁移
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // V1 -> V2: 添加新字段和 CachedContent 表
        if (from < 2) {
          // 添加 crawl_rules 表新字段
          await m.addColumn(crawlRules, crawlRules.ruleId);
          await m.addColumn(crawlRules, crawlRules.description);
          await m.addColumn(crawlRules, crawlRules.version);
          await m.addColumn(crawlRules, crawlRules.globalConfig);
          await m.addColumn(crawlRules, crawlRules.displayConfig);
          await m.addColumn(crawlRules, crawlRules.source);
          await m.addColumn(crawlRules, crawlRules.iconUrl);
          await m.addColumn(crawlRules, crawlRules.author);

          // 创建 CachedContent 表
          await m.createTable(cachedContent);
        }
      },
    );
  }

  /// 打开数据库连接
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'spectra_db');
  }
}
