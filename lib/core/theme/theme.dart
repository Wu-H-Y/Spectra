/// Spectra 主题系统
///
/// 导出所有主题相关的类和常量。
///
/// ## 使用指南
///
/// ### 主题访问
/// ```dart
/// Theme.of(context).colorScheme.primary  // 当前主题的主色
/// Theme.of(context).textTheme.bodyLarge  // 当前主题的正文样式
/// ```
///
/// ### 设计令牌
/// ```dart
/// ColorTokens.cyberCyan      // 核心品牌色
/// AppSpacing.md              // 间距值
/// AppRadius.lg               // 圆角值
/// AppDurations.normal        // 动画时长
/// ```
///
/// ### 视觉效果
/// ```dart
/// AppEffects.card(context)   // 主题自适应卡片效果
/// AppEffects.neonGlow()      // 霓虹发光效果
/// ```
library;

import 'package:flutter/material.dart';

// Core Theme
export 'spectra_theme.dart';

// Design Tokens
export 'tokens/color_tokens.dart';
export 'tokens/app_radius.dart';
export 'tokens/text_tokens.dart';
export 'tokens/effect_tokens.dart';

// Other Tokens
export 'app_breakpoints.dart';
export 'app_durations.dart';
export 'app_spacing.dart';

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
