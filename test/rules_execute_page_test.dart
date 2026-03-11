import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/errors/app_failure.dart';
import 'package:spectra/core/server/runtime_workspace_client.dart';
import 'package:spectra/core/server/server_provider.dart';
import 'package:spectra/features/rules_execute/application/rules_runtime_workspace_controller.dart';
import 'package:spectra/features/rules_execute/presentation/pages/rules_execute_page.dart';
import 'package:spectra/l10n/generated/l10n.dart';

void main() {
  testWidgets('renders runtime workspace state and run results', (tester) async {
    final client = _FakeRuntimeWorkspaceClient();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          runtimeWorkspaceClientProvider.overrideWithValue(client),
          runtimeWorkspaceSessionIdProvider.overrideWithValue(
            'session_runtime_page_test',
          ),
          serverProvider.overrideWithValue(
            const ServerStatus(
              isRunning: true,
              port: 8080,
              url: 'http://localhost:8080',
            ),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const RulesExecutePage(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.byKey(const Key('rules_execute_server_section')), findsOne);
    expect(find.byKey(const Key('rules_execute_workspace_section')), findsOne);
    expect(find.text('session_runtime_page_test'), findsOneWidget);
    expect(find.byKey(const Key('rules_execute_preview_section')), findsOne);
    await tester.scrollUntilVisible(
      find.byKey(const Key('rules_execute_runs_section')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.byKey(const Key('rules_execute_runs_section')), findsOne);
    await tester.scrollUntilVisible(
      find.byKey(const Key('rules_execute_timeline_section')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.byKey(const Key('rules_execute_timeline_section')), findsOne);

    // Select a rule from the dropdown first (required before executing)
    await tester.tap(find.byType(DropdownButtonFormField<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Runtime Page Rule (demo.runtime.page)').last);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField).first,
      'https://example.com/runtime',
    );
    await tester.tap(find.byKey(const Key('rules_execute_preview_button')));
    await tester.pumpAndSettle();

    expect(find.text('preview_runtime_page_test'), findsOneWidget);

    // Scroll to make run button visible again after preview opened
    await tester.scrollUntilVisible(
      find.byKey(const Key('rules_execute_run_button')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byKey(const Key('rules_execute_run_button')));
    await tester.pumpAndSettle();

    expect(find.text('Runtime Page Rule'), findsWidgets);
    expect(find.text('run_runtime_page_test'), findsWidgets);
    expect(
      find.byKey(const Key('rules_execute_response_section')),
      findsOneWidget,
    );

    client.emit(
      RuntimeTimelineMessage(
        type: 'node_event',
        data: {
          'event': 'run_started',
          'runId': 'run_runtime_page_test',
          'seq': 1,
        },
        receivedAt: DateTime.utc(2026, 3, 9, 12, 0, 1),
      ),
    );
    await tester.pump();

    client.emit(
      RuntimeTimelineMessage(
        type: 'node_event',
        data: {
          'event': 'run_finished',
          'runId': 'run_runtime_page_test',
          'seq': 2,
          'success': true,
        },
        receivedAt: DateTime.utc(2026, 3, 9, 12, 0, 2),
      ),
    );
    await tester.pump();

    final context = tester.element(find.byType(RulesExecutePage));
    final l10n = S.of(context);
    expect(find.text(l10n.rulesExecuteRunStatusFinished), findsOneWidget);
  });
}

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
        runId: 'run_runtime_page_test',
        status: 'accepted',
        responseJson: {
          'runId': 'run_runtime_page_test',
          'status': 'accepted',
        },
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
        serverToken: 'st_runtime_page_test',
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
        ruleId: 'demo.runtime.page',
        enabled: true,
        rule: {
          'irVersion': '1.0.0',
          'metadata': {
            'ruleId': 'demo.runtime.page',
            'name': 'Runtime Page Rule',
          },
          'graph': {
            'nodes': <Object?>[],
            'edges': <Object?>[],
            'phaseEntrypoints': <String, Object?>{},
          },
          'normalizedOutputs': <String, Object?>{},
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
        ruleId: 'demo.runtime.page',
        name: 'Runtime Page Rule',
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
        previewSessionId: 'preview_runtime_page_test',
        debugUrl: 'ws://debug/page',
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
