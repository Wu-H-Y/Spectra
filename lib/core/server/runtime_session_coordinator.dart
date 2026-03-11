import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:spectra/core/server/preview_runner_adapter.dart';
import 'package:spectra/core/server/routes/preview_routes.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// 预览选择状态变更回调。
typedef PublishSelectionStateCallback = void Function({
  required String previewSessionId,
  required String? sessionId,
  required bool isSelecting,
});

/// 元素选中回调。
typedef PublishElementSelectedCallback = void Function(
  PreviewElementSelectedEvent event, {
  required String? sessionId,
});

/// Runtime 会话协调器配置。
@immutable
class RuntimeSessionCoordinatorConfig {
  /// 创建协调器配置。
  const RuntimeSessionCoordinatorConfig({
    this.maxConcurrentPreviewSessions = 2,
    this.previewSessionIdleTimeout = const Duration(minutes: 5),
  });

  /// 允许同时活跃的预览会话上限。
  final int maxConcurrentPreviewSessions;

  /// 预览会话空闲超时。
  final Duration previewSessionIdleTimeout;
}

/// Runtime 会话协调器接口。
abstract class RuntimeSessionCoordinator {
  /// 打开预览会话。
  Future<PreviewOpenResult> openPreview({
    required String url,
    String? sessionId,
  });

  /// 测试预览选择器。
  Future<PreviewSelectorTestResult> testPreviewSelector({
    required String previewSessionId,
    required String selectorType,
    required String expression,
  });

  /// 切换预览选择模式。
  Future<void> setPreviewSelectionMode({
    required String previewSessionId,
    required bool enabled,
  });

  /// 关闭所有预览会话。
  Future<void> closeAllPreviewSessions({required String reason});

  /// 查询预览会话归属的 sessionId。
  String? sessionIdForPreviewSession(String previewSessionId);
}

/// 默认 Runtime 会话协调器实现。
class RuntimeSessionCoordinatorImpl implements RuntimeSessionCoordinator {
  /// 创建协调器。
  RuntimeSessionCoordinatorImpl({
    required this.previewRunnerAdapter,
    required this.projectRootPath,
    required this.previewSessionIdGenerator,
    required this.publishSelectionState,
    required this.publishElementSelected,
    this.talker,
    this.config = const RuntimeSessionCoordinatorConfig(),
  });

  /// 预览 runner 适配器。
  final PreviewRunnerAdapter previewRunnerAdapter;

  /// 项目根目录。
  final String projectRootPath;

  /// 预览会话 ID 生成器。
  final String Function() previewSessionIdGenerator;

  /// 选择状态发布回调。
  final PublishSelectionStateCallback publishSelectionState;

  /// 元素选中发布回调。
  final PublishElementSelectedCallback publishElementSelected;

  /// 日志器。
  final Talker? talker;

  /// 协调器配置。
  final RuntimeSessionCoordinatorConfig config;

  final Map<String, _PreviewSessionRuntime> _previewSessions = {};

  @override
  Future<PreviewOpenResult> openPreview({
    required String url,
    String? sessionId,
  }) async {
    if (_previewSessions.length >= config.maxConcurrentPreviewSessions) {
      throw const PreviewRouteException(
        statusCode: 429,
        type: 'preview_session_limit_reached',
        message: '已达到 Chromium 预览会话上限，请先关闭旧会话',
      );
    }

    final previewSessionId = previewSessionIdGenerator();
    final controller = previewRunnerAdapter.createSessionController(
      previewSessionId: previewSessionId,
      url: url,
      projectRootPath: projectRootPath,
      talker: talker,
    );

    final now = DateTime.now().toUtc();
    final session =
        _PreviewSessionRuntime(
            previewSessionId: previewSessionId,
            url: url,
            sessionId: sessionId,
            createdAt: now,
            controller: controller,
          )
          ..eventSubscription = controller.events.listen(
            _handlePreviewRunnerEvent,
            onError: (Object error, StackTrace stackTrace) {
              talker?.error(
                'Preview runner event stream failed',
                error,
                stackTrace,
              );
              unawaited(
                _closePreviewSession(
                  previewSessionId,
                  reason: 'runner_event_error',
                  notifyRunner: false,
                  publishSelectionCancelled: true,
                ),
              );
            },
          );

    try {
      final startResult = await controller.start();
      _previewSessions[previewSessionId] = session;
      _touchPreviewSession(session);
      talker?.info('Preview session opened: $previewSessionId');

      return PreviewOpenResult(
        previewSessionId: previewSessionId,
        debugUrl: startResult.debugUrl,
        wsChannel: {'previewSessionId': previewSessionId},
      );
    } on PreviewRouteException {
      await session.cancelEventSubscription();
      await controller.close();
      rethrow;
    } on Exception catch (error, stackTrace) {
      await session.cancelEventSubscription();
      await controller.close();
      talker?.error('Preview session open failed', error, stackTrace);
      throw const PreviewRouteException(
        statusCode: 500,
        type: 'preview_runner_error',
        message: '启动 Chromium 预览失败',
      );
    }
  }

