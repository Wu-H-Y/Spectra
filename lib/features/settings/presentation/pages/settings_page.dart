import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:spectra/core/constants/locale_constants.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/l10n/generated/app_localizations.dart';
import 'package:spectra/shared/providers/settings_provider.dart';

/// 设置页面
///
/// 提供应用设置功能，包括：
/// - 主题模式切换（深色/浅色/跟随系统）
/// - 语言切换（中文/英文）
/// - 关于信息
class SettingsPage extends ConsumerWidget {
  /// 创建设置页面实例
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: _buildAppBar(context, l10n),
      body: _buildBody(context, ref, l10n),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    AppLocalizations l10n,
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
    AppLocalizations l10n,
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
    AppLocalizations l10n,
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
    AppLocalizations l10n,
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

  Widget _buildAboutTile(BuildContext context, AppLocalizations l10n) {
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

  String _getThemeModeName(AppLocalizations l10n, AppThemeMode mode) {
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
    AppLocalizations l10n,
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
    AppLocalizations l10n,
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
    AppLocalizations l10n,
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
