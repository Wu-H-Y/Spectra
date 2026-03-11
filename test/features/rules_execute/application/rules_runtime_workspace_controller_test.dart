import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/errors/app_failure.dart';
import 'package:spectra/core/server/runtime_workspace_client.dart';
import 'package:spectra/core/server/server_provider.dart';
import 'package:spectra/features/rules_execute/application/rules_runtime_workspace_controller.dart';
import 'package:spectra/features/rules_execute/application/rules_runtime_workspace_state.dart';

void main() {
  test('controller maps session preview and runs into workspace state', () async {
    final client = _FakeRuntimeWorkspaceClient();
    final container = ProviderContainer(
      overrides: [
        runtimeWorkspaceClientProvider.overrideWithValue(client),
        runtimeWorkspaceSessionIdProvider.overrideWithValue(
          'session_runtime_test',
        ),
        serverProvider.overrideWithValue(
          const ServerStatus(
            isRunning: true,
            port: 8080,
            url: 'http://localhost:8080',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    final stateSubscription = container.listen(
      rulesRuntimeWorkspaceControllerProvider,
      (_, _) {},
    );
    addTearDown(stateSubscription.close);

    final controller = container.read(
      rulesRuntimeWorkspaceControllerProvider.notifier,
    );

    await controller.refreshWorkspace();

    expect(
      container.read(rulesRuntimeWorkspaceControllerProvider).sessionId,
      'session_runtime_test',
    );
    expect(
      container.read(rulesRuntimeWorkspaceControllerProvider).selectedRuleId,
      1,
    );
    expect(
      container.read(rulesRuntimeWorkspaceControllerProvider).timelineConnected,
      isTrue,
    );

    await controller.openPreview('https://example.com/story');

    expect(
      container.read(rulesRuntimeWorkspaceControllerProvider).activePreview
          ?.previewSessionId,
      'preview_runtime_001',
    );

    await controller.executeSelectedRule();

    var state = container.read(rulesRuntimeWorkspaceControllerProvider);
    expect(state.runsById.keys, contains('run_runtime_001'));
    expect(
      state.runsById['run_runtime_001']?.status,
      RuntimeWorkspaceRunStatus.accepted,
    );

    client.emit(
      RuntimeTimelineMessage(
        type: 'node_event',
        data: {'event': 'run_started', 'runId': 'run_runtime_001', 'seq': 1},
        receivedAt: _startedAt,
      ),
    );
    await Future<void>.delayed(Duration.zero);

    state = container.read(rulesRuntimeWorkspaceControllerProvider);
    expect(
      state.runsById['run_runtime_001']?.status,
      RuntimeWorkspaceRunStatus.running,
    );

    client.emit(
      RuntimeTimelineMessage(
        type: 'node_event',
        data: {
          'event': 'run_finished',
          'runId': 'run_runtime_001',
          'seq': 2,
          'success': true,
        },
        receivedAt: _finishedAt,
      ),
    );
    await Future<void>.delayed(Duration.zero);

    state = container.read(rulesRuntimeWorkspaceControllerProvider);
    expect(
      state.runsById['run_runtime_001']?.status,
      RuntimeWorkspaceRunStatus.finished,
    );
    expect(state.runsById['run_runtime_001']?.success, isTrue);
    expect(state.timeline.map((item) => item.type), contains('preview_opened'));
    expect(state.timeline.map((item) => item.type), contains('run_accepted'));
    expect(state.timeline.map((item) => item.type), contains('node_event'));
  });
}

final _startedAt = DateTime.utc(2026, 3, 9, 12, 0, 1);
final _finishedAt = DateTime.utc(2026, 3, 9, 12, 0, 2);

class _FakeRuntimeWorkspaceClient implements RuntimeWorkspaceClient {
  final _connection = _FakeRuntimeSessionTimelineConnection();

  @override
  Future<Either<AppFailure, RuntimeSessionTimelineConnection>>
  connectSessionTimeline({
    required String serverUrl,
    required String serverToken,
    required String sessionId,
  }) async {
    return right(_connection);
  }

  @override
  void dispose() {}

  void emit(RuntimeTimelineMessage message) {
    _connection.emit(message);
  }

  @override
  Future<Either<AppFailure, RuntimeExecuteAccepted>> executeRule({
    required String serverUrl,
    required String serverToken,
    required Map<String, dynamic> rule,
    required String sessionId,
    String? previewSessionId,
  }) async {
    return right(
      const RuntimeExecuteAccepted(
        runId: 'run_runtime_001',
        status: 'accepted',
        responseJson: {'runId': 'run_runtime_001', 'status': 'accepted'},
      ),
    );
  }

  @override
  Future<Either<AppFailure, RuntimeServerSnapshot>> fetchServerSnapshot({
    required String serverUrl,
  }) async {
    return right(
      const RuntimeServerSnapshot(
        isRunning: true,
        port: 8080,
        url: 'http://localhost:8080',
        serverToken: 'st_runtime_test',
      ),
    );
  }

  @override
  Future<Either<AppFailure, RuntimeRuleDocument>> getRule({
    required String serverUrl,
    required String serverToken,
    required int id,
  }) async {
    return right(
      const RuntimeRuleDocument(
        id: 1,
        ruleId: 'demo.runtime',
        enabled: true,
        rule: {
          'irVersion': '1.0.0',
          'metadata': {'ruleId': 'demo.runtime', 'name': 'Runtime Rule'},
          'graph': {'nodes': [], 'edges': [], 'phaseEntrypoints': {}},
          'normalizedOutputs': {},
          'capabilities': {
            'supportsPagination': false,
            'supportsConcurrency': false,
            'requiresAuth': false,
          },
        },
      ),
    );
  }

  @override
  Future<Either<AppFailure, List<RuntimeRuleSummary>>> listRules({
    required String serverUrl,
    required String serverToken,
  }) async {
    return right([
      RuntimeRuleSummary(
        id: 1,
        ruleId: 'demo.runtime',
        name: 'Runtime Rule',
        irVersion: '1.0.0',
        updatedAt: DateTime.utc(2026, 3, 9, 12),
      ),
    ]);
  }

  @override
  Future<Either<AppFailure, RuntimePreviewSession>> openPreview({
    required String serverUrl,
    required String serverToken,
    required String sessionId,
    required String previewUrl,
  }) async {
    return right(
      RuntimePreviewSession(
        previewSessionId: 'preview_runtime_001',
        debugUrl: 'ws://debug/runtime',
        previewUrl: previewUrl,
      ),
    );
  }

  @override
  Future<Either<AppFailure, RuntimeSelectorTestResult>> testSelector({
    required String serverUrl,
    required String serverToken,
    required String previewSessionId,
    required String selectorType,
    required String expression,
  }) async {
    return right(
      const RuntimeSelectorTestResult(
        success: true,
        count: 1,
        elements: [
          RuntimeSelectorMatchedElement(text: 'Test', html: '<div>Test</div>'),
        ],
      ),
    );
  }
}

class _FakeRuntimeSessionTimelineConnection
    implements RuntimeSessionTimelineConnection {
  final StreamController<RuntimeTimelineMessage> _controller =
      StreamController<RuntimeTimelineMessage>.broadcast();

  @override
  Stream<RuntimeTimelineMessage> get messages => _controller.stream;

  void emit(RuntimeTimelineMessage message) {
    _controller.add(message);
  }

  @override
  Future<void> close() async {
    await _controller.close();
  }
}
