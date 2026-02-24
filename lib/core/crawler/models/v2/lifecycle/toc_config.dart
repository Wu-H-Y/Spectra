import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/v2/lifecycle/pagination.dart';
import 'package:spectra/core/crawler/models/v2/pipeline_node.dart';

part 'toc_config.freezed.dart';
part 'toc_config.g.dart';

/// 目录/章节配置。
///
/// 用于提取章节列表。
@freezed
sealed class TocConfig with _$TocConfig {
  const factory TocConfig({
    /// 章节列表容器选择器。
    required String container,

    /// 章节字段提取 Pipeline。
    required Map<String, Pipeline> fields,

    /// 目录页 URL 模板 (支持 {{id}} 变量)。
    String? url,

    /// 是否为逆序 (最新在前)。
    @Default(false) bool reverseOrder,

    /// 分页配置 (多页目录)。
    PaginationConfig? pagination,
  }) = _TocConfig;

  factory TocConfig.fromJson(Map<String, dynamic> json) =>
      _$TocConfigFromJson(json);
}
