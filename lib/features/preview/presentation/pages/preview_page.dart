import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/server/server_provider.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/features/preview/presentation/providers/preview_provider.dart';
import 'package:spectra/l10n/generated/l10n.dart';

/// 页面预览页面。
///
/// 用于在应用内预览目标页面并选择元素生成选择器。
class PreviewPage extends HookConsumerWidget {
  /// 创建预览页面实例。
  const PreviewPage({
    super.key,
    this.initialUrl,
  });

  /// 初始 URL。
  final String? initialUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final previewState = ref.watch(pagePreviewProvider);

    // 连接到服务器 WebSocket
    ref.listen(serverProvider, (prev, next) {
      if (next.isRunning && next.url != null) {
        unawaited(ref.read(pagePreviewProvider.notifier).connect(next.url!));
      }
    });

    return Scaffold(
      appBar: _buildAppBar(context, ref, l10n, previewState),
      body: Column(
        children: [
          // URL 输入栏
          _buildUrlBar(context, ref, l10n, previewState),

          // 状态栏
          if (previewState.status == PreviewStatus.loading)
            const LinearProgressIndicator(),

          if (previewState.error != null)
            _buildErrorBar(context, previewState.error!),

          // 选择模式指示器
          if (previewState.isSelecting)
            _buildSelectionModeBar(context, ref, l10n),

          // WebView 内容区域
          Expanded(
            child: _buildWebViewContent(context, ref, l10n, previewState),
          ),

          // 选中元素面板
          if (previewState.hasSelection && previewState.selectedElement != null)
            _buildSelectedElementPanel(context, ref, l10n, previewState),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    WidgetRef ref,
    S l10n,
    PreviewState previewState,
  ) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          ref.read(pagePreviewProvider.notifier).disconnect();
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        l10n.previewPage,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      actions: [
        // 刷新按钮
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: previewState.url != null
              ? () {
                  ref
                      .read(pagePreviewProvider.notifier)
                      .loadUrl(previewState.url!);
                }
              : null,
          tooltip: l10n.refresh,
        ),
        // 选择元素按钮
        IconButton(
          icon: Icon(
            previewState.isSelecting
                ? Icons.touch_app
                : Icons.touch_app_outlined,
          ),
          onPressed: () {
            if (previewState.isSelecting) {
              ref.read(pagePreviewProvider.notifier).cancelSelection();
            } else {
              ref.read(pagePreviewProvider.notifier).startSelection();
            }
          },
          tooltip: previewState.isSelecting
              ? l10n.cancelSelection
              : l10n.selectElement,
        ),
      ],
    );
  }

  Widget _buildUrlBar(
    BuildContext context,
    WidgetRef ref,
    S l10n,
    PreviewState previewState,
  ) {
    final controller = TextEditingController(
      text: previewState.url ?? initialUrl ?? '',
    );

    return Container(
      padding: AppSpacing.paddingSm,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.link, size: 20),
          AppSpacing.horizontalGapSm,
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: l10n.enterUrl,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onSubmitted: (url) {
                if (url.isNotEmpty) {
                  ref.read(pagePreviewProvider.notifier).loadUrl(url);
                }
              },
            ),
          ),
          AppSpacing.horizontalGapSm,
          FilledButton.tonal(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref.read(pagePreviewProvider.notifier).loadUrl(controller.text);
              }
            },
            child: Text(l10n.go),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBar(BuildContext context, String error) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.paddingSm,
      color: Theme.of(context).colorScheme.errorContainer,
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            size: 16,
            color: Theme.of(context).colorScheme.error,
          ),
          AppSpacing.horizontalGapSm,
          Expanded(
            child: Text(
              error,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionModeBar(
    BuildContext context,
    WidgetRef ref,
    S l10n,
  ) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.paddingSm,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Row(
        children: [
          Icon(
            Icons.touch_app,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          AppSpacing.horizontalGapSm,
          Expanded(
            child: Text(
              l10n.tapToSelectElement,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(pagePreviewProvider.notifier).cancelSelection();
            },
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  Widget _buildWebViewContent(
    BuildContext context,
    WidgetRef ref,
    S l10n,
    PreviewState previewState,
  ) {
    if (previewState.status == PreviewStatus.idle) {
      return _buildEmptyState(context, l10n);
    }

    // 注意：实际的 WebView 实现需要 flutter_inappwebview 依赖
    // 这里提供一个占位符，实际项目中需要替换为真实的 WebView
    return _buildPlaceholderWebView(context, ref, l10n, previewState);
  }

  Widget _buildEmptyState(BuildContext context, S l10n) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.web,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          AppSpacing.verticalGapMd,
          Text(
            l10n.enterUrlToPreview,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderWebView(
    BuildContext context,
    WidgetRef ref,
    S l10n,
    PreviewState previewState,
  ) {
    // 这是占位符实现
    // 实际项目中需要使用 flutter_inappwebview 或类似的包
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            AppSpacing.verticalGapMd,
            Text(
              l10n.webViewPlaceholder,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            AppSpacing.verticalGapSm,
            Text(
              previewState.url ?? '',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedElementPanel(
    BuildContext context,
    WidgetRef ref,
    S l10n,
    PreviewState previewState,
  ) {
    final element = previewState.selectedElement!;
    final selectorOption = ref.watch(selectorOptionProvider);

    return Container(
      width: double.infinity,
      padding: AppSpacing.paddingMd,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.vertical(top: AppRadius.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题和复制按钮
          Row(
            children: [
              Text(
                l10n.selectedElement,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              // 选择器类型切换
              SegmentedButton<SelectorTypeOption>(
                segments: const [
                  ButtonSegment(
                    value: SelectorTypeOption.css,
                    label: Text('CSS'),
                  ),
                  ButtonSegment(
                    value: SelectorTypeOption.xpath,
                    label: Text('XPath'),
                  ),
                ],
                selected: {selectorOption},
                onSelectionChanged: (value) {
                  ref.read(selectorOptionProvider.notifier).set(value.first);
                },
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  textStyle: WidgetStateProperty.all(
                    const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              AppSpacing.horizontalGapSm,
              // 复制按钮
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  final selector = selectorOption == SelectorTypeOption.css
                      ? element.selector
                      : element.selector; // 这里应该用 XPath
                  unawaited(Clipboard.setData(ClipboardData(text: selector)));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.copiedToClipboard)),
                  );
                },
                tooltip: l10n.copy,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          AppSpacing.verticalGapSm,

          // 选择器显示
          Container(
            width: double.infinity,
            padding: AppSpacing.paddingSm,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: AppRadius.borderRadiusSm,
            ),
            child: SelectableText(
              element.selector,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
              ),
            ),
          ),

          // 文本内容预览
          if (element.textContent != null &&
              element.textContent!.isNotEmpty) ...[
            AppSpacing.verticalGapSm,
            Text(
              l10n.textContent,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              element.textContent!,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          // 发送到编辑器按钮
          AppSpacing.verticalGapMd,
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                ref
                    .read(pagePreviewProvider.notifier)
                    .sendSelectedElement(element);
                Navigator.of(context).pop(element);
              },
              icon: const Icon(Icons.send),
              label: Text(l10n.sendToEditor),
            ),
          ),
        ],
      ),
    );
  }
}
