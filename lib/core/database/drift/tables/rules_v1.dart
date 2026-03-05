import 'package:drift/drift.dart';

/// 规则存储表（V1）
class RulesV1 extends Table {
  /// 自增主键
  IntColumn get id => integer().autoIncrement()();

  /// 规则唯一标识
  TextColumn get ruleId => text().unique()();

  /// 规则名称
  TextColumn get name => text()();

  /// 规则描述
  TextColumn get description => text().nullable()();

  /// IR 版本标识
  TextColumn get irVersion => text()();

  /// 规则信封数据（JSON 字符串）
  TextColumn get ruleEnvelopeJson => text()();

  /// 展示配置（JSON 字符串）
  TextColumn get displayConfigJson => text().nullable()();

  /// 规则级 CookieJar 密文字段
  TextColumn get cookieJarEncrypted => text().nullable()();

  /// 规则级 KV 存储密文字段
  TextColumn get kvStoreEncrypted => text().nullable()();

  /// 启用状态
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// 更新时间
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// 会话存储表（V1）
class SessionsV1 extends Table {
  /// 自增主键
  IntColumn get id => integer().autoIncrement()();

  /// 会话唯一标识
  TextColumn get sessionId => text().unique()();

  /// CookieJar 密文字段
  TextColumn get cookieJarEncrypted => text().nullable()();

  /// KV 存储密文字段
  TextColumn get kvStoreEncrypted => text().nullable()();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// 更新时间
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
