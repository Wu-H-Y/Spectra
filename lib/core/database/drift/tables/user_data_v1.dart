import 'package:drift/drift.dart';

/// 收藏内容表（V1）
///
/// 存储用户收藏的多媒体内容
class FavoritesV1 extends Table {
  /// 自增主键
  IntColumn get id => integer().autoIncrement()();

  /// 内容唯一标识（外部系统ID）
  TextColumn get contentId => text()();

  /// 内容标题
  TextColumn get title => text()();

  /// 内容类型：video, music, novel, comic, image
  TextColumn get contentType => text()();

  /// 封面图片URL
  TextColumn get coverUrl => text().nullable()();

  /// 作者/创作者
  TextColumn get author => text().nullable()();

  /// 内容描述
  TextColumn get description => text().nullable()();

  /// 来源规则ID
  TextColumn get sourceRuleId => text()();

  /// 来源规则名称
  TextColumn get sourceRuleName => text()();

  /// 原始内容URL
  TextColumn get contentUrl => text().nullable()();

  /// 附加数据（JSON字符串，存储额外信息）
  TextColumn get metadataJson => text().nullable()();

  /// 收藏时间
  DateTimeColumn get favoritedAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// 最后观看/访问时间
  DateTimeColumn get lastAccessedAt => dateTime().nullable()();

  /// 访问次数
  IntColumn get accessCount => integer().withDefault(const Constant(0))();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// 更新时间
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {contentId, sourceRuleId},
  ];
}

/// 搜索历史表（V1）
///
/// 存储用户的搜索历史记录
class SearchHistoryV1 extends Table {
  /// 自增主键
  IntColumn get id => integer().autoIncrement()();

  /// 搜索关键词
  TextColumn get query => text()();

  /// 搜索类型过滤：all, video, music, novel, comic, image
  TextColumn get filterType => text().withDefault(const Constant('all'))();

  /// 搜索次数（同一关键词）
  IntColumn get searchCount => integer().withDefault(const Constant(1))();

  /// 最后搜索时间
  DateTimeColumn get lastSearchedAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {query},
  ];
}

/// 发现内容缓存表（V1）
///
/// 缓存发现页面的内容数据
class DiscoverCacheV1 extends Table {
  /// 自增主键
  IntColumn get id => integer().autoIncrement()();

  /// 内容唯一标识
  TextColumn get contentId => text()();

  /// 内容标题
  TextColumn get title => text()();

  /// 内容类型
  TextColumn get contentType => text()();

  /// 封面图片URL
  TextColumn get coverUrl => text().nullable()();

  /// 作者/创作者
  TextColumn get author => text().nullable()();

  /// 内容描述
  TextColumn get description => text().nullable()();

  /// 来源规则ID
  TextColumn get sourceRuleId => text()();

  /// 来源规则名称
  TextColumn get sourceRuleName => text()();

  /// 浏览量/热度
  TextColumn get viewCount => text().nullable()();

  /// 原始内容URL
  TextColumn get contentUrl => text().nullable()();

  /// 附加数据（JSON字符串）
  TextColumn get metadataJson => text().nullable()();

  /// 缓存时间
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();

  /// 过期时间
  DateTimeColumn get expiresAt => dateTime()();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {contentId, sourceRuleId},
  ];
}

/// 用户设置表（V1）
///
/// 存储用户个性化设置（扩展Hive设置）
class UserSettingsV1 extends Table {
  /// 自增主键
  IntColumn get id => integer().autoIncrement()();

  /// 设置键
  TextColumn get key => text().unique()();

  /// 设置值（JSON字符串）
  TextColumn get value => text()();

  /// 设置类型：string, int, bool, double, json
  TextColumn get valueType => text()();

  /// 更新时间
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
