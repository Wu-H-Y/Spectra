import 'dart:ui';

import 'package:flutter/material.dart';

import 'color_tokens.dart';
import 'app_radius.dart';

/// Spectra 视觉效果令牌
///
/// 提供标准化的视觉效果，支持深色/浅色主题自适应。
///
/// ## 性能注意事项
///
/// ### Backdrop Blur (背景模糊)
/// - **性能影响**: 高
/// - **建议**: 仅在静态元素上使用，避免在列表项中使用
/// - **低端设备**: 考虑提供简化版本或完全禁用
///
/// ### Neon Glow (霓虹发光)
/// - **性能影响**: 中等
/// - **建议**: 限制在少量静态元素上使用
/// - **注意**: 过多的阴影效果会影响渲染性能
///
/// ### Soft Shadow (柔和阴影)
/// - **性能影响**: 低
/// - **建议**: 安全用于大多数场景
class AppEffects {
  AppEffects._();

  // ============ 深色主题效果 ============

  /// Glassmorphism 卡片效果 - 深色主题
  ///
  /// 特点：半透明背景 + 微妙边框
  ///
  /// **性能警告**: 如需添加 backdrop blur，请使用 [glassCardDarkWithBlur]
  static BoxDecoration get glassCardDark => BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: AppRadius.borderRadiusLg,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      );

  /// Glassmorphism 卡片效果 (带模糊) - 深色主题
  ///
  /// **性能警告**: 包含 backdrop blur，性能影响较高
  /// 仅在静态卡片上使用，避免在列表项中使用
  static BoxDecoration glassCardDarkWithBlur({double blurAmount = 10.0}) =>
      BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: AppRadius.borderRadiusLg,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      );

  /// Neon Glow 效果 - 深色主题
  ///
  /// [color] 发光颜色，默认使用 Cyber Cyan
  /// [blurRadius] 模糊半径，默认 20
  /// [spreadRadius] 扩散半径，默认 2
  ///
  /// **性能提示**: 限制在少量静态元素上使用
  static BoxDecoration neonGlow({
    Color? color,
    double blurRadius = 20,
    double spreadRadius = 2,
  }) {
    final glowColor = color ?? ColorTokens.cyberCyan;
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: glowColor.withValues(alpha: 0.3),
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        ),
      ],
    );
  }

  /// Neon Glow 效果 (带背景色) - 深色主题
  ///
  /// 组合了背景色和发光效果
  static BoxDecoration neonGlowCard({
    Color? glowColor,
    Color? backgroundColor,
    double blurRadius = 20,
    double spreadRadius = 2,
  }) {
    final color = glowColor ?? ColorTokens.cyberCyan;
    final bg = backgroundColor ?? Colors.white.withValues(alpha: 0.05);
    return BoxDecoration(
      color: bg,
      borderRadius: AppRadius.borderRadiusLg,
      border: Border.all(
        color: color.withValues(alpha: 0.3),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        ),
      ],
    );
  }

  // ============ 浅色主题效果 ============

  /// Soft Card 效果 - 浅色主题
  ///
  /// 特点：纯白背景 + 柔和阴影
  static BoxDecoration get softCardLight => BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.borderRadiusLg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

  /// Soft Glass 效果 - 浅色主题
  ///
  /// 特点：半透明白色背景 + 柔和阴影
  ///
  /// **性能警告**: 如需添加 backdrop blur，请自行在 ClipRRect 中使用 BackdropFilter
  static BoxDecoration get softGlassLight => BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: AppRadius.borderRadiusLg,
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

  /// Soft Shadow 效果 - 浅色主题
  ///
  /// 仅提供阴影，不设置背景色
  static BoxDecoration get softShadow => BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

  // ============ 主题自适应效果 ============

  /// 主题自适应卡片效果
  ///
  /// 根据当前主题自动选择合适的效果：
  /// - 深色主题: Glassmorphism
  /// - 浅色主题: Soft Shadow
  static BoxDecoration card(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? glassCardDark : softCardLight;
  }

  /// 主题自适应玻璃效果
  ///
  /// 根据当前主题自动选择合适的玻璃效果：
  /// - 深色主题: Glassmorphism
  /// - 浅色主题: Soft Glass
  static BoxDecoration glass(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? glassCardDark : softGlassLight;
  }

  // ============ 通用边框效果 ============

  /// 微妙边框 - 深色主题
  static Border subtleBorderDark() => Border.all(
        color: Colors.white.withValues(alpha: 0.1),
        width: 1,
      );

  /// 微妙边框 - 浅色主题
  static Border subtleBorderLight() => Border.all(
        color: Colors.grey.withValues(alpha: 0.2),
        width: 1,
      );

  /// 主题自适应微妙边框
  static Border subtleBorder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? subtleBorderDark() : subtleBorderLight();
  }
}

/// Backdrop Filter 辅助组件
///
/// 用于创建带模糊效果的容器
///
/// ```dart
/// GlassContainer(
///   blurAmount: 10,
///   child: YourContent(),
/// )
/// ```
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.blurAmount = 10.0,
    this.borderRadius,
    this.padding,
    this.backgroundColor,
  });

  final Widget child;
  final double blurAmount;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ??
        (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.8));
    final radius = borderRadius ?? AppRadius.borderRadiusLg;

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurAmount,
          sigmaY: blurAmount,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
            border: isDark
                ? Border.all(color: Colors.white.withValues(alpha: 0.1))
                : Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: child,
        ),
      ),
    );
  }
}
