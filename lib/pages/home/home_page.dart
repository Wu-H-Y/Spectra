import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';

/// Spectra 主页
///
/// 应用的主入口页面，展示品牌风格 UI。
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepVoid,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Spectra',
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

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 欢迎区域
            _buildWelcomeSection(context),
            const SizedBox(height: 32),
            // 功能卡片区域
            Expanded(
              child: _buildFeatureGrid(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '欢迎使用 Spectra',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '一款现代化的多媒体数据采集应用',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
        ),
      ],
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final features = [
      _FeatureItem(
        icon: Icons.video_library,
        title: '视频采集',
        color: AppColors.cyberCyan,
      ),
      _FeatureItem(
        icon: Icons.music_note,
        title: '音乐采集',
        color: AppColors.electricViolet,
      ),
      _FeatureItem(
        icon: Icons.book,
        title: '小说采集',
        color: AppColors.neonPink,
      ),
      _FeatureItem(
        icon: Icons.image,
        title: '图片采集',
        color: AppColors.cyberCyan,
      ),
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
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
          // TODO: 导航到对应功能页面
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                feature.icon,
                size: 40,
                color: feature.color,
              ),
              const SizedBox(height: 12),
              Text(
                feature.title,
                style: GoogleFonts.notoSansSc(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
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

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.color,
  });
}
