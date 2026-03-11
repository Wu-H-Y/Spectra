import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:spectra/core/errors/app_failure.dart';
import 'package:spectra/core/errors/exception_mapper.dart';

/// Runtime 工作区服务端快照。
@immutable
class RuntimeServerSnapshot {
  /// 创建服务端快照。
  const RuntimeServerSnapshot({
    required this.isRunning,
    required this.port,
    required this.url,
    required this.serverToken,
  });

  /// 服务端是否运行中。
  final bool isRunning;

  /// 端口号。
  final int port;

  /// 服务端地址。
  final String url;

  /// 鉴权令牌。
  final String serverToken;
}

/// Runtime 工作区规则摘要。
@immutable
class RuntimeRuleSummary {
  /// 创建规则摘要。
  const RuntimeRuleSummary({
    required this.id,
    required this.ruleId,
    required this.name,
    required this.irVersion,
    required this.updatedAt,
  });

  /// 数据库主键。
  final int id;

  /// 规则 ID。
  final String ruleId;

  /// 规则名称。
  final String name;

  /// IR 版本。
  final String irVersion;

  /// 更新时间。
  final DateTime updatedAt;
}

/// Runtime 工作区规则详情。
@immutable
class RuntimeRuleDocument {
  /// 创建规则详情。
  const RuntimeRuleDocument({
    required this.id,
    required this.ruleId,
    required this.enabled,
    required this.rule,
  });

  /// 数据库主键。
  final int id;

  /// 规则 ID。
  final String ruleId;

  /// 是否启用。
  final bool enabled;

  /// 规则信封。
  final Map<String, dynamic> rule;
}

/// Runtime 工作区预览结果。
@immutable
class RuntimePreviewSession {
  /// 创建预览结果。
  const RuntimePreviewSession({
    required this.previewSessionId,
    required this.debugUrl,
    required this.previewUrl,
  });

  /// 预览会话 ID。
  final String previewSessionId;

  /// Chromium 调试地址。
  final String debugUrl;

  /// 预览页面地址。
  final String previewUrl;
}

/// Runtime 执行受理结果。
@immutable
class RuntimeExecuteAccepted {
  /// 创建执行受理结果。
  const RuntimeExecuteAccepted({
    required this.runId,
    required this.status,
    required this.responseJson,
  });

  /// 运行 ID。
  final String runId;

  /// 服务端受理状态。
  final String status;

  /// 原始响应 JSON。
  final Map<String, dynamic> responseJson;
}

/// Runtime 选择器匹配元素。
@immutable
class RuntimeSelectorMatchedElement {
  /// 创建匹配元素。
  const RuntimeSelectorMatchedElement({
    required this.text,
    required this.html,
  });

  /// 元素文本。
  final String text;

  /// 元素 HTML。
  final String html;
}

/// Runtime 选择器测试结果。
@immutable
class RuntimeSelectorTestResult {
  /// 创建选择器测试结果。
  const RuntimeSelectorTestResult({
    required this.success,
    required this.count,
    required this.elements,
    this.error,
  });

  /// 是否成功。
  final bool success;

  /// 匹配数量。
  final int count;

  /// 匹配样本。
  final List<RuntimeSelectorMatchedElement> elements;

  /// 错误信息。
  final String? error;
}

/// Runtime 时间线消息。
@immutable
class RuntimeTimelineMessage {
  /// 创建时间线消息。
  const RuntimeTimelineMessage({
    required this.type,
    required this.data,
    required this.receivedAt,
  });

  /// 消息类型。
  final String type;

  /// 消息负载。
  final Map<String, dynamic> data;

  /// 接收时间。
  final DateTime receivedAt;

  /// 关联 runId。
  String? get runId => data['runId'] as String?;

  /// 节点事件名称。
  String? get event => data['event'] as String?;

  /// 关联 previewSessionId。
  String? get previewSessionId => data['previewSessionId'] as String?;

