import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:spectra/core/errors/app_failure.dart';
import 'package:spectra/core/server/runtime_workspace_client.dart';
import 'package:spectra/core/server/server_provider.dart';

/// Runtime 工作区时间线条目。
@immutable
class RuntimeWorkspaceTimelineEntry {
  /// 创建时间线条目。
  const RuntimeWorkspaceTimelineEntry({
    required this.id,
    required this.type,
    required this.data,
    required this.occurredAt,
  });

  /// 唯一 ID。
  final String id;

  /// 条目类型。
  final String type;

  /// 负载数据。
  final Map<String, dynamic> data;

  /// 发生时间。
  final DateTime occurredAt;

  /// 关联 runId。
  String? get runId => data['runId'] as String?;

  /// 展示标题。
  String get displayLabel {
    if (type == 'node_event') {
      return (data['event'] as String?) ?? type;
    }
    return type;
  }
}

/// Runtime 工作区预览状态。
@immutable
class RuntimeWorkspacePreviewState {
  /// 创建预览状态。
  const RuntimeWorkspacePreviewState({
    required this.previewSessionId,
    required this.previewUrl,
    required this.debugUrl,
    required this.openedAt,
  });

  /// 预览会话 ID。
  final String previewSessionId;

  /// 预览地址。
  final String previewUrl;

  /// 调试地址。
  final String debugUrl;

  /// 打开时间。
  final DateTime openedAt;
}

/// Runtime 工作区运行状态。
@immutable
class RuntimeWorkspaceRunState {
  /// 创建运行状态。
  const RuntimeWorkspaceRunState({
    required this.runId,
    required this.ruleId,
    required this.ruleName,
    required this.status,
    required this.acceptedAt,
    required this.executeResponseJson,
    this.previewSessionId,
    this.startedAt,
    this.finishedAt,
    this.lastSeq,
    this.success,
  });

  /// 运行 ID。
  final String runId;

  /// 规则 ID。
  final String ruleId;

  /// 规则名称。
  final String ruleName;

  /// 运行状态。
  final RuntimeWorkspaceRunStatus status;

  /// 受理时间。
  final DateTime acceptedAt;

  /// 原始响应 JSON。
  final Map<String, dynamic> executeResponseJson;

  /// 关联预览会话 ID。
  final String? previewSessionId;

  /// 开始时间。
  final DateTime? startedAt;

  /// 完成时间。
  final DateTime? finishedAt;

  /// 最后事件序号。
  final int? lastSeq;

  /// 是否成功。
  final bool? success;

  /// 复制状态。
  RuntimeWorkspaceRunState copyWith({
    RuntimeWorkspaceRunStatus? status,
    DateTime? startedAt,
    DateTime? finishedAt,
    int? lastSeq,
    bool? success,
  }) {
    return RuntimeWorkspaceRunState(
      runId: runId,
      ruleId: ruleId,
      ruleName: ruleName,
      status: status ?? this.status,
      acceptedAt: acceptedAt,
      executeResponseJson: executeResponseJson,
      previewSessionId: previewSessionId,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      lastSeq: lastSeq ?? this.lastSeq,
      success: success ?? this.success,
    );
  }
}

/// Runtime 工作区运行状态枚举。
enum RuntimeWorkspaceRunStatus {
  /// 已受理。
  accepted,

  /// 运行中。
  running,

  /// 已完成。
  finished,
}

/// 已选元素信息。
@immutable
class SelectedElementInfo {
  /// 创建已选元素信息。
  const SelectedElementInfo({
    required this.selector,
    required this.selectorType,
    required this.outerHtml,
    this.textContent,
    this.xpath,
    this.selectedAt,
  });

  /// 选择器表达式。
  final String selector;

  /// 选择器类型（css/xpath）。
  final String selectorType;

  /// 元素 outerHTML。
  final String outerHtml;

  /// 文本内容。
  final String? textContent;

  /// XPath 表达式。
  final String? xpath;

  /// 选中时间。
  final DateTime? selectedAt;
}

/// Runtime 工作区页面状态。
@immutable
class RulesRuntimeWorkspaceState {
  /// 创建工作区状态。
  const RulesRuntimeWorkspaceState({
    required this.sessionId,
    required this.serverStatus,
    this.rules = const <RuntimeRuleSummary>[],
    this.selectedRuleId,
    this.activePreview,
    this.runsById = const <String, RuntimeWorkspaceRunState>{},
    this.timeline = const <RuntimeWorkspaceTimelineEntry>[],
    this.failure,
    this.isRefreshingWorkspace = false,
    this.isTogglingServer = false,
    this.isOpeningPreview = false,
    this.isExecuting = false,
    this.timelineConnected = false,
    this.isElementSelectionMode = false,
    this.isTestingSelector = false,
    this.selectorTestResult,
    this.selectorType = 'css',
    this.selectorExpression = '',
    this.selectedElement,
  });

