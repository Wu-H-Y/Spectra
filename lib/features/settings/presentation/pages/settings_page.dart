import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spectra/core/i18n/strings.g.dart';
import 'package:spectra/core/server/server_provider.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/shared/providers/settings_provider.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 设置页面 - 分组卡片结构
/// 应用的设置主页面，包含外观、数据、播放等子设置入口
class SettingsPage extends HookConsumerWidget {
  /// 构建设置页面
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;

    return AdaptiveScaffold(
      currentIndex: 3,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(t.settingsTitle),
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
                  title: t.appearanceSettings,
                  subtitle: _getCurrentThemeSubtitle(context, ref, t),
                  onTap: () => context.go('/settings/appearance'),
                ),
                const SizedBox(height: 12),
                // 数据存储分组
                _SettingsGroupCard(
                  icon: Icons.storage_outlined,
                  iconColor: Theme.of(context).colorScheme.secondary,
                  title: t.settingsDataStorage,
                  subtitle: '128 MB', // TODO(WuHaiYue): 从实际获取
                  onTap: () => context.go('/settings/data'),
                ),
                const SizedBox(height: 12),
                // 播放预览分组
                _SettingsGroupCard(
                  icon: Icons.play_circle_outlined,
                  iconColor: Theme.of(context).colorScheme.tertiary,
                  title: t.settingsPlayback,
                  subtitle: '自动播放: 关闭', // TODO(WuHaiYue): 从实际获取
                  onTap: () => context.go('/settings/playback'),
                ),
                const SizedBox(height: 12),
                // 开发者工具分组（保留）
                _buildDeveloperToolsCard(context, ref, t),
                const SizedBox(height: 12),
                // 关于分组
                _buildAboutCard(context, t),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentThemeSubtitle(
    BuildContext context,
    WidgetRef ref,
    Translations t,
  ) {
    final themeMode = ref.watch(persistedThemeModeProvider);
    final locale = ref.watch(persistedLocaleProvider);
    final themeName = switch (themeMode) {
      AppThemeMode.dark => t.themeModeDark,
      AppThemeMode.light => t.themeModeLight,
      AppThemeMode.system => t.themeModeSystem,
    };
    final languageName = locale.languageCode == 'zh'
        ? t.languageChinese
        : t.languageEnglish;
    return '$themeName · $languageName';
  }

  Widget _buildDeveloperToolsCard(
    BuildContext context,
    WidgetRef ref,
    Translations t,
  ) {
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
                            t.developerTools,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            t.ruleEditorDescription,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: colorScheme.onSurface.withValues(
                                    alpha: 0.6,
                                  ),
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
                                ? t.serverRunning
                                : t.serverStopped,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: serverStatus.isRunning
                                      ? Colors.green
                                      : colorScheme.onSurface.withValues(
                                          alpha: 0.6,
                                        ),
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
                        serverStatus.isRunning ? t.serverStop : t.serverStart,
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

  Widget _buildAboutCard(BuildContext context, Translations t) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final version = snapshot.data?.version ?? '...';
        return _SettingsGroupCard(
          icon: Icons.info_outline,
          iconColor: Theme.of(context).colorScheme.outline,
          title: t.about,
          subtitle: '${t.version}: $version',
          onTap: () => _showAboutDialog(context, t, version),
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context, Translations t, String version) {
    // ignore: discarded_futures - 显示对话框不需要等待结果
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.about),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.appName),
            Text('${t.version}: $version'),
            const SizedBox(height: 16),
            Text(t.appDescription),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.actionClose),
          ),
        ],
      ),
    );
  }
}

/// 设置分组卡片组件
class _SettingsGroupCard extends StatelessWidget {
  const _SettingsGroupCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

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
