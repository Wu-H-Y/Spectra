import 'package:flutter/material.dart';

/// Spectra 品牌色彩定义
///
/// 基于赛博朋克风格的配色方案，包含：
/// - Cyber Cyan: 主色调，科技感
/// - Electric Violet: 次色调，神秘感
/// - Neon Pink: 强调色，活力感
/// - Deep Void: 深色背景，沉稳感
class AppColors {
  AppColors._();

  // ============ 品牌核心色 ============

  /// Cyber Cyan - 主色调
  /// 用于：Primary 按钮、重要图标、激活状态
  static const Color cyberCyan = Color(0xFF00F2FF);

  /// Electric Violet - 次色调
  /// 用于：Secondary 按钮、装饰元素、渐变
  static const Color electricViolet = Color(0xFF7000FF);

  /// Neon Pink - 强调色
  /// 用于：Tertiary 元素、警告、重要提示
  static const Color neonPink = Color(0xFFFF0055);

  /// Deep Void - 深色背景
  /// 用于：Scaffold 背景、卡片背景
  static const Color deepVoid = Color(0xFF0B0E14);

  // ============ 派生色（容器色） ============

  /// Cyber Cyan 容器色（深色版本）
  static const Color cyberCyanContainer = Color(0xFF003840);

  /// Electric Violet 容器色（深色版本）
  static const Color electricVioletContainer = Color(0xFF2D004D);

  /// Neon Pink 容器色（深色版本）
  static const Color neonPinkContainer = Color(0xFF4D0019);

  // ============ 浅色主题适配色 ============

  /// 浅色主题主色（降低饱和度以适配浅色背景）
  static const Color primaryLight = Color(0xFF006C7A);

  /// 浅色主题次色（降低饱和度）
  static const Color secondaryLight = Color(0xFF4A00B0);

  // ============ 语义色 ============

  /// 错误色（Material 3 标准）
  static const Color error = Color(0xFFCF6679);

  /// 成功色
  static const Color success = Color(0xFF4CAF50);

  /// 警告色
  static const Color warning = Color(0xFFFF9800);

  // ============ 灰度色 ============

  /// 表面色（卡片、弹窗等）
  static const Color surface = Color(0xFF0F172A);

  /// 表面变体色
  static const Color surfaceVariant = Color(0xFF1E293B);

  /// 轮廓色
  static const Color outline = Color(0xFF334155);

  /// 轮廓变体色
  static const Color outlineVariant = Color(0xFF475569);
}
