import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spectra/core/preview/selector_generator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'preview_provider.g.dart';

/// 预览状态。
enum PreviewStatus {
  /// 空闲。
  idle,

  /// 加载中。
  loading,

  /// 已加载。
  loaded,

  /// 错误。
  error,
}

/// 预览状态数据。
class PreviewState {
  /// 创建预览状态。
  const PreviewState({
    this.status = PreviewStatus.idle,
    this.url,
    this.title,
    this.selectionMode = SelectionMode.none,
    this.selectedElement,
    this.highlightedSelector,
    this.error,
  });

  /// 状态。
  final PreviewStatus status;

  /// 当前 URL。
  final String? url;

  /// 页面标题。
  final String? title;

  /// 选择模式。
  final SelectionMode selectionMode;

  /// 选中的元素。
  final SelectedElement? selectedElement;

  /// 高亮的选择器。
  final String? highlightedSelector;

  /// 错误信息。
  final String? error;

  /// 是否正在选择元素。
  bool get isSelecting => selectionMode == SelectionMode.selecting;

  /// 是否已选中元素。
  bool get hasSelection => selectionMode == SelectionMode.selected;

  /// 复制并更新值。
  PreviewState copyWith({
    PreviewStatus? status,
    String? url,
    String? title,
    SelectionMode? selectionMode,
    SelectedElement? selectedElement,
    String? highlightedSelector,
    String? error,
    bool clearSelectedElement = false,
    bool clearHighlightedSelector = false,
    bool clearError = false,
  }) {
    return PreviewState(
      status: status ?? this.status,
      url: url ?? this.url,
      title: title ?? this.title,
      selectionMode: selectionMode ?? this.selectionMode,
      selectedElement: clearSelectedElement
          ? null
          : (selectedElement ?? this.selectedElement),
      highlightedSelector: clearHighlightedSelector
          ? null
          : (highlightedSelector ?? this.highlightedSelector),
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// 页面预览 Provider。
@riverpod
class PagePreview extends _$PagePreview {
  WebSocketChannel? _channel;
  StreamSubscription<void>? _subscription;

  @override
  PreviewState build() {
    ref.onDispose(_cleanup);
    return const PreviewState();
  }

  /// 连接到 WebSocket 服务器。
  Future<void> connect(String serverUrl) async {
    _cleanup();

    try {
      final wsUrl = serverUrl
          .replaceFirst('http://', 'ws://')
          .replaceFirst('https://', 'wss://');
      final uri = Uri.parse('$wsUrl/ws');

      _channel = WebSocketChannel.connect(uri);
      await _channel!.ready;

      _subscription = _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDone,
      );

      state = state.copyWith(clearError: true);
    } on Exception catch (e) {
      state = state.copyWith(error: 'WebSocket 连接失败: $e');
    }
  }

  /// 断开 WebSocket 连接。
  void disconnect() {
    _cleanup();
    state = const PreviewState();
  }

  /// 加载 URL。
  void loadUrl(String url) {
    state = state.copyWith(
      status: PreviewStatus.loading,
      url: url,
      clearError: true,
    );

    _sendMessage({
      'type': 'preview_request',
      'data': {'url': url},
    });
  }

  /// 进入元素选择模式。
  void startSelection() {
    state = state.copyWith(
      selectionMode: SelectionMode.selecting,
      clearSelectedElement: true,
    );

    _sendMessage({
      'type': 'start_selection',
    });
  }

  /// 取消元素选择。
  void cancelSelection() {
    state = state.copyWith(
      selectionMode: SelectionMode.none,
      clearSelectedElement: true,
    );

    _sendMessage({
      'type': 'cancel_selection',
    });
  }

  /// 高亮选择器匹配的元素。
  void highlightSelector(String selector) {
    state = state.copyWith(highlightedSelector: selector);

    _sendMessage({
      'type': 'highlight_selector',
      'data': {'selector': selector},
    });
  }

  /// 清除高亮。
  void clearHighlight() {
    state = state.copyWith(clearHighlightedSelector: true);

    _sendMessage({
      'type': 'clear_highlight',
    });
  }

  /// 发送选中的元素到编辑器。
  void sendSelectedElement(SelectedElement element) {
    _sendMessage({
      'type': 'element_selected',
      'data': element.toJson(),
    });
  }

  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String) as Map<String, dynamic>;
      final type = data['type'] as String?;
      final payload = data['data'];

      switch (type) {
        case 'connected':
          debugPrint('WebSocket connected');

        case 'preview_response':
          _handlePreviewResponse(payload as Map<String, dynamic>?);

        case 'element_selected':
          _handleElementSelected(payload as Map<String, dynamic>?);

        case 'page_loaded':
          _handlePageLoaded(payload as Map<String, dynamic>?);

        default:
          debugPrint('Unknown message type: $type');
      }
    } on Exception catch (e) {
      debugPrint('Error handling message: $e');
    }
  }

  void _handlePreviewResponse(Map<String, dynamic>? data) {
    if (data == null) return;

    final status = data['status'] as String?;
    if (status == 'accepted') {
      state = state.copyWith(status: PreviewStatus.loaded);
    } else {
      state = state.copyWith(
        status: PreviewStatus.error,
        error: data['error'] as String? ?? '预览请求失败',
      );
    }
  }

  void _handleElementSelected(Map<String, dynamic>? data) {
    if (data == null) return;

    final element = SelectedElement(
      selector: data['selector'] as String? ?? '',
      selectorType: data['selectorType'] as String? ?? 'css',
      outerHtml: data['outerHtml'] as String? ?? '',
      textContent: data['textContent'] as String?,
      rect: data['rect'] != null
          ? ElementRect.fromJson(data['rect'] as Map<String, dynamic>)
          : null,
    );

    state = state.copyWith(
      selectionMode: SelectionMode.selected,
      selectedElement: element,
    );
  }

  void _handlePageLoaded(Map<String, dynamic>? data) {
    if (data == null) return;

    state = state.copyWith(
      status: PreviewStatus.loaded,
      title: data['title'] as String?,
      clearError: true,
    );
  }

  void _handleError(dynamic error) {
    debugPrint('WebSocket error: $error');
    state = state.copyWith(
      error: 'WebSocket 错误: $error',
    );
  }

  void _handleDone() {
    debugPrint('WebSocket connection closed');
    _channel = null;
    _subscription = null;
  }

  void _sendMessage(Map<String, dynamic> message) {
    _channel?.sink.add(jsonEncode(message));
  }

  void _cleanup() {
    unawaited(_subscription?.cancel());
    _subscription = null;
    unawaited(_channel?.sink.close());
    _channel = null;
  }
}

/// 选择器类型选择。
enum SelectorTypeOption {
  /// CSS 选择器。
  css,

  /// XPath 选择器。
  xpath,
}

/// 选择器选项 Provider。
@riverpod
class SelectorOption extends _$SelectorOption {
  @override
  SelectorTypeOption build() {
    return SelectorTypeOption.css;
  }

  /// 切换选择器类型。
  void toggle() {
    state = state == SelectorTypeOption.css
        ? SelectorTypeOption.xpath
        : SelectorTypeOption.css;
  }

  /// 设置选择器类型。
  // ignore: use_setters_to_change_properties
  void set(SelectorTypeOption option) {
    state = option;
  }
}
