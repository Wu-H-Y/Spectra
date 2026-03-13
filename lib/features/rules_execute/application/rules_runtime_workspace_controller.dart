import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/errors/app_failure.dart';
import 'package:spectra/core/server/runtime_workspace_client.dart';
import 'package:spectra/core/server/server_provider.dart';
import 'package:spectra/features/rules_execute/application/rules_runtime_workspace_state.dart';

export 'package:spectra/features/rules_execute/application/rules_runtime_workspace_state.dart'
    show SelectedElementInfo;

/// Runtime 工作区客户端 Provider。
final runtimeWorkspaceClientProvider = Provider<RuntimeWorkspaceClient>((ref) {
  final client = DefaultRuntimeWorkspaceClient();
  ref.onDispose(client.dispose);
  return client;
});

/// Runtime 工作区时间 Provider。
final runtimeWorkspaceNowProvider = Provider<DateTime Function()>((_) {
  return () => DateTime.now().toUtc();
});

/// Runtime 工作区会话 ID Provider。
final runtimeWorkspaceSessionIdProvider = Provider<String>((_) {
  final micros = DateTime.now().toUtc().microsecondsSinceEpoch;
  return 'session_${micros.toRadixString(16)}';
});

/// Runtime 工作区控制器 Provider。
final NotifierProvider<
  RulesRuntimeWorkspaceController,
  RulesRuntimeWorkspaceState
>
rulesRuntimeWorkspaceControllerProvider =
    NotifierProvider.autoDispose<
      RulesRuntimeWorkspaceController,
      RulesRuntimeWorkspaceState
    >(RulesRuntimeWorkspaceController.new);

