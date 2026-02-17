import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/theme.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Spectra 主页
///
/// 应用的主入口页面，展示品牌风格 UI。
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.deepVoid,
      appBar: _buildAppBar(context, l10n),
      body: _buildBody(context, l10n),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, AppLocalizations l10n) {
    return AppBar(
      title: Text(
        l10n.appName,
        style: GoogleFonts.orbitron(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColors.electricViolet,
      elevation: 0,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
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
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
        ),
        AppSpacing.verticalGapSm,
        Text(
          l10n.homeSubtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
        ),
      ],
    );
  }

  Widget _buildFeatureGrid(BuildContext context, AppLocalizations l10n) {
    final features = [
      _FeatureItem(
        icon: Icons.video_library,
        title: l10n.featureVideo,
        color: AppColors.cyberCyan,
        route: '/video',
      ),
      _FeatureItem(
        icon: Icons.music_note,
        title: l10n.featureMusic,
        color: AppColors.electricViolet,
        route: '/music',
      ),
      _FeatureItem(
        icon: Icons.book,
        title: l10n.featureNovel,
        color: AppColors.neonPink,
        route: '/novel',
      ),
      _FeatureItem(
        icon: Icons.image,
        title: l10n.featureImage,
        color: AppColors.cyberCyan,
        route: '/image',
      ),
      _FeatureItem(
        icon: Icons.menu_book,
        title: l10n.featureComic,
        color: AppColors.electricViolet,
        route: '/comic',
      ),
      _FeatureItem(
        icon: Icons.settings,
        title: l10n.settingsTitle,
        color: AppColors.neonPink,
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
    return Card(
      elevation: 2,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: feature.color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
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
                style: GoogleFonts.notoSansSc(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 功能项数据类
class _FeatureItem {
  final IconData icon;
  final String title;
  final Color color;
  final String route;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.route,
  });
}
