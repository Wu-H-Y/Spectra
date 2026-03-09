import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/errors/app_failure.dart';
import 'package:spectra/core/errors/app_failure_display_extension.dart';
import 'package:spectra/core/errors/exception_mapper.dart';
import 'package:spectra/core/rust/rules_ir/normalized_model.dart';
import 'package:spectra/core/server/server_provider.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/l10n/generated/l10n.dart';

/// 规则执行最小闭环页面。
///
/// 页面会调用本地 `/api/rules/execute`，展示 `runId/status`，并使用
/// `NormalizedModel` 的示例结果渲染固定模板（Search/Detail/Toc/Content）。
class RulesExecutePage extends ConsumerStatefulWidget {
  /// 创建规则执行最小闭环页面。
  RulesExecutePage({
    super.key,
    RulesExecuteService? service,
  }) : service = service ?? RulesExecuteDemoService();

  /// 执行规则并返回规范化模型的服务。
  final RulesExecuteService service;

  @override
  ConsumerState<RulesExecutePage> createState() => _RulesExecutePageState();
}

class _RulesExecutePageState extends ConsumerState<RulesExecutePage> {
  bool _isLoading = false;
  AppFailure? _failure;
  RulesExecuteResult? _result;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final serverStatus = ref.watch(serverProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.rulesExecutePageTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.paddingMd,
          children: [
            Text(
              l10n.rulesExecutePageDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            AppSpacing.verticalGapMd,
            _buildServerStatusCard(context, l10n, serverStatus),
            AppSpacing.verticalGapMd,
            FilledButton.icon(
              key: const Key('rules_execute_run_button'),
              onPressed: _isLoading ? null : _executeRule,
              icon: const Icon(Icons.play_arrow),
              label: Text(l10n.rulesExecuteRunButton),
            ),
            if (_isLoading) ...[
              AppSpacing.verticalGapSm,
              const LinearProgressIndicator(),
            ],
            if (_failure != null) ...[
              AppSpacing.verticalGapMd,
              _buildErrorCard(context, l10n, _failure!),
            ],
            if (_result != null) ...[
              AppSpacing.verticalGapMd,
              _buildJsonCard(
                context,
                sectionKey: const Key('rules_execute_response_section'),
                title: l10n.rulesExecuteResponseSection,
                json: _result!.executeResponseJson,
              ),
              AppSpacing.verticalGapMd,
              _buildJsonCard(
                context,
                sectionKey: const Key('rules_execute_normalized_section'),
                title: l10n.rulesExecuteNormalizedSection,
                json: _result!.normalizedJson,
              ),
              AppSpacing.verticalGapMd,
              _buildSearchTemplate(context, l10n, _result!.model.search),
              AppSpacing.verticalGapMd,
              _buildDetailTemplate(context, l10n, _result!.model.detail),
              AppSpacing.verticalGapMd,
              _buildTocTemplate(context, l10n, _result!.model.toc),
              AppSpacing.verticalGapMd,
              _buildContentTemplate(context, l10n, _result!.model.content),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildServerStatusCard(
    BuildContext context,
    S l10n,
    ServerStatus status,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: AppSpacing.paddingMd,
      decoration: AppEffects.card(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.serverStatus,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AppSpacing.verticalGapSm,
          Row(
            children: [
              Icon(
                status.isRunning ? Icons.check_circle : Icons.error_outline,
                color: status.isRunning ? Colors.green : colorScheme.error,
              ),
              AppSpacing.horizontalGapSm,
              Expanded(
                child: Text(
                  status.isRunning ? l10n.serverRunning : l10n.serverStopped,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              if (status.isRunning) ...[
                const Icon(Icons.link, size: 16),
                AppSpacing.horizontalGapXs,
                Expanded(
                  child: Text(
                    status.url ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ],
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
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AppSpacing.verticalGapSm,
          child,
        ],
      ),
    );
  }

  Widget _buildEmptySection(BuildContext context, String message) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildJsonCard(
    BuildContext context, {
    required String title,
    required Map<String, dynamic> json,
    Key? sectionKey,
  }) {
    final pretty = const JsonEncoder.withIndent('  ').convert(json);

    return _buildSectionCard(
      context,
      sectionKey: sectionKey,
      title: title,
      child: SelectableText(
        pretty,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Widget _buildSearchTemplate(
    BuildContext context,
    S l10n,
    SearchModel? search,
  ) {
    final items = search?.items ?? const <SearchItem>[];

    return _buildSectionCard(
      context,
      sectionKey: const Key('rules_execute_search_section'),
      title: l10n.rulesExecuteSearchSection,
      child: items.isEmpty
          ? _buildEmptySection(context, l10n.rulesExecuteEmptyState)
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.search),
                  title: Text(item.title),
                  subtitle: Text(item.url),
                  trailing: item.author == null ? null : Text(item.author!),
                );
              },
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemCount: items.length,
            ),
    );
  }

  Widget _buildDetailTemplate(
    BuildContext context,
    S l10n,
    DetailModel? detail,
  ) {
    final value = detail;

    return _buildSectionCard(
      context,
      sectionKey: const Key('rules_execute_detail_section'),
      title: l10n.rulesExecuteDetailSection,
      child: value == null
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (value.author != null) ...[
                  AppSpacing.verticalGapSm,
                  Text(value.author!),
                ],
                if (value.description != null) ...[
                  AppSpacing.verticalGapSm,
                  Text(value.description!),
                ],
                if (value.tags.isNotEmpty) ...[
                  AppSpacing.verticalGapSm,
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: value.tags
                        .map(
                          (tag) => Chip(
                            label: Text(tag),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildTocTemplate(
    BuildContext context,
    S l10n,
    TocModel? toc,
  ) {
    final chapters = toc?.chapters ?? const <ChapterItem>[];

    return _buildSectionCard(
      context,
      sectionKey: const Key('rules_execute_toc_section'),
      title: l10n.rulesExecuteTocSection,
      child: chapters.isEmpty
          ? _buildEmptySection(context, l10n.rulesExecuteEmptyState)
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final chapter = chapters[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.format_list_numbered),
                  title: Text(chapter.title),
                  subtitle: chapter.url == null ? null : Text(chapter.url!),
                );
              },
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemCount: chapters.length,
            ),
    );
  }

  Widget _buildContentTemplate(
    BuildContext context,
    S l10n,
    ContentModel? content,
  ) {
    final value = content;
    final mediaAssets = value?.mediaAssets ?? const <MediaAsset>[];

    return _buildSectionCard(
      context,
      sectionKey: const Key('rules_execute_content_section'),
      title: l10n.rulesExecuteContentSection,
      child: value == null
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (value.contentTextPlain != null) ...[
                  Text(value.contentTextPlain!),
                  AppSpacing.verticalGapSm,
                ],
                if (value.contentTextHtml != null) ...[
                  Text(
                    value.contentTextHtml!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  AppSpacing.verticalGapSm,
                ],
                for (final asset in mediaAssets)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.perm_media_outlined),
                    title: Text(asset.title ?? asset.mediaType.name),
                    subtitle: Text(asset.url),
                  ),
              ],
            ),
    );
  }

  Widget _buildErrorCard(BuildContext context, S l10n, AppFailure failure) {
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
            onPressed: _isLoading ? null : _executeRule,
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }

  Future<void> _executeRule() async {
    setState(() {
      _isLoading = true;
      _failure = null;
      _result = null;
    });

    final serverUrl = await _resolveServerUrl();
    if (serverUrl == null) {
      return;
    }

    final outcome = await widget.service.execute(serverUrl: serverUrl);

    if (!mounted) {
      return;
    }

    outcome.match(
      (failure) {
        setState(() {
          _failure = failure;
          _isLoading = false;
        });
      },
      (result) {
        setState(() {
          _result = result;
          _isLoading = false;
        });
      },
    );
  }

  Future<String?> _resolveServerUrl() async {
    if (widget.service is! RulesExecuteDemoService) {
      return ref.read(serverProvider).url ?? 'http://localhost:0';
    }

    final serverNotifier = ref.read(serverProvider.notifier);
    var currentStatus = ref.read(serverProvider);

    if (!currentStatus.isRunning) {
      try {
        await serverNotifier.start();
      } on Exception catch (error, stackTrace) {
        if (!mounted) {
          return null;
        }
        setState(() {
          _failure = ExceptionMapper.map(error, stackTrace);
          _isLoading = false;
        });
        return null;
      }
      currentStatus = ref.read(serverProvider);
    }

    final serverUrl = currentStatus.url;
    if (serverUrl == null) {
      if (mounted) {
        setState(() {
          _failure = const AppFailure.serverError();
          _isLoading = false;
        });
      }
      return null;
    }

    return serverUrl;
  }
}

/// 规则执行结果。
class RulesExecuteResult {
  /// 创建规则执行结果。
  const RulesExecuteResult({
    required this.executeResponseJson,
    required this.normalizedJson,
    required this.model,
  });

  /// 原始执行响应 JSON。
  final Map<String, dynamic> executeResponseJson;

  /// 从 `initialResultJson` 解析出的规范化 JSON。
  final Map<String, dynamic> normalizedJson;

  /// 规范化结果模型。
  final NormalizedModel model;
}

/// 规则执行服务。
class RulesExecuteService {
  /// 创建规则执行服务。
  const RulesExecuteService({required this.execute});

  /// 执行规则并返回结果。
  final Future<Either<AppFailure, RulesExecuteResult>> Function({
    required String serverUrl,
  })
  execute;
}

/// 真实的规则执行演示服务。
class RulesExecuteDemoService extends RulesExecuteService {
  /// 创建规则执行演示服务。
  RulesExecuteDemoService() : super(execute: _executeWithHttp);

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 8),
    ),
  );

  static Future<Either<AppFailure, RulesExecuteResult>> _executeWithHttp({
    required String serverUrl,
  }) async {
    try {
      final statusResponse = await _dio.get<Map<String, dynamic>>(
        '$serverUrl/api/server/status',
      );
      final serverToken = statusResponse.data?['serverToken'] as String?;
      if (serverToken == null || serverToken.isEmpty) {
        return left(
          const AppFailure.badRequest(),
        );
      }

      final executeResponse = await _dio.post<Map<String, dynamic>>(
        '$serverUrl/api/rules/execute',
        data: const {'rule': _demoRuleEnvelope},
        options: Options(
          headers: {'Authorization': 'Bearer $serverToken'},
        ),
      );

      final executeJson = executeResponse.data;
      if (executeJson == null) {
        return left(
          const AppFailure.parseError(),
        );
      }

      // 从响应中提取 initialResultJson
      final initialResultJsonString =
          executeJson['initialResultJson'] as String?;
      if (initialResultJsonString == null || initialResultJsonString.isEmpty) {
        return left(
          const AppFailure.badRequest(),
        );
      }

      // 解析 initialResultJson 为 Map
      final normalizedJson =
          jsonDecode(initialResultJsonString) as Map<String, dynamic>;
      final model = NormalizedModel.fromJson(normalizedJson);

      return right(
        RulesExecuteResult(
          executeResponseJson: executeJson,
          normalizedJson: normalizedJson,
          model: model,
        ),
      );
    } on Exception catch (error, stackTrace) {
      return left(ExceptionMapper.map(error, stackTrace));
    }
  }
}

const Map<String, Object> _demoRuleEnvelope = {
  'irVersion': '1.0.0',
  'metadata': {
    'ruleId': 'task21.min.demo',
    'name': 'Task21 Demo Rule',
    'description': 'Flutter page minimal execute demo',
  },
  'graph': {
    'nodes': [
      {
        'id': 'search_input',
        'kind': {'type': 'input'},
        'phase': 'search',
        'inputs': <Map<String, Object>>[],
        'outputs': [
          {
            'name': 'query',
            'dataType': {'type': 'text'},
            'optional': false,
          },
        ],
      },
      {
        'id': 'search_output',
        'kind': {'type': 'output'},
        'phase': 'search',
        'inputs': [
          {
            'name': 'items',
            'dataType': {'type': 'text'},
            'optional': false,
          },
        ],
        'outputs': [
          {
            'name': 'normalized',
            'dataType': {
              'type': 'list',
              'item': {'type': 'normalizedModel'},
            },
            'optional': false,
          },
        ],
      },
    ],
    'edges': [
      {
        'from': {'nodeId': 'search_input', 'portName': 'query'},
        'to': {'nodeId': 'search_output', 'portName': 'items'},
      },
    ],
    'phaseEntrypoints': {
      'search': {'nodeId': 'search_input', 'portName': 'query'},
    },
  },
  'normalizedOutputs': {
    'search': {'nodeId': 'search_output', 'portName': 'normalized'},
  },
  'capabilities': {
    'supportsPagination': true,
    'supportsConcurrency': false,
    'requiresAuth': false,
  },
};
