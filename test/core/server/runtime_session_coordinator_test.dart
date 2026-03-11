import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:spectra/core/server/preview_runner_adapter.dart';
import 'package:spectra/core/server/routes/preview_routes.dart';
import 'package:spectra/core/server/runtime_session_coordinator.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  test(
    'coordinator closes selecting session and publishes cancelled state',
    () async {
    final adapter = _FakePreviewRunnerAdapter();
    final selectionStates = <({String previewSessionId, bool isSelecting})>[];

      final coordinator = RuntimeSessionCoordinatorImpl(
      previewRunnerAdapter: adapter,
      projectRootPath: 'D:/workspace/workspace_flutter/Spectra',
      previewSessionIdGenerator: () => 'preview_runtime_001',
      publishSelectionState: ({
        required previewSessionId,
        required sessionId,
        required isSelecting,
      }) {
        selectionStates.add(
          (
            previewSessionId: previewSessionId,
            isSelecting: isSelecting,
          ),
        );
      },
      publishElementSelected: (_, {required sessionId}) {},
    );

      final openResult = await coordinator.openPreview(
        url: 'https://example.com/runtime',
        sessionId: 'session_runtime_001',
      );

      expect(openResult.previewSessionId, 'preview_runtime_001');
      expect(openResult.debugUrl, 'https://example.com/runtime');
      expect(openResult.wsChannel, {
        'previewSessionId': 'preview_runtime_001',
      });

      await coordinator.setPreviewSelectionMode(
        previewSessionId: 'preview_runtime_001',
        enabled: true,
      );

      final controller = adapter.controllers['preview_runtime_001']!;
      expect(controller.selectionModeHistory, [true]);
      expect(selectionStates, [
        (
          previewSessionId: 'preview_runtime_001',
          isSelecting: true,
        ),
      ]);

      controller.emitClosed('browser_closed');
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(selectionStates, [
        (
          previewSessionId: 'preview_runtime_001',
          isSelecting: true,
        ),
        (
          previewSessionId: 'preview_runtime_001',
          isSelecting: false,
        ),
      ]);

      await expectLater(
        coordinator.testPreviewSelector(
          previewSessionId: 'preview_runtime_001',
          selectorType: 'css',
          expression: '#story',
        ),
        throwsA(
          isA<PreviewRouteException>().having(
            (error) => error.type,
            'type',
            'preview_session_not_found',
          ),
        ),
      );
    },
  );

  test('coordinator enforces max concurrent preview sessions', () async {
    final adapter = _FakePreviewRunnerAdapter();
    var index = 0;
    final coordinator = RuntimeSessionCoordinatorImpl(
      previewRunnerAdapter: adapter,
      projectRootPath: 'D:/workspace/workspace_flutter/Spectra',
      previewSessionIdGenerator: () {
        index += 1;
        return 'preview_runtime_00$index';
      },
      publishSelectionState: ({
        required previewSessionId,
        required sessionId,
        required isSelecting,
      }) {},
      publishElementSelected: (_, {required sessionId}) {},
    );

    await coordinator.openPreview(url: 'https://example.com/1');
    await coordinator.openPreview(url: 'https://example.com/2');

    await expectLater(
      coordinator.openPreview(url: 'https://example.com/3'),
      throwsA(
        isA<PreviewRouteException>().having(
          (error) => error.type,
          'type',
          'preview_session_limit_reached',
        ),
      ),
    );

    await coordinator.closeAllPreviewSessions(reason: 'test_teardown');

    expect(adapter.controllers['preview_runtime_001']!.closeCalls, 1);
    expect(adapter.controllers['preview_runtime_002']!.closeCalls, 1);
  });
}

class _FakePreviewRunnerAdapter implements PreviewRunnerAdapter {
  final Map<String, _FakePreviewSessionController> controllers = {};

  @override
  PreviewSessionController createSessionController({
    required String previewSessionId,
    required String url,
    required String projectRootPath,
    Talker? talker,
  }) {
    final controller = _FakePreviewSessionController(
      previewSessionId: previewSessionId,
      debugUrl: url,
    );
    controllers[previewSessionId] = controller;
    return controller;
  }
}

class _FakePreviewSessionController implements PreviewSessionController {
  _FakePreviewSessionController({
    required this.previewSessionId,
    required this.debugUrl,
  });

  final String previewSessionId;
  final String debugUrl;
  final StreamController<PreviewRunnerEvent> _eventsController =
      StreamController<PreviewRunnerEvent>.broadcast();

  int startCalls = 0;
  int closeCalls = 0;
  final List<bool> selectionModeHistory = [];

  @override
  Stream<PreviewRunnerEvent> get events => _eventsController.stream;

  @override
  Future<PreviewSessionStartResult> start() async {
    startCalls += 1;
    return PreviewSessionStartResult(debugUrl: debugUrl);
  }

  @override
  Future<void> setSelectionMode({required bool enabled}) async {
    selectionModeHistory.add(enabled);
  }

  @override
  Future<PreviewSelectorTestResult> testSelector({
    required String selectorType,
    required String expression,
  }) async {
    return const PreviewSelectorTestResult(
      success: true,
      count: 1,
      elements: [
        PreviewSelectorMatchedElement(
          text: 'Story',
          html: '<article id="story">Story</article>',
        ),
      ],
    );
  }

  @override
  Future<void> close() async {
    closeCalls += 1;
    await _eventsController.close();
  }

  void emitClosed(String reason) {
    _eventsController.add(
      PreviewSessionClosedEvent(
        previewSessionId: previewSessionId,
        reason: reason,
      ),
    );
  }
}
