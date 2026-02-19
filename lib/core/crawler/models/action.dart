import 'package:freezed_annotation/freezed_annotation.dart';

part 'action.freezed.dart';
part 'action.g.dart';

/// Action type for page interactions.
@JsonEnum()
enum ActionType {
  /// Wait for element or time.
  wait,

  /// Click on element.
  click,

  /// Scroll page.
  scroll,

  /// Fill form field.
  fill,

  /// Execute JavaScript.
  script,

  /// Conditional action.
  condition,

  /// Loop action.
  loop,
}

/// Action for page interactions (anti-crawl handling).
@freezed
sealed class CrawlerAction with _$CrawlerAction {
  const factory CrawlerAction({
    /// Action type.
    required ActionType type,

    /// Action parameters (varies by type).
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

/// Wait action configuration.
@freezed
sealed class WaitAction with _$WaitAction {
  const factory WaitAction({
    /// Selector to wait for (optional - if null, waits for time).
    String? selector,

    /// Timeout in milliseconds.
    @Default(5000) int timeout,
  }) = _WaitAction;

  factory WaitAction.fromJson(Map<String, dynamic> json) =>
      _$WaitActionFromJson(json);
}

/// Click action configuration.
@freezed
sealed class ClickAction with _$ClickAction {
  const factory ClickAction({
    /// Selector for element to click.
    required String selector,

    /// Whether to scroll element into view first.
    @Default(true) bool scrollIntoView,
  }) = _ClickAction;

  factory ClickAction.fromJson(Map<String, dynamic> json) =>
      _$ClickActionFromJson(json);
}

/// Scroll action configuration.
@freezed
sealed class ScrollAction with _$ScrollAction {
  const factory ScrollAction({
    /// Scroll direction.
    @Default(ScrollDirection.down) ScrollDirection direction,

    /// Scroll distance in pixels (0 = scroll to end).
    @Default(0) int distance,

    /// Scroll smoothly.
    @Default(true) bool smooth,
  }) = _ScrollAction;

  factory ScrollAction.fromJson(Map<String, dynamic> json) =>
      _$ScrollActionFromJson(json);
}

/// Scroll direction.
@JsonEnum()
enum ScrollDirection {
  /// Scroll up.
  up,

  /// Scroll down.
  down,

  /// Scroll left.
  left,

  /// Scroll right.
  right,
}

/// Fill action configuration.
@freezed
sealed class FillAction with _$FillAction {
  const factory FillAction({
    /// Selector for form field.
    required String selector,

    /// Value to fill.
    required String value,

    /// Whether to simulate typing (with delays).
    @Default(false) bool simulateTyping,
  }) = _FillAction;

  factory FillAction.fromJson(Map<String, dynamic> json) =>
      _$FillActionFromJson(json);
}

/// Script action configuration.
@freezed
sealed class ScriptAction with _$ScriptAction {
  const factory ScriptAction({
    /// JavaScript code to execute.
    required String code,

    /// Whether to wait for script to complete.
    @Default(true) bool awaitCompletion,
  }) = _ScriptAction;

  factory ScriptAction.fromJson(Map<String, dynamic> json) =>
      _$ScriptActionFromJson(json);
}

/// Condition action configuration.
@freezed
sealed class ConditionAction with _$ConditionAction {
  const factory ConditionAction({
    /// Condition to check (JavaScript expression or selector).
    required String check,

    /// Actions to execute if condition is true.
    required List<CrawlerAction> thenActions,

    /// Actions to execute if condition is false.
    List<CrawlerAction>? elseActions,
  }) = _ConditionAction;

  factory ConditionAction.fromJson(Map<String, dynamic> json) =>
      _$ConditionActionFromJson(json);
}

/// Loop action configuration.
@freezed
sealed class LoopAction with _$LoopAction {
  const factory LoopAction({
    /// Number of iterations.
    required int count,

    /// Actions to execute in each iteration.
    required List<CrawlerAction> actions,

    /// Delay between iterations in milliseconds.
    @Default(1000) int delayMs,
  }) = _LoopAction;

  factory LoopAction.fromJson(Map<String, dynamic> json) =>
      _$LoopActionFromJson(json);
}