/// Rules runtime workspace 控制器。
class RulesRuntimeWorkspaceController
    extends Notifier<RulesRuntimeWorkspaceState> {
  late final RuntimeWorkspaceClient _client = ref.read(
    runtimeWorkspaceClientProvider,
  );
  late final DateTime Function() _now = ref.read(
    runtimeWorkspaceNowProvider,
  );
  String _sessionIdFactory() => ref.read(runtimeWorkspaceSessionIdProvider);

  RuntimeSessionTimelineConnection? _timelineConnection;
  StreamSubscription<RuntimeTimelineMessage>? _timelineSubscription;
  String? _serverToken;
  String? _connectedServerUrl;
  int _timelineCounter = 0;

  @override
  RulesRuntimeWorkspaceState build() {
    ref
      ..listen<ServerStatus>(
        serverProvider,
        (_, next) => syncServerStatus(next),
      )
      ..onDispose(_disconnectTimeline);

    final serverStatus = ref.read(serverProvider);
    return RulesRuntimeWorkspaceState(
      sessionId: _sessionIdFactory(),
      serverStatus: serverStatus,
    );
  }

  /// 启动页面工作区。
  Future<void> bootstrap() async {
    if (!state.serverStatus.isRunning) {
      return;
    }
    await refreshWorkspace();
  }

  /// 同步服务端状态。
  void syncServerStatus(ServerStatus serverStatus) {
    state = state.copyWith(serverStatus: serverStatus);
    if (!serverStatus.isRunning) {
      unawaited(_disconnectTimeline());
      state = state.copyWith(
        timelineConnected: false,
        activePreview: null,
      );
    }
  }

  /// 切换服务端状态。
  Future<void> toggleServer() async {
    if (state.isTogglingServer) {
      return;
    }

    state = state.copyWith(isTogglingServer: true, failure: null);
    try {
      if (state.serverStatus.isRunning) {
        await ref.read(serverProvider.notifier).stop();
        await _disconnectTimeline();
        state = state.copyWith(
          serverStatus: ref.read(serverProvider),
          activePreview: null,
          timelineConnected: false,
        );
      } else {
        await ref.read(serverProvider.notifier).start();
        state = state.copyWith(serverStatus: ref.read(serverProvider));
        await refreshWorkspace();
      }
    } on Exception catch (error, stackTrace) {
      state = state.copyWith(failure: AppFailure.unknown(error));
      FlutterError.reportError(
        FlutterErrorDetails(exception: error, stack: stackTrace),
      );
    } finally {
      state = state.copyWith(isTogglingServer: false);
    }
  }

  /// 刷新工作区。
  Future<void> refreshWorkspace() async {
    if (state.isRefreshingWorkspace) {
      return;
    }

    state = state.copyWith(isRefreshingWorkspace: true, failure: null);
    try {
      final ready = await _ensureRuntimeReady();
      if (!ready) {
        return;
      }
      await _loadRules();
    } finally {
      state = state.copyWith(isRefreshingWorkspace: false);
    }
  }

  /// 选择规则。
  void selectRule(int? ruleId) {
    state = state.copyWith(selectedRuleId: ruleId);
  }

  /// 切换元素选择模式。
  void toggleElementSelectionMode() {
    state = state.copyWith(
      isElementSelectionMode: !state.isElementSelectionMode,
    );
  }

  /// 设置选择器类型。
  void setSelectorType(String type) {
    state = state.copyWith(selectorType: type);
  }

  /// 设置选择器表达式。
  void setSelectorExpression(String expression) {
    state = state.copyWith(selectorExpression: expression);
  }

  /// 测试选择器。
  Future<void> testSelector() async {
    final previewSessionId = state.activePreviewSessionId;
    if (previewSessionId == null || state.isTestingSelector) {
      return;
    }

    final expression = state.selectorExpression.trim();
    if (expression.isEmpty) {
      return;
    }

    state = state.copyWith(isTestingSelector: true, failure: null);
    try {
      final ready = await _ensureRuntimeReady();
      if (!ready) {
        return;
      }

      final result = await _client.testSelector(
        serverUrl: state.serverStatus.url!,
        serverToken: _serverToken!,
        previewSessionId: previewSessionId,
        selectorType: state.selectorType,
        expression: expression,
      );

      result.match(_applyFailure, (testResult) {
        state = state.copyWith(
          selectorTestResult: testResult,
          failure: null,
        );
        _appendTimelineEntry(
          type: 'selector_tested',
          data: {
            'previewSessionId': previewSessionId,
            'selectorType': state.selectorType,
            'expression': expression,
            'success': testResult.success,
            'count': testResult.count,
          },
        );
      });
    } finally {
      state = state.copyWith(isTestingSelector: false);
    }
  }

  /// 清除选择器测试结果。
  void clearSelectorTestResult() {
    state = state.copyWith(selectorTestResult: null);
  }

  /// 打开预览。
  Future<void> openPreview(String previewUrl) async {
    final normalizedUrl = previewUrl.trim();
    if (normalizedUrl.isEmpty || state.isOpeningPreview) {
      return;
    }

    state = state.copyWith(isOpeningPreview: true, failure: null);
    try {
      final ready = await _ensureRuntimeReady();
      if (!ready) {
        return;
      }

      final result = await _client.openPreview(
        serverUrl: state.serverStatus.url!,
        serverToken: _serverToken!,
        sessionId: state.sessionId,
        previewUrl: normalizedUrl,
      );

      result.match(_applyFailure, (preview) {
        state = state.copyWith(
          activePreview: RuntimeWorkspacePreviewState(
            previewSessionId: preview.previewSessionId,
            previewUrl: preview.previewUrl,
            debugUrl: preview.debugUrl,
            openedAt: _now(),
          ),
          failure: null,
        );
        _appendTimelineEntry(
          type: 'preview_opened',
          data: {
            'previewSessionId': preview.previewSessionId,
            'previewUrl': preview.previewUrl,
            'debugUrl': preview.debugUrl,
          },
        );
      });
    } finally {
      state = state.copyWith(isOpeningPreview: false);
    }
  }

  /// 执行选中规则。
  Future<void> executeSelectedRule() async {
    final selectedRule = _selectedRuleSummary;
    if (selectedRule == null || state.isExecuting) {
      return;
    }

    state = state.copyWith(isExecuting: true, failure: null);
    try {
      final ready = await _ensureRuntimeReady();
      if (!ready) {
        return;
      }

      RuntimeRuleDocument? ruleDocument;
      final ruleDocumentResult = await _client.getRule(
        serverUrl: state.serverStatus.url!,
        serverToken: _serverToken!,
        id: selectedRule.id,
      );
      ruleDocumentResult.match(_applyFailure, (document) {
        ruleDocument = document;
      });
      if (ruleDocument == null) {
        return;
      }

      final executeResult = await _client.executeRule(
        serverUrl: state.serverStatus.url!,
        serverToken: _serverToken!,
        rule: ruleDocument!.rule,
        sessionId: state.sessionId,
        previewSessionId: state.activePreviewSessionId,
      );

      executeResult.match(_applyFailure, (accepted) {
        final nextRuns =
            Map<String, RuntimeWorkspaceRunState>.from(
                state.runsById,
              )
              ..[accepted.runId] = RuntimeWorkspaceRunState(
                runId: accepted.runId,
                ruleId: selectedRule.ruleId,
                ruleName: selectedRule.name,
                status: RuntimeWorkspaceRunStatus.accepted,
                acceptedAt: _now(),
                executeResponseJson: accepted.responseJson,
                previewSessionId: state.activePreviewSessionId,
              );
        state = state.copyWith(runsById: nextRuns, failure: null);
        _appendTimelineEntry(
          type: 'run_accepted',
          data: {
            'runId': accepted.runId,
            'status': accepted.status,
            'ruleId': selectedRule.ruleId,
            if (state.activePreviewSessionId != null)
              'previewSessionId': state.activePreviewSessionId,
          },
        );
      });
    } finally {
      state = state.copyWith(isExecuting: false);
    }
  }

  RuntimeRuleSummary? get _selectedRuleSummary {
    final selectedRuleId = state.selectedRuleId;
    if (selectedRuleId == null) {
      return null;
    }
    for (final rule in state.rules) {
      if (rule.id == selectedRuleId) {
        return rule;
      }
    }
    return null;
  }

  Future<bool> _ensureRuntimeReady() async {
    if (!state.serverStatus.isRunning) {
      await ref.read(serverProvider.notifier).start();
      state = state.copyWith(serverStatus: ref.read(serverProvider));
    }

    final serverUrl = state.serverStatus.url;
    if (serverUrl == null || serverUrl.isEmpty) {
      _applyFailure(const AppFailure.serverError());
      return false;
    }

    RuntimeServerSnapshot? snapshot;
    final snapshotResult = await _client.fetchServerSnapshot(
      serverUrl: serverUrl,
    );
    snapshotResult.match(_applyFailure, (value) {
      snapshot = value;
    });
    if (snapshot == null) {
      return false;
    }

    _serverToken = snapshot!.serverToken;
    state = state.copyWith(
      serverStatus: ServerStatus(
        isRunning: snapshot!.isRunning,
        port: snapshot!.port,
        url: snapshot!.url,
      ),
    );

    return _connectTimeline(serverUrl: snapshot!.url);
  }

  Future<void> _loadRules() async {
    final serverUrl = state.serverStatus.url;
    final serverToken = _serverToken;
    if (serverUrl == null || serverToken == null) {
      return;
    }

    final result = await _client.listRules(
      serverUrl: serverUrl,
      serverToken: serverToken,
    );
    result.match(_applyFailure, (rules) {
      final selectedRuleId = state.selectedRuleId;
      final hasSelectedRule =
          selectedRuleId != null &&
          rules.any((item) => item.id == selectedRuleId);
      state = state.copyWith(
        rules: rules,
        selectedRuleId: hasSelectedRule
            ? selectedRuleId
            : rules.isEmpty
            ? null
            : rules.first.id,
        failure: null,
      );
    });
  }

  Future<bool> _connectTimeline({required String serverUrl}) async {
    if (_serverToken == null) {
      return false;
    }

    if (_timelineConnection != null &&
        _connectedServerUrl == serverUrl &&
        state.timelineConnected) {
      return true;
    }

    await _disconnectTimeline();
    final result = await _client.connectSessionTimeline(
      serverUrl: serverUrl,
      serverToken: _serverToken!,
      sessionId: state.sessionId,
    );

    var connected = false;
    result.match(
      (failure) {
        _applyFailure(failure);
        state = state.copyWith(timelineConnected: false);
      },
      (connection) {
        _timelineConnection = connection;
        _connectedServerUrl = serverUrl;
        _timelineSubscription = connection.messages.listen(
          _handleTimelineMessage,
          onError: (Object error, StackTrace stackTrace) {
            final failure = error is AppFailure
                ? error
                : AppFailure.unknown(error);
            _applyFailure(failure);
            state = state.copyWith(timelineConnected: false);
            FlutterError.reportError(
              FlutterErrorDetails(exception: error, stack: stackTrace),
            );
          },
          onDone: () {
            state = state.copyWith(timelineConnected: false);
          },
        );
        state = state.copyWith(timelineConnected: true, failure: null);
        connected = true;
      },
    );
    return connected;
  }

  Future<void> _disconnectTimeline() async {
    await _timelineSubscription?.cancel();
    _timelineSubscription = null;
    await _timelineConnection?.close();
    _timelineConnection = null;
    _connectedServerUrl = null;
  }

  void _handleTimelineMessage(RuntimeTimelineMessage message) {
    _appendTimelineEntry(type: message.type, data: message.data);

    // 处理元素选中事件
    if (message.type == 'element_selected') {
      _handleElementSelected(message.data);
      return;
    }

    // 处理选择状态变更事件
    if (message.type == 'selection_started' ||
        message.type == 'selection_cancelled') {
      state = state.copyWith(
        isElementSelectionMode: message.type == 'selection_started',
      );
      return;
    }

    if (message.type != 'node_event' || message.runId == null) {
      return;
    }

    final existingRun = state.runsById[message.runId!];
    if (existingRun == null) {
      return;
    }

    final updatedRun = switch (message.event) {
      'run_started' => existingRun.copyWith(
        status: RuntimeWorkspaceRunStatus.running,
        startedAt: message.receivedAt,
        lastSeq: message.seq,
      ),
      'run_finished' => existingRun.copyWith(
        status: RuntimeWorkspaceRunStatus.finished,
        finishedAt: message.receivedAt,
        lastSeq: message.seq,
        success: message.data['success'] as bool?,
      ),
      _ => existingRun.copyWith(lastSeq: message.seq),
    };

    final nextRuns = Map<String, RuntimeWorkspaceRunState>.from(state.runsById)
      ..[message.runId!] = updatedRun;
    state = state.copyWith(runsById: nextRuns);
  }

  void _handleElementSelected(Map<String, dynamic> data) {
    final selector = data['selector'] as String?;
    final selectorType = data['selectorType'] as String?;
    final outerHtml = data['outerHtml'] as String?;

    if (selector == null || selectorType == null || outerHtml == null) {
      return;
    }

    // 更新选中的元素信息，同时退出选择模式
    state = state.copyWith(
      selectedElement: SelectedElementInfo(
        selector: selector,
        selectorType: selectorType,
        outerHtml: outerHtml,
        textContent: data['textContent'] as String?,
        xpath: data['xpath'] as String?,
        selectedAt: DateTime.now().toUtc(),
      ),
      isElementSelectionMode: false,
      // 同时更新选择器表达式和类型
      selectorType: selectorType,
      selectorExpression: selector,
    );
  }

  void _applyFailure(AppFailure failure) {
    state = state.copyWith(failure: failure);
  }

  void _appendTimelineEntry({
    required String type,
    required Map<String, dynamic> data,
  }) {
    final nextEntry = RuntimeWorkspaceTimelineEntry(
      id: '${type}_${_timelineCounter++}',
      type: type,
      data: Map<String, dynamic>.unmodifiable(data),
      occurredAt: _now(),
    );
    final nextTimeline = <RuntimeWorkspaceTimelineEntry>[
      nextEntry,
      ...state.timeline,
    ];
    if (nextTimeline.length > 50) {
      nextTimeline.removeRange(50, nextTimeline.length);
    }
    state = state.copyWith(timeline: nextTimeline);
  }
}
