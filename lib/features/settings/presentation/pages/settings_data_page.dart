import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/i18n/strings.g.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 数据存储设置子页面
/// 管理应用的缓存、数据导出和导入功能
class SettingsDataPage extends HookConsumerWidget {
  /// 创建数据存储设置页面
  const SettingsDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;

    return AdaptiveScaffold(
      currentIndex: 3,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(t.settingsDataStorage),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildCacheSection(context, t),
                const SizedBox(height: 24),
                _buildExportImportSection(context, t),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCacheSection(BuildContext context, Translations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.settingsCacheSize,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.storage_outlined),
          title: const Text('128 MB'),
          trailing: TextButton(
            onPressed: () => _showClearCacheDialog(context, t),
            child: Text(t.settingsClearCache),
          ),
        ),
      ],
    );
  }

  Widget _buildExportImportSection(BuildContext context, Translations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '导入/导出',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.upload_outlined),
          title: Text(t.settingsExportFavorites),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _exportFavorites(context),
        ),
        ListTile(
          leading: const Icon(Icons.download_outlined),
          title: Text(t.settingsImportFavorites),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _importFavorites(context),
        ),
      ],
    );
  }

  void _showClearCacheDialog(BuildContext context, Translations t) {
    // ignore: discarded_futures - 显示对话框不需要等待结果
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.settingsClearCache),
        content: Text(t.settingsClearCacheConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.actionCancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(t.settingsCacheCleared)),
              );
            },
            child: Text(t.actionConfirm),
          ),
        ],
      ),
    );
  }

  void _exportFavorites(BuildContext context) {
    // TODO(WuHaiYue): 实现导出功能
  }

  void _importFavorites(BuildContext context) {
    // TODO(WuHaiYue): 实现导入功能
  }
}
