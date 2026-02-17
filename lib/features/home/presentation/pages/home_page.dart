import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/l10n/generated/app_localizations.dart';

/// Spectra 主页
///
/// 应用的主入口页面，展示品牌风格 UI。
///
/// 包含欢迎区域和功能卡片网格，支持深色/浅色主题。
class HomePage extends ConsumerWidget {
  /// 创建主页实例
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: _buildAppBar(context, l10n),
      body: _buildBody(context, l10n),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return AppBar(
      title: Text(
        l10n.appName,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => context.go('/settings'),
          tooltip: l10n.settingsTitle,
        ),
        AppSpacing.horizontalGapSm,
      ],
    );
  }

  Widget _buildBody(BuildContext context, AppLocalizations l10n) {
    return SafeArea(
      child: Padding(
        padding: AppSpacing.paddingLg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 欢迎区域
            _buildWelcomeSection(context, l10n),
            AppSpacing.verticalGapLg,
            // 功能卡片区域
            Expanded(
              child: _buildFeatureGrid(context, l10n),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.homeTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        AppSpacing.verticalGapSm,
        Text(
          l10n.homeSubtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureGrid(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;

    final features = [
      _FeatureItem(
        icon: Icons.video_library,
        title: l10n.featureVideo,
        color: colorScheme.primary,
        route: '/video',
      ),
      _FeatureItem(
        icon: Icons.music_note,
        title: l10n.featureMusic,
        color: colorScheme.secondary,
        route: '/music',
      ),
      _FeatureItem(
        icon: Icons.book,
        title: l10n.featureNovel,
        color: colorScheme.tertiary,
        route: '/novel',
      ),
      _FeatureItem(
        icon: Icons.image,
        title: l10n.featureImage,
        color: colorScheme.primary,
        route: '/image',
      ),
      _FeatureItem(
        icon: Icons.menu_book,
        title: l10n.featureComic,
        color: colorScheme.secondary,
        route: '/comic',
      ),
      _FeatureItem(
        icon: Icons.settings,
        title: l10n.settingsTitle,
        color: colorScheme.tertiary,
        route: '/settings',
      ),
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.2,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return _buildFeatureCard(context, features[index]);
      },
    );
  }

  Widget _buildFeatureCard(BuildContext context, _FeatureItem feature) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: isDark
          ? AppEffects.glassCardDark.copyWith(
              border: Border.all(
                color: feature.color.withValues(alpha: 0.3),
              ),
            )
          : AppEffects.softCardLight.copyWith(
              border: Border.all(
                color: feature.color.withValues(alpha: 0.2),
              ),
            ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.borderRadiusLg,
          onTap: () {
            context.go(feature.route);
          },
          child: Padding(
            padding: AppSpacing.paddingMd,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  feature.icon,
                  size: 40,
                  color: feature.color,
                ),
                AppSpacing.verticalGapMd,
                Text(
                  feature.title,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 功能项数据类
class _FeatureItem {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.route,
  });
  final IconData icon;
  final String title;
  final Color color;
  final String route;
}