  /// 页面会话 ID。
  final String sessionId;

  /// 当前服务端状态。
  final ServerStatus serverStatus;

  /// 可执行规则列表。
  final List<RuntimeRuleSummary> rules;

  /// 当前选中的规则 ID。
  final int? selectedRuleId;

  /// 当前活跃预览。
  final RuntimeWorkspacePreviewState? activePreview;

  /// 运行注册表。
  final Map<String, RuntimeWorkspaceRunState> runsById;

  /// 时间线条目。
  final List<RuntimeWorkspaceTimelineEntry> timeline;

  /// 当前失败。
  final AppFailure? failure;

  /// 是否正在刷新工作区。
  final bool isRefreshingWorkspace;

  /// 是否正在切换服务端。
  final bool isTogglingServer;

  /// 是否正在打开预览。
  final bool isOpeningPreview;

  /// 是否正在执行规则。
  final bool isExecuting;

  /// 时间线是否已连接。
  final bool timelineConnected;

  /// 是否处于元素选择模式。
  final bool isElementSelectionMode;

  /// 是否正在测试选择器。
  final bool isTestingSelector;

  /// 选择器测试结果。
  final RuntimeSelectorTestResult? selectorTestResult;

  /// 选择器类型（css/xpath）。
  final String selectorType;

  /// 选择器表达式。
  final String selectorExpression;

  /// 当前选中的元素信息。
  final SelectedElementInfo? selectedElement;

  /// 当前活跃预览 ID。
  String? get activePreviewSessionId => activePreview?.previewSessionId;

  /// 最新运行。
  RuntimeWorkspaceRunState? get latestRun {
    if (runsById.isEmpty) {
      return null;
    }
    return orderedRuns.first;
  }

  /// 有序运行列表。
  List<RuntimeWorkspaceRunState> get orderedRuns {
    final values = runsById.values.toList()
      ..sort((a, b) => b.acceptedAt.compareTo(a.acceptedAt));
    return UnmodifiableListView(values);
  }

  /// 是否可发起执行。
  bool get canExecute => selectedRuleId != null && !isExecuting;

  /// 是否可打开预览。
  bool get canOpenPreview => !isOpeningPreview;

  /// 复制状态。
  RulesRuntimeWorkspaceState copyWith({
    String? sessionId,
    ServerStatus? serverStatus,
    List<RuntimeRuleSummary>? rules,
    Object? selectedRuleId = _unset,
    Object? activePreview = _unset,
    Map<String, RuntimeWorkspaceRunState>? runsById,
    List<RuntimeWorkspaceTimelineEntry>? timeline,
    Object? failure = _unset,
    bool? isRefreshingWorkspace,
    bool? isTogglingServer,
    bool? isOpeningPreview,
    bool? isExecuting,
    bool? timelineConnected,
    bool? isElementSelectionMode,
    bool? isTestingSelector,
    Object? selectorTestResult = _unset,
    String? selectorType,
    String? selectorExpression,
    Object? selectedElement = _unset,
  }) {
    return RulesRuntimeWorkspaceState(
      sessionId: sessionId ?? this.sessionId,
      serverStatus: serverStatus ?? this.serverStatus,
      rules: rules ?? this.rules,
      selectedRuleId: identical(selectedRuleId, _unset)
          ? this.selectedRuleId
          : selectedRuleId as int?,
      activePreview: identical(activePreview, _unset)
          ? this.activePreview
          : activePreview as RuntimeWorkspacePreviewState?,
      runsById: runsById ?? this.runsById,
      timeline: timeline ?? this.timeline,
      failure: identical(failure, _unset)
          ? this.failure
          : failure as AppFailure?,
      isRefreshingWorkspace:
          isRefreshingWorkspace ?? this.isRefreshingWorkspace,
      isTogglingServer: isTogglingServer ?? this.isTogglingServer,
      isOpeningPreview: isOpeningPreview ?? this.isOpeningPreview,
      isExecuting: isExecuting ?? this.isExecuting,
      timelineConnected: timelineConnected ?? this.timelineConnected,
      isElementSelectionMode:
          isElementSelectionMode ?? this.isElementSelectionMode,
      isTestingSelector: isTestingSelector ?? this.isTestingSelector,
      selectorTestResult: identical(selectorTestResult, _unset)
          ? this.selectorTestResult
          : selectorTestResult as RuntimeSelectorTestResult?,
      selectorType: selectorType ?? this.selectorType,
      selectorExpression: selectorExpression ?? this.selectorExpression,
      selectedElement: identical(selectedElement, _unset)
          ? this.selectedElement
          : selectedElement as SelectedElementInfo?,
    );
  }
}

const _unset = Object();
