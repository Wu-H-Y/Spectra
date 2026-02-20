import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spectra/core/constants/locale_constants.dart';
import 'package:spectra/core/server/server_provider.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/l10n/generated/l10n.dart';
import 'package:spectra/shared/providers/settings_provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// 设置页面
///
/// 提供应用设置功能，包括：
/// - 主题模式切换（深色/浅色/跟随系统）
/// - 语言切换（中文/英文）
/// - 关于信息
class SettingsPage extends HookConsumerWidget {
  /// 创建设置页面实例
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: _buildAppBar(context, l10n),
      body: _buildBody(context, ref, l10n),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    S l10n,
  ) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.go('/'),
      ),
      title: Text(
        l10n.settingsTitle,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    S l10n,
  ) {
    return SafeArea(
      child: ListView(
        padding: AppSpacing.paddingMd,
        children: [
          // 外观设置
          _buildSectionHeader(context, l10n.appearanceSettings),
          AppSpacing.verticalGapSm,
          _buildThemeTile(context, ref, l10n),
          _buildLanguageTile(context, ref, l10n),
          AppSpacing.verticalGapLg,

          // 开发者工具
          _buildSectionHeader(context, l10n.developerTools),
          AppSpacing.verticalGapSm,
          _buildRuleEditorTile(context, ref, l10n),
          AppSpacing.verticalGapLg,

          // 关于
          _buildSectionHeader(context, l10n.about),
          AppSpacing.verticalGapSm,
          _buildAboutTile(context, l10n),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.xs),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildThemeTile(
    BuildContext context,
    WidgetRef ref,
    S l10n,
  ) {
    final themeMode = ref.watch(persistedThemeModeProvider);
    final themeModeName = _getThemeModeName(l10n, themeMode);

    return _SettingsTile(
      icon: Icons.palette_outlined,
      iconColor: Theme.of(context).colorScheme.primary,
      title: l10n.themeMode,
      subtitle: themeModeName,
      onTap: () => _showThemeDialog(context, ref, l10n),
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    WidgetRef ref,
    S l10n,
  ) {
    final locale = ref.watch(persistedLocaleProvider);
    final languageName = locale.isChinese
        ? l10n.languageChinese
        : l10n.languageEnglish;

    return _SettingsTile(
      icon: Icons.language,
      iconColor: Theme.of(context).colorScheme.secondary,
      title: l10n.language,
      subtitle: languageName,
      onTap: () => _showLanguageDialog(context, ref, l10n),
    );
  }

  Widget _buildRuleEditorTile(
    BuildContext context,
    WidgetRef ref,
    S l10n,
  ) {
    final serverStatus = ref.watch(serverProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: AppEffects.card(context).copyWith(
        border: Border.all(
          color: colorScheme.tertiary.withValues(alpha: 0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: AppSpacing.paddingSm,
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary.withValues(alpha: 0.1),
                      borderRadius: AppRadius.borderRadiusSm,
                    ),
                    child: Icon(
                      Icons.code,
                      color: colorScheme.tertiary,
                      size: 24,
                    ),
                  ),
                  AppSpacing.horizontalGapMd,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.ruleEditor,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.ruleEditorDescription,
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
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  // 服务器状态指示器
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: serverStatus.isRunning
                          ? Colors.green.withValues(alpha: 0.1)
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: AppRadius.borderRadiusSm,
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
                  // 启动/停止按钮
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
              if (serverStatus.isRunning && serverStatus.url != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${l10n.serverUrl}: ${serverStatus.url}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    IconButton(
                      icon: const Icon(Icons.open_in_browser, size: 18),
                      onPressed: () async {
                        final uri = Uri.parse(serverStatus.url!);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                      tooltip: l10n.openInBrowser,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutTile(BuildContext context, S l10n) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final version = snapshot.data?.version ?? '...';
        return _SettingsTile(
          icon: Icons.info_outline,
          iconColor: Theme.of(context).colorScheme.tertiary,
          title: l10n.about,
          subtitle: '${l10n.version}: $version',
          onTap: () {
            // TODO(developer): 显示关于页面
          },
        );
      },
    );
  }

  String _getThemeModeName(S l10n, AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.dark:
        return l10n.themeModeDark;
      case AppThemeMode.light:
        return l10n.themeModeLight;
      case AppThemeMode.system:
        return l10n.themeModeSystem;
    }
  }

  Future<void> _showThemeDialog(
    BuildContext context,
    WidgetRef ref,
    S l10n,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.themeMode),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(
              context,
              ref,
              l10n,
              AppThemeMode.dark,
              l10n.themeModeDark,
            ),
            _buildThemeOption(
              context,
              ref,
              l10n,
              AppThemeMode.light,
              l10n.themeModeLight,
            ),
            _buildThemeOption(
              context,
              ref,
              l10n,
              AppThemeMode.system,
              l10n.themeModeSystem,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref,
    S l10n,
    AppThemeMode mode,
    String label,
  ) {
    final currentMode = ref.watch(persistedThemeModeProvider);
    final isSelected = currentMode == mode;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      title: Text(label),
      trailing: isSelected
          ? Icon(Icons.check, color: colorScheme.primary)
          : null,
      onTap: () async {
        await ref.read(persistedThemeModeProvider.notifier).setThemeMode(mode);
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  Future<void> _showLanguageDialog(
    BuildContext context,
    WidgetRef ref,
    S l10n,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(
              context,
              ref,
              const Locale('en', 'US'),
              l10n.languageEnglish,
            ),
            _buildLanguageOption(
              context,
              ref,
              const Locale('zh', 'CN'),
              l10n.languageChinese,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    WidgetRef ref,
    Locale locale,
    String label,
  ) {
    final currentLocale = ref.watch(persistedLocaleProvider);
    final isSelected = currentLocale.languageCode == locale.languageCode;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      title: Text(label),
      trailing: isSelected
          ? Icon(Icons.check, color: colorScheme.secondary)
          : null,
      onTap: () async {
        await ref.read(persistedLocaleProvider.notifier).setLocale(locale);
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}

/// 设置项组件
class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
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
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: AppEffects.card(context).copyWith(
        border: Border.all(
          color: iconColor.withValues(alpha: 0.2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.borderRadiusLg,
          onTap: onTap,
          child: Padding(
            padding: AppSpacing.paddingMd,
            child: Row(
              children: [
                Container(
                  padding: AppSpacing.paddingSm,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: AppRadius.borderRadiusSm,
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                AppSpacing.horizontalGapMd,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurface.withValues(alpha: 0.38),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
