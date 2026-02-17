import 'package:flutter/material.dart';

/// Spectra 圆角设计令牌
///
/// 提供标准化的圆角值，确保应用内一致的形状语言。
class AppRadius {
  AppRadius._();

  // ============ 基础圆角值 ============

  /// 小圆角 - 8dp
  /// 用于：Chips, Tags, Small buttons
  static const double sm = 8;

  /// 中等圆角 - 12dp
  /// 用于：Buttons, Inputs, Medium cards
  static const double md = 12;

  /// 大圆角 - 16dp
  /// 用于：Cards, Dialogs, Large containers
  static const double lg = 16;

  /// 超大圆角 - 24dp
  /// 用于：Modals, Bottom sheets, Feature cards
  static const double xl = 24;

  /// 全圆角 - 9999dp
  /// 用于：Circular avatars, Pills, Fab
  static const double full = 9999;

  // ============ Radius 快捷方式 ============

  /// 小圆角 Radius
  static Radius get radiusSm => const Radius.circular(sm);

  /// 中等圆角 Radius
  static Radius get radiusMd => const Radius.circular(md);

  /// 大圆角 Radius
  static Radius get radiusLg => const Radius.circular(lg);

  /// 超大圆角 Radius
  static Radius get radiusXl => const Radius.circular(xl);

  /// 全圆角 Radius
  static Radius get radiusFull => const Radius.circular(full);

  // ============ BorderRadius 快捷方式 ============

  /// 小圆角 BorderRadius
  static BorderRadius get borderRadiusSm => BorderRadius.circular(sm);

  /// 中等圆角 BorderRadius
  static BorderRadius get borderRadiusMd => BorderRadius.circular(md);

  /// 大圆角 BorderRadius
  static BorderRadius get borderRadiusLg => BorderRadius.circular(lg);

  /// 超大圆角 BorderRadius
  static BorderRadius get borderRadiusXl => BorderRadius.circular(xl);

  /// 全圆角 BorderRadius
  static BorderRadius get borderRadiusFull => BorderRadius.circular(full);

  // ============ RoundedRectangleBorder 快捷方式 ============

  /// 小圆角 RoundedRectangleBorder
  static RoundedRectangleBorder get roundedSm =>
      RoundedRectangleBorder(borderRadius: borderRadiusSm);

  /// 中等圆角 RoundedRectangleBorder
  static RoundedRectangleBorder get roundedMd =>
      RoundedRectangleBorder(borderRadius: borderRadiusMd);

  /// 大圆角 RoundedRectangleBorder
  static RoundedRectangleBorder get roundedLg =>
      RoundedRectangleBorder(borderRadius: borderRadiusLg);

  /// 超大圆角 RoundedRectangleBorder
  static RoundedRectangleBorder get roundedXl =>
      RoundedRectangleBorder(borderRadius: borderRadiusXl);
}
