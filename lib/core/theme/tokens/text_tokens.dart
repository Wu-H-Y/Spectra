import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Spectra 字体令牌
///
/// 提供标准化的字体配置，支持中文优化。
///
/// ## 字体方案
/// - **Display**: Orbitron (科幻感标题)
/// - **Body**: Noto Sans SC (优秀的中英文混排)
/// - **Code**: JetBrains Mono (现代编程字体)
class TextTokens {
  TextTokens._();

  // ============ 字体常量 ============

  /// Display 字体 - Orbitron
  /// 用于：大标题、品牌标识
  static const String displayFont = 'Orbitron';

  /// Body 字体 - Noto Sans SC
  /// 用于：正文、按钮、标签
  static const String bodyFont = 'Noto Sans SC';

  /// Code 字体 - JetBrains Mono
  /// 用于：代码块、时间戳、版本号
  static const String codeFont = 'JetBrains Mono';

  // ============ 行高配置 ============

  /// 中文文本行高乘数
  /// 中文需要更大的行高以保证可读性
  static const double chineseLineHeight = 1.6;

  /// 英文文本行高乘数
  static const double latinLineHeight = 1.5;

  // ============ Display 文字样式 (Orbitron) ============

  /// Display Large - 57dp, Bold
  static TextStyle displayLarge({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.orbitron(
        fontSize: 57,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.25,
        height: height ?? 1.12,
        color: color,
      );

  /// Display Medium - 45dp, Bold
  static TextStyle displayMedium({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.orbitron(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        height: height ?? 1.16,
        color: color,
      );

  /// Display Small - 36dp, Bold
  static TextStyle displaySmall({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.orbitron(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        height: height ?? 1.22,
        color: color,
      );

  /// Headline Large - 32dp, SemiBold
  static TextStyle headlineLarge({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.orbitron(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: height ?? 1.25,
        color: color,
      );

  /// Headline Medium - 28dp, SemiBold
  static TextStyle headlineMedium({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.orbitron(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: height ?? 1.29,
        color: color,
      );

  /// Headline Small - 24dp, SemiBold
  static TextStyle headlineSmall({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.orbitron(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: height ?? 1.33,
        color: color,
      );

  /// Title Large - 22dp, SemiBold
  static TextStyle titleLarge({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.orbitron(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: height ?? 1.27,
        color: color,
      );

  // ============ Body 文字样式 (Noto Sans SC) ============

  /// Title Medium - 16dp, SemiBold
  static TextStyle titleMedium({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.notoSansSc(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: height ?? chineseLineHeight,
        color: color,
      );

  /// Title Small - 14dp, SemiBold
  static TextStyle titleSmall({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.notoSansSc(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: height ?? chineseLineHeight,
        color: color,
      );

  /// Body Large - 16dp, Regular
  static TextStyle bodyLarge({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.notoSansSc(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: height ?? chineseLineHeight,
        color: color,
      );

  /// Body Medium - 14dp, Regular
  static TextStyle bodyMedium({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.notoSansSc(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: height ?? chineseLineHeight,
        color: color,
      );

  /// Body Small - 12dp, Regular
  static TextStyle bodySmall({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.notoSansSc(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: height ?? chineseLineHeight,
        color: color,
      );

  /// Label Large - 14dp, Medium
  static TextStyle labelLarge({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.notoSansSc(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: height ?? 1.43,
        color: color,
      );

  /// Label Medium - 12dp, Medium
  static TextStyle labelMedium({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.notoSansSc(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: height ?? 1.33,
        color: color,
      );

  /// Label Small - 11dp, Medium
  static TextStyle labelSmall({
    Color? color,
    double? height,
  }) =>
      GoogleFonts.notoSansSc(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: height ?? 1.45,
        color: color,
      );

  // ============ Code 文字样式 (JetBrains Mono) ============

  /// Code Regular - 14dp
  static TextStyle codeRegular({
    Color? color,
    double fontSize = 14,
  }) =>
      GoogleFonts.jetBrainsMono(
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        height: 1.5,
        color: color,
      );

  /// Code Medium - 14dp
  static TextStyle codeMedium({
    Color? color,
    double fontSize = 14,
  }) =>
      GoogleFonts.jetBrainsMono(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: color,
      );

  // ============ TextTheme 构建器 ============

  /// 构建完整的 TextTheme
  ///
  /// [textColor] 主要文字颜色
  /// [secondaryColor] 次要文字颜色 (用于 bodySmall, labelSmall)
  static TextTheme buildTextTheme({
    Color textColor = Colors.white,
    Color? secondaryColor,
  }) {
    final secondary = secondaryColor ?? textColor.withValues(alpha: 0.7);
    return TextTheme(
      displayLarge: displayLarge(color: textColor),
      displayMedium: displayMedium(color: textColor),
      displaySmall: displaySmall(color: textColor),
      headlineLarge: headlineLarge(color: textColor),
      headlineMedium: headlineMedium(color: textColor),
      headlineSmall: headlineSmall(color: textColor),
      titleLarge: titleLarge(color: textColor),
      titleMedium: titleMedium(color: textColor),
      titleSmall: titleSmall(color: textColor),
      bodyLarge: bodyLarge(color: textColor),
      bodyMedium: bodyMedium(color: textColor),
      bodySmall: bodySmall(color: secondary),
      labelLarge: labelLarge(color: textColor),
      labelMedium: labelMedium(color: textColor),
      labelSmall: labelSmall(color: secondary),
    );
  }

  /// 构建深色主题 TextTheme
  static TextTheme buildDarkTextTheme() => buildTextTheme(
        textColor: Colors.white,
        secondaryColor: Colors.white70,
      );

  /// 构建浅色主题 TextTheme
  static TextTheme buildLightTextTheme() => buildTextTheme(
        textColor: const Color(0xFF0F172A),
        secondaryColor: const Color(0xFF64748B),
      );
}

/// TextTheme 中文优化扩展
///
/// 提供针对中文文本优化的样式访问器
extension ChineseTextStyles on TextTheme {
  /// 中文正文样式 - 优化行高
  ///
  /// 返回 bodyLarge 并应用中文优化的行高 (1.6)
  TextStyle? get chineseBody => bodyLarge?.copyWith(height: TextTokens.chineseLineHeight);

  /// 中文次级正文样式 - 优化行高
  TextStyle? get chineseBodyMedium =>
      bodyMedium?.copyWith(height: TextTokens.chineseLineHeight);

  /// 中文小号正文样式 - 优化行高
  TextStyle? get chineseBodySmall =>
      bodySmall?.copyWith(height: TextTokens.chineseLineHeight);

  /// 中文标题样式 - 优化行高
  TextStyle? get chineseTitle => titleMedium?.copyWith(height: TextTokens.chineseLineHeight);

  /// 中文小标题样式 - 优化行高
  TextStyle? get chineseTitleSmall =>
      titleSmall?.copyWith(height: TextTokens.chineseLineHeight);
}

/// 代码样式扩展
extension CodeTextStyles on TextTheme {
  /// 代码块样式
  TextStyle? get code => TextTokens.codeRegular();

  /// 代码块样式 (指定颜色)
  TextStyle codeWithColor([Color? color]) => TextTokens.codeRegular(color: color);
}
