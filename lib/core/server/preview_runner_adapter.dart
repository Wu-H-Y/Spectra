import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:spectra/core/server/routes/preview_routes.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// 预览选中元素矩形。
class PreviewSelectedElementRect {
  /// 创建矩形信息。
  const PreviewSelectedElementRect({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  /// 左上角 X。
  final double x;

  /// 左上角 Y。
  final double y;

  /// 宽度。
  final double width;

  /// 高度。
  final double height;

  /// 转为 JSON。
  Map<String, double> toJson() {
    return {
      'x': x,
      'y': y,
      'width': width,
      'height': height,
    };
  }
}

/// 预览 runner 启动结果。
class PreviewSessionStartResult {
  /// 创建启动结果。
  const PreviewSessionStartResult({required this.debugUrl});

  /// 调试 URL。
  final String debugUrl;
}

/// 预览 runner 事件基类。
abstract class PreviewRunnerEvent {
  /// 创建 runner 事件。
  const PreviewRunnerEvent({required this.previewSessionId});

  /// 预览会话 ID。
  final String previewSessionId;
}

/// 预览元素选中事件。
class PreviewElementSelectedEvent extends PreviewRunnerEvent {
  /// 创建元素选中事件。
  const PreviewElementSelectedEvent({
    required super.previewSessionId,
    required this.selector,
    required this.selectorType,
    required this.outerHtml,
    this.textContent,
    this.rect,
    this.xpath,
  });

  /// 首选选择器。
  final String selector;

  /// 选择器类型。
  final String selectorType;

  /// outerHTML。
  final String outerHtml;

  /// 文本内容。
  final String? textContent;

  /// 矩形信息。
  final PreviewSelectedElementRect? rect;

  /// XPath 回退。
  final String? xpath;
}

/// 预览会话关闭事件。
class PreviewSessionClosedEvent extends PreviewRunnerEvent {
  /// 创建会话关闭事件。
  const PreviewSessionClosedEvent({
    required super.previewSessionId,
    required this.reason,
  });

  /// 关闭原因。
  final String reason;
}

/// 预览 runner 会话控制器。
abstract class PreviewSessionController {
  /// 预览 runner 事件流。
  Stream<PreviewRunnerEvent> get events;

  /// 启动会话。
  Future<PreviewSessionStartResult> start();

  /// 切换选择模式。
  Future<void> setSelectionMode({required bool enabled});

  /// 在当前页面测试选择器。
  Future<PreviewSelectorTestResult> testSelector({
    required String selectorType,
    required String expression,
  });

  /// 关闭会话。
  Future<void> close();
}

/// 预览 runner 控制器工厂。
typedef PreviewSessionControllerFactory =
    PreviewSessionController Function({
      required String previewSessionId,
      required String url,
      required String projectRootPath,
      Talker? talker,
    });

/// 预览 runner 适配器。
// ignore: one_member_abstracts
abstract class PreviewRunnerAdapter {
  /// 为预览会话创建控制器。
  PreviewSessionController createSessionController({
    required String previewSessionId,
    required String url,
    required String projectRootPath,
    Talker? talker,
  });
}

/// 默认预览 runner 适配器。
class DefaultPreviewRunnerAdapter implements PreviewRunnerAdapter {
  /// 创建默认适配器。
  const DefaultPreviewRunnerAdapter({
    this.controllerFactory = defaultPreviewSessionControllerFactory,
  });

  /// 控制器工厂。
  final PreviewSessionControllerFactory controllerFactory;

  @override
  PreviewSessionController createSessionController({
    required String previewSessionId,
    required String url,
    required String projectRootPath,
    Talker? talker,
  }) {
    return controllerFactory(
      previewSessionId: previewSessionId,
      url: url,
      projectRootPath: projectRootPath,
      talker: talker,
    );
  }
}

/// 默认进程控制器工厂。
PreviewSessionController defaultPreviewSessionControllerFactory({
  required String previewSessionId,
  required String url,
  required String projectRootPath,
  Talker? talker,
}) {
  return _PreviewRunnerProcessSessionController(
    previewSessionId: previewSessionId,
    url: url,
    projectRootPath: projectRootPath,
    talker: talker,
  );
}

class _PreviewRunnerProcessSessionController
    implements PreviewSessionController {
  _PreviewRunnerProcessSessionController({
    required this.previewSessionId,
    required this.url,
    required this.projectRootPath,
    this.talker,
  });

  static const Duration _commandTimeout = Duration(seconds: 10);
  static const Duration _startTimeout = Duration(seconds: 30);
  static const Duration _closeTimeout = Duration(seconds: 5);

  final String previewSessionId;
  final String url;
  final String projectRootPath;
  final Talker? talker;

  final StreamController<PreviewRunnerEvent> _eventsController =
      StreamController<PreviewRunnerEvent>.broadcast();
  final Map<String, Completer<Map<String, dynamic>>> _pendingCommands = {};
  final List<String> _stderrBuffer = [];
  int _nextCommandId = 0;
  Process? _process;
  bool _closed = false;
  bool _ready = false;
  bool _closedEventSent = false;
  Future<PreviewSessionStartResult>? _startFuture;

  @override
  Stream<PreviewRunnerEvent> get events => _eventsController.stream;

  @override
  Future<PreviewSessionStartResult> start() {
    return _startFuture ??= _startInternal();
  }

  Future<PreviewSessionStartResult> _startInternal() async {
    final runnerFile = File(_runnerScriptPath());
    if (!runnerFile.existsSync()) {
      throw const PreviewRouteException(
        statusCode: 500,
        type: 'preview_runner_missing',
        message: '找不到本地 Playwright 预览 runner',
      );
    }

    try {
      _process = await Process.start(
        Platform.isWindows ? 'node.exe' : 'node',
        [
          runnerFile.path,
          '--session-id',
          previewSessionId,
          '--url',
          url,
        ],
        workingDirectory: projectRootPath,
      );
    } on ProcessException catch (error) {
      throw PreviewRouteException(
        statusCode: 500,
        type: 'preview_runner_spawn_failed',
        message: '启动 Node 预览 runner 失败: ${error.message}',
      );
    }

    final readyCompleter = Completer<PreviewSessionStartResult>();
    _process!.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(
          (line) => _handleStdoutLine(line, readyCompleter),
          onError: (Object error, StackTrace stackTrace) {
            talker?.error('Preview runner stdout failed', error, stackTrace);
          },
        );
    _process!.stderr
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(_handleStderrLine);

    unawaited(
      _process!.exitCode.then((exitCode) {
        _handleProcessExit(exitCode, readyCompleter);
      }),
    );

    return readyCompleter.future.timeout(
      _startTimeout,
      onTimeout: () {
        throw const PreviewRouteException(
          statusCode: 500,
          type: 'preview_runner_start_timeout',
          message: '等待 Chromium 预览窗口启动超时',
        );
      },
    );
  }

  @override
  Future<void> setSelectionMode({required bool enabled}) async {
    await _sendCommand(
      'set_selection_mode',
      <String, dynamic>{'enabled': enabled},
    );
  }

  @override
  Future<PreviewSelectorTestResult> testSelector({
    required String selectorType,
    required String expression,
  }) async {
    final response = await _sendCommand(
      'test_selector',
      <String, dynamic>{
        'selectorType': selectorType,
        'expression': expression,
      },
    );
    final elements = (response['elements'] as List<dynamic>? ?? const [])
        .map((item) => Map<String, dynamic>.from(item as Map<Object?, Object?>))
        .map(
          (item) => PreviewSelectorMatchedElement(
            text: item['text'] as String? ?? '',
            html: item['html'] as String? ?? '',
          ),
        )
        .toList();

    return PreviewSelectorTestResult(
      success: response['success'] as bool? ?? false,
      count: response['count'] as int? ?? elements.length,
      elements: elements,
      error: response['error'] as String?,
    );
  }

  @override
  Future<void> close() async {
    if (_closed) {
      return;
    }
    _closed = true;

    try {
      if (_process != null) {
        try {
          await _sendCommand('close', const <String, dynamic>{});
        } on Exception {
          _process?.kill();
        }
        await _process!.exitCode.timeout(
          _closeTimeout,
          onTimeout: () {
            _process?.kill();
            return -1;
          },
        );
      }
    } finally {
      for (final completer in _pendingCommands.values) {
        if (!completer.isCompleted) {
          completer.completeError(
            const PreviewRouteException(
              statusCode: 500,
              type: 'preview_runner_closed',
              message: '预览 runner 已关闭',
            ),
          );
        }
      }
      _pendingCommands.clear();
      await _eventsController.close();
    }
  }

  Future<Map<String, dynamic>> _sendCommand(
    String command,
    Map<String, dynamic> payload,
  ) async {
    await start();
    final process = _process;
    if (process == null) {
      throw const PreviewRouteException(
        statusCode: 500,
        type: 'preview_runner_unavailable',
        message: '预览 runner 不可用',
      );
    }

    final commandId = 'cmd_${_nextCommandId++}';
    final completer = Completer<Map<String, dynamic>>();
    _pendingCommands[commandId] = completer;
    process.stdin.writeln(
      jsonEncode({
        'kind': 'command',
        'id': commandId,
        'command': command,
        ...payload,
      }),
    );

    return completer.future.timeout(
      _commandTimeout,
      onTimeout: () {
        _pendingCommands.remove(commandId);
        throw PreviewRouteException(
          statusCode: 500,
          type: 'preview_runner_command_timeout',
          message: '等待预览 runner 执行 $command 超时',
        );
      },
    );
  }

  void _handleStdoutLine(
    String line,
    Completer<PreviewSessionStartResult> readyCompleter,
  ) {
    if (line.trim().isEmpty) {
      return;
    }

    try {
      final message = Map<String, dynamic>.from(
        jsonDecode(line) as Map<Object?, Object?>,
      );
      final kind = message['kind'] as String?;
      switch (kind) {
        case 'ready':
          _ready = true;
          if (!readyCompleter.isCompleted) {
            readyCompleter.complete(
              PreviewSessionStartResult(
                debugUrl: message['debugUrl'] as String? ?? url,
              ),
            );
          }
        case 'response':
          final commandId = message['id'] as String?;
          if (commandId == null) {
            return;
          }
          final completer = _pendingCommands.remove(commandId);
          if (completer == null || completer.isCompleted) {
            return;
          }
          if (message['ok'] == true) {
            final result = message['result'];
            final payload = result is Map<Object?, Object?>
                ? Map<String, dynamic>.from(result)
                : <String, dynamic>{};
            completer.complete(payload);
          } else {
            completer.completeError(
              PreviewRouteException(
                statusCode: 500,
                type: 'preview_runner_command_failed',
                message: message['error'] as String? ?? '预览 runner 命令执行失败',
              ),
            );
          }
        case 'event':
          _handleRunnerEventMessage(message);
        default:
          talker?.warning('Unknown preview runner message: $line');
      }
    } on Exception catch (error, stackTrace) {
      talker?.error('Failed to parse preview runner stdout', error, stackTrace);
    }
  }

  void _handleRunnerEventMessage(Map<String, dynamic> message) {
    final event = message['event'] as String?;
    final data = message['data'] is Map<Object?, Object?>
        ? Map<String, dynamic>.from(message['data'] as Map<Object?, Object?>)
        : const <String, dynamic>{};
    switch (event) {
      case 'element_selected':
        final selector = data['selector'] as String? ?? '';
        final xpath = data['xpath'] as String?;
        final runnerSelectorType = data['selectorType'] as String?;
        final resolvedSelector = selector.isNotEmpty ? selector : xpath ?? '';
        final selectorType = runnerSelectorType == 'css'
            ? 'css'
            : runnerSelectorType == 'xpath'
            ? 'xpath'
            : selector.isNotEmpty
            ? 'css'
            : 'xpath';
        if (resolvedSelector.isEmpty) {
          return;
        }
        _eventsController.add(
          PreviewElementSelectedEvent(
            previewSessionId: previewSessionId,
            selector: resolvedSelector,
            selectorType: selectorType,
            outerHtml: data['outerHtml'] as String? ?? '',
            textContent: data['textContent'] as String?,
            rect: _parseRect(data['rect']),
            xpath: xpath,
          ),
        );
      case 'closed':
        _emitClosedEvent(data['reason'] as String? ?? 'runner_closed');
    }
  }

  PreviewSelectedElementRect? _parseRect(Object? rawRect) {
    if (rawRect is! Map<Object?, Object?>) {
      return null;
    }
    final rect = Map<String, dynamic>.from(rawRect);
    final x = (rect['x'] as num?)?.toDouble();
    final y = (rect['y'] as num?)?.toDouble();
    final width = (rect['width'] as num?)?.toDouble();
    final height = (rect['height'] as num?)?.toDouble();
    if (x == null || y == null || width == null || height == null) {
      return null;
    }

    return PreviewSelectedElementRect(
      x: x,
      y: y,
      width: width,
      height: height,
    );
  }

  void _handleStderrLine(String line) {
    if (_stderrBuffer.length >= 20) {
      _stderrBuffer.removeAt(0);
    }
    _stderrBuffer.add(line);
    talker?.debug(line);
  }

  void _handleProcessExit(
    int exitCode,
    Completer<PreviewSessionStartResult> readyCompleter,
  ) {
    if (!_ready && !readyCompleter.isCompleted) {
      readyCompleter.completeError(
        PreviewRouteException(
          statusCode: 500,
          type: 'preview_runner_start_failed',
          message: _stderrBuffer.isEmpty
              ? 'Chromium 预览 runner 启动失败（exitCode=$exitCode）'
              : _stderrBuffer.last,
        ),
      );
    }

    for (final completer in _pendingCommands.values) {
      if (!completer.isCompleted) {
        completer.completeError(
          PreviewRouteException(
            statusCode: 500,
            type: 'preview_runner_exited',
            message: '预览 runner 已退出（exitCode=$exitCode）',
          ),
        );
      }
    }
    _pendingCommands.clear();
    _emitClosedEvent('process_exit_$exitCode');
  }

  void _emitClosedEvent(String reason) {
    if (_closedEventSent || _eventsController.isClosed) {
      return;
    }
    _closedEventSent = true;
    _eventsController.add(
      PreviewSessionClosedEvent(
        previewSessionId: previewSessionId,
        reason: reason,
      ),
    );
  }

  String _runnerScriptPath() {
    return [
      projectRootPath,
      'tools',
      'preview-runner',
      'index.mjs',
    ].join(Platform.pathSeparator);
  }
}
