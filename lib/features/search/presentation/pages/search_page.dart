import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:spectra/core/i18n/strings.g.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 搜索页面
///
/// 全局搜索功能，支持多类型结果展示和搜索历史。
class SearchPage extends HookConsumerWidget {
  /// 创建搜索页面
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final colorScheme = Theme.of(context).colorScheme;
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final selectedTab = useState(0);
    final isSearching = useState(false);

    // 搜索历史（示例数据）
    final searchHistory = useState<List<String>>([
      'Flutter 教程',
      'Rust 入门',
      'Dart 异步编程',
    ]);

    // 热门搜索（示例数据）
    final hotSearches = [
      t.searchTabVideo,
      t.searchTabMusic,
      t.searchTabNovel,
      t.searchTabComic,
      t.searchTabImage,
    ];

    // Tab 选项
    final tabs = [
      t.searchTabAll,
      t.searchTabVideo,
      t.searchTabMusic,
      t.searchTabNovel,
      t.searchTabComic,
      t.searchTabImage,
    ];

    return AdaptiveScaffold(
      currentIndex: 2,
      body: Column(
        children: [
          // 搜索栏
          _buildSearchBar(
            context,
            t,
            colorScheme,
            searchController,
            searchQuery,
            isSearching,
            searchHistory,
          ),
          // 内容区域
          Expanded(
            child: searchQuery.value.isEmpty
                ? _buildSearchSuggestions(
                    context,
                    t,
                    colorScheme,
                    searchHistory,
                    hotSearches,
                    searchController,
                  )
                : _buildSearchResults(
                    context,
                    t,
                    colorScheme,
                    tabs,
                    selectedTab,
                    isSearching,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    Translations t,
    ColorScheme colorScheme,
    TextEditingController controller,
    ValueNotifier<String> query,
    ValueNotifier<bool> isSearching,
    ValueNotifier<List<String>> history,
  ) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.searchPageTitle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            // 搜索输入框
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadius.xl),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: t.searchHint,
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  suffixIcon: query.value.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                          onPressed: () {
                            controller.clear();
                            query.value = '';
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.h,
                  ),
                ),
                onChanged: (value) => query.value = value,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    isSearching.value = true;
                    // 添加到历史
                    if (!history.value.contains(value)) {
                      history.value = [value, ...history.value.take(9)];
                    }
                    // TODO(WuHaiYue): 执行搜索
                    Future.delayed(const Duration(seconds: 1), () {
                      isSearching.value = false;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSuggestions(
    BuildContext context,
    Translations t,
    ColorScheme colorScheme,
    ValueNotifier<List<String>> history,
    List<String> hotSearches,
    TextEditingController controller,
  ) {
    return ListView(
      padding: EdgeInsets.all(4.w),
      children: [
        // 搜索历史
        if (history.value.isNotEmpty) ...[
          _buildSectionHeader(
            context,
            t.searchHistory,
            trailing: TextButton(
              onPressed: () => history.value = [],
              child: Text(t.searchClearHistory),
            ),
          ),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 2.w,
            runSpacing: 1.h,
            children: history.value.map((item) {
              return _HistoryChip(
                label: item,
                onTap: () {
                  controller.text = item;
                  // TODO(WuHaiYue): 执行搜索
                },
                onDelete: () {
                  history.value = history.value
                      .where((h) => h != item)
                      .toList();
                },
              );
            }).toList(),
          ),
          SizedBox(height: 4.h),
        ],
        // 热门搜索
        _buildSectionHeader(context, t.searchHot),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: hotSearches.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return _HotSearchChip(
              rank: index + 1,
              label: item,
              onTap: () {
                controller.text = item;
                // TODO(WuHaiYue): 执行搜索
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    Widget? trailing,
  }) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: ColorTokens.cyberCyan,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ?trailing,
      ],
    );
  }

  Widget _buildSearchResults(
    BuildContext context,
    Translations t,
    ColorScheme colorScheme,
    List<String> tabs,
    ValueNotifier<int> selectedTab,
    ValueNotifier<bool> isSearching,
  ) {
    if (isSearching.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // TODO(WuHaiYue): 从状态管理获取搜索结果
    final results = <_SearchResult>[];

    return Column(
      children: [
        // Tab 栏
        Container(
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: tabs.length,
            separatorBuilder: (_, _) => SizedBox(width: 2.w),
            itemBuilder: (context, index) {
              final isSelected = selectedTab.value == index;
              return _TabChip(
                label: tabs[index],
                isSelected: isSelected,
                onTap: () => selectedTab.value = index,
              );
            },
          ),
        ),
        // 结果列表
        Expanded(
          child: results.isEmpty
              ? _buildNoResults(context, t, colorScheme)
              : ListView.builder(
                  padding: EdgeInsets.all(4.w),
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    return _SearchResultCard(item: results[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildNoResults(
    BuildContext context,
    Translations t,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_outlined,
            size: 64,
            color: colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          SizedBox(height: 2.h),
          Text(
            t.searchNoResults,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

/// 搜索历史芯片
class _HistoryChip extends StatelessWidget {
  const _HistoryChip({
    required this.label,
    required this.onTap,
    required this.onDelete,
  });

  final String label;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.history,
                size: 16,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              SizedBox(width: 1.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
              SizedBox(width: 1.w),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 热门搜索芯片
class _HotSearchChip extends StatelessWidget {
  const _HotSearchChip({
    required this.rank,
    required this.label,
    required this.onTap,
  });

  final int rank;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isTop3 = rank <= 3;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isTop3
                      ? ColorTokens.cyberCyan.withValues(alpha: 0.2)
                      : colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  '$rank',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: isTop3
                        ? ColorTokens.cyberCyan
                        : colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tab 芯片
class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
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
                  : Colors.transparent,
            ),
            boxShadow: isSelected && isDark
                ? [
                    BoxShadow(
                      color: ColorTokens.cyberCyan.withValues(alpha: 0.2),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected
                  ? ColorTokens.cyberCyan
                  : colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}

/// 搜索结果数据
class _SearchResult {
  _SearchResult({
    required this.id,
    required this.title,
    required this.type,
  });

  final String id;
  final String title;
  final String type;
}

/// 搜索结果卡片
class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({required this.item});

  final _SearchResult item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // TODO(WuHaiYue): 导航到详情页
        },
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          padding: EdgeInsets.all(3.w),
          margin: EdgeInsets.only(bottom: 2.h),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Row(
            children: [
              // 封面
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: _buildPlaceholder(),
                ),
              ),
              SizedBox(width: 3.w),
              // 信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 1.h),
                    // 类型标签
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
                        _getTypeLabel(context, item.type),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorTokens.cyberCyan,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return ColoredBox(
      color: Colors.grey.withValues(alpha: 0.2),
      child: Center(
        child: Icon(
          _getTypeIcon(),
          size: 32,
          color: Colors.grey,
        ),
      ),
    );
  }

  IconData _getTypeIcon() {
    switch (item.type) {
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

  String _getTypeLabel(BuildContext context, String type) {
    final t = context.t;
    switch (type) {
      case 'video':
        return t.mediaTypeVideo;
      case 'music':
        return t.mediaTypeMusic;
      case 'novel':
        return t.mediaTypeNovel;
      case 'comic':
        return t.mediaTypeComic;
      case 'image':
        return t.mediaTypeImage;
      default:
        return t.mediaTypeAll;
    }
  }
}
