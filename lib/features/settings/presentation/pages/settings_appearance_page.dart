import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/i18n/strings.g.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/shared/providers/settings_provider.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 外观设置子页面
/// 允许用户自定义应用外观，包括主题模式和语言设置
class SettingsAppearancePage extends HookConsumerWidget {
  /// 创建外观设置页面
  const SettingsAppearancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;

    return AdaptiveScaffold(
      currentIndex: 3,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(t.appearanceSettings),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildThemeSection(context, ref, t),
                const SizedBox(height: 24),
                _buildLanguageSection(context, ref, t),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSection(
    BuildContext context,
    WidgetRef ref,
    Translations t,
  ) {
    final themeMode = ref.watch(persistedThemeModeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.themeMode,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<AppThemeMode>(
          initialValue: themeMode,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: AppThemeMode.values
              .map(
                (mode) => DropdownMenuItem<AppThemeMode>(
                  value: mode,
                  child: Text(_getThemeModeName(t, mode)),
                ),
              )
              .toList(growable: false),
          onChanged: (value) async {
            if (value != null) {
              await ref
                  .read(persistedThemeModeProvider.notifier)
                  .setThemeMode(value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildLanguageSection(
    BuildContext context,
    WidgetRef ref,
    Translations t,
  ) {
    final locale = ref.watch(persistedLocaleProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.language,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<Locale>(
          initialValue: locale,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: [
            DropdownMenuItem<Locale>(
              value: const Locale('zh', 'CN'),
              child: Text(t.languageChinese),
            ),
            DropdownMenuItem<Locale>(
              value: const Locale('en', 'US'),
              child: Text(t.languageEnglish),
            ),
          ],
          onChanged: (value) async {
            if (value != null) {
              await ref.read(persistedLocaleProvider.notifier).setLocale(value);
            }
          },
        ),
      ],
    );
  }

  String _getThemeModeName(Translations t, AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.dark:
        return t.themeModeDark;
      case AppThemeMode.light:
        return t.themeModeLight;
      case AppThemeMode.system:
        return t.themeModeSystem;
    }
  }
}
