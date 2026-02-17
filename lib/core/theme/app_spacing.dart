import 'package:flutter/material.dart';

/// Spectra 间距设计令牌
///
/// 提供标准化的间距值，确保应用内一致的布局。
class AppSpacing {
  AppSpacing._();

  // ============ 基础间距值 ============

  /// 超小间距 - 4dp
  static const double xs = 4;

  /// 小间距 - 8dp
  static const double sm = 8;

  /// 中等间距 - 16dp (默认)
  static const double md = 16;

  /// 大间距 - 24dp
  static const double lg = 24;

  /// 超大间距 - 32dp
  static const double xl = 32;

  /// 特大间距 - 48dp
  static const double xxl = 48;

  // ============ EdgeInsets 快捷方式 ============

  /// 所有方向 xs 间距
  static EdgeInsets get paddingXs => const EdgeInsets.all(xs);

  /// 所有方向 sm 间距
  static EdgeInsets get paddingSm => const EdgeInsets.all(sm);

  /// 所有方向 md 间距
  static EdgeInsets get paddingMd => const EdgeInsets.all(md);

  /// 所有方向 lg 间距
  static EdgeInsets get paddingLg => const EdgeInsets.all(lg);

  /// 所有方向 xl 间距
  static EdgeInsets get paddingXl => const EdgeInsets.all(xl);

  // ============ 水平/垂直 EdgeInsets ============

  /// 水平 sm 间距
  static EdgeInsets get horizontalSm =>
      const EdgeInsets.symmetric(horizontal: sm);

  /// 水平 md 间距
  static EdgeInsets get horizontalMd =>
      const EdgeInsets.symmetric(horizontal: md);

  /// 水平 lg 间距
  static EdgeInsets get horizontalLg =>
      const EdgeInsets.symmetric(horizontal: lg);

  /// 垂直 sm 间距
  static EdgeInsets get verticalSm => const EdgeInsets.symmetric(vertical: sm);

  /// 垂直 md 间距
  static EdgeInsets get verticalMd => const EdgeInsets.symmetric(vertical: md);

  /// 垂直 lg 间距
  static EdgeInsets get verticalLg => const EdgeInsets.symmetric(vertical: lg);

  // ============ SizedBox 快捷方式 ============

  /// 水平 sm 间距
  static SizedBox get horizontalGapSm => const SizedBox(width: sm);

  /// 水平 md 间距
  static SizedBox get horizontalGapMd => const SizedBox(width: md);

  /// 水平 lg 间距
  static SizedBox get horizontalGapLg => const SizedBox(width: lg);

  /// 垂直 xs 间距
  static SizedBox get verticalGapXs => const SizedBox(height: xs);

  /// 垂直 sm 间距
  static SizedBox get verticalGapSm => const SizedBox(height: sm);

  /// 垂直 md 间距
  static SizedBox get verticalGapMd => const SizedBox(height: md);

  /// 垂直 lg 间距
  static SizedBox get verticalGapLg => const SizedBox(height: lg);
}