  /// 事件序号。
  int? get seq => data['seq'] as int?;
}

/// Runtime 会话时间线连接。
abstract class RuntimeSessionTimelineConnection {
  /// 时间线消息流。
  Stream<RuntimeTimelineMessage> get messages;

  /// 主动关闭连接。
  Future<void> close();
}

/// Runtime 工作区服务端客户端。
abstract class RuntimeWorkspaceClient {
  /// 读取服务端快照。
  Future<Either<AppFailure, RuntimeServerSnapshot>> fetchServerSnapshot({
    required String serverUrl,
  });

  /// 拉取规则列表。
  Future<Either<AppFailure, List<RuntimeRuleSummary>>> listRules({
    required String serverUrl,
    required String serverToken,
  });

  /// 拉取规则详情。
  Future<Either<AppFailure, RuntimeRuleDocument>> getRule({
    required String serverUrl,
    required String serverToken,
    required int id,
  });

  /// 打开预览。
  Future<Either<AppFailure, RuntimePreviewSession>> openPreview({
    required String serverUrl,
    required String serverToken,
    required String sessionId,
    required String previewUrl,
  });

  /// 执行规则。
  Future<Either<AppFailure, RuntimeExecuteAccepted>> executeRule({
    required String serverUrl,
    required String serverToken,
    required Map<String, dynamic> rule,
    required String sessionId,
    String? previewSessionId,
  });

  /// 建立会话时间线连接。
  Future<Either<AppFailure, RuntimeSessionTimelineConnection>>
  connectSessionTimeline({
    required String serverUrl,
    required String serverToken,
    required String sessionId,
  });

  /// 测试选择器。
  Future<Either<AppFailure, RuntimeSelectorTestResult>> testSelector({
    required String serverUrl,
    required String serverToken,
    required String previewSessionId,
    required String selectorType,
    required String expression,
  });

  /// 释放客户端资源。
  void dispose();
}