  @override
  Future<PreviewSelectorTestResult> testPreviewSelector({
    required String previewSessionId,
    required String selectorType,
    required String expression,
  }) async {
    final session = _previewSessions[previewSessionId];
    if (session == null) {
      throw const PreviewRouteException(
        statusCode: 404,
        type: 'preview_session_not_found',
        message: '预览会话不存在或已关闭',
      );
    }

    final normalizedType = selectorType.trim().toLowerCase();
    if (normalizedType != 'css' && normalizedType != 'xpath') {
      throw const PreviewRouteException(
        statusCode: 400,
        type: 'unsupported_selector_type',
        message: '预览选择器测试仅支持 CSS 或 XPath',
      );
    }

    final result = await session.controller.testSelector(
      selectorType: normalizedType,
      expression: expression,
    );
    _touchPreviewSession(session);
    return result;
  }

  @override
  Future<void> setPreviewSelectionMode({
    required String previewSessionId,
    required bool enabled,
  }) async {
    final session = _previewSessions[previewSessionId];
    if (session == null) {
      throw const PreviewRouteException(
        statusCode: 404,
        type: 'preview_session_not_found',
        message: '预览会话不存在或已关闭',
      );
    }

    await session.controller.setSelectionMode(enabled: enabled);
    session.isSelecting = enabled;
    _touchPreviewSession(session);
    publishSelectionState(
      previewSessionId: previewSessionId,
      sessionId: session.sessionId,
      isSelecting: enabled,
    );
  }

  @override
  Future<void> closeAllPreviewSessions({required String reason}) async {
    for (final previewSessionId in _previewSessions.keys.toList()) {
      await _closePreviewSession(previewSessionId, reason: reason);
    }
  }

  @override
  String? sessionIdForPreviewSession(String previewSessionId) {
    return _previewSessions[previewSessionId]?.sessionId;
  }

  void _handlePreviewRunnerEvent(PreviewRunnerEvent event) {
    final session = _previewSessions[event.previewSessionId];
    if (session == null) {
      return;
    }
    _touchPreviewSession(session);

    switch (event) {
      case PreviewElementSelectedEvent():
        session.isSelecting = false;
        publishElementSelected(event, sessionId: session.sessionId);
      case PreviewSessionClosedEvent():
        unawaited(
          _closePreviewSession(
            event.previewSessionId,
            reason: event.reason,
            notifyRunner: false,
            publishSelectionCancelled: true,
          ),
        );
    }
  }

  void _touchPreviewSession(_PreviewSessionRuntime session) {
    session.lastActivityAt = DateTime.now().toUtc();
    session.idleTimer?.cancel();
    session.idleTimer = Timer(config.previewSessionIdleTimeout, () {
      unawaited(
        _closePreviewSession(
          session.previewSessionId,
          reason: 'idle_timeout',
          publishSelectionCancelled: true,
        ),
      );
    });
  }

  Future<void> _closePreviewSession(
    String previewSessionId, {
    required String reason,
    bool notifyRunner = true,
    bool publishSelectionCancelled = false,
  }) async {
    final session = _previewSessions.remove(previewSessionId);
    if (session == null) {
      return;
    }

    session.idleTimer?.cancel();
    await session.eventSubscription?.cancel();
    if (publishSelectionCancelled && session.isSelecting) {
      publishSelectionState(
        previewSessionId: previewSessionId,
        sessionId: session.sessionId,
        isSelecting: false,
      );
    }

    if (notifyRunner) {
      try {
        await session.controller.close();
      } on Exception catch (error, stackTrace) {
        talker?.error('Failed to close preview runner', error, stackTrace);
      }
    }

    talker?.info('Preview session closed: $previewSessionId ($reason)');
  }
}

class _PreviewSessionRuntime {
  _PreviewSessionRuntime({
    required this.previewSessionId,
    required this.url,
    required this.sessionId,
    required this.createdAt,
    required this.controller,
  }) : lastActivityAt = createdAt;

  final String previewSessionId;
  final String url;
  final String? sessionId;
  final DateTime createdAt;
  final PreviewSessionController controller;
  DateTime lastActivityAt;
  bool isSelecting = false;
  Timer? idleTimer;
  StreamSubscription<PreviewRunnerEvent>? eventSubscription;

  Future<void> cancelEventSubscription() async {
    await eventSubscription?.cancel();
    eventSubscription = null;
  }
}
