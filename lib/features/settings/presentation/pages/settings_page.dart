import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spectra/core/server/server_provider.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/l10n/generated/l10n.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

/// 设置页面 - 分组卡片结构
class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);

    return AdaptiveScaffold(
      currentIndex: 3,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(l10n.settingsTitle),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 外观设置分组
                _SettingsGroupCard(
                  icon: Icons.palette_outlined,
                  iconColor: Theme.of(context).colorScheme.primary,
                  title: l10n.appearanceSettings,
                  subtitle: _getCurrentThemeSubtitle(context, ref, l10n),
                  onTap: () => context.go('/settings/appearance'),
                ),
                const SizedBox(height: 12),
                // 数据存储分组
                _SettingsGroupCard(
                  icon: Icons.storage_outlined,
                  iconColor: Theme.of(context).colorScheme.secondary,
                  title: l10n.settingsDataStorage,
                  subtitle: '128 MB', // TODO: 从实际获取
                  onTap: () => context.go('/settings/data'),
                ),
                const SizedBox(height: 12),
                // 播放预览分组
                _SettingsGroupCard(
                  icon: Icons.play_circle_outlined,
                  iconColor: Theme.of(context).colorScheme.tertiary,
                  title: l10n.settingsPlayback,
                  subtitle: '自动播放: 关闭', // TODO: 从实际获取
                  onTap: () => context.go('/settings/playback'),
                ),
                const SizedBox(height: 12),
                // 开发者工具分组（保留）
                _buildDeveloperToolsCard(context, ref, l10n),
                const SizedBox(height: 12),
                // 关于分组
                _buildAboutCard(context, l10n),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentThemeSubtitle(BuildContext context, WidgetRef ref, S l10n) {
    final themeMode = ref.watch(persistedThemeModeProvider);
    final locale = ref.watch(persistedLocaleProvider);
    final themeName = switch (themeMode) {
      AppThemeMode.dark => l10n.themeModeDark,
      AppThemeMode.light => l10n.themeModeLight,
      AppThemeMode.system => l10n.themeModeSystem,
    };
    final languageName = locale.languageCode == 'zh'
        ? l10n.languageChinese
        : l10n.languageEnglish;
    return '$themeName · $languageName';
  }

  Widget _buildDeveloperToolsCard(BuildContext context, WidgetRef ref, S l10n) {
    final serverStatus = ref.watch(serverProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => context.go('/rules-execute'),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.tertiary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.code,
                        color: colorScheme.tertiary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.developerTools,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.ruleEditorDescription,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: serverStatus.isRunning
                            ? Colors.green.withValues(alpha: 0.1)
                            : colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            serverStatus.isRunning
                                ? Icons.circle
                                : Icons.circle_outlined,
                            size: 8,
                            color: serverStatus.isRunning
                                ? Colors.green
                                : colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            serverStatus.isRunning
                                ? l10n.serverRunning
                                : l10n.serverStopped,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: serverStatus.isRunning
                                  ? Colors.green
                                  : colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    FilledButton.tonal(
                      onPressed: () async {
                        final notifier = ref.read(serverProvider.notifier);
                        if (serverStatus.isRunning) {
                          await notifier.stop();
                        } else {
                          await notifier.start();
                        }
                      },
                      child: Text(
                        serverStatus.isRunning
                            ? l10n.serverStop
                            : l10n.serverStart,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutCard(BuildContext context, S l10n) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final version = snapshot.data?.version ?? '...';
        return _SettingsGroupCard(
          icon: Icons.info_outline,
          iconColor: Theme.of(context).colorScheme.outline,
          title: l10n.about,
          subtitle: '${l10n.version}: $version',
          onTap: () => _showAboutDialog(context, l10n, version),
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context, S l10n, String version) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.about),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Spectra'),
            Text('${l10n.version}: $version'),
            const SizedBox(height: 16),
            const Text('一款现代化的多媒体数据采集应用'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionClose),
          ),
        ],
      ),
    );
  }
}

/// 设置分组卡片组件
class _SettingsGroupCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsGroupCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
