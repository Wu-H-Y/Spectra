// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $favoritesRoute,
  $discoverRoute,
  $searchRoute,
  $settingsRoute,
  $settingsAppearanceRoute,
  $settingsDataRoute,
  $settingsPlaybackRoute,
  $rulesExecuteRoute,
];

RouteBase get $favoritesRoute =>
    GoRouteData.$route(path: '/', factory: $FavoritesRoute._fromState);

mixin $FavoritesRoute on GoRouteData {
  static FavoritesRoute _fromState(GoRouterState state) =>
      const FavoritesRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $discoverRoute =>
    GoRouteData.$route(path: '/discover', factory: $DiscoverRoute._fromState);

mixin $DiscoverRoute on GoRouteData {
  static DiscoverRoute _fromState(GoRouterState state) => const DiscoverRoute();

  @override
  String get location => GoRouteData.$location('/discover');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $searchRoute =>
    GoRouteData.$route(path: '/search', factory: $SearchRoute._fromState);

mixin $SearchRoute on GoRouteData {
  static SearchRoute _fromState(GoRouterState state) => const SearchRoute();

  @override
  String get location => GoRouteData.$location('/search');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsRoute =>
    GoRouteData.$route(path: '/settings', factory: $SettingsRoute._fromState);

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsAppearanceRoute => GoRouteData.$route(
  path: '/settings/appearance',
  factory: $SettingsAppearanceRoute._fromState,
);

mixin $SettingsAppearanceRoute on GoRouteData {
  static SettingsAppearanceRoute _fromState(GoRouterState state) =>
      const SettingsAppearanceRoute();

  @override
  String get location => GoRouteData.$location('/settings/appearance');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsDataRoute => GoRouteData.$route(
  path: '/settings/data',
  factory: $SettingsDataRoute._fromState,
);

mixin $SettingsDataRoute on GoRouteData {
  static SettingsDataRoute _fromState(GoRouterState state) =>
      const SettingsDataRoute();

  @override
  String get location => GoRouteData.$location('/settings/data');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsPlaybackRoute => GoRouteData.$route(
  path: '/settings/playback',
  factory: $SettingsPlaybackRoute._fromState,
);

mixin $SettingsPlaybackRoute on GoRouteData {
  static SettingsPlaybackRoute _fromState(GoRouterState state) =>
      const SettingsPlaybackRoute();

  @override
  String get location => GoRouteData.$location('/settings/playback');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rulesExecuteRoute => GoRouteData.$route(
  path: '/rules-execute',
  factory: $RulesExecuteRoute._fromState,
);

mixin $RulesExecuteRoute on GoRouteData {
  static RulesExecuteRoute _fromState(GoRouterState state) =>
      const RulesExecuteRoute();

  @override
  String get location => GoRouteData.$location('/rules-execute');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 路由 Provider
///
/// 提供全局 GoRouter 实例，支持：
/// - 类型安全路由
/// - 深度链接
/// - 路由守卫
/// - Talker 路由日志

@ProviderFor(router)
final routerProvider = RouterProvider._();

/// 路由 Provider
///
/// 提供全局 GoRouter 实例，支持：
/// - 类型安全路由
/// - 深度链接
/// - 路由守卫
/// - Talker 路由日志

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// 路由 Provider
  ///
  /// 提供全局 GoRouter 实例，支持：
  /// - 类型安全路由
  /// - 深度链接
  /// - 路由守卫
  /// - Talker 路由日志
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$routerHash() => r'1db0f611e1d2a1dcae5e1daf350c379b66ea319f';
