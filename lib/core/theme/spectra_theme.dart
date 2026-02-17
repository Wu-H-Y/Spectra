import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Spectra 主题配置
///
/// 基于 FlexColorScheme 实现的 Material 3 主题系统，
/// 提供深色和浅色两种主题模式。
class SpectraTheme {
  SpectraTheme._();

  // ============ 浅色主题 ============

  static ThemeData get light {
    return FlexThemeData.light(
      scheme: FlexScheme.materialBaseline,
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
        defaultRadius: 12.0,
        inputDecoratorBorderType: FlexInputBorderType.underline,
        inputDecoratorUnfocusedBorderIsColored: false,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
    );
  }

  // ============ 深色主题（Spectra 默认） ============

  static ThemeData get dark {
    return FlexThemeData.dark(
      colors: const FlexSchemeColor(
        primary: AppColors.cyberCyan,
        primaryContainer: AppColors.cyberCyanContainer,
        secondary: AppColors.electricViolet,
        secondaryContainer: AppColors.electricVioletContainer,
        tertiary: AppColors.neonPink,
        tertiaryContainer: AppColors.neonPinkContainer,
        appBarColor: AppColors.electricViolet,
        error: AppColors.error,
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useMaterial3Typography: true,
        useM2StyleDividerInM3: true,
        defaultRadius: 16.0,
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
      fontFamily: GoogleFonts.inter().fontFamily,
      // 自定义文字主题：标题使用 Orbitron 字体
      textTheme: _buildDarkTextTheme(),
    );
  }

  /// 构建深色主题文字主题
  static TextTheme _buildDarkTextTheme() {
    return TextTheme(
      // 大标题 - 使用 Orbitron 科幻字体
      displayLarge: GoogleFonts.orbitron(
        fontSize: 57,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.25,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.orbitron(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displaySmall: GoogleFonts.orbitron(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      // 标题 - 使用 Orbitron 字体
      headlineLarge: GoogleFonts.orbitron(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.orbitron(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineSmall: GoogleFonts.orbitron(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      // 小标题
      titleLarge: GoogleFonts.orbitron(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      // 正文 - 使用 Inter 字体
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.white70,
      ),
      // 标签
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
    );
  }
}
