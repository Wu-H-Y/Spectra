import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spectra/features/discover/presentation/pages/discover_page.dart';
import 'package:spectra/features/favorites/presentation/pages/favorites_page.dart';
import 'package:spectra/features/rules_execute/presentation/pages/rules_execute_page.dart';
import 'package:spectra/features/search/presentation/pages/search_page.dart';
import 'package:spectra/features/settings/presentation/pages/settings_appearance_page.dart';
import 'package:spectra/features/settings/presentation/pages/settings_data_page.dart';
import 'package:spectra/features/settings/presentation/pages/settings_page.dart';
import 'package:spectra/features/settings/presentation/pages/settings_playback_page.dart';
import 'package:spectra/l10n/generated/l10n.dart';
import 'package:spectra/shared/providers/talker_provider.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'app_router.g.dart';

/// 路由 Provider
///
/// 提供全局 GoRouter 实例，支持：
/// - 类型安全路由
/// - 深度链接
/// - 路由守卫
/// - Talker 路由日志
@riverpod
GoRouter router(Ref ref) {
  final talker = ref.watch(talkerProvider);

  return GoRouter(
    routes: $appRoutes,
    errorBuilder: (context, state) => NotFoundPage(error: state.error),
    debugLogDiagnostics: true,
    initialLocation: '/',
    observers: [TalkerRouteObserver(talker)],
  );
}

/// 收藏页路由（首页）
///
/// 应用根路由，展示用户收藏的多媒体内容
@TypedGoRoute<FavoritesRoute>(path: '/')
class FavoritesRoute extends GoRouteData with $FavoritesRoute {
  /// 创建收藏页路由实例
  const FavoritesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FavoritesPage();
  }
}

/// 发现页路由
///
/// 通过选择不同规则展示不同的发现数据
@TypedGoRoute<DiscoverRoute>(path: '/discover')
class DiscoverRoute extends GoRouteData with $DiscoverRoute {
  /// 创建发现页路由实例
  const DiscoverRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DiscoverPage();
  }
}

/// 搜索页路由
///
/// 全局搜索功能
@TypedGoRoute<SearchRoute>(path: '/search')
class SearchRoute extends GoRouteData with $SearchRoute {
  /// 创建搜索页路由实例
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SearchPage();
  }
}

/// 设置路由
///
/// 导航到设置页面
@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData with $SettingsRoute {
  /// 创建设置路由实例
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

/// 外观设置路由
@TypedGoRoute<SettingsAppearanceRoute>(path: '/settings/appearance')
class SettingsAppearanceRoute extends GoRouteData with $SettingsAppearanceRoute {
  const SettingsAppearanceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsAppearancePage();
  }
}

/// 数据存储设置路由
@TypedGoRoute<SettingsDataRoute>(path: '/settings/data')
class SettingsDataRoute extends GoRouteData with $SettingsDataRoute {
  const SettingsDataRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsDataPage();
  }
}

/// 播放预览设置路由
@TypedGoRoute<SettingsPlaybackRoute>(path: '/settings/playback')
class SettingsPlaybackRoute extends GoRouteData with $SettingsPlaybackRoute {
  const SettingsPlaybackRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPlaybackPage();
  }
}

/// 运行时工作区路由
///
/// 导航到 Flutter 侧 runtime workspace 页面，用于统一查看：
/// - 服务器状态
/// - session 上下文
/// - 活跃预览
/// - 运行结果
/// - 节点事件时间线
@TypedGoRoute<RulesExecuteRoute>(path: '/rules-execute')
class RulesExecuteRoute extends GoRouteData with $RulesExecuteRoute {
  /// 创建运行时工作区路由实例
  const RulesExecuteRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RulesExecutePage();
  }
}

/// 404 错误页面
///
/// 当用户导航到不存在的路由时显示此页面
class NotFoundPage extends StatelessWidget {
  /// 创建 404 错误页面
  ///
  /// [error] 可选的错误信息，将显示在页面上
  const NotFoundPage({super.key, this.error});

  /// 路由错误信息
  final Exception? error;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pageNotFound),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.pageNotFound,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (error != null) ...[
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: Text(l10n.goHome),
            ),
          ],
        ),
      ),
    );
  }
}
