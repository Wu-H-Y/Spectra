import 'package:freezed_annotation/freezed_annotation.dart';

part 'execution_state.freezed.dart';
part 'execution_state.g.dart';

/// 规则执行状态。
enum ExecutionStatus {
  /// 空闲/未开始。
  idle,

  /// 执行中。
  running,

  /// 已暂停。
  paused,

  /// 成功完成。
  completed,

  /// 失败并出错。
  failed,

  /// 已取消。
  cancelled,
}

/// 规则执行的状态跟踪器。
@freezed
sealed class ExecutionState with _$ExecutionState {
  const factory ExecutionState({
    /// 唯一执行 ID。
    required String id,

    /// 正在执行的规则 ID。
    required String ruleId,

    /// 当前状态。
    @Default(ExecutionStatus.idle) ExecutionStatus status,

    /// 当前正在处理的 URL。
    String? currentUrl,

    /// 当前页码。
    @Default(1) int currentPage,

    /// 总页数（0 = 未知/无限制）。
    @Default(0) int totalPages,

    /// 目前已提取的项目数。
    @Default(0) int extractedCount,

    /// 提取失败的项目数。
    @Default(0) int failedCount,

    /// 遇到的错误列表。
    @Default([]) List<String> errors,

    /// 警告列表。
    @Default([]) List<String> warnings,

    /// 开始时间。
    DateTime? startTime,

    /// 结束时间。
    DateTime? endTime,

    /// 当前提取阶段。
    @Default(ExecutionPhase.initializing) ExecutionPhase phase,

    /// 额外的元数据。
    @Default({}) Map<String, dynamic> metadata,
  }) = _ExecutionState;

  factory ExecutionState.fromJson(Map<String, dynamic> json) =>
      _$ExecutionStateFromJson(json);
}

/// 执行阶段。
enum ExecutionPhase {
  /// 初始化执行。
  initializing,

  /// 加载页面。
  loading,

  /// 执行前置动作。
  beforeActions,

  /// 提取列表页。
  listExtraction,

  /// 提取详情页。
  detailExtraction,

  /// 提取内容。
  contentExtraction,

  /// 处理分页。
  pagination,

  /// 执行后置动作。
  afterActions,

  /// 已完成。
  completed,

  /// 已失败。
  failed,
}

/// ExecutionState 的扩展方法。
extension ExecutionStateX on ExecutionState {
  /// 执行是否活跃。
  bool get isActive => status == ExecutionStatus.running;

  /// 执行是否已结束（完成、失败或取消）。
  bool get isFinished =>
      status == ExecutionStatus.completed ||
      status == ExecutionStatus.failed ||
      status == ExecutionStatus.cancelled;

  /// 进度百分比（0-100）。
  int get progressPercent {
    if (totalPages == 0) return 0;
    return ((currentPage / totalPages) * 100).round().clamp(0, 100);
  }

  /// 执行持续时间。
  Duration? get duration {
    if (startTime == null) return null;
    final end = endTime ?? DateTime.now();
    return end.difference(startTime!);
  }

  /// 成功率（0-100）。
  int get successRate {
    final total = extractedCount + failedCount;
    if (total == 0) return 100;
    return ((extractedCount / total) * 100).round().clamp(0, 100);
  }
}
