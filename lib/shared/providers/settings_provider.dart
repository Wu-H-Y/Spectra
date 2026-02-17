import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/database/hive/hive_service.dart';
import '../../core/database/hive/settings_keys.dart';
import '../../core/theme/theme.dart';

part 'settings_provider.g.dart';

/// 持久化的主题模式 Provider
///
/// 将主题模式保存到 Hive，应用重启后恢复
@riverpod
class PersistedThemeMode extends _$PersistedThemeMode {
  @override
  AppThemeMode build() {
    // 从 Hive 读取保存的主题模式
    final savedMode =
        HiveService.instance.settingsBox.get(
              SettingsKeys.themeMode,
              defaultValue: 'dark',
            )
            as String;

    return _stringToThemeMode(savedMode);
  }

  @override
  set state(AppThemeMode value) {
    super.state = value;
    _persist(value);
  }

  /// 设置主题模式
  void setThemeMode(AppThemeMode mode) {
    state = mode;
  }

  /// 持久化到 Hive
  void _persist(AppThemeMode mode) {
    HiveService.instance.settingsBox.put(
      SettingsKeys.themeMode,
      _themeModeToString(mode),
    );
  }

  /// ThemeMode 转字符串
  String _themeModeToString(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.dark:
        return 'dark';
      case AppThemeMode.light:
        return 'light';
      case AppThemeMode.system:
        return 'system';
    }
  }

  /// 字符串转 ThemeMode
  AppThemeMode _stringToThemeMode(String value) {
    switch (value) {
      case 'light':
        return AppThemeMode.light;
      case 'system':
        return AppThemeMode.system;
      case 'dark':
      default:
        return AppThemeMode.dark;
    }
  }
}

/// 持久化的语言 Provider
///
/// 将语言设置保存到 Hive，应用重启后恢复
@riverpod
class PersistedLocale extends _$PersistedLocale {
  @override
  Locale build() {
    // 从 Hive 读取保存的语言
    final savedLocale =
        HiveService.instance.settingsBox.get(
              SettingsKeys.locale,
              defaultValue: 'en',
            )
            as String;

    return _stringToLocale(savedLocale);
  }

  @override
  set state(Locale value) {
    super.state = value;
    _persist(value);
  }

  /// 设置语言
  void setLocale(Locale locale) {
    state = locale;
  }

  /// 持久化到 Hive
  void _persist(Locale locale) {
    HiveService.instance.settingsBox.put(
      SettingsKeys.locale,
      '${locale.languageCode}_${locale.countryCode ?? ''}',
    );
  }

  /// 字符串转 Locale
  Locale _stringToLocale(String value) {
    final parts = value.split('_');
    if (parts.length >= 2 && parts[1].isNotEmpty) {
      return Locale(parts[0], parts[1]);
    }
    return Locale(parts[0]);
  }
}
