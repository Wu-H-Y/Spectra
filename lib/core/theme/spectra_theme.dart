import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'tokens/color_tokens.dart';
import 'tokens/text_tokens.dart';
import 'tokens/app_radius.dart';

/// Spectra 主题配置
///
/// 基于 FlexColorScheme 实现的 Material 3 主题系统，
/// 提供深色和浅色两种主题模式。
///
/// ## 设计特点
/// - **深色主题**: Cyberpunk 风格，Neon Glow 效果
/// - **浅色主题**: Tech Refined 风格，独立配色方案
/// - **字体**: Orbitron (Display) + Noto Sans SC (Body) + JetBrains Mono (Code)
class SpectraTheme {
  SpectraTheme._();

  // ============ 深色主题（Spectra 默认） ============

  /// 深色主题 - Cyberpunk 风格
  ///
  /// 配色：Cyber Cyan + Electric Violet + Neon Pink
  /// 背景：Deep Void (#0B0E14)
  static ThemeData get dark {
    final baseTheme = FlexThemeData.dark(
      colors: const FlexSchemeColor(
        primary: ColorTokens.cyberCyan,
        primaryContainer: ColorTokens.cyberCyanContainer,
        secondary: ColorTokens.electricViolet,
        secondaryContainer: ColorTokens.electricVioletContainer,
        tertiary: ColorTokens.neonPink,
        tertiaryContainer: ColorTokens.neonPinkContainer,
        appBarColor: ColorTokens.electricViolet,
        error: ColorTokens.error,
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
        defaultRadius: AppRadius.lg,
        thinBorderWidth: 1.5,
        // 输入框样式：底部发光线
        inputDecoratorBorderType: FlexInputBorderType.underline,
        inputDecoratorUnfocusedBorderIsColored: false,
        // FAB 样式
        fabUseShape: true,
        fabAlwaysCircular: true,
        // Card 样式
        cardElevation: 2,
      ),
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      // 使用新的字体令牌系统
      textTheme: TextTokens.buildDarkTextTheme(),
    );

    // 自定义 scaffold 背景色
    return baseTheme.copyWith(
      scaffoldBackgroundColor: ColorTokens.deepVoid,
    );
  }

  // ============ 浅色主题 ============

  /// 浅色主题 - Tech Refined 风格
  ///
  /// 独立配色方案，非深色主题降级版
  /// 配色：Digital Teal + Deep Indigo + Vibrant Rose
  /// 背景：Light Void (#F8FAFC)
  static ThemeData get light {
    final baseTheme = FlexThemeData.light(
      colors: const FlexSchemeColor(
        primary: ColorTokens.digitalTeal,
        primaryContainer: ColorTokens.digitalTealContainer,
        secondary: ColorTokens.deepIndigo,
        secondaryContainer: ColorTokens.deepIndigoContainer,
        tertiary: ColorTokens.vibrantRose,
        tertiaryContainer: ColorTokens.vibrantRoseContainer,
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
        defaultRadius: AppRadius.lg,
        inputDecoratorBorderType: FlexInputBorderType.underline,
        inputDecoratorUnfocusedBorderIsColored: false,
        // Card 样式 - 浅色主题使用柔和阴影
        cardElevation: 1,
      ),
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      // 使用新的字体令牌系统
      textTheme: TextTokens.buildLightTextTheme(),
    );

    // 自定义 scaffold 背景色
    return baseTheme.copyWith(
      scaffoldBackgroundColor: ColorTokens.lightVoid,
    );
  }
}
