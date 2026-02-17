import 'package:flutter/material.dart';

/// Spectra 核心品牌颜色令牌
///
/// 定义所有主题共用的基础颜色，作为语义颜色的来源。
class ColorTokens {
  ColorTokens._();

  // ============ 深色主题品牌色 ============

  /// Cyber Cyan - 深色主题主色
  /// 用于：Primary 按钮、重要图标、激活状态
  static const Color cyberCyan = Color(0xFF00F2FF);

  /// Cyber Cyan 容器色（深色版本）
  static const Color cyberCyanContainer = Color(0xFF003840);

  /// Electric Violet - 深色主题次色
  /// 用于：Secondary 按钮、装饰元素、渐变
  static const Color electricViolet = Color(0xFF7000FF);

  /// Electric Violet 容器色
  static const Color electricVioletContainer = Color(0xFF2D004D);

  /// Neon Pink - 深色主题强调色
  /// 用于：Tertiary 元素、警告、重要提示
  static const Color neonPink = Color(0xFFFF0055);

  /// Neon Pink 容器色
  static const Color neonPinkContainer = Color(0xFF4D0019);

  /// Deep Void - 深色背景
  /// 用于：Scaffold 背景
  static const Color deepVoid = Color(0xFF0B0E14);

  // ============ 浅色主题品牌色 (Tech Refined) ============

  /// Digital Teal - 浅色主题主色
  /// 用于：Primary 按钮、重要图标
  static const Color digitalTeal = Color(0xFF0891B2);

  /// Digital Teal 容器色
  static const Color digitalTealContainer = Color(0xFFCFFAFE);

  /// Deep Indigo - 浅色主题次色
  /// 用于：Secondary 元素
  static const Color deepIndigo = Color(0xFF6366F1);

  /// Deep Indigo 容器色
  static const Color deepIndigoContainer = Color(0xFFE0E7FF);

  /// Vibrant Rose - 浅色主题强调色
  /// 用于：Tertiary 元素、警告
  static const Color vibrantRose = Color(0xFFE11D48);

  /// Vibrant Rose 容器色
  static const Color vibrantRoseContainer = Color(0xFFFFE4E6);

  /// Light Void - 浅色背景
  /// 用于：Scaffold 背景
  static const Color lightVoid = Color(0xFFF8FAFC);

  // ============ 语义色 ============

  /// 错误色（Material 3 标准）
  static const Color error = Color(0xFFCF6679);

  /// 错误容器色
  static const Color errorContainer = Color(0xFFB3261E);

  /// 成功色
  static const Color success = Color(0xFF4CAF50);

  /// 警告色
  static const Color warning = Color(0xFFFF9800);

  // ============ 深色主题语义色 ============

  /// 深色主题 - Surface 色（卡片、弹窗等）
  static const Color darkSurface = Color(0xFF0F172A);

  /// 深色主题 - Surface 变体色（层级容器）
  static const Color darkSurfaceContainer = Color(0xFF1E293B);

  /// 深色主题 - 轮廓色
  static const Color darkOutline = Color(0xFF334155);

  /// 深色主题 - 轮廓变体色
  static const Color darkOutlineVariant = Color(0xFF475569);

  /// 深色主题 - On Primary 文字色
  static const Color darkOnPrimary = Color(0xFF003840);

  /// 深色主题 - On Secondary 文字色
  static const Color darkOnSecondary = Color(0xFFFFFFFF);

  // ============ 浅色主题语义色 ============

  /// 浅色主题 - Surface 色（卡片、弹窗等）
  static const Color lightSurface = Color(0xFFFFFFFF);

  /// 浅色主题 - Surface 变体色（层级容器）
  static const Color lightSurfaceContainer = Color(0xFFF1F5F9);

  /// 浅色主题 - 轮廓色
  static const Color lightOutline = Color(0xFFE2E8F0);

  /// 浅色主题 - 轮廓变体色
  static const Color lightOutlineVariant = Color(0xFFCBD5E1);

  /// 浅色主题 - On Primary 文字色
  static const Color lightOnPrimary = Color(0xFFFFFFFF);

  /// 浅色主题 - On Secondary 文字色
  static const Color lightOnSecondary = Color(0xFFFFFFFF);

  /// 浅色主题 - On Surface 文字色
  static const Color lightOnSurface = Color(0xFF0F172A);
}
