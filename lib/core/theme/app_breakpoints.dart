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

  /// 大平板断点 - 840dp
  ///
  /// 用于：大平板、小桌面
  static const double tabletLarge = 840;

  /// 桌面断点 - 1024dp
  ///
  /// 用于：平板横屏、小桌面
  static const double desktop = 1024;

  /// 大桌面断点 - 1440dp
  ///
  /// 用于：大屏幕桌面
  static const double desktopLarge = 1440;

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

  /// 是否为小平板布局
  bool get isTabletSmall =>
      screenWidth >= AppBreakpoints.tablet &&
      screenWidth < AppBreakpoints.tabletLarge;

  /// 是否为大平板布局
  bool get isTabletLarge =>
      screenWidth >= AppBreakpoints.tabletLarge &&
      screenWidth < AppBreakpoints.desktop;

  /// 是否为平板布局（包含大小平板）
  bool get isTablet => isTabletSmall || isTabletLarge;

  /// 是否为桌面布局
  bool get isDesktop => screenWidth >= AppBreakpoints.desktop;

  /// 是否使用侧边栏（桌面/大平板）
  bool get useSidebar => screenWidth >= AppBreakpoints.tabletLarge;

  /// 是否使用底部导航（移动端/小平板）
  bool get useBottomNav => screenWidth < AppBreakpoints.tabletLarge;

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

  /// 获取响应式网格列数
  ///
  /// 使用示例:
  /// ```dart
  /// final columns = context.gridColumns(mobile: 2, tablet: 3, desktop: 4);
  /// ```
  int gridColumns({
    required int mobile,
    int? tablet,
    int? desktop,
  }) {
    return responsive(
      mobile: mobile,
      tablet: tablet ?? mobile + 1,
      desktop: desktop ?? tablet ?? mobile + 2,
    );
  }

  /// 获取响应式内边距
  ///
  /// 使用示例:
  /// ```dart
  /// Padding(padding: context.responsivePadding(mobile: 16))
  /// ```
  EdgeInsets responsivePadding({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final value = responsive(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
    return EdgeInsets.all(value);
  }

  /// 获取响应式水平内边距（垂直固定）
  EdgeInsets responsiveHorizontalPadding({
    required double mobile,
    double? tablet,
    double? desktop,
    double vertical = 0,
  }) {
    final horizontal = responsive(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }
}