/// 基于 Dio/WS 的 Runtime 工作区客户端。
class DefaultRuntimeWorkspaceClient implements RuntimeWorkspaceClient {
  /// 创建客户端。
  DefaultRuntimeWorkspaceClient({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 15),
              validateStatus: (_) => true,
            ),
          );

  final Dio _dio;

  @override
  Future<Either<AppFailure, RuntimeServerSnapshot>> fetchServerSnapshot({
    required String serverUrl,
  }) async {
    try {
      final response = await _dio.get<Object?>('$serverUrl/api/server/status');
      final body = _expectJsonMap(response.data);
      if (body == null) {
        return left(const AppFailure.parseError());
      }

      final isRunning = body['isRunning'];
      final port = body['port'];
      final url = body['url'];
      final serverToken = body['serverToken'];
      if (isRunning is! bool ||
          port is! int ||
          url is! String ||
          serverToken is! String ||
          url.isEmpty ||
          serverToken.isEmpty) {
        return left(const AppFailure.parseError());
      }

      return right(
        RuntimeServerSnapshot(
          isRunning: isRunning,
          port: port,
          url: url,
          serverToken: serverToken,
        ),
      );
    } on Exception catch (error, stackTrace) {
      return left(ExceptionMapper.map(error, stackTrace));
    }
  }

  @override
  Future<Either<AppFailure, List<RuntimeRuleSummary>>> listRules({
    required String serverUrl,
    required String serverToken,
  }) async {
    try {
      final response = await _authorizedGet(
        '$serverUrl/api/rules',
        serverToken: serverToken,
      );
      final failure = _failureFromResponse(response);
      if (failure != null) {
        return left(failure);
      }

      final body = _expectJsonMap(response.data);
      final items = body?['items'];
      if (items is! List<Object?>) {
        return left(const AppFailure.parseError());
      }

      final result = <RuntimeRuleSummary>[];
      for (final item in items) {
        if (item is! Map<String, dynamic>) {
          return left(const AppFailure.parseError());
        }

        final id = item['id'];
        final ruleId = item['ruleId'];
        final name = item['name'];
        final irVersion = item['irVersion'];
        final updatedAt = item['updatedAt'];
        if (id is! int ||
            ruleId is! String ||
            name is! String ||
            irVersion is! String ||
            updatedAt is! String) {
          return left(const AppFailure.parseError());
        }

        result.add(
          RuntimeRuleSummary(
            id: id,
            ruleId: ruleId,
            name: name,
            irVersion: irVersion,
            updatedAt: DateTime.parse(updatedAt).toUtc(),
          ),
        );
      }

      return right(result);
    } on FormatException {
      return left(const AppFailure.parseError());
    } on Exception catch (error, stackTrace) {
      return left(ExceptionMapper.map(error, stackTrace));
    }
  }

  @override
  Future<Either<AppFailure, RuntimeRuleDocument>> getRule({
    required String serverUrl,
    required String serverToken,
    required int id,
  }) async {
    try {
      final response = await _authorizedGet(
        '$serverUrl/api/rules/$id',
        serverToken: serverToken,
      );
      final failure = _failureFromResponse(response);
      if (failure != null) {
        return left(failure);
      }

      final body = _expectJsonMap(response.data);
      final ruleId = body?['ruleId'];
      final enabled = body?['enabled'];
      final rule = body?['rule'];
      if (ruleId is! String ||
          enabled is! bool ||
          rule is! Map<String, dynamic>) {
        return left(const AppFailure.parseError());
      }

      return right(
        RuntimeRuleDocument(
          id: id,
          ruleId: ruleId,
          enabled: enabled,
          rule: rule,
        ),
      );
    } on Exception catch (error, stackTrace) {
      return left(ExceptionMapper.map(error, stackTrace));
    }
  }

  @override
  Future<Either<AppFailure, RuntimePreviewSession>> openPreview({
    required String serverUrl,
    required String serverToken,
    required String sessionId,
    required String previewUrl,
  }) async {
    try {
      final response = await _authorizedPost(
        '$serverUrl/api/preview/open',
        serverToken: serverToken,
        data: {'url': previewUrl, 'sessionId': sessionId},
        isHostOnly: true,
      );
      final failure = _failureFromResponse(response);
      if (failure != null) {
        return left(failure);
      }

      final body = _expectJsonMap(response.data);
      final previewSessionId = body?['previewSessionId'];
      final debugUrl = body?['debugUrl'];
      if (previewSessionId is! String || debugUrl is! String) {
        return left(const AppFailure.parseError());
      }

      return right(
        RuntimePreviewSession(
          previewSessionId: previewSessionId,
          debugUrl: debugUrl,
          previewUrl: previewUrl,
        ),
      );
    } on Exception catch (error, stackTrace) {
      return left(ExceptionMapper.map(error, stackTrace));
    }
  }

  @override
  Future<Either<AppFailure, RuntimeExecuteAccepted>> executeRule({
    required String serverUrl,
    required String serverToken,
    required Map<String, dynamic> rule,
    required String sessionId,
    String? previewSessionId,
  }) async {
    try {
      final response = await _authorizedPost(
        '$serverUrl/api/rules/execute',
        serverToken: serverToken,
        data: {
          'rule': rule,
          'context': {
            'sessionId': sessionId,
            ...?previewSessionId == null
                ? null
                : {'previewSessionId': previewSessionId},
          },
        },
        isHostOnly: true,
      );
      final failure = _failureFromResponse(response);
      if (failure != null) {
        return left(failure);
      }

      final body = _expectJsonMap(response.data);
      final runId = body?['runId'];
      final status = body?['status'];
      if (runId is! String || status is! String) {
        return left(const AppFailure.parseError());
      }

      return right(
        RuntimeExecuteAccepted(
          runId: runId,
          status: status,
          responseJson: body!,
        ),
      );
    } on Exception catch (error, stackTrace) {
      return left(ExceptionMapper.map(error, stackTrace));
    }
  }

  @override
  Future<Either<AppFailure, RuntimeSessionTimelineConnection>>
  connectSessionTimeline({
    required String serverUrl,
    required String serverToken,
    required String sessionId,
  }) async {
    try {
      final wsUri = Uri.parse(serverUrl).replace(scheme: 'ws', path: '/ws');
      final socket = await WebSocket.connect(wsUri.toString());
      final connection = _RuntimeWebSocketConnection(
        socket: socket,
        serverToken: serverToken,
        sessionId: sessionId,
      );
      await connection.initialize();
      return right(connection);
    } on AppFailure catch (error) {
      return left(error);
    } on Exception catch (error, stackTrace) {
      return left(ExceptionMapper.map(error, stackTrace));
    }
  }

  @override
  Future<Either<AppFailure, RuntimeSelectorTestResult>> testSelector({
    required String serverUrl,
    required String serverToken,
    required String previewSessionId,
    required String selectorType,
    required String expression,
  }) async {
    try {
      final response = await _authorizedPost(
        '$serverUrl/api/preview/test-selector',
        serverToken: serverToken,
        data: {
          'previewSessionId': previewSessionId,
          'selector': {'type': selectorType, 'expression': expression},
        },
        isHostOnly: true,
      );
      final failure = _failureFromResponse(response);
      if (failure != null) {
        return left(failure);
      }

      final body = _expectJsonMap(response.data);
      final success = body?['success'];
      final count = body?['count'];
      final elements = body?['elements'];
      final error = body?['error'] as String?;

      if (success is! bool || count is! int) {
        return left(const AppFailure.parseError());
      }

      final matchedElements = <RuntimeSelectorMatchedElement>[];
      if (elements is List<Object?>) {
        for (final item in elements) {
          if (item is Map<String, dynamic>) {
            final text = item['text'] as String? ?? '';
            final html = item['html'] as String? ?? '';
            matchedElements.add(
              RuntimeSelectorMatchedElement(text: text, html: html),
            );
          }
        }
      }

      return right(
        RuntimeSelectorTestResult(
          success: success,
          count: count,
          elements: matchedElements,
          error: error,
        ),
      );
    } on Exception catch (error, stackTrace) {
      return left(ExceptionMapper.map(error, stackTrace));
    }
  }

  @override
  void dispose() {
    _dio.close(force: true);
  }

  Future<Response<Object?>> _authorizedGet(
    String url, {
    required String serverToken,
  }) {
    return _dio.get<Object?>(
      url,
      options: Options(
        headers: {'Authorization': 'Bearer $serverToken'},
      ),
    );
  }

  Future<Response<Object?>> _authorizedPost(
    String url, {
    required String serverToken,
    required Map<String, dynamic> data,
    bool isHostOnly = false,
  }) {
    return _dio.post<Object?>(
      url,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $serverToken',
          if (isHostOnly) 'X-Host-Only': 'true',
        },
      ),
    );
  }

  AppFailure? _failureFromResponse(Response<Object?> response) {
    final statusCode = response.statusCode ?? 500;
    if (statusCode >= 200 && statusCode < 300) {
      return null;
    }

    final body = _expectJsonMap(response.data);
    final error = body?['error'];
    if (error is Map<String, dynamic>) {
      final message = error['message'] as String?;
      return switch (statusCode) {
        400 => AppFailure.validationError(
          message: message ?? '请求参数有误',
        ),
        401 => const AppFailure.unauthorized(),
        403 => const AppFailure.forbidden(),
        404 => const AppFailure.notFound(),
        final int code when code >= 500 => AppFailure.serverError(
          statusCode: code,
        ),
        _ => AppFailure.badRequest(details: message),
      };
    }

    return AppFailure.serverError(statusCode: statusCode);
  }

  Map<String, dynamic>? _expectJsonMap(Object? value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map<Object?, Object?>) {
      return Map<String, dynamic>.from(value);
    }
    if (value is String && value.isNotEmpty) {
      final decoded = jsonDecode(value);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      if (decoded is Map<Object?, Object?>) {
        return Map<String, dynamic>.from(decoded);
      }
    }
    return null;
  }
}

