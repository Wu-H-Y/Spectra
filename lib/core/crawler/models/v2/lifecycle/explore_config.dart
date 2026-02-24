import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/v2/lifecycle/pagination.dart';
import 'package:spectra/core/crawler/models/v2/pipeline_node.dart';

part 'explore_config.freezed.dart';
part 'explore_config.g.dart';

/// 分类/筛选菜单项。
@freezed
sealed class ExploreMenu with _$ExploreMenu {
  const factory ExploreMenu({
    /// 菜单名称。
    required String name,

    /// 菜单标识 (用于 {{category}} 变量)。
    required String key,

    /// 菜单选项。
    required List<ExploreOption> options,
  }) = _ExploreMenu;

  factory ExploreMenu.fromJson(Map<String, dynamic> json) =>
      _$ExploreMenuFromJson(json);
}

/// 菜单选项。
@freezed
sealed class ExploreOption with _$ExploreOption {
  const factory ExploreOption({
    /// 选项名称。
    required String name,

    /// 选项值 (用于 URL 模板)。
    required String value,
  }) = _ExploreOption;

  factory ExploreOption.fromJson(Map<String, dynamic> json) =>
      _$ExploreOptionFromJson(json);
}

/// 发现页/分类浏览配置。
///
/// 用于配置分类浏览和筛选功能。
@freezed
sealed class ExploreConfig with _$ExploreConfig {
  const factory ExploreConfig({
    /// 请求 URL 模板 (支持 {{category}}, {{page}} 变量)。
    required String url,

    /// 列表项提取 Pipeline。
    required Map<String, Pipeline> list,

    /// 分类/筛选菜单。
    List<ExploreMenu>? menus,

    /// 分页配置。
    PaginationConfig? pagination,
  }) = _ExploreConfig;

  factory ExploreConfig.fromJson(Map<String, dynamic> json) =>
      _$ExploreConfigFromJson(json);
}
