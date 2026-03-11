import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';
import 'package:spectra/core/theme/app_breakpoints.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/l10n/generated/l10n.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 收藏页面
///
/// 展示用户收藏的多媒体内容，支持按类型筛选。
class FavoritesPage extends HookConsumerWidget {
  /// 创建收藏页面
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final selectedType = useState<String?>('all');

    // 媒体类型筛选选项
    final mediaTypes = [
      _MediaTypeFilter(id: 'all', label: l10n.mediaTypeAll, icon: Icons.apps),
      _MediaTypeFilter(id: 'video', label: l10n.mediaTypeVideo, icon: Icons.video_library_outlined),
      _MediaTypeFilter(id: 'music', label: l10n.mediaTypeMusic, icon: Icons.music_note_outlined),
      _MediaTypeFilter(id: 'novel', label: l10n.mediaTypeNovel, icon: Icons.menu_book_outlined),
      _MediaTypeFilter(id: 'comic', label: l10n.mediaTypeComic, icon: Icons.image_outlined),
      _MediaTypeFilter(id: 'image', label: l10n.mediaTypeImage, icon: Icons.photo_library_outlined),
    ];

    return AdaptiveScaffold(
      currentIndex: 0,
      body: CustomScrollView(
        slivers: [
          // 顶部标题栏
          SliverToBoxAdapter(
            child: _buildHeader(context, l10n, colorScheme),
          ),
          // 媒体类型筛选器
          SliverToBoxAdapter(
            child: _buildTypeFilter(
              context,
              mediaTypes,
              selectedType.value,
              (type) => selectedType.value = type,
              colorScheme,
            ),
          ),
          // 最近观看区域
          SliverToBoxAdapter(
            child: _buildSectionTitle(context, l10n.favoritesRecent, colorScheme),
          ),
          // 最近观看内容（横向滚动）
          SliverToBoxAdapter(
            child: _buildRecentContent(context, colorScheme, l10n),
          ),
          // 全部收藏标题
          SliverToBoxAdapter(
            child: _buildSectionTitle(context, l10n.favoritesAll, colorScheme),
          ),
          // 收藏内容网格
          _buildFavoritesGrid(context, colorScheme),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, S l10n, ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.favoritesPageTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            l10n.favoritesPageSubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeFilter(
    BuildContext context,
    List<_MediaTypeFilter> types,
    String? selectedId,
    Function(String?) onSelect,
    ColorScheme colorScheme,
  ) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        separatorBuilder: (_, __) => SizedBox(width: 2.w),
        itemBuilder: (context, index) {
          final type = types[index];
          final isSelected = selectedId == type.id;

          return _FilterChip(
            label: type.label,
            icon: type.icon,
            isSelected: isSelected,
            onTap: () => onSelect(type.id),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, ColorScheme colorScheme) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 2.h),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: ColorTokens.cyberCyan,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentContent(BuildContext context, ColorScheme colorScheme, S l10n) {
    // TODO: 从状态管理获取最近观看数据
    final recentItems = <_ContentItem>[];

    if (recentItems.isEmpty) {
      return Container(
        height: 15.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.history_outlined,
                size: 32,
                color: colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              SizedBox(height: 1.h),
              Text(
                l10n.noRecentHistory,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 15.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: recentItems.length,
        separatorBuilder: (_, __) => SizedBox(width: 3.w),
        itemBuilder: (context, index) {
          return _RecentCard(item: recentItems[index]);
        },
      ),
    );
  }

  Widget _buildFavoritesGrid(BuildContext context, ColorScheme colorScheme) {
    // TODO: 从状态管理获取收藏数据
    final favorites = <_ContentItem>[];

    if (favorites.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: _EmptyState(),
      );
    }

    // 使用响应式列数
    final columns = context.responsive<int>(
      mobile: 2,
      tablet: 3,
      desktop: 4,
    );

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: 0.75,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 3.w,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return _ContentCard(item: favorites[index]);
        },
      ),
    );
  }
}

/// 媒体类型筛选数据
class _MediaTypeFilter {
  const _MediaTypeFilter({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;
}

/// 内容项数据
class _ContentItem {
  const _ContentItem({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.type,
    this.author,
    this.updateTime,
  });

  final String id;
  final String title;
  final String coverUrl;
  final String type;
  final String? author;
  final DateTime? updateTime;
}

/// 筛选芯片组件
class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: AnimatedContainer(
          duration: AppDurations.fast,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      ColorTokens.cyberCyan.withValues(alpha: 0.2),
                      ColorTokens.electricViolet.withValues(alpha: 0.1),
                    ],
                  )
                : null,
            color: isSelected ? null : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: isSelected
                  ? ColorTokens.cyberCyan.withValues(alpha: 0.5)
                  : colorScheme.outline.withValues(alpha: 0.1),
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: isSelected && isDark
                ? [
                    BoxShadow(
                      color: ColorTokens.cyberCyan.withValues(alpha: 0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected
                    ? ColorTokens.cyberCyan
                    : colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              SizedBox(width: 1.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? ColorTokens.cyberCyan
                      : colorScheme.onSurface.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 最近观看卡片
class _RecentCard extends StatelessWidget {
  const _RecentCard({required this.item});

  final _ContentItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 25.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        image: DecorationImage(
          image: NetworkImage(item.coverUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: 0.7),
            ],
          ),
        ),
        padding: EdgeInsets.all(2.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (item.author != null)
              Text(
                item.author!,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// 内容卡片
class _ContentCard extends StatelessWidget {
  const _ContentCard({required this.item});

  final _ContentItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: () {
          // TODO: 导航到详情页
        },
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            color: colorScheme.surfaceContainerHighest,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 封面图
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppRadius.lg),
                    ),
                    color: colorScheme.surfaceContainerHighest,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppRadius.lg),
                    ),
                    child: Container(
                      color: colorScheme.surfaceContainerHighest,
                      child: Center(
                        child: Icon(
                          _getTypeIcon(item.type),
                          size: 40,
                          color: colorScheme.onSurface.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 信息区域
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      if (item.author != null)
                        Text(
                          item.author!,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      Spacer(),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                              vertical: 0.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: ColorTokens.cyberCyan.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              _getTypeLabel(item.type),
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: ColorTokens.cyberCyan,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'video':
        return Icons.video_library_outlined;
      case 'music':
        return Icons.music_note_outlined;
      case 'novel':
        return Icons.menu_book_outlined;
      case 'comic':
        return Icons.image_outlined;
      case 'image':
        return Icons.photo_library_outlined;
      default:
        return Icons.auto_awesome;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'video':
        return '视频';
      case 'music':
        return '音乐';
      case 'novel':
        return '小说';
      case 'comic':
        return '漫画';
      case 'image':
        return '图片';
      default:
        return '其他';
    }
  }
}

/// 空状态组件
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Icon(
              Icons.favorite_border,
              size: 40,
              color: colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            l10n.favoritesEmptyTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            l10n.favoritesEmptySubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          FilledButton.icon(
            onPressed: () {
              // TODO: 导航到发现页
            },
            icon: const Icon(Icons.explore),
            label: Text(l10n.goToDiscover),
            style: FilledButton.styleFrom(
              backgroundColor: ColorTokens.cyberCyan,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
            ),
          ),
        ],
      ),
    );
  }
}
