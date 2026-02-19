import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spectra/features/home/presentation/pages/home_page.dart';
import 'package:spectra/features/settings/presentation/pages/settings_page.dart';
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

/// 首页路由
///
/// 应用的根路由，导航到首页
@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData with $HomeRoute {
  /// 创建首页路由实例
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
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
