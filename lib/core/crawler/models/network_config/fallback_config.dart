import 'package:freezed_annotation/freezed_annotation.dart';

part 'fallback_config.freezed.dart';
part 'fallback_config.g.dart';

/// 回退动作类型。
enum FallbackAction {
  /// 切换到 WebView 解决。
  webviewSolve,

  /// 切换代理。
  switchProxy,

  /// 等待重试。
  waitRetry,

  /// 放弃。
  abort,
}

/// 触发条件。
@freezed
sealed class TriggerCondition with _$TriggerCondition {
  const factory TriggerCondition({
    /// HTTP 状态码。
    int? statusCode,

    /// 正则匹配响应体。
    String? bodyRegex,

    /// 响应头匹配。
    String? headerPattern,
  }) = _TriggerCondition;

  factory TriggerCondition.fromJson(Map<String, dynamic> json) =>
      _$TriggerConditionFromJson(json);
}

/// 失败回退配置。
@freezed
sealed class FallbackConfig with _$FallbackConfig {
  const factory FallbackConfig({
    /// 触发条件列表 (任一满足即触发)。
    required List<TriggerCondition> trigger,

    /// 回退动作。
    required FallbackAction action,

    /// 解决超时时间 (毫秒)。
    @Default(30000) int timeout,

    /// 是否同步 Cookie。
    @Default(true) bool syncCookies,

    /// 最大重试次数。
    @Default(3) int maxRetries,
  }) = _FallbackConfig;

  factory FallbackConfig.fromJson(Map<String, dynamic> json) =>
      _$FallbackConfigFromJson(json);
}
