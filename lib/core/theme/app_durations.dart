/// Spectra 动画时长设计令牌
///
/// 提供标准化的动画时长值，确保应用内一致的运动体验。
class AppDurations {
  AppDurations._();

  // ============ 基础时长值 ============

  /// 快速动画 - 150ms
  ///
  /// 用于：按钮点击反馈、开关切换、简单过渡
  static const Duration fast = Duration(milliseconds: 150);

  /// 标准动画 - 300ms
  ///
  /// 用于：页面切换、抽屉展开、卡片展开
  static const Duration normal = Duration(milliseconds: 300);

  /// 慢速动画 - 500ms
  ///
  /// 用于：复杂过渡、强调性动画
  static const Duration slow = Duration(milliseconds: 500);

  // ============ 特定场景时长 ============

  /// 点击波纹 - 100ms
  static const Duration ripple = Duration(milliseconds: 100);

  /// Toast 显示 - 3s
  static const Duration toastDisplay = Duration(seconds: 3);

  /// Splash 屏幕 - 2s
  static const Duration splash = Duration(seconds: 2);

  /// 页面加载超时 - 30s
  static const Duration pageLoadTimeout = Duration(seconds: 30);

  /// 网络请求超时 - 10s
  static const Duration networkTimeout = Duration(seconds: 10);
}
