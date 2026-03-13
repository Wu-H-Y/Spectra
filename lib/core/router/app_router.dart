import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spectra/core/i18n/strings.g.dart';
import 'package:spectra/features/discover/presentation/pages/discover_page.dart';
import 'package:spectra/features/favorites/presentation/pages/favorites_page.dart';
import 'package:spectra/features/rules/presentation/pages/rules_page.dart';
import 'package:spectra/features/rules_execute/presentation/pages/rules_execute_page.dart';
import 'package:spectra/features/search/presentation/pages/search_page.dart';
import 'package:spectra/features/settings/presentation/pages/settings_appearance_page.dart';
import 'package:spectra/features/settings/presentation/pages/settings_data_page.dart';
import 'package:spectra/features/settings/presentation/pages/settings_page.dart';
import 'package:spectra/features/settings/presentation/pages/settings_playback_page.dart';
import 'package:spectra/shared/providers/talker_provider.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'app_router.g.dart';

/// 启动时的深度链接路由位置。
final launchRouteLocationProvider = Provider<String?>((_) => null);

/// 规范化规则导入 deep link。
String? normalizeRulesImportDeepLink(Uri uri) {
  if (uri.scheme.toLowerCase() != 'spectra') {
    return null;
  }

  final isRulesImport =
      (uri.host == 'rules' && uri.path == '/import') ||
      uri.path == '/rules/import';
  if (!isRulesImport) {
    return null;
  }

  final importUrl = uri.queryParameters['url'];
  if (importUrl == null || importUrl.trim().isEmpty) {
    return const RulesRoute().location;
  }

  return RulesRoute(url: importUrl).location;
}

/// 从启动参数中解析 deep link 路由位置。
String? resolveLaunchRouteLocation(List<String> args) {
  for (final arg in args.reversed) {
    final uri = Uri.tryParse(arg.trim());
    if (uri == null) {
      continue;
    }

    final normalized = normalizeRulesImportDeepLink(uri);
    if (normalized != null) {
      return normalized;
    }
  }

  return null;
}

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
  final launchRouteLocation = ref.watch(launchRouteLocationProvider);

  return GoRouter(
    routes: $appRoutes,
    errorBuilder: (context, state) => NotFoundPage(error: state.error),
    debugLogDiagnostics: true,
    initialLocation: launchRouteLocation ?? '/',
    observers: [TalkerRouteObserver(talker)],
    redirect: (context, state) {
      final normalized = normalizeRulesImportDeepLink(state.uri);
      if (normalized != null && normalized != state.uri.toString()) {
        return normalized;
      }

      return null;
    },
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

/// 规则管理页路由
///
/// 导航到规则列表与导入管理页面
@TypedGoRoute<RulesRoute>(path: '/rules')
class RulesRoute extends GoRouteData with $RulesRoute {
  /// 创建规则管理页路由实例
  const RulesRoute({this.url});

  /// 预填充的规则 URL。
  final String? url;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RulesPage(initialImportUrl: url);
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
class SettingsAppearanceRoute extends GoRouteData
    with $SettingsAppearanceRoute {
  /// 构建外观设置页面
  const SettingsAppearanceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsAppearancePage();
  }
}

/// 数据存储设置路由
@TypedGoRoute<SettingsDataRoute>(path: '/settings/data')
class SettingsDataRoute extends GoRouteData with $SettingsDataRoute {
  /// 构建数据存储设置页面
  const SettingsDataRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsDataPage();
  }
}

/// 播放预览设置路由
@TypedGoRoute<SettingsPlaybackRoute>(path: '/settings/playback')
class SettingsPlaybackRoute extends GoRouteData with $SettingsPlaybackRoute {
  /// 构建播放预览设置页面
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
    final t = context.t;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.pageNotFound),
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
              t.pageNotFound,
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
              child: Text(t.goHome),
            ),
          ],
        ),
      ),
    );
  }
}
