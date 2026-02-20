import 'package:freezed_annotation/freezed_annotation.dart';

part 'transform.freezed.dart';
part 'transform.g.dart';

/// 数据转换的转换类型。
@JsonEnum()
enum TransformType {
  /// 移除首尾空白。
  trim,

  /// 解析为数字。
  number,

  /// 解析为日期/时间。
  date,

  /// 规范化 URL（解析相对 URL）。
  url,

  /// 正则替换。
  regex,

  /// 字符串替换。
  replace,

  /// 转换为小写。
  lowercase,

  /// 转换为大写。
  uppercase,

  /// 提取子字符串（起始、结束索引）。
  substring,

  /// 按分隔符分割字符串。
  split,

  /// 用分隔符连接数组。
  join,

  /// 映射值（查找/替换字典）。
  map,

  /// 解析 JSON 字符串。
  parseJson,

  /// 带后缀格式化数字（1K、1M 等）。
  formatNumber,
}

/// 数据转换配置。
@freezed
sealed class Transform with _$Transform {
  const factory Transform({
    /// 转换类型。
    required TransformType type,

    /// 转换参数（根据类型而异）。
    /// - regex: 模式（带可选替换）
    /// - replace: {find: string, replace: string}
    /// - date: 格式字符串（例如 "yyyy-MM-dd"）
    /// - url: 用于解析相对 URL 的基础 URL
    /// - substring: {start: int, end: int?}
    /// - split: 分隔符
    /// - join: 分隔符
    /// - map: {key1: value1, key2: value2}
    dynamic params,
  }) = _Transform;

  factory Transform.fromJson(Map<String, dynamic> json) =>
      _$TransformFromJson(json);
}
