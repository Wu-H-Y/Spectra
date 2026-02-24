import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/v2/lifecycle/pagination.dart';
import 'package:spectra/core/crawler/models/v2/pipeline_node.dart';

part 'search_config.freezed.dart';
part 'search_config.g.dart';

/// 搜索配置。
///
/// 用于配置关键词搜索功能。
@freezed
sealed class SearchConfig with _$SearchConfig {
  const factory SearchConfig({
    /// 搜索 URL 模板 (支持 {{key}}, {{page}} 变量)。
    required String url,

    /// 搜索结果列表提取 Pipeline。
    required Map<String, Pipeline> list,

    /// 分页配置。
    PaginationConfig? pagination,

    /// URL 编码方式。
    @Default(UrlEncoding.utf8) UrlEncoding encoding,
  }) = _SearchConfig;

  factory SearchConfig.fromJson(Map<String, dynamic> json) =>
      _$SearchConfigFromJson(json);
}

/// URL 编码方式。
enum UrlEncoding {
  /// UTF-8 编码。
  utf8,

  /// GBK 编码。
  gbk,

  /// GB2312 编码。
  gb2312,
}
