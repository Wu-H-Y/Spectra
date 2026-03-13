import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/errors/app_failure.dart';
import 'package:spectra/core/errors/app_failure_display_extension.dart';
import 'package:spectra/core/i18n/strings.g.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/features/rules_execute/application/rules_runtime_workspace_controller.dart';
import 'package:spectra/features/rules_execute/application/rules_runtime_workspace_state.dart';
import 'package:url_launcher/url_launcher.dart';

// 导出 SelectedElementInfo 以便在 UI 中使用
export 'package:spectra/features/rules_execute/application/rules_runtime_workspace_state.dart'
    show SelectedElementInfo;

/// Flutter 侧 runtime workspace 页面。
class RulesExecutePage extends ConsumerStatefulWidget {
  /// 创建 runtime workspace 页面。
  const RulesExecutePage({super.key});

  @override
  ConsumerState<RulesExecutePage> createState() => _RulesExecutePageState();
}

class _RulesExecutePageState extends ConsumerState<RulesExecutePage> {
  late final TextEditingController _previewUrlController;
  late final TextEditingController _selectorExpressionController;

  @override
  void initState() {
    super.initState();
    _previewUrlController = TextEditingController();
    _selectorExpressionController = TextEditingController();
    unawaited(
      Future.microtask(() async {
        await ref
            .read(rulesRuntimeWorkspaceControllerProvider.notifier)
            .bootstrap();
      }),
    );
  }

