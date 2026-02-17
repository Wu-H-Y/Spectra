import 'package:flutter/material.dart';

/// Spectra 响应式断点设计令牌
///
/// 提供标准化的断点值，用于构建响应式布局。
class AppBreakpoints {
  AppBreakpoints._();

  // ============ 断点值 ============

  /// 移动端断点 - 0dp
  ///
  /// 用于：手机竖屏
  static const double mobile = 0;

  /// 平板断点 - 600dp
  ///
  /// 用于：手机横屏、小平板
  static const double tablet = 600;

  /// 桌面断点 - 900dp
  ///
  /// 用于：平板横屏、小桌面
  static const double desktop = 900;

  /// 大桌面断点 - 1200dp
  ///
  /// 用于：大屏幕桌面
  static const double desktopLarge = 1200;

  // ============ 布局列数 ============

  /// 移动端列数
  static const int mobileColumns = 4;

  /// 平板列数
  static const int tabletColumns = 8;

  /// 桌面列数
  static const int desktopColumns = 12;

  // ============ 布局边距 ============

  /// 移动端边距
  static const double mobileMargin = 16;

  /// 平板边距
  static const double tabletMargin = 32;

  /// 桌面边距
  static const double desktopMargin = 64;
}

/// 响应式布局助手扩展
extension ResponsiveContext on BuildContext {
  /// 是否为移动端布局
  bool get isMobile => screenWidth < AppBreakpoints.tablet;

  /// 是否为平板布局
  bool get isTablet =>
      screenWidth >= AppBreakpoints.tablet &&
      screenWidth < AppBreakpoints.desktop;

  /// 是否为桌面布局
  bool get isDesktop => screenWidth >= AppBreakpoints.desktop;

  /// 屏幕宽度
  double get screenWidth => MediaQuery.of(this).size.width;

  /// 屏幕高度
  double get screenHeight => MediaQuery.of(this).size.height;

  /// 根据屏幕大小返回值
  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }
}
