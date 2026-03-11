import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/l10n/generated/l10n.dart';

/// 自适应脚手架
///
/// 根据屏幕尺寸自动切换导航模式：
/// - 桌面端：侧边栏导航
/// - 移动端：底部导航栏
///
/// 使用示例：
/// ```dart
/// AdaptiveScaffold(
///   currentIndex: 0,
///   body: HomePage(),
/// )
/// ```
class AdaptiveScaffold extends HookConsumerWidget {
  /// 创建自适应脚手架
  const AdaptiveScaffold({
    required this.currentIndex,
    required this.body,
    super.key,
  });

  /// 当前选中的导航索引
  final int currentIndex;

  /// 主体内容
  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    // 使用 LayoutBuilder 检测屏幕尺寸
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= AppBreakpoints.tabletLarge;

        if (isDesktop) {
          return _DesktopLayout(
            currentIndex: currentIndex,
            body: body,
            l10n: l10n,
            colorScheme: colorScheme,
          );
        } else {
          return _MobileLayout(
            currentIndex: currentIndex,
            body: body,
            l10n: l10n,
            colorScheme: colorScheme,
          );
        }
      },
    );
  }
}

/// 桌面端布局
class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.currentIndex,
    required this.body,
    required this.l10n,
    required this.colorScheme,
  });

  final int currentIndex;
  final Widget body;
  final S l10n;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 侧边栏
          _Sidebar(
            currentIndex: currentIndex,
            l10n: l10n,
            colorScheme: colorScheme,
          ),
          // 主内容区
          Expanded(child: body),
        ],
      ),
    );
  }
}

/// 移动端布局
class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.currentIndex,
    required this.body,
    required this.l10n,
    required this.colorScheme,
  });

  final int currentIndex;
  final Widget body;
  final S l10n;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: _BottomNavBar(
        currentIndex: currentIndex,
        l10n: l10n,
        colorScheme: colorScheme,
      ),
    );
  }
}

/// 侧边栏导航
class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.currentIndex,
    required this.l10n,
    required this.colorScheme,
  });

  final int currentIndex;
  final S l10n;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 72,
      decoration: BoxDecoration(
        color: isDark ? ColorTokens.deepVoid : ColorTokens.lightVoid,
        border: Border(
          right: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo 区域
          _buildLogo(),
          const Divider(height: 1),
          // 导航项
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Column(
                children: [
                  _NavItem(
                    index: 0,
                    currentIndex: currentIndex,
                    icon: Icons.favorite_outline,
                    activeIcon: Icons.favorite,
                    tooltip: l10n.navFavorites,
                    route: '/',
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _NavItem(
                    index: 1,
                    currentIndex: currentIndex,
                    icon: Icons.explore_outlined,
                    activeIcon: Icons.explore,
                    tooltip: l10n.navDiscover,
                    route: '/discover',
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _NavItem(
                    index: 2,
                    currentIndex: currentIndex,
                    icon: Icons.search_outlined,
                    activeIcon: Icons.search,
                    tooltip: l10n.navSearch,
                    route: '/search',
                    colorScheme: colorScheme,
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          // 设置按钮
          _NavItem(
            index: 3,
            currentIndex: currentIndex,
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings,
            tooltip: l10n.settingsTitle,
            route: '/settings',
            colorScheme: colorScheme,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      height: 72,
      alignment: Alignment.center,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ColorTokens.cyberCyan, ColorTokens.electricViolet],
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: const Icon(
          Icons.auto_awesome,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}

/// 导航项组件
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.tooltip,
    required this.route,
    required this.colorScheme,
  });

  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final String tooltip;
  final String route;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;

    return Tooltip(
      message: tooltip,
      preferBelow: false,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.go(route),
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.md),
              gradient: isSelected
                  ? LinearGradient(
                      colors: [
                        ColorTokens.cyberCyan.withValues(alpha: 0.2),
                        ColorTokens.electricViolet.withValues(alpha: 0.1),
                      ],
                    )
                  : null,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 选中指示器
                if (isSelected)
                  Positioned(
                    left: 0,
                    top: 16,
                    bottom: 16,
                    child: Container(
                      width: 3,
                      decoration: BoxDecoration(
                        color: ColorTokens.cyberCyan,
                        borderRadius: BorderRadius.circular(1.5),
                        boxShadow: [
                          BoxShadow(
                            color: ColorTokens.cyberCyan.withValues(alpha: 0.5),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                // 图标
                Icon(
                  isSelected ? activeIcon : icon,
                  color: isSelected
                      ? ColorTokens.cyberCyan
                      : colorScheme.onSurface.withValues(alpha: 0.6),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 底部导航栏
class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.currentIndex,
    required this.l10n,
    required this.colorScheme,
  });

  final int currentIndex;
  final S l10n;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? ColorTokens.deepVoid : ColorTokens.lightVoid,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: ColorTokens.cyberCyan.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomNavItem(
                index: 0,
                currentIndex: currentIndex,
                icon: Icons.favorite_outline,
                activeIcon: Icons.favorite,
                label: l10n.navFavorites,
                route: '/',
                colorScheme: colorScheme,
              ),
              _BottomNavItem(
                index: 1,
                currentIndex: currentIndex,
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore,
                label: l10n.navDiscover,
                route: '/discover',
                colorScheme: colorScheme,
              ),
              // 中央 FAB 占位
              const SizedBox(width: 64),
              _BottomNavItem(
                index: 2,
                currentIndex: currentIndex,
                icon: Icons.search_outlined,
                activeIcon: Icons.search,
                label: l10n.navSearch,
                route: '/search',
                colorScheme: colorScheme,
              ),
              _BottomNavItem(
                index: 3,
                currentIndex: currentIndex,
                icon: Icons.settings_outlined,
                activeIcon: Icons.settings,
                label: l10n.settingsTitle,
                route: '/settings',
                colorScheme: colorScheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 底部导航项组件
class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
    required this.colorScheme,
  });

  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.go(route),
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          width: 64,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected
                    ? ColorTokens.cyberCyan
                    : colorScheme.onSurface.withValues(alpha: 0.6),
                size: 24,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected
                      ? ColorTokens.cyberCyan
                      : colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 中央悬浮按钮
class CenterFAB extends StatelessWidget {
  /// 创建中央悬浮按钮
  const CenterFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ColorTokens.cyberCyan, ColorTokens.electricViolet],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: ColorTokens.cyberCyan.withValues(alpha: 0.4),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          onTap: () {
            // TODO: 打开快速操作菜单
          },
          borderRadius: BorderRadius.circular(28),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}
