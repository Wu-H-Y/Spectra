import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/l10n/generated/l10n.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 数据存储设置子页面
class SettingsDataPage extends HookConsumerWidget {
  const SettingsDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);

    return AdaptiveScaffold(
      currentIndex: 3,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(l10n.settingsDataStorage),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildCacheSection(context, l10n),
                const SizedBox(height: 24),
                _buildExportImportSection(context, l10n),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCacheSection(BuildContext context, S l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.settingsCacheSize,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.storage_outlined),
          title: const Text('128 MB'), // TODO: 从实际获取
          trailing: TextButton(
            onPressed: () => _showClearCacheDialog(context, l10n),
            child: Text(l10n.settingsClearCache),
          ),
        ),
      ],
    );
  }

  Widget _buildExportImportSection(BuildContext context, S l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '导入/导出', // TODO: 添加 i18n
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.upload_outlined),
          title: Text(l10n.settingsExportFavorites),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _exportFavorites(context),
        ),
        ListTile(
          leading: const Icon(Icons.download_outlined),
          title: Text(l10n.settingsImportFavorites),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _importFavorites(context),
        ),
      ],
    );
  }

  void _showClearCacheDialog(BuildContext context, S l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsClearCache),
        content: Text(l10n.settingsClearCacheConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            onPressed: () {
              // TODO: 实现清除缓存
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.settingsCacheCleared)),
              );
            },
            child: Text(l10n.actionConfirm),
          ),
        ],
      ),
    );
  }

  void _exportFavorites(BuildContext context) {
    // TODO: 实现导出功能
  }

  void _importFavorites(BuildContext context) {
    // TODO: 实现导入功能
  }
}
