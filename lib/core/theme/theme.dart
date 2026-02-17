/// Spectra 主题系统
///
/// 导出所有主题相关的类和常量。
library;

import 'package:flutter/material.dart';

export 'app_colors.dart';
export 'app_breakpoints.dart';
export 'app_durations.dart';
export 'app_spacing.dart';
export 'spectra_theme.dart';

/// 主题模式枚举
enum AppThemeMode {
  /// 跟随系统
  system,

  /// 浅色模式
  light,

  /// 深色模式
  dark,
}

/// AppThemeMode 扩展方法
extension AppThemeModeExtension on AppThemeMode {
  /// 转换为 Flutter ThemeMode
  ThemeMode get flutterThemeMode {
    switch (this) {
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