class _RuntimeWebSocketConnection implements RuntimeSessionTimelineConnection {
  _RuntimeWebSocketConnection({
    required this.socket,
    required this.serverToken,
    required this.sessionId,
  });

  final WebSocket socket;
  final String serverToken;
  final String sessionId;
  final StreamController<RuntimeTimelineMessage> _controller =
      StreamController<RuntimeTimelineMessage>.broadcast();

  StreamSubscription<dynamic>? _subscription;
  Completer<void>? _authCompleter;
  Completer<void>? _subscribeCompleter;
  bool _closed = false;

  Future<void> initialize() async {
    _authCompleter = Completer<void>();
    _subscribeCompleter = Completer<void>();
    _subscription = socket.listen(
      _handleSocketEvent,
      onError: _handleSocketError,
      onDone: _handleSocketDone,
      cancelOnError: false,
    );

    socket.add(
      jsonEncode({
        'type': 'auth',
        'data': {'token': serverToken},
      }),
    );
    await _authCompleter!.future.timeout(const Duration(seconds: 5));

    socket.add(
      jsonEncode({
        'type': 'subscribe',
        'data': {'sessionId': sessionId},
      }),
    );
    await _subscribeCompleter!.future.timeout(const Duration(seconds: 5));
  }

  @override
  Stream<RuntimeTimelineMessage> get messages => _controller.stream;

