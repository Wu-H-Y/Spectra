import 'package:freezed_annotation/freezed_annotation.dart';

part 'action.freezed.dart';
part 'action.g.dart';

/// 页面交互的动作类型。
@JsonEnum()
enum ActionType {
  /// 等待元素或时间。
  wait,

  /// 点击元素。
  click,

  /// 滚动页面。
  scroll,

  /// 填充表单字段。
  fill,

  /// 执行 JavaScript。
  script,

  /// 条件动作。
  condition,

  /// 循环动作。
  loop,
}

/// 页面交互动作（反爬虫处理）。
@freezed
sealed class CrawlerAction with _$CrawlerAction {
  const factory CrawlerAction({
    /// 动作类型。
    required ActionType type,

    /// 动作参数（根据类型而异）。
    /// - wait: {selector?: string, timeout?: int}
    /// - click: {selector: string}
    /// - scroll: {direction: "up"|"down", distance?: int}
    /// - fill: {selector: string, value: string}
    /// - script: {code: string}
    /// - condition: {check: string, then: List<Action>, else?: List<Action>}
    /// - loop: {count: int, actions: List<Action>, delay?: int}
    required Map<String, dynamic> params,
  }) = _CrawlerAction;

  factory CrawlerAction.fromJson(Map<String, dynamic> json) =>
      _$CrawlerActionFromJson(json);
}

/// 等待动作配置。
@freezed
sealed class WaitAction with _$WaitAction {
  const factory WaitAction({
    /// 要等待的选择器（可选 - 如果为 null，则等待时间）。
    String? selector,

    /// 超时时间（毫秒）。
    @Default(5000) int timeout,
  }) = _WaitAction;

  factory WaitAction.fromJson(Map<String, dynamic> json) =>
      _$WaitActionFromJson(json);
}

/// 点击动作配置。
@freezed
sealed class ClickAction with _$ClickAction {
  const factory ClickAction({
    /// 要点击的元素选择器。
    required String selector,

    /// 是否先将元素滚动到视图中。
    @Default(true) bool scrollIntoView,
  }) = _ClickAction;

  factory ClickAction.fromJson(Map<String, dynamic> json) =>
      _$ClickActionFromJson(json);
}

/// 滚动动作配置。
@freezed
sealed class ScrollAction with _$ScrollAction {
  const factory ScrollAction({
    /// 滚动方向。
    @Default(ScrollDirection.down) ScrollDirection direction,

    /// 滚动距离（像素）（0 = 滚动到底部）。
    @Default(0) int distance,

    /// 平滑滚动。
    @Default(true) bool smooth,
  }) = _ScrollAction;

  factory ScrollAction.fromJson(Map<String, dynamic> json) =>
      _$ScrollActionFromJson(json);
}

/// 滚动方向。
@JsonEnum()
enum ScrollDirection {
  /// 向上滚动。
  up,

  /// 向下滚动。
  down,

  /// 向左滚动。
  left,

  /// 向右滚动。
  right,
}

/// 填充动作配置。
@freezed
sealed class FillAction with _$FillAction {
  const factory FillAction({
    /// 表单字段的选择器。
    required String selector,

    /// 要填充的值。
    required String value,

    /// 是否模拟打字（带延迟）。
    @Default(false) bool simulateTyping,
  }) = _FillAction;

  factory FillAction.fromJson(Map<String, dynamic> json) =>
      _$FillActionFromJson(json);
}

/// 脚本动作配置。
@freezed
sealed class ScriptAction with _$ScriptAction {
  const factory ScriptAction({
    /// 要执行的 JavaScript 代码。
    required String code,

    /// 是否等待脚本完成。
    @Default(true) bool awaitCompletion,
  }) = _ScriptAction;

  factory ScriptAction.fromJson(Map<String, dynamic> json) =>
      _$ScriptActionFromJson(json);
}

/// 条件动作配置。
@freezed
sealed class ConditionAction with _$ConditionAction {
  const factory ConditionAction({
    /// 要检查的条件（JavaScript 表达式或选择器）。
    required String check,

    /// 条件为真时执行的动作。
    required List<CrawlerAction> thenActions,

    /// 条件为假时执行的动作。
    List<CrawlerAction>? elseActions,
  }) = _ConditionAction;

  factory ConditionAction.fromJson(Map<String, dynamic> json) =>
      _$ConditionActionFromJson(json);
}

/// 循环动作配置。
@freezed
sealed class LoopAction with _$LoopAction {
  const factory LoopAction({
    /// 迭代次数。
    required int count,

    /// 每次迭代中执行的动作。
    required List<CrawlerAction> actions,

    /// 迭代之间的延迟（毫秒）。
    @Default(1000) int delayMs,
  }) = _LoopAction;

  factory LoopAction.fromJson(Map<String, dynamic> json) =>
      _$LoopActionFromJson(json);
}
