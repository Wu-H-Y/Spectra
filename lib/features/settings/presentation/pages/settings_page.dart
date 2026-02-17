import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/constants/locale_constants.dart';
import '../../../../core/theme/theme.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/providers/settings_provider.dart';

/// 设置页面
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.deepVoid,
      appBar: _buildAppBar(context, l10n),
      body: _buildBody(context, ref, l10n),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, AppLocalizations l10n) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.go('/'),
      ),
      title: Text(
        l10n.settingsTitle,
        style: GoogleFonts.orbitron(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColors.electricViolet,
      elevation: 0,
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    return SafeArea(
      child: ListView(
        padding: AppSpacing.paddingMd,
        children: [
          // 外观设置
          _buildSectionHeader(l10n.appearanceSettings),
          AppSpacing.verticalGapSm,
          _buildThemeTile(context, ref, l10n),
          _buildLanguageTile(context, ref, l10n),
          AppSpacing.verticalGapLg,

          // 关于
          _buildSectionHeader(l10n.about),
          AppSpacing.verticalGapSm,
          _buildAboutTile(context, l10n),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.xs),
      child: Text(
        title,
        style: GoogleFonts.orbitron(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.cyberCyan,
        ),
      ),
    );
  }

  Widget _buildThemeTile(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final themeMode = ref.watch(persistedThemeModeProvider);
    final themeModeName = _getThemeModeName(l10n, themeMode);

    return _SettingsTile(
      icon: Icons.palette_outlined,
      iconColor: AppColors.cyberCyan,
      title: l10n.themeMode,
      subtitle: themeModeName,
      onTap: () => _showThemeDialog(context, ref, l10n),
    );
  }

  Widget _buildLanguageTile(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final locale = ref.watch(persistedLocaleProvider);
    final languageName = locale.isChinese ? l10n.languageChinese : l10n.languageEnglish;

    return _SettingsTile(
      icon: Icons.language,
      iconColor: AppColors.electricViolet,
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
          iconColor: AppColors.neonPink,
          title: l10n.about,
          subtitle: '${l10n.version}: $version',
          onTap: () {
            // TODO: 显示关于页面
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

  void _showThemeDialog(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          l10n.themeMode,
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(context, ref, l10n, AppThemeMode.dark, l10n.themeModeDark),
            _buildThemeOption(context, ref, l10n, AppThemeMode.light, l10n.themeModeLight),
            _buildThemeOption(context, ref, l10n, AppThemeMode.system, l10n.themeModeSystem),
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

    return ListTile(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      trailing: isSelected
          ? const Icon(Icons.check, color: AppColors.cyberCyan)
          : null,
      onTap: () {
        ref.read(persistedThemeModeProvider.notifier).state = mode;
        Navigator.of(context).pop();
      },
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          l10n.language,
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(context, ref, const Locale('en', 'US'), l10n.languageEnglish),
            _buildLanguageOption(context, ref, const Locale('zh', 'CN'), l10n.languageChinese),
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

    return ListTile(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      trailing: isSelected
          ? const Icon(Icons.check, color: AppColors.electricViolet)
          : null,
      onTap: () {
        ref.read(persistedLocaleProvider.notifier).state = locale;
        Navigator.of(context).pop();
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
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: iconColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: Row(
            children: [
              Container(
                padding: AppSpacing.paddingSm,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
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
                      style: GoogleFonts.notoSansSc(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.notoSansSc(
                        fontSize: 12,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
