import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/selector.dart';
import 'package:spectra/core/crawler/models/transform.dart';

part 'field_mapping.freezed.dart';
part 'field_mapping.g.dart';

/// 用于提取和转换数据的字段映射。
@freezed
sealed class FieldMapping with _$FieldMapping {
  const factory FieldMapping({
    /// 输出中的目标字段名。
    required String field,

    /// 用于提取值的选择器。
    required Selector selector,

    /// 提取失败时的默认值。
    String? defaultValue,

    /// 要应用的转换列表。
    List<Transform>? transforms,

    /// 此字段是否为必需。
    @Default(false) bool required,
  }) = _FieldMapping;

  factory FieldMapping.fromJson(Map<String, dynamic> json) =>
      _$FieldMappingFromJson(json);
}
