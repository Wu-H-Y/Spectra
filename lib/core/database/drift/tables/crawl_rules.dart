import 'package:drift/drift.dart';

/// 爬虫规则类型
enum CrawlRuleType {
  /// 视频规则
  video,

  /// 音乐规则
  music,

  /// 小说规则
  novel,

  /// 漫画规则
  comic,

  /// 图片规则
  image,

  /// 音频规则
  audio,

  /// RSS 规则
  rss,

  /// 通用规则
  generic,
}

/// 爬虫规则表
///
/// 存储自定义爬虫规则配置，支持节点化流程定义
class CrawlRules extends Table {
  /// 规则 ID
  IntColumn get id => integer().autoIncrement()();

  /// 规则唯一标识符 (用于导入导出和分享)
  TextColumn get ruleId => text().unique().withLength(min: 1, max: 64)();

  /// 规则名称
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// 规则描述
  TextColumn get description => text().nullable().withLength(max: 500)();

  /// 规则类型 (video, music, novel, comic, image, audio, rss, generic)
  IntColumn get type => integer().map(const CrawlRuleTypeConverter())();

  /// 目标网站 URL 模式
  TextColumn get pattern => text()();

  /// 规则版本号 (语义化版本)
  TextColumn get version => text().withDefault(const Constant('1.0.0'))();

  /// 规则配置 (JSON 格式,包含 flows, nodes, edges, display)
  TextColumn get config => text()();

  /// 全局配置 (JSON 格式,包含 baseUrl, headers, variables)
  TextColumn get globalConfig => text().nullable()();

  /// 展示配置 (JSON 格式,包含字段映射和模板配置)
  TextColumn get displayConfig => text().nullable()();

  /// 规则来源 (official/third_party/user)
  TextColumn get source => text().withDefault(const Constant('user'))();

  /// 是否启用
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  /// 规则图标 URL
  TextColumn get iconUrl => text().nullable()();

  /// 规则作者
  TextColumn get author => text().nullable().withLength(max: 50)();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// 更新时间
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// CrawlRuleType 转换器
///
/// 用于将 [CrawlRuleType] 枚举与数据库整数相互转换
class CrawlRuleTypeConverter extends TypeConverter<CrawlRuleType, int> {
  /// 创建转换器实例
  const CrawlRuleTypeConverter();

  @override
  CrawlRuleType fromSql(int fromDb) {
    // 兼容旧版本: 如果索引超出范围，返回 generic
    if (fromDb < 0 || fromDb >= CrawlRuleType.values.length) {
      return CrawlRuleType.generic;
    }
    return CrawlRuleType.values[fromDb];
  }

  @override
  int toSql(CrawlRuleType value) {
    return value.index;
  }
}

/// 内容缓存表
///
/// 缓存采集的内容结果，支持快速查询和离线访问
class CachedContent extends Table {
  /// 缓存 ID
  IntColumn get id => integer().autoIncrement()();

  /// 内容唯一标识符 (用于多源关联)
  TextColumn get contentId => text().withLength(max: 128)();

  /// 关联的规则 ID
  IntColumn get ruleId => integer().references(CrawlRules, #id)();

  /// 媒体类型
  IntColumn get mediaType => integer().map(const CrawlRuleTypeConverter())();

  /// 内容标题
  TextColumn get title => text()();

  /// 封面 URL
  TextColumn get coverUrl => text().nullable()();

  /// 作者
  TextColumn get author => text().nullable()();

  /// 描述
  TextColumn get description => text().nullable()();

  /// 原始数据 (JSON 格式)
  TextColumn get rawData => text()();

  /// 缓存时间
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();

  /// 过期时间
  DateTimeColumn get expiresAt => dateTime().nullable()();
}