  @override
  Future<void> close() async {
    if (_closed) {
      return;
    }
    _closed = true;
    await _subscription?.cancel();
    await socket.close();
    await _controller.close();
  }

  void _handleSocketEvent(dynamic rawEvent) {
    if (rawEvent is! String) {
      return;
    }

    final decoded = jsonDecode(rawEvent);
    if (decoded is! Map<String, dynamic>) {
      return;
    }

    final type = decoded['type'] as String?;
    final data = decoded['data'];
    final payload = data is Map<String, dynamic>
        ? data
        : data is Map<Object?, Object?>
        ? Map<String, dynamic>.from(data)
        : const <String, dynamic>{};

    switch (type) {
      case 'connected':
        return;
      case 'auth_ok':
        _authCompleter?.complete();
        return;
      case 'subscribed':
        _subscribeCompleter?.complete();
        return;
      case 'error':
        final message = payload['message'] as String? ?? 'WebSocket 错误';
        final failure = AppFailure.serverSideMessage(message: message);
        _authCompleter?.completeError(failure);
        _subscribeCompleter?.completeError(failure);
        _controller.addError(failure);
        return;
      default:
        if (_controller.isClosed) {
          return;
        }
        _controller.add(
          RuntimeTimelineMessage(
            type: type ?? 'unknown',
            data: payload,
            receivedAt: DateTime.now().toUtc(),
          ),
        );
    }
  }

  void _handleSocketError(Object error, StackTrace stackTrace) {
    if (_controller.isClosed) {
      return;
    }

    final failure = ExceptionMapper.map(error, stackTrace);
    _authCompleter?.completeError(failure);
    _subscribeCompleter?.completeError(failure);
    _controller.addError(failure, stackTrace);
  }

  void _handleSocketDone() {
    if (_controller.isClosed) {
      return;
    }

    const failure = AppFailure.serverSideMessage(
      message: 'Runtime 时间线连接已关闭',
    );
    if (!(_authCompleter?.isCompleted ?? true)) {
      _authCompleter?.completeError(failure);
    }
    if (!(_subscribeCompleter?.isCompleted ?? true)) {
      _subscribeCompleter?.completeError(failure);
    }
  }
}
