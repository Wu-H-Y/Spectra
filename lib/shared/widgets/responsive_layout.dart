import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// 设备类型枚举
enum DeviceType {
  /// 手机 (< 600px)
  mobile,

  /// 平板 (600px - 1024px)
  tablet,

  /// 桌面 (> 1024px)
  desktop,
}

/// 响应式布局组件
///
/// 根据屏幕尺寸自动切换手机/平板/桌面布局。
/// 断点配置：
/// - mobile: width <= 599px
/// - tablet: 600px < width <= 1024px
/// - desktop: width > 1024px
class ResponsiveLayout extends StatelessWidget {
  /// 创建响应式布局
  const ResponsiveLayout({
    required this.mobile,
    this.tablet,
    this.desktop,
    super.key,
  });

  /// 手机布局
  final Widget mobile;

  /// 平板布局（可选，默认使用手机布局）
  final Widget? tablet;

  /// 桌面布局（可选，默认使用平板或手机布局）
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = _getDeviceType(constraints.maxWidth);

        switch (deviceType) {
          case DeviceType.desktop:
            return desktop ?? tablet ?? mobile;
          case DeviceType.tablet:
            return tablet ?? mobile;
          case DeviceType.mobile:
            return mobile;
        }
      },
    );
  }

  /// 根据宽度获取设备类型
  static DeviceType _getDeviceType(double width) {
    if (width > 1024) {
      return DeviceType.desktop;
    } else if (width > 599) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  /// 获取当前设备类型
  static DeviceType get currentDeviceType {
    return _getDeviceType(100.w);
  }

  /// 是否为手机
  static bool get isMobile => currentDeviceType == DeviceType.mobile;

  /// 是否为平板
  static bool get isTablet => currentDeviceType == DeviceType.tablet;

  /// 是否为桌面
  static bool get isDesktop => currentDeviceType == DeviceType.desktop;

  /// 根据设备类型返回不同的值
  static T valueByDevice<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    switch (currentDeviceType) {
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.mobile:
        return mobile;
    }
  }
}

/// 响应式间距常量
///
/// 使用 sizer 单位实现响应式间距
class ResponsiveSpacing {
  ResponsiveSpacing._();

  /// 超小间距 (0.5.w)
  static double get xs => 0.5.w;

  /// 小间距 (1.w)
  static double get sm => 1.w;

  /// 中等间距 (2.w)
  static double get md => 2.w;

  /// 大间距 (3.w)
  static double get lg => 3.w;

  /// 超大间距 (4.w)
  static double get xl => 4.w;

  /// 超超大间距 (6.w)
  static double get xxl => 6.w;

  /// 列表项间距
  static double get listItem => ResponsiveLayout.valueByDevice(
    mobile: 1.5.w,
    tablet: 1.w,
    desktop: 0.8.w,
  );

  /// 卡片内边距
  static double get cardPadding => ResponsiveLayout.valueByDevice(
    mobile: 3.w,
    tablet: 2.w,
    desktop: 1.5.w,
  );

  /// 页面边距
  static double get pagePadding => ResponsiveLayout.valueByDevice(
    mobile: 4.w,
    tablet: 3.w,
    desktop: 2.w,
  );

  /// 按钮内边距
  static double get buttonPadding => ResponsiveLayout.valueByDevice(
    mobile: 3.w,
    tablet: 2.w,
    desktop: 1.5.w,
  );
}

/// 响应式字体大小常量
class ResponsiveFontSize {
  ResponsiveFontSize._();

  /// 超小字体 (8.sp)
  static double get xs => 8.sp;

  /// 小字体 (10.sp)
  static double get sm => 10.sp;

  /// 正常字体 (12.sp)
  static double get base => 12.sp;

  /// 中等字体 (14.sp)
  static double get md => 14.sp;

  /// 大字体 (16.sp)
  static double get lg => 16.sp;

  /// 超大字体 (18.sp)
  static double get xl => 18.sp;

  /// 超超大字体 (24.sp)
  static double get xxl => 24.sp;

  /// 标题字体 (32.sp)
  static double get heading => 32.sp;

  /// 标题字体大小
  static double headingSize(int level) {
    switch (level) {
      case 1:
        return 28.sp;
      case 2:
        return 24.sp;
      case 3:
        return 20.sp;
      case 4:
        return 18.sp;
      case 5:
        return 16.sp;
      case 6:
        return 14.sp;
      default:
        return 14.sp;
    }
  }
}

/// 响应式图标大小常量
class ResponsiveIconSize {
  ResponsiveIconSize._();

  /// 小图标 (14.sp)
  static double get sm => 14.sp;

  /// 正常图标 (18.sp)
  static double get base => 18.sp;

  /// 中等图标 (22.sp)
  static double get md => 22.sp;

  /// 大图标 (28.sp)
  static double get lg => 28.sp;

  /// 超大图标 (36.sp)
  static double get xl => 36.sp;
}

/// 响应式布局构建器
///
/// 在需要根据屏幕尺寸动态调整布局时使用
class ResponsiveBuilder extends StatelessWidget {
  /// 创建响应式构建器
  const ResponsiveBuilder({
    required this.builder,
    super.key,
  });

  /// 构建函数
  /// [context] 构建上下文
  /// [deviceType] 当前设备类型
  /// [orientation] 屏幕方向
  /// [screenWidth] 屏幕宽度
  /// [screenHeight] 屏幕高度
  final Widget Function(
    BuildContext context,
    DeviceType deviceType,
    Orientation orientation,
    double screenWidth,
    double screenHeight,
  )
  builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = ResponsiveLayout._getDeviceType(
          constraints.maxWidth,
        );
        final orientation = constraints.maxWidth > constraints.maxHeight
            ? Orientation.landscape
            : Orientation.portrait;

        return builder(
          context,
          deviceType,
          orientation,
          constraints.maxWidth,
          constraints.maxHeight,
        );
      },
    );
  }
}
