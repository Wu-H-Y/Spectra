// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 持久化的主题模式 Provider
///
/// 将主题模式保存到 Hive，应用重启后恢复

@ProviderFor(PersistedThemeMode)
final persistedThemeModeProvider = PersistedThemeModeProvider._();

/// 持久化的主题模式 Provider
///
/// 将主题模式保存到 Hive，应用重启后恢复
final class PersistedThemeModeProvider
    extends $NotifierProvider<PersistedThemeMode, AppThemeMode> {
  /// 持久化的主题模式 Provider
  ///
  /// 将主题模式保存到 Hive，应用重启后恢复
  PersistedThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'persistedThemeModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$persistedThemeModeHash();

  @$internal
  @override
  PersistedThemeMode create() => PersistedThemeMode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppThemeMode>(value),
    );
  }
}

String _$persistedThemeModeHash() =>
    r'65fe5964f4d5352d1819ea68ec0dfa3feffb6368';

/// 持久化的主题模式 Provider
///
/// 将主题模式保存到 Hive，应用重启后恢复

abstract class _$PersistedThemeMode extends $Notifier<AppThemeMode> {
  AppThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppThemeMode, AppThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppThemeMode, AppThemeMode>,
              AppThemeMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// 持久化的语言 Provider
///
/// 将语言设置保存到 Hive，应用重启后恢复

@ProviderFor(PersistedLocale)
final persistedLocaleProvider = PersistedLocaleProvider._();

/// 持久化的语言 Provider
///
/// 将语言设置保存到 Hive，应用重启后恢复
final class PersistedLocaleProvider
    extends $NotifierProvider<PersistedLocale, Locale> {
  /// 持久化的语言 Provider
  ///
  /// 将语言设置保存到 Hive，应用重启后恢复
  PersistedLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'persistedLocaleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$persistedLocaleHash();

  @$internal
  @override
  PersistedLocale create() => PersistedLocale();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$persistedLocaleHash() => r'57e3541da291ba5e217f1f2a485b272167859116';

/// 持久化的语言 Provider
///
/// 将语言设置保存到 Hive，应用重启后恢复

abstract class _$PersistedLocale extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
