import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:spectra/core/i18n/strings.g.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 发现页面
///
/// 通过选择不同规则展示不同的发现数据。
class DiscoverPage extends HookConsumerWidget {
  /// 创建发现页面
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final colorScheme = Theme.of(context).colorScheme;
    final selectedRule = useState<String?>(null);
    final isLoading = useState(false);

    // TODO(WuHaiYue): 从状态管理获取可用规则列表
    final rules = <_RuleItem>[
      _RuleItem(
        id: 'bilibili',
        name: 'Bilibili ${t.mediaTypeVideo}',
        icon: Icons.video_library,
        type: 'video',
      ),
      _RuleItem(
        id: 'netease',
        name: t.mediaTypeMusic,
        icon: Icons.music_note,
        type: 'music',
      ),
      _RuleItem(
        id: 'qidian',
        name: t.mediaTypeNovel,
        icon: Icons.menu_book,
        type: 'novel',
      ),
      _RuleItem(
        id: 'bilibili_comic',
        name: t.mediaTypeComic,
        icon: Icons.image,
        type: 'comic',
      ),
    ];

    return AdaptiveScaffold(
      currentIndex: 1,
      body: CustomScrollView(
        slivers: [
          // 顶部标题栏
          SliverToBoxAdapter(
            child: _buildHeader(context, t, colorScheme, rules, selectedRule),
          ),
          // 规则选择器
          SliverToBoxAdapter(
            child: _buildRuleSelector(
              context,
              rules,
              selectedRule,
              colorScheme,
            ),
          ),
          // 内容区域
          if (selectedRule.value == null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: _buildNoRuleSelected(context, t, colorScheme),
            )
          else if (isLoading.value)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator()),
            )
          else
            _buildContentGrid(context, colorScheme),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    Translations t,
    ColorScheme colorScheme,
    List<_RuleItem> rules,
    ValueNotifier<String?> selectedRule,
  ) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.discoverPageTitle,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      t.discoverPageSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              // 规则下拉选择器（桌面端显示）
              if (rules.isNotEmpty)
                _buildRuleDropdown(context, rules, selectedRule, colorScheme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRuleDropdown(
    BuildContext context,
    List<_RuleItem> rules,
    ValueNotifier<String?> selectedRule,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedRule.value ?? rules.first.id,
          isDense: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          items: rules.map((rule) {
            return DropdownMenuItem<String>(
              value: rule.id,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    rule.icon,
                    size: 18,
                    color: ColorTokens.cyberCyan,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    rule.name,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              selectedRule.value = value;
            }
          },
        ),
      ),
    );
  }

  Widget _buildRuleSelector(
    BuildContext context,
    List<_RuleItem> rules,
    ValueNotifier<String?> selectedRule,
    ColorScheme colorScheme,
  ) {
    if (rules.isEmpty) {
      return Container(
        padding: EdgeInsets.all(4.w),
        child: Center(
          child: Text(
            Translations.of(context).discoverNoRules,
            style: TextStyle(
              fontSize: 12.sp,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      );
    }

    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: rules.length,
        separatorBuilder: (_, _) => SizedBox(width: 3.w),
        itemBuilder: (context, index) {
          final rule = rules[index];
          final isSelected = selectedRule.value == rule.id;

          return _RuleCard(
            rule: rule,
            isSelected: isSelected,
            onTap: () => selectedRule.value = rule.id,
          );
        },
      ),
    );
  }

  Widget _buildNoRuleSelected(
    BuildContext context,
    Translations t,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Icon(
              Icons.explore_outlined,
              size: 48,
              color: colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            Translations.of(context).discoverSelectRuleHint,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            Translations.of(context).discoverSelectRuleDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContentGrid(BuildContext context, ColorScheme colorScheme) {
    // TODO(WuHaiYue): 从状态管理获取发现数据
    final items = <_DiscoverItem>[
      const _DiscoverItem(
        id: '1',
        title: '示例内容 1',
        coverUrl: '',
        author: '作者 A',
        views: '10万',
        type: 'video',
      ),
      const _DiscoverItem(
        id: '2',
        title: '示例内容 2',
        coverUrl: '',
        author: '作者 B',
        views: '5万',
        type: 'video',
      ),
      const _DiscoverItem(
        id: '3',
        title: '示例内容 3',
        coverUrl: '',
        author: '作者 C',
        views: '20万',
        type: 'video',
      ),
    ];

    // 使用响应式列数
    final columns = context.responsive<int>(
      mobile: 2,
      tablet: 3,
      desktop: 4,
    );

    return SliverPadding(
      padding: EdgeInsets.all(4.w),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 3.w,
        ),
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == items.length) {
            return _LoadMoreCard(
              onTap: () {
                // TODO(WuHaiYue): 加载更多
              },
            );
          }
          return _DiscoverCard(item: items[index]);
        },
      ),
    );
  }
}

/// 规则项数据
class _RuleItem {
  const _RuleItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
  });

  final String id;
  final String name;
  final IconData icon;
  final String type;
}

/// 发现项数据
class _DiscoverItem {
  const _DiscoverItem({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.type,
    this.author,
    this.views,
  });

  final String id;
  final String title;
  final String coverUrl;
  final String? author;
  final String? views;
  final String type;
}

/// 规则卡片
class _RuleCard extends StatelessWidget {
  const _RuleCard({
    required this.rule,
    required this.isSelected,
    required this.onTap,
  });

  final _RuleItem rule;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: AnimatedContainer(
          duration: AppDurations.fast,
          width: 120,
          padding: EdgeInsets.all(3.w),
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
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: isSelected
                  ? ColorTokens.cyberCyan.withValues(alpha: 0.5)
                  : colorScheme.outline.withValues(alpha: 0.1),
              width: isSelected ? 2 : 1,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                rule.icon,
                size: 28,
                color: isSelected
                    ? ColorTokens.cyberCyan
                    : colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              SizedBox(height: 1.h),
              Text(
                rule.name,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? ColorTokens.cyberCyan
                      : colorScheme.onSurface.withValues(alpha: 0.9),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 发现内容卡片
class _DiscoverCard extends StatelessWidget {
  const _DiscoverCard({required this.item});

  final _DiscoverItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: () {
          // TODO(WuHaiYue): 导航到详情页
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
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppRadius.lg),
                    ),
                    color: colorScheme.surfaceContainerHighest,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppRadius.lg),
                    ),
                    child: ColoredBox(
                      color: colorScheme.surfaceContainerHighest,
                      child: Center(
                        child: Icon(
                          _getTypeIcon(item.type),
                          size: 48,
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
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.visibility_outlined,
                            size: 14,
                            color: colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            item.views ?? '0',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.5,
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
}

/// 加载更多卡片
class _LoadMoreCard extends StatelessWidget {
  const _LoadMoreCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = context.t;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.expand_more,
                size: 32,
                color: colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              SizedBox(height: 1.h),
              Text(
                t.discoverLoadMore,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