  @override
  void dispose() {
    _previewUrlController.dispose();
    _selectorExpressionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final state = ref.watch(rulesRuntimeWorkspaceControllerProvider);
    final controller = ref.read(
      rulesRuntimeWorkspaceControllerProvider.notifier,
    );

    // 同步选择器表达式控制器
    if (_selectorExpressionController.text != state.selectorExpression) {
      _selectorExpressionController.text = state.selectorExpression;
    }

    return Scaffold(
      appBar: AppBar(title: Text(t.rulesExecutePageTitle)),
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.paddingMd,
          children: [
            Text(
              t.rulesExecutePageDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            AppSpacing.verticalGapMd,
            _buildServerStatusCard(
              context,
              t,
              state,
              onToggleServer: controller.toggleServer,
              onRefreshWorkspace: controller.refreshWorkspace,
            ),
            AppSpacing.verticalGapMd,
            _buildWorkspaceCard(
              context,
              t,
              state,
              onRuleSelected: controller.selectRule,
            ),
            AppSpacing.verticalGapMd,
            _buildPreviewCard(
              context,
              t,
              state,
              onOpenPreview: () => controller.openPreview(
                _previewUrlController.text,
              ),
              onToggleSelectionMode: controller.toggleElementSelectionMode,
              onOpenDebugUrl: _launchUrl,
            ),
            AppSpacing.verticalGapMd,
            if (state.activePreview != null)
              _buildEmbeddedPreviewCard(
                context,
                t,
                state,
                onOpenDebugUrl: _launchUrl,
              ),
            if (state.activePreview != null) AppSpacing.verticalGapMd,
            if (state.activePreview != null)
              _buildSelectorTestCard(
                context,
                t,
                state,
                onTypeChanged: controller.setSelectorType,
                onExpressionChanged: controller.setSelectorExpression,
                onTest: controller.testSelector,
                onClear: controller.clearSelectorTestResult,
              ),
            if (state.activePreview != null) AppSpacing.verticalGapMd,
            _buildRunsCard(
              context,
              t,
              state,
              onExecute: controller.executeSelectedRule,
            ),
            AppSpacing.verticalGapMd,
            _buildTimelineCard(context, t, state),
            if (state.failure != null) ...[
              AppSpacing.verticalGapMd,
              _buildErrorCard(context, t, state.failure!),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildServerStatusCard(
    BuildContext context,
    Translations t,
    RulesRuntimeWorkspaceState state, {
    required Future<void> Function() onToggleServer,
    required Future<void> Function() onRefreshWorkspace,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isRunning = state.serverStatus.isRunning;

    return _buildSectionCard(
      context,
      sectionKey: const Key('rules_execute_server_section'),
      title: t.serverStatus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isRunning ? Icons.check_circle : Icons.error_outline,
                color: isRunning ? ColorTokens.success : colorScheme.error,
              ),
              AppSpacing.horizontalGapSm,
              Expanded(
                child: Text(
                  isRunning ? t.serverRunning : t.serverStopped,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              _buildTimelineChip(context, t, state.timelineConnected),
            ],
          ),
          if (state.serverStatus.url != null) ...[
            AppSpacing.verticalGapSm,
            SelectableText(
              '${t.serverUrl}: ${state.serverStatus.url}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          AppSpacing.verticalGapMd,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              FilledButton.tonalIcon(
                onPressed: state.isTogglingServer ? null : onToggleServer,
                icon: Icon(
                  isRunning ? Icons.stop_circle_outlined : Icons.play_arrow,
                ),
                label: Text(
                  isRunning ? t.serverStop : t.serverStart,
                ),
              ),
              OutlinedButton.icon(
                onPressed: state.isRefreshingWorkspace || !isRunning
                    ? null
                    : onRefreshWorkspace,
                icon: const Icon(Icons.refresh),
                label: Text(t.refresh),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkspaceCard(
    BuildContext context,
    Translations t,
    RulesRuntimeWorkspaceState state, {
    required ValueChanged<int?> onRuleSelected,
  }) {
    final selectedRuleId = state.selectedRuleId;

    return _buildSectionCard(
      context,
      sectionKey: const Key('rules_execute_workspace_section'),
      title: t.rulesExecuteWorkspaceSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabelValueBlock(
            context,
            label: t.rulesExecuteSessionLabel,
            value: state.sessionId,
          ),
          AppSpacing.verticalGapMd,
          Text(
            t.rulesExecuteRuleLabel,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          AppSpacing.verticalGapSm,
          if (state.rules.isEmpty)
            Text(
              t.rulesExecuteNoRules,
              style: Theme.of(context).textTheme.bodySmall,
            )
          else
            DropdownButtonFormField<int>(
              initialValue: selectedRuleId,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: t.rulesExecuteRuleLabel,
              ),
              items: state.rules
                  .map(
                    (rule) => DropdownMenuItem<int>(
                      value: rule.id,
                      child: Text('${rule.name} (${rule.ruleId})'),
                    ),
                  )
                  .toList(),
              onChanged: onRuleSelected,
            ),
        ],
      ),
    );
  }

  Widget _buildPreviewCard(
    BuildContext context,
    Translations t,
    RulesRuntimeWorkspaceState state, {
    required VoidCallback onOpenPreview,
    required VoidCallback onToggleSelectionMode,
    required ValueChanged<String> onOpenDebugUrl,
  }) {
    final preview = state.activePreview;
    final colorScheme = Theme.of(context).colorScheme;

    return _buildSectionCard(
      context,
      sectionKey: const Key('rules_execute_preview_section'),
      title: t.previewPage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _previewUrlController,
            decoration: InputDecoration(
              labelText: t.enterUrl,
              hintText: t.enterUrlToPreview,
              border: const OutlineInputBorder(),
            ),
          ),
          AppSpacing.verticalGapMd,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              FilledButton.icon(
                key: const Key('rules_execute_preview_button'),
                onPressed: state.canOpenPreview ? onOpenPreview : null,
                icon: const Icon(Icons.open_in_browser),
                label: Text(t.go),
              ),
              if (preview != null)
                OutlinedButton.icon(
                  onPressed: onToggleSelectionMode,
                  icon: Icon(
                    state.isElementSelectionMode
                        ? Icons.cancel_outlined
                        : Icons.touch_app_outlined,
                  ),
                  label: Text(
                    state.isElementSelectionMode
                        ? t.cancelSelection
                        : t.selectElement,
                  ),
                  style: state.isElementSelectionMode
                      ? OutlinedButton.styleFrom(
                          foregroundColor: colorScheme.error,
                        )
                      : null,
                ),
            ],
          ),
          AppSpacing.verticalGapMd,
          if (preview == null)
            Text(
              t.rulesExecuteNoActivePreview,
              style: Theme.of(context).textTheme.bodySmall,
            )
          else ...[
            _buildLabelValueBlock(
              context,
              label: t.rulesExecuteActivePreviewLabel,
              value: preview.previewSessionId,
            ),
            AppSpacing.verticalGapSm,
            _buildLabelValueBlock(
              context,
              label: t.enterUrl,
              value: preview.previewUrl,
            ),
            AppSpacing.verticalGapSm,
            Row(
              children: [
                Expanded(
                  child: _buildLabelValueBlock(
                    context,
                    label: t.rulesExecuteDebugUrlLabel,
                    value: preview.debugUrl,
                  ),
                ),
                IconButton(
                  onPressed: () => onOpenDebugUrl(preview.debugUrl),
                  icon: const Icon(Icons.open_in_new),
                  tooltip: t.openInBrowser,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmbeddedPreviewCard(
    BuildContext context,
    Translations t,
    RulesRuntimeWorkspaceState state, {
    required ValueChanged<String> onOpenDebugUrl,
  }) {
    final preview = state.activePreview!;
    final colorScheme = Theme.of(context).colorScheme;
    final selectedElement = state.selectedElement;

    return _buildSectionCard(
      context,
      sectionKey: const Key('rules_execute_embedded_preview_section'),
      title: t.previewPage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 预览视图占位区域
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: AppRadius.borderRadiusMd,
              border: Border.all(
                color: state.isElementSelectionMode
                    ? colorScheme.primary
                    : colorScheme.outlineVariant,
                width: state.isElementSelectionMode ? 2 : 1,
              ),
            ),
            child: Stack(
              children: [
                // 预览内容区域
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.web_outlined,
                        size: 64,
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      AppSpacing.verticalGapMd,
                      Text(
                        t.webViewPlaceholder,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                      AppSpacing.verticalGapSm,
                      Text(
                        preview.previewUrl,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // 元素选择模式遮罩
                if (state.isElementSelectionMode)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: AppRadius.borderRadiusMd,
                      ),
                      child: Center(
                        child: Container(
                          padding: AppSpacing.paddingMd,
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: AppRadius.borderRadiusMd,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.touch_app,
                                color: colorScheme.onPrimaryContainer,
                              ),
                              AppSpacing.horizontalGapSm,
                              Text(
                                t.tapToSelectElement,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: colorScheme.onPrimaryContainer,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          AppSpacing.verticalGapSm,
          // 预览信息栏
          Row(
            children: [
              Expanded(
                child: Text(
                  '${t.rulesExecuteActivePreviewLabel}: '
                  '${preview.previewSessionId}',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () => onOpenDebugUrl(preview.debugUrl),
                icon: const Icon(Icons.open_in_new, size: 18),
                tooltip: t.openInBrowser,
              ),
            ],
          ),
          // 已选元素信息展示
          if (selectedElement != null) ...[
            AppSpacing.verticalGapMd,
            const Divider(),
            AppSpacing.verticalGapMd,
            _buildSelectedElementInfo(context, t, selectedElement),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedElementInfo(
    BuildContext context,
    Translations t,
    SelectedElementInfo element,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: AppSpacing.paddingMd,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: AppRadius.borderRadiusMd,
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: colorScheme.primary,
                size: 20,
              ),
              AppSpacing.horizontalGapSm,
              Text(
                t.selectedElement,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              AppSpacing.horizontalGapSm,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: AppRadius.borderRadiusSm,
                ),
                child: Text(
                  element.selectorType.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.verticalGapMd,
          // 选择器表达式
          _buildLabelValueBlock(
            context,
            label: t.selectorExpressionLabel,
            value: element.selector,
          ),
          // XPath（如果有）
          if (element.xpath != null && element.xpath!.isNotEmpty) ...[
            AppSpacing.verticalGapSm,
            _buildLabelValueBlock(
              context,
              label: 'XPath',
              value: element.xpath!,
            ),
          ],
          // 文本内容预览
          if (element.textContent != null &&
              element.textContent!.isNotEmpty) ...[
            AppSpacing.verticalGapSm,
            Text(
              t.textContent,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            AppSpacing.verticalGapXs,
            Container(
              width: double.infinity,
              padding: AppSpacing.paddingSm,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: AppRadius.borderRadiusSm,
              ),
              child: Text(
                element.textContent!.length > 200
                    ? '${element.textContent!.substring(0, 200)}...'
                    : element.textContent!,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          // HTML 预览
          AppSpacing.verticalGapSm,
          Text(
            t.selectorElementHtml,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          AppSpacing.verticalGapXs,
          Container(
            width: double.infinity,
            padding: AppSpacing.paddingSm,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: AppRadius.borderRadiusSm,
            ),
            child: SelectableText(
              element.outerHtml.length > 300
                  ? '${element.outerHtml.substring(0, 300)}...'
                  : element.outerHtml,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
              ),
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectorTestCard(
    BuildContext context,
    Translations t,
    RulesRuntimeWorkspaceState state, {
    required ValueChanged<String> onTypeChanged,
    required ValueChanged<String> onExpressionChanged,
    required VoidCallback onTest,
    required VoidCallback onClear,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final testResult = state.selectorTestResult;

    return _buildSectionCard(
      context,
      sectionKey: const Key('rules_execute_selector_test_section'),
      title: t.selectorTestSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 选择器类型选择
          Row(
            children: [
              Expanded(
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'css',
                      label: Text('CSS'),
                    ),
                    ButtonSegment(
                      value: 'xpath',
                      label: Text('XPath'),
                    ),
                  ],
                  selected: {state.selectorType},
                  onSelectionChanged: (selected) {
                    if (selected.isNotEmpty) {
                      onTypeChanged(selected.first);
                    }
                  },
                ),
              ),
            ],
          ),
          AppSpacing.verticalGapMd,
          // 选择器表达式输入
          TextField(
            controller: _selectorExpressionController,
            onChanged: onExpressionChanged,
            decoration: InputDecoration(
              labelText: t.selectorExpressionLabel,
              hintText: state.selectorType == 'css'
                  ? t.selectorCssHint
                  : t.selectorXPathHint,
              border: const OutlineInputBorder(),
              suffixIcon: _selectorExpressionController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _selectorExpressionController.clear();
                        onExpressionChanged('');
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : null,
            ),
          ),
          AppSpacing.verticalGapMd,
          // 测试按钮
          Row(
            children: [
              FilledButton.icon(
                onPressed: state.isTestingSelector ? null : onTest,
                icon: state.isTestingSelector
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(t.selectorTestButton),
              ),
              if (testResult != null) ...[
                AppSpacing.horizontalGapSm,
                OutlinedButton.icon(
                  onPressed: onClear,
                  icon: const Icon(Icons.clear),
                  label: Text(t.selectorClearResult),
                ),
              ],
            ],
          ),
          // 测试结果展示
          if (testResult != null) ...[
            AppSpacing.verticalGapMd,
            Container(
              padding: AppSpacing.paddingMd,
              decoration: BoxDecoration(
                color: testResult.success
                    ? colorScheme.primaryContainer
                    : colorScheme.errorContainer,
                borderRadius: AppRadius.borderRadiusMd,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        testResult.success ? Icons.check_circle : Icons.error,
                        color: testResult.success
                            ? colorScheme.primary
                            : colorScheme.error,
                      ),
                      AppSpacing.horizontalGapSm,
                      Text(
                        testResult.success
                            ? t.selectorMatchSuccess(count: testResult.count)
                            : t.selectorMatchFailed,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: testResult.success
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onErrorContainer,
                        ),
                      ),
                    ],
                  ),
                  if (testResult.error != null) ...[
                    AppSpacing.verticalGapSm,
                    Text(
                      t.selectorMatchError(error: testResult.error!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onErrorContainer,
                      ),
                    ),
                  ],
                  if (testResult.elements.isNotEmpty) ...[
                    AppSpacing.verticalGapSm,
                    const Divider(),
                    AppSpacing.verticalGapSm,
                    Text(
                      t.selectorMatchSamples,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: testResult.success
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onErrorContainer,
                      ),
                    ),
                    AppSpacing.verticalGapSm,
                    ...testResult.elements.take(5).map((element) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Container(
                          padding: AppSpacing.paddingSm,
                          decoration: BoxDecoration(
                            color:
                                (testResult.success
                                        ? colorScheme.surface
                                        : colorScheme.surface)
                                    .withValues(alpha: 0.5),
                            borderRadius: AppRadius.borderRadiusSm,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (element.text.isNotEmpty)
                                Builder(
                                  builder: (context) {
                                    final preview = element.text.length > 100
                                        ? '${element.text.substring(0, 100)}...'
                                        : element.text;
                                    return Text(
                                      '${t.selectorElementText}: $preview',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  },
                                ),
                              if (element.text.isNotEmpty &&
                                  element.html.isNotEmpty)
                                AppSpacing.verticalGapXs,
                              if (element.html.isNotEmpty)
                                Builder(
                                  builder: (context) {
                                    final preview = element.html.length > 100
                                        ? '${element.html.substring(0, 100)}...'
                                        : element.html;
                                    return Text(
                                      '${t.selectorElementHtml}: $preview',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                    if (testResult.elements.length > 5)
                      Text(
                        t.selectorMatchMore(
                          count: testResult.elements.length - 5,
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRunsCard(
    BuildContext context,
    Translations t,
    RulesRuntimeWorkspaceState state, {
    required Future<void> Function() onExecute,
  }) {
    final latestRun = state.latestRun;

    return _buildSectionCard(
      context,
      sectionKey: const Key('rules_execute_runs_section'),
      title: t.rulesExecuteRunsSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilledButton.icon(
            key: const Key('rules_execute_run_button'),
            onPressed: state.canExecute ? onExecute : null,
            icon: const Icon(Icons.play_arrow),
            label: Text(t.rulesExecuteRunButton),
          ),
          if (state.isExecuting) ...[
            AppSpacing.verticalGapSm,
            const LinearProgressIndicator(),
          ],
          AppSpacing.verticalGapMd,
          if (state.orderedRuns.isEmpty)
            Text(
              t.rulesExecuteNoRuns,
              style: Theme.of(context).textTheme.bodySmall,
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.orderedRuns.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final run = state.orderedRuns[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: _buildRunStatusIcon(context, run),
                  title: Text(run.ruleName),
                  subtitle: Text(run.runId),
                  trailing: Text(_runStatusLabel(t, run)),
                );
              },
            ),
          if (latestRun != null) ...[
            AppSpacing.verticalGapMd,
            Text(
              t.rulesExecuteResponseSection,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            AppSpacing.verticalGapSm,
            KeyedSubtree(
              key: const Key('rules_execute_response_section'),
              child: _buildJsonPanel(context, latestRun.executeResponseJson),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimelineCard(
    BuildContext context,
    Translations t,
    RulesRuntimeWorkspaceState state,
  ) {
    return _buildSectionCard(
      context,
      sectionKey: const Key('rules_execute_timeline_section'),
      title: t.rulesExecuteTimelineSection,
      child: state.timeline.isEmpty
          ? Text(
              t.rulesExecuteTimelineEmpty,
              style: Theme.of(context).textTheme.bodySmall,
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.timeline.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = state.timeline[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(item.displayLabel),
                  subtitle: SelectableText(
                    _formatTimestamp(item.occurredAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: SizedBox(
                    width: 160,
                    child: SelectableText(
                      _compactJson(item.data),
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildErrorCard(
    BuildContext context,
    Translations t,
    AppFailure failure,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: AppSpacing.paddingMd,
      decoration: AppEffects.card(context).copyWith(
        border: Border.all(
          color: colorScheme.error.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            failure.localizedTitle(context),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AppSpacing.verticalGapSm,
          Text(
            failure.localizedMessage(context),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          AppSpacing.verticalGapSm,
          FilledButton.tonal(
            onPressed: () => ref
                .read(rulesRuntimeWorkspaceControllerProvider.notifier)
                .refreshWorkspace(),
            child: Text(t.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required Widget child,
    Key? sectionKey,
  }) {
    return Container(
      key: sectionKey,
      padding: AppSpacing.paddingMd,
      decoration: AppEffects.card(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          AppSpacing.verticalGapSm,
          child,
        ],
      ),
    );
  }

  Widget _buildLabelValueBlock(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        AppSpacing.verticalGapXs,
        SelectableText(value, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildJsonPanel(BuildContext context, Map<String, dynamic> json) {
    final pretty = const JsonEncoder.withIndent('  ').convert(json);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: AppRadius.borderRadiusMd,
      ),
      child: Padding(
        padding: AppSpacing.paddingMd,
        child: SelectableText(
          pretty,
          style: Theme.of(context).textTheme.code,
        ),
      ),
    );
  }

  Widget _buildTimelineChip(
    BuildContext context,
    Translations t,
    bool isConnected,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = isConnected
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerHighest;
    final foregroundColor = isConnected
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.borderRadiusSm,
      ),
      child: Text(
        isConnected
            ? t.rulesExecuteTimelineConnected
            : t.rulesExecuteTimelineDisconnected,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: foregroundColor,
        ),
      ),
    );
  }

  Widget _buildRunStatusIcon(
    BuildContext context,
    RuntimeWorkspaceRunState run,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (run.status) {
      RuntimeWorkspaceRunStatus.accepted => Icon(
        Icons.schedule,
        color: colorScheme.secondary,
      ),
      RuntimeWorkspaceRunStatus.running => Icon(
        Icons.sync,
        color: colorScheme.primary,
      ),
      RuntimeWorkspaceRunStatus.finished => Icon(
        (run.success ?? true) ? Icons.task_alt : Icons.error_outline,
        color: (run.success ?? true) ? ColorTokens.success : colorScheme.error,
      ),
    };
  }

  String _runStatusLabel(Translations t, RuntimeWorkspaceRunState run) {
    return switch (run.status) {
      RuntimeWorkspaceRunStatus.accepted => t.rulesExecuteRunStatusAccepted,
      RuntimeWorkspaceRunStatus.running => t.rulesExecuteRunStatusRunning,
      RuntimeWorkspaceRunStatus.finished => t.rulesExecuteRunStatusFinished,
    };
  }

  String _compactJson(Map<String, dynamic> json) {
    final encoded = jsonEncode(json);
    if (encoded.length <= 72) {
      return encoded;
    }
    return '${encoded.substring(0, 69)}...';
  }

  String _formatTimestamp(DateTime value) {
    final local = value.toLocal();
    final millis = local.millisecond.toString().padLeft(3, '0');
    return '${local.hour.toString().padLeft(2, '0')}:'
        '${local.minute.toString().padLeft(2, '0')}:'
        '${local.second.toString().padLeft(2, '0')}.$millis';
  }
}
