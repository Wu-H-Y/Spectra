import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/pipeline_node.dart';

part 'detail_config.freezed.dart';
part 'detail_config.g.dart';

/// 详情页配置。
///
/// 用于提取作品/内容的详细信息。
@freezed
sealed class DetailConfig with _$DetailConfig {
  const factory DetailConfig({
    /// 详情字段提取 Pipeline。
    required Map<String, Pipeline> fields,

    /// 详情页 URL 模板 (支持 {{id}} 变量)。
    String? url,

    /// 从列表项获取详情 URL 的选择器 (如果不使用 URL 模板)。
    String? urlFromList,
  }) = _DetailConfig;

  factory DetailConfig.fromJson(Map<String, dynamic> json) =>
      _$DetailConfigFromJson(json);
}
