import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/l10n/generated/l10n.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 外观设置子页面
class SettingsAppearancePage extends HookConsumerWidget {
  const SettingsAppearancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return AdaptiveScaffold(
      currentIndex: 3,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(l10n.appearanceSettings),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildThemeSection(context, ref, l10n),
                const SizedBox(height: 24),
                _buildLanguageSection(context, ref, l10n),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context, WidgetRef ref, S l10n) {
    final themeMode = ref.watch(persistedThemeModeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.themeMode,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ...AppThemeMode.values.map((mode) => RadioListTile<AppThemeMode>(
          title: Text(_getThemeModeName(l10n, mode)),
          value: mode,
          groupValue: themeMode,
          onChanged: (value) {
            if (value != null) {
              ref.read(persistedThemeModeProvider.notifier).setThemeMode(value);
            }
          },
        )),
      ],
    );
  }

  Widget _buildLanguageSection(BuildContext context, WidgetRef ref, S l10n) {
    final locale = ref.watch(persistedLocaleProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.language,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        RadioListTile<Locale>(
          title: Text(l10n.languageChinese),
          value: const Locale('zh', 'CN'),
          groupValue: locale,
          onChanged: (value) {
            if (value != null) {
              ref.read(persistedLocaleProvider.notifier).setLocale(value);
            }
          },
        ),
        RadioListTile<Locale>(
          title: Text(l10n.languageEnglish),
          value: const Locale('en', 'US'),
          groupValue: locale,
          onChanged: (value) {
            if (value != null) {
              ref.read(persistedLocaleProvider.notifier).setLocale(value);
            }
          },
        ),
      ],
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
}
