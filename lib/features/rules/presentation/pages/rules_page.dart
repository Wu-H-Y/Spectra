import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/functional/failures.dart';
import 'package:spectra/core/i18n/strings.g.dart';
import 'package:spectra/features/rules/domain/entities/rule.dart';
import 'package:spectra/features/rules/presentation/providers/rules_provider.dart';
import 'package:spectra/features/rules/presentation/widgets/import_rule_button.dart';
import 'package:spectra/features/rules/presentation/widgets/import_rule_dialog.dart';
import 'package:spectra/features/rules/presentation/widgets/import_rule_url_dialog.dart';

/// 规则管理页面。
class RulesPage extends ConsumerStatefulWidget {
  /// 创建规则管理页面。
  const RulesPage({
    this.initialImportUrl,
    this.pickRuleFile,
    super.key,
  });

  /// 预填充的 URL 导入参数。
  final String? initialImportUrl;

  /// 用于测试的文件选择器注入。
  final Future<String?> Function()? pickRuleFile;

  @override
  ConsumerState<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends ConsumerState<RulesPage> {
  bool _handledInitialImportUrl = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_handledInitialImportUrl) {
        return;
      }
      final initialUrl = widget.initialImportUrl?.trim();
      if (initialUrl == null || initialUrl.isEmpty) {
        return;
      }
      _handledInitialImportUrl = true;
      await _openUrlImportDialog(initialUrl: initialUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final rulesAsync = ref.watch(rulesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.rulesPageTitle),
        actions: [
          ImportRuleButton(
            onImportFile: _importRuleFromFile,
            onImportUrl: _openUrlImportDialog,
          ),
        ],
      ),
      body: rulesAsync.when(
        data: (rules) {
          if (rules.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  t.rulesPageEmpty,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: rules.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final rule = rules[index];
              return Card(
                child: ListTile(
                  title: Text(rule.name),
                  subtitle: Text(
                    rule.metadata.description?.trim().isNotEmpty == true
                        ? rule.metadata.description!
                        : rule.id,
                  ),
                  trailing: Text(rule.irVersion),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }

  Future<void> _importRuleFromFile() async {
    final picker = widget.pickRuleFile ?? _pickRuleFile;
    final filePath = await picker();
    if (!mounted || filePath == null || filePath.isEmpty) {
      return;
    }

    await _handleImportResult(
      ref.read(rulesImportProvider.notifier).importRuleFromFile(filePath),
    );
  }

  Future<void> _openUrlImportDialog({String? initialUrl}) async {
    if (!mounted) {
      return;
    }

    final url = await showDialog<String>(
      context: context,
      builder: (_) => ImportRuleUrlDialog(initialUrl: initialUrl),
    );
    if (!mounted || url == null || url.isEmpty) {
      return;
    }

    await _handleImportResult(
      ref.read(rulesImportProvider.notifier).importRuleFromUrl(url),
    );
  }

  Future<void> _handleImportResult(
    Future<Either<Failure, Rule>> importFuture,
  ) async {
    if (!mounted) {
      return;
    }

    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const ImportRuleDialog(),
      ),
    );

    final result = await importFuture;
    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (!mounted) {
      return;
    }

    result.match(_showImportFailure, _showImportSuccess);
  }

  void _showImportFailure(Failure failure) {
    final t = context.t;
    unawaited(
      showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(t.rulesImportFailedTitle),
          content: Text(failure.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.cancel),
            ),
          ],
        ),
      ),
    );
  }

  void _showImportSuccess(Rule rule) {
    final t = context.t;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.rulesImportSuccess(ruleName: rule.name))),
    );
  }

  Future<String?> _pickRuleFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json', 'rule'],
    );
    return result?.files.single.path;
  }
}
