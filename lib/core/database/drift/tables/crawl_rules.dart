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
}

/// 爬虫规则表
///
/// 存储自定义爬虫规则配置
class CrawlRules extends Table {
  /// 规则 ID
  IntColumn get id => integer().autoIncrement()();

  /// 规则名称
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// 规则类型 (video, music, novel, comic, image)
  IntColumn get type => integer().map(const CrawlRuleTypeConverter())();

  /// 目标网站 URL 模式
  TextColumn get pattern => text()();

  /// 规则配置 (JSON 格式)
  TextColumn get config => text()();

  /// 是否启用
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

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
    return CrawlRuleType.values[fromDb];
  }

  @override
  int toSql(CrawlRuleType value) {
    return value.index;
  }
}
