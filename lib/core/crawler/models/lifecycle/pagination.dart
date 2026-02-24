import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.freezed.dart';
part 'pagination.g.dart';

/// 分页类型。
enum PaginationType {
  /// URL 分页。
  url,

  /// 点击分页。
  click,

  /// 无限滚动。
  scroll,
}

/// 分页配置。
@freezed
sealed class PaginationConfig with _$PaginationConfig {
  const factory PaginationConfig({
    /// 分页类型。
    @Default(PaginationType.url) PaginationType type,

    /// 下一页选择器 (type = url)。
    String? nextSelector,

    /// 页码参数名 (type = url)。
    @Default('page') String pageParam,

    /// 起始页码。
    @Default(1) int startPage,

    /// 最大页数。
    int? maxPages,

    /// 加载更多按钮选择器 (type = click)。
    String? loadMoreSelector,

    /// 滚动加载等待时间 (type = scroll)。
    @Default(1000) int scrollWaitMs,
  }) = _PaginationConfig;

  factory PaginationConfig.fromJson(Map<String, dynamic> json) =>
      _$PaginationConfigFromJson(json);
}
