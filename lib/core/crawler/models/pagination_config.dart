import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/selector.dart';

part 'pagination_config.freezed.dart';
part 'pagination_config.g.dart';

/// 分页类型。
@JsonEnum()
enum PaginationType {
  /// 基于 URL 的分页（page=1, page=2 等）。
  url,

  /// 基于点击的分页（"加载更多"按钮）。
  click,

  /// 无限滚动分页。
  infiniteScroll,
}

/// 分页配置。
@freezed
sealed class PaginationConfig with _$PaginationConfig {
  const factory PaginationConfig({
    /// 分页类型。
    required PaginationType type,

    /// 下一页链接的选择器（用于 URL 类型）。
    Selector? nextSelector,

    /// 带页码占位符的 URL 模板（用于 URL 类型）。
    /// 使用 {page} 作为占位符，例如 "list?page={page}"
    String? urlTemplate,

    /// "加载更多"按钮的选择器（用于点击类型）。
    Selector? clickSelector,

    /// 滚动容器选择器（用于无限滚动类型）。
    Selector? scrollContainer,

    /// 最大爬取页数（0 = 无限制）。
    @Default(0) int maxPages,

    /// 页面请求之间的延迟（毫秒）。
    @Default(1000) int delayMs,

    /// 分页后等待内容加载的时间。
    @Default(2000) int waitAfterLoadMs,
  }) = _PaginationConfig;

  factory PaginationConfig.fromJson(Map<String, dynamic> json) =>
      _$PaginationConfigFromJson(json);
}
