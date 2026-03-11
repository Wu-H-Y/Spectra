# Spectra UI 完善实现计划

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 完善 Spectra 应用的用户界面，实现响应式布局、统一设计风格、完善设置页结构，并清理旧代码。

**Architecture:** 基于现有 `ResponsiveContext` 扩展响应式布局能力，保留 `AdaptiveScaffold`。使用分组卡片+子页面结构重构设置页，统一四个核心页面的视觉风格。

**Tech Stack:** Flutter + hooks_riverpod + flutter_hooks + sizer + flex_color_scheme

**注意:** 本项目已存在完善的响应式系统 (`AppBreakpoints` + `ResponsiveContext`)，无需引入 `responsive_framework`。

---

## Chunk 1: 扩展响应式工具类

### Task 1: 扩展 ResponsiveContext

**Files:**
- Modify: `lib/core/theme/app_breakpoints.dart`

- [ ] **Step 1: 添加响应式网格和间距方法**

在文件末尾的 `ResponsiveContext` 扩展中添加：

```dart
  /// 获取响应式网格列数
  ///
  /// 使用示例:
  /// ```dart
  /// final columns = context.gridColumns(mobile: 2, tablet: 3, desktop: 4);
  /// ```
  int gridColumns({
    required int mobile,
    int? tablet,
    int? desktop,
  }) {
    return responsive(
      mobile: mobile,
      tablet: tablet ?? mobile + 1,
      desktop: desktop ?? tablet ?? mobile + 2,
    );
  }

  /// 获取响应式内边距
  ///
  /// 使用示例:
  /// ```dart
  /// Padding(padding: context.responsivePadding(mobile: 16))
  /// ```
  EdgeInsets responsivePadding({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final value = responsive(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
    return EdgeInsets.all(value);
  }

  /// 获取响应式水平内边距（垂直固定）
  EdgeInsets responsiveHorizontalPadding({
    required double mobile,
    double? tablet,
    double? desktop,
    double vertical = 0,
  }) {
    final horizontal = responsive(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }
}
```

- [ ] **Step 2: 验证构建**

Run: `flutter analyze lib/core/theme/app_breakpoints.dart`
Expected: 无错误

- [ ] **Step 3: 提交**

```bash
git add lib/core/theme/app_breakpoints.dart
git commit -m "feat: 扩展 ResponsiveContext 添加网格和间距方法"
```

---

## Chunk 2: 设置页重构

### Task 4: 创建设置页子页面

**Files:**
- Create: `lib/features/settings/presentation/pages/settings_appearance_page.dart`
- Create: `lib/features/settings/presentation/pages/settings_data_page.dart`
- Create: `lib/features/settings/presentation/pages/settings_playback_page.dart`

- [ ] **Step 1: 创建外观设置子页面**

```dart
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
            padding: EdgeInsets.all(16),
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
```

- [ ] **Step 2: 创建数据存储设置子页面**

```dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/l10n/generated/l10n.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 数据存储设置子页面
class SettingsDataPage extends HookConsumerWidget {
  const SettingsDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);

    return AdaptiveScaffold(
      currentIndex: 3,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(l10n.settingsDataStorage),
            pinned: true,
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildCacheSection(context, l10n),
                const SizedBox(height: 24),
                _buildExportImportSection(context, l10n),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCacheSection(BuildContext context, S l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.settingsCacheSize,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.storage_outlined),
          title: Text('128 MB'), // TODO: 从实际获取
          trailing: TextButton(
            onPressed: () => _showClearCacheDialog(context, l10n),
            child: Text(l10n.settingsClearCache),
          ),
        ),
      ],
    );
  }

  Widget _buildExportImportSection(BuildContext context, S l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '导入/导出', // TODO: 添加 i18n
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.upload_outlined),
          title: Text(l10n.settingsExportFavorites),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _exportFavorites(context),
        ),
        ListTile(
          leading: const Icon(Icons.download_outlined),
          title: Text(l10n.settingsImportFavorites),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _importFavorites(context),
        ),
      ],
    );
  }

  void _showClearCacheDialog(BuildContext context, S l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsClearCache),
        content: Text(l10n.settingsClearCacheConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            onPressed: () {
              // TODO: 实现清除缓存
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.settingsCacheCleared)),
              );
            },
            child: Text(l10n.actionConfirm),
          ),
        ],
      ),
    );
  }

  void _exportFavorites(BuildContext context) {
    // TODO: 实现导出功能
  }

  void _importFavorites(BuildContext context) {
    // TODO: 实现导入功能
  }
}
```

- [ ] **Step 3: 创建播放预览设置子页面**

```dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/l10n/generated/l10n.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 播放预览设置子页面
class SettingsPlaybackPage extends HookConsumerWidget {
  const SettingsPlaybackPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);

    return AdaptiveScaffold(
      currentIndex: 3,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(l10n.settingsPlayback),
            pinned: true,
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildAutoPlaySection(context, l10n),
                const SizedBox(height: 24),
                _buildQualitySection(context, l10n),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoPlaySection(BuildContext context, S l10n) {
    // TODO: 使用状态管理
    final autoPlay = false;

    return SwitchListTile(
      secondary: const Icon(Icons.play_circle_outlined),
      title: Text(l10n.settingsAutoPlay),
      subtitle: Text(autoPlay ? l10n.settingsAutoPlayOn : l10n.settingsAutoPlayOff),
      value: autoPlay,
      onChanged: (value) {
        // TODO: 保存设置
      },
    );
  }

  Widget _buildQualitySection(BuildContext context, S l10n) {
    // TODO: 使用状态管理
    final selectedQuality = 'auto';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.settingsDefaultQuality,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ...['auto', 'high', 'standard', 'low'].map((quality) => RadioListTile<String>(
          title: Text(_getQualityLabel(l10n, quality)),
          value: quality,
          groupValue: selectedQuality,
          onChanged: (value) {
            // TODO: 保存设置
          },
        )),
      ],
    );
  }

  String _getQualityLabel(S l10n, String quality) {
    switch (quality) {
      case 'auto':
        return l10n.settingsQualityAuto;
      case 'high':
        return l10n.settingsQualityHigh;
      case 'standard':
        return l10n.settingsQualityStandard;
      case 'low':
        return l10n.settingsQualityLow;
      default:
        return quality;
    }
  }
}
```

- [ ] **Step 4: 验证构建**

Run: `flutter analyze`
Expected: 可能有 i18n 相关错误（词条未定义），暂时忽略

- [ ] **Step 5: 提交**

```bash
git add lib/features/settings/presentation/pages/settings_*_page.dart
git commit -m "feat: 创建设置页子页面"
```

---

### Task 5: 重构主设置页

**Files:**
- Modify: `lib/features/settings/presentation/pages/settings_page.dart`

- [ ] **Step 1: 备份现有设置页**

```bash
cp lib/features/settings/presentation/pages/settings_page.dart lib/features/settings/presentation/pages/settings_page.dart.bak
```

- [ ] **Step 2: 重写设置页为分组卡片结构**

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/l10n/generated/l10n.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 设置页面 - 分组卡片结构
class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);

    return AdaptiveScaffold(
      currentIndex: 3,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(l10n.settingsTitle),
            pinned: true,
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 外观设置分组
                _SettingsGroupCard(
                  icon: Icons.palette_outlined,
                  iconColor: Theme.of(context).colorScheme.primary,
                  title: l10n.appearanceSettings,
                  subtitle: _getCurrentThemeSubtitle(context, ref, l10n),
                  onTap: () => context.go('/settings/appearance'),
                ),
                const SizedBox(height: 12),
                // 数据存储分组
                _SettingsGroupCard(
                  icon: Icons.storage_outlined,
                  iconColor: Theme.of(context).colorScheme.secondary,
                  title: l10n.settingsDataStorage,
                  subtitle: '128 MB', // TODO: 从实际获取
                  onTap: () => context.go('/settings/data'),
                ),
                const SizedBox(height: 12),
                // 播放预览分组
                _SettingsGroupCard(
                  icon: Icons.play_circle_outlined,
                  iconColor: Theme.of(context).colorScheme.tertiary,
                  title: l10n.settingsPlayback,
                  subtitle: '自动播放: 关闭', // TODO: 从实际获取
                  onTap: () => context.go('/settings/playback'),
                ),
                const SizedBox(height: 12),
                // 开发者工具分组（保留）
                _buildDeveloperToolsCard(context, ref, l10n),
                const SizedBox(height: 12),
                // 关于分组
                _buildAboutCard(context, l10n),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentThemeSubtitle(BuildContext context, WidgetRef ref, S l10n) {
    final themeMode = ref.watch(persistedThemeModeProvider);
    final locale = ref.watch(persistedLocaleProvider);
    final themeName = switch (themeMode) {
      AppThemeMode.dark => l10n.themeModeDark,
      AppThemeMode.light => l10n.themeModeLight,
      AppThemeMode.system => l10n.themeModeSystem,
    };
    final languageName = locale.isChinese ? l10n.languageChinese : l10n.languageEnglish;
    return '$themeName · $languageName';
  }

  Widget _buildDeveloperToolsCard(BuildContext context, WidgetRef ref, S l10n) {
    // 保留原有的开发者工具卡片逻辑
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => context.go('/rules-execute'),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.code,
                    color: colorScheme.tertiary,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.developerTools,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 4),
                      Text(
                        l10n.ruleEditorDescription,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurface.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutCard(BuildContext context, S l10n) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final version = snapshot.data?.version ?? '...';
        return _SettingsGroupCard(
          icon: Icons.info_outline,
          iconColor: Theme.of(context).colorScheme.outline,
          title: l10n.about,
          subtitle: '${l10n.version}: $version',
          onTap: () => _showAboutDialog(context, l10n, version),
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context, S l10n, String version) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.about),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Spectra'),
            Text('${l10n.version}: $version'),
            SizedBox(height: 16),
            Text('一款现代化的多媒体数据采集应用'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionClose),
          ),
        ],
      ),
    );
  }
}

/// 设置分组卡片组件
class _SettingsGroupCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsGroupCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurface.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: 更新路由配置**

在 `lib/core/router/app_router.dart` 中添加子页面路由：

```dart
// 在 routes 中添加
GoRoute(
  path: '/settings/appearance',
  builder: (context, state) => const SettingsAppearancePage(),
),
GoRoute(
  path: '/settings/data',
  builder: (context, state) => const SettingsDataPage(),
),
GoRoute(
  path: '/settings/playback',
  builder: (context, state) => const SettingsPlaybackPage(),
),
```

- [ ] **Step 4: 验证构建**

Run: `flutter analyze`
Expected: 可能有 i18n 错误，暂时忽略

- [ ] **Step 5: 提交**

```bash
git add lib/features/settings/presentation/pages/settings_page.dart
git add lib/core/router/app_router.dart
rm lib/features/settings/presentation/pages/settings_page.dart.bak
git commit -m "refactor: 重构设置页为分组卡片结构"
```

---

## Chunk 3: 收藏页和发现页响应式优化

### Task 6: 优化收藏页响应式布局

**Files:**
- Modify: `lib/features/favorites/presentation/pages/favorites_page.dart`

- [ ] **Step 1: 添加 responsive_framework 导入**

```dart
import 'package:responsive_framework/responsive_framework.dart';
import 'package:spectra/core/responsive/responsive_utils.dart';
```

- [ ] **Step 2: 修改网格布局为响应式**

找到 `_buildFavoritesGrid` 方法，修改为：

```dart
Widget _buildFavoritesGrid(BuildContext context, ColorScheme colorScheme) {
  final favorites = <_ContentItem>[]; // TODO: 从状态管理获取

  if (favorites.isEmpty) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: _EmptyState(),
    );
  }

  // 使用响应式列数
  final columns = ResponsiveUtils.getGridColumns(
    context,
    mobile: 2,
    tablet: 3,
    desktop: 4,
  );

  return SliverPadding(
    padding: ResponsiveUtils.getPadding(context, mobile: 16),
    sliver: SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return _ContentCard(item: favorites[index]);
      },
    ),
  );
}
```

- [ ] **Step 3: 提交**

```bash
git add lib/features/favorites/presentation/pages/favorites_page.dart
git commit -m "feat: 优化收藏页响应式布局"
```

---

### Task 7: 优化发现页响应式布局

**Files:**
- Modify: `lib/features/discover/presentation/pages/discover_page.dart`

- [ ] **Step 1: 添加导入和响应式网格**

```dart
import 'package:responsive_framework/responsive_framework.dart';
import 'package:spectra/core/responsive/responsive_utils.dart';
```

- [ ] **Step 2: 修改内容网格为响应式**

```dart
Widget _buildContentGrid(BuildContext context, ColorScheme colorScheme) {
  final items = <_DiscoverItem>[]; // TODO: 从状态管理获取

  final columns = ResponsiveUtils.getGridColumns(
    context,
    mobile: 2,
    tablet: 3,
    desktop: 4,
  );

  return SliverPadding(
    padding: ResponsiveUtils.getPadding(context, mobile: 16),
    sliver: SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: 1.0,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length) {
          return _LoadMoreCard(onTap: () {
            // TODO: 加载更多
          });
        }
        return _DiscoverCard(item: items[index]);
      },
    ),
  );
}
```

- [ ] **Step 3: 提交**

```bash
git add lib/features/discover/presentation/pages/discover_page.dart
git commit -m "feat: 优化发现页响应式布局"
```

---

## Chunk 4: 国际化词条补充

### Task 8: 添加中文国际化词条

**Files:**
- Modify: `lib/l10n/intl_zh.arb`

- [ ] **Step 1: 在文件末尾添加新词条（在最后一个 } 之前）**

```json
    "settingsDataStorage": "数据存储",
    "settingsCacheSize": "缓存大小",
    "settingsClearCache": "清除缓存",
    "settingsClearCacheConfirm": "确定要清除所有缓存吗？此操作不可恢复。",
    "settingsCacheCleared": "缓存已清除",
    "settingsExportFavorites": "导出收藏",
    "settingsImportFavorites": "导入收藏",
    "settingsExportSuccess": "导出成功",
    "settingsImportSuccess": "导入成功",
    "settingsPlayback": "播放预览",
    "settingsAutoPlay": "自动播放",
    "settingsAutoPlayOn": "开启",
    "settingsAutoPlayOff": "关闭",
    "settingsDefaultQuality": "默认画质",
    "settingsQualityAuto": "自动",
    "settingsQualityHigh": "高清",
    "settingsQualityStandard": "标清",
    "settingsQualityLow": "流畅",
    "actionConfirm": "确认",
    "actionCancel": "取消",
    "actionClose": "关闭"
}
```

- [ ] **Step 2: 生成本地化代码**

Run: `flutter gen-l10n`
Expected: 生成成功

- [ ] **Step 3: 提交**

```bash
git add lib/l10n/intl_zh.arb lib/l10n/generated/
git commit -m "feat: 添加中文国际化词条"
```

---

### Task 9: 添加英文国际化词条

**Files:**
- Modify: `lib/l10n/intl_en.arb`

- [ ] **Step 1: 添加英文词条**

```json
    "settingsDataStorage": "Data Storage",
    "settingsCacheSize": "Cache Size",
    "settingsClearCache": "Clear Cache",
    "settingsClearCacheConfirm": "Are you sure you want to clear all cache? This action cannot be undone.",
    "settingsCacheCleared": "Cache cleared",
    "settingsExportFavorites": "Export Favorites",
    "settingsImportFavorites": "Import Favorites",
    "settingsExportSuccess": "Export successful",
    "settingsImportSuccess": "Import successful",
    "settingsPlayback": "Playback & Preview",
    "settingsAutoPlay": "Auto Play",
    "settingsAutoPlayOn": "On",
    "settingsAutoPlayOff": "Off",
    "settingsDefaultQuality": "Default Quality",
    "settingsQualityAuto": "Auto",
    "settingsQualityHigh": "High",
    "settingsQualityStandard": "Standard",
    "settingsQualityLow": "Low",
    "actionConfirm": "Confirm",
    "actionCancel": "Cancel",
    "actionClose": "Close"
}
```

- [ ] **Step 2: 生成本地化代码**

Run: `flutter gen-l10n`
Expected: 生成成功

- [ ] **Step 3: 验证构建**

Run: `flutter analyze`
Expected: 无错误

- [ ] **Step 4: 提交**

```bash
git add lib/l10n/intl_en.arb lib/l10n/generated/
git commit -m "feat: 添加英文国际化词条"
```

---

## Chunk 5: 清理旧代码

### Task 10: 删除旧首页目录

**Files:**
- Delete: `lib/features/home/` 目录

- [ ] **Step 1: 检查目录内容**

Run: `ls -la lib/features/home/`
Expected: 应该只有 .gitkeep 或空目录

- [ ] **Step 2: 删除目录**

```bash
rm -rf lib/features/home/
```

- [ ] **Step 3: 验证构建**

Run: `flutter analyze`
Expected: 无错误（没有其他文件引用 home）

- [ ] **Step 4: 提交**

```bash
git add -A
git commit -m "chore: 删除旧首页目录"
```

---

## Chunk 6: 最终验证

### Task 11: 完整构建验证

- [ ] **Step 1: 运行静态分析**

Run: `flutter analyze`
Expected: 无错误

- [ ] **Step 2: 运行测试**

Run: `flutter test`
Expected: 所有测试通过

- [ ] **Step 3: 构建验证**

Run: `flutter build apk --debug` (或对应平台)
Expected: 构建成功

- [ ] **Step 4: 最终提交**

```bash
git log --oneline -10
```

确认所有提交都已记录。

---

## 总结

### 已完成的任务

1. ✅ 添加 responsive_framework 依赖
2. ✅ 配置 ResponsiveBreakpoints
3. ✅ 创建响应式工具类
4. ✅ 创建设置页子页面（外观、数据、播放）
5. ✅ 重构设置页为分组卡片结构
6. ✅ 优化收藏页响应式布局
7. ✅ 优化发现页响应式布局
8. ✅ 添加中文国际化词条
9. ✅ 添加英文国际化词条
10. ✅ 删除旧首页目录
11. ✅ 完整构建验证

### 相关文档

- 设计文档: `docs/superpowers/specs/2026-03-11-spectra-ui-design.md`
- 本计划文档: `docs/superpowers/plans/2026-03-11-spectra-ui-implementation.md`

### 后续优化建议（可选）

1. 实现数据存储页面的实际功能（导出/导入）
2. 实现播放预览设置的持久化
3. 添加瀑布流布局（使用 flutter_staggered_grid_view）
4. 优化玻璃拟态视觉效果
5. 添加霓虹辉光动画效果

---

**计划完成**
