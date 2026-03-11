# Spectra UI 完善设计文档

**日期**: 2026-03-11
**版本**: 1.0
**状态**: 待实现

---

## 1. 概述

### 1.1 项目背景
Spectra 是一个跨平台多媒体数据采集应用，主栈为 Flutter + Rust FFI + React Web 编辑器。本次设计旨在完善用户界面，实现一个统一的、响应式的、具有赛博朋克风格的 UI 系统。

### 1.2 设计目标
1. 完善四大核心页面：收藏页（首页）、发现页、搜索页、设置页
2. 实现桌面端和移动端的自适应布局
3. 统一设计风格，优化现有赛博朋克主题
4. 清理旧代码，统一使用 `AdaptiveScaffold`
5. 完善用户可配置项

### 1.3 设计风格
**"深空赛博" (Deep Space Cyber)**
- 深色主题：Cyber Cyan (#00F5FF) + Electric Violet (#8B5CF6) + Neon Pink (#FF00FF)
- 浅色系：Digital Teal + Deep Indigo + Vibrant Rose
- 字体：Orbitron (标题) + Noto Sans SC (正文)
- 视觉元素：玻璃拟态卡片、霓虹辉光效果、瀑布流布局

---

## 2. 页面架构

### 2.1 导航结构
```
收藏(首页) → 发现 → 搜索 → 设置
   [0]      [1]     [2]     [3]
```

### 2.2 响应式布局
- **移动端 (< 840dp)**: 底部导航栏 (64px 高) + 中央悬浮按钮
- **桌面端 (>= 840dp)**: 左侧边栏导航 (72px 宽)

### 2.3 页面详情

#### 2.3.1 收藏页 (FavoritesPage)
**功能**: 展示用户收藏的多媒体内容，支持按类型筛选

**布局结构**:
```
┌─────────────────────────────────────┐
│  标题栏                              │
│  "我的收藏" / 副标题                  │
├─────────────────────────────────────┤
│  媒体类型筛选器 (横向滚动)            │
│  [全部] [视频] [音乐] [小说] [漫画] [图片] │
├─────────────────────────────────────┤
│  最近观看                            │
│  ┌─────┐ ┌─────┐ ┌─────┐           │
│  │     │ │     │ │     │  横向滚动   │
│  └─────┘ └─────┘ └─────┘           │
├─────────────────────────────────────┤
│  全部收藏                            │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐       │
│  │    │ │    │ │    │ │    │  网格   │
│  └────┘ └────┘ └────┘ └────┘       │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐       │
│  │    │ │    │ │    │ │    │       │
│  └────┘ └────┘ └────┘ └────┘       │
└─────────────────────────────────────┘
```

**组件**:
- `_FilterChip`: 媒体类型筛选芯片
- `_RecentCard`: 最近观看卡片（横向滚动）
- `_ContentCard`: 内容卡片（网格布局）
- `_EmptyState`: 空状态组件

**响应式规则**:
- 移动端：2 列网格
- 桌面端：4 列网格
- 卡片宽高比：0.75

---

#### 2.3.2 发现页 (DiscoverPage)
**功能**: 通过选择不同规则展示不同的发现数据，瀑布流布局

**布局结构**:
```
┌─────────────────────────────────────┐
│  标题栏 + 规则下拉选择器 (桌面端)      │
├─────────────────────────────────────┤
│  规则选择器 (横向滚动卡片)            │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐       │
│  │Bili│ │网易│ │起点│ │Bili│       │
│  │    │ │云  │ │中文│ │漫画│       │
│  └────┘ └────┘ └────┘ └────┘       │
├─────────────────────────────────────┤
│  内容类型筛选 (二级筛选)              │
│  [全部] [视频] [音乐] [小说] [漫画]    │
├─────────────────────────────────────┤
│  瀑布流内容                           │
│  ┌────┐ ┌────────┐ ┌────┐          │
│  │    │ │        │ │    │          │
│  │    │ │        │ ├────┤          │
│  ├────┤ │        │ │    │          │
│  │    │ ├────────┤ │    │          │
│  └────┘ └────────┘ └────┘          │
│  ┌────────┐ ┌────┐ ┌────┐          │
│  │        │ │    │ │    │          │
│  └────────┘ └────┘ └────┘          │
└─────────────────────────────────────┘
```

**组件**:
- `_RuleCard`: 规则选择卡片
- `_TypeFilter`: 内容类型筛选器
- `_MasonryCard`: 瀑布流内容卡片（支持不同高度）
- `_LoadMoreCard`: 加载更多卡片

**响应式规则**:
- 移动端：2 列瀑布流
- 桌面端：3-4 列瀑布流

---

#### 2.3.3 搜索页 (SearchPage)
**功能**: 全局搜索，支持搜索历史和热门搜索

**布局结构**:
```
┌─────────────────────────────────────┐
│  搜索栏                              │
│  ┌────────────────────────────────┐ │
│  │ 🔍 搜索内容...              ❌  │ │
│  └────────────────────────────────┘ │
├─────────────────────────────────────┤
│  搜索历史                            │
│  ┌─────┐ ┌─────┐ ┌─────┐           │
│  │🕐 xx│ │🕐 xx│ │🕐 xx│  [清除]    │
│  └─────┘ └─────┘ └─────┘           │
├─────────────────────────────────────┤
│  热门搜索                            │
│  ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐     │
│  │1  │ │2  │ │3  │ │4  │ │5  │     │
│  │热门│ │热门│ │热门│ │热门│ │热门│     │
│  └───┘ └───┘ └───┘ └───┘ └───┘     │
├─────────────────────────────────────┤
│  搜索结果 (搜索后显示)                │
│  [全部] [视频] [音乐] [小说] [漫画]    │
│  ┌────────────────────────────┐     │
│  │ 封面 │ 标题                │     │
│  │      │ 作者                │     │
│  │      │ 描述          [类型]│     │
│  └────────────────────────────┘     │
└─────────────────────────────────────┘
```

**组件**:
- `_HistoryChip`: 搜索历史芯片（带删除按钮）
- `_HotSearchChip`: 热门搜索芯片（带排名）
- `_TabChip`: 搜索结果类型标签
- `_SearchResultCard`: 搜索结果卡片

---

#### 2.3.4 设置页 (SettingsPage)
**功能**: 应用设置，分组卡片 + 子页面结构

**布局结构**:
```
┌─────────────────────────────────────┐
│  设置标题                            │
├─────────────────────────────────────┤
│  ┌────────────────────────────────┐ │
│  │ 🎨 外观设置              >     │ │
│  │    主题: 深色模式               │ │
│  └────────────────────────────────┘ │
│  ┌────────────────────────────────┐ │
│  │ 💾 数据存储              >     │ │
│  │    缓存: 128 MB               │ │
│  └────────────────────────────────┘ │
│  ┌────────────────────────────────┐ │
│  │ ▶️ 播放预览              >     │ │
│  │    自动播放: 关闭              │ │
│  └────────────────────────────────┘ │
│  ┌────────────────────────────────┐ │
│  │ ℹ️ 关于                  >     │ │
│  │    版本: 1.0.0                │ │
│  └────────────────────────────────┘ │
└─────────────────────────────────────┘
```

**分组卡片**:
1. **外观设置** (子页面)
   - 主题模式 (深色/浅色/跟随系统)
   - 语言切换 (中文/英文)

2. **数据存储** (子页面)
   - 清除缓存
   - 导出收藏
   - 导入收藏

3. **播放预览设置** (子页面)
   - 自动播放开关
   - 默认画质选择

4. **关于** (弹窗/子页面)
   - 版本信息
   - 开源许可
   - 隐私政策

**组件**:
- `_SettingsGroupCard`: 设置分组卡片
- `_SettingsTile`: 设置项组件
- `_SettingsSubPage`: 设置子页面

---

## 3. 共享组件设计

### 3.1 AdaptiveScaffold (已存在，需统一使用)
```dart
AdaptiveScaffold(
  currentIndex: 0, // 0=收藏, 1=发现, 2=搜索, 3=设置
  body: FavoritesPage(),
)
```

### 3.2 玻璃拟态卡片 (GlassCard)
```dart
GlassCard(
  child: Widget,
  blur: 10.0,
  opacity: 0.1,
  borderRadius: AppRadius.lg,
)
```

### 3.3 霓虹辉光效果 (NeonGlow)
```dart
NeonGlow(
  color: ColorTokens.cyberCyan,
  intensity: 0.5,
  child: Widget,
)
```

### 3.4 内容类型标签 (TypeBadge)
```dart
TypeBadge(
  type: ContentType.video, // video, music, novel, comic, image
  size: BadgeSize.small,   // small, medium, large
)
```

---

## 4. 主题系统优化

### 4.1 扩展现有 ColorTokens
```dart
// 新增玻璃拟态颜色
static const Color glassWhite = Color(0xFFFFFFFF);
static const Color glassBorder = Color(0xFFFFFFFF);

// 新增内容类型颜色
static const Color videoAccent = Color(0xFF00F5FF);    // Cyan
static const Color musicAccent = Color(0xFFFFD700);    // Gold
static const Color novelAccent = Color(0xFF00FF9D);    // Green
static const Color comicAccent = Color(0xFFFF00FF);    // Magenta
static const Color imageAccent = Color(0xFF8B5CF6);    // Violet
```

### 4.2 阴影效果
```dart
// 霓虹阴影
static List<BoxShadow> neonShadow(Color color) => [
  BoxShadow(
    color: color.withOpacity(0.4),
    blurRadius: 12,
    spreadRadius: 2,
  ),
];

// 卡片阴影
static List<BoxShadow> cardShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 10,
    offset: Offset(0, 4),
  ),
];
```

---

## 5. 数据模型

### 5.1 收藏内容模型 (FavoriteItem)
```dart
@freezed
class FavoriteItem with _$FavoriteItem {
  const factory FavoriteItem({
    required String id,
    required String title,
    required ContentType type,
    required String coverUrl,
    String? author,
    DateTime? collectedAt,
    DateTime? lastWatchedAt,
    int? progress, // 观看进度百分比
  }) = _FavoriteItem;
}
```

### 5.2 发现规则模型 (DiscoverRule)
```dart
@freezed
class DiscoverRule with _$DiscoverRule {
  const factory DiscoverRule({
    required String id,
    required String name,
    required IconData icon,
    required ContentType type,
    required String sourceUrl,
    bool isEnabled,
  }) = _DiscoverRule;
}
```

### 5.3 搜索结果模型 (SearchResult)
```dart
@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    required String id,
    required String title,
    required ContentType type,
    String? coverUrl,
    String? author,
    String? description,
    bool isFavorited,
  }) = _SearchResult;
}
```

---

## 6. 状态管理

### 6.1 Riverpod Providers
```dart
// 收藏状态
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, AsyncValue<List<FavoriteItem>>>((ref) {
  return FavoritesNotifier(ref);
});

// 发现规则状态
final discoverRulesProvider = StateNotifierProvider<DiscoverRulesNotifier, AsyncValue<List<DiscoverRule>>>((ref) {
  return DiscoverRulesNotifier(ref);
});

// 搜索状态
final searchProvider = StateNotifierProvider<SearchNotifier, AsyncValue<List<SearchResult>>>((ref) {
  return SearchNotifier(ref);
});

// 设置状态
final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier(ref);
});
```

---

## 7. 清理清单

### 7.1 删除旧代码
- [ ] `lib/features/home/` 目录（已删除页面文件，需删除整个目录）

### 7.2 统一使用 AdaptiveScaffold
- [ ] `lib/features/settings/presentation/pages/settings_page.dart`
  - 当前使用普通 Scaffold
  - 需要改为使用 AdaptiveScaffold

### 7.3 依赖检查
- [ ] 添加 `flutter_staggered_grid_view` 用于瀑布流布局

---

## 8. 实现优先级

1. **P0 - 核心功能**
   - 统一设置页使用 AdaptiveScaffold
   - 清理旧代码
   - 完善收藏页数据绑定

2. **P1 - 体验优化**
   - 发现页瀑布流布局
   - 搜索页历史记录持久化
   - 设置页分组卡片 + 子页面

3. **P2 - 视觉优化**
   - 玻璃拟态卡片组件
   - 霓虹辉光效果
   - 内容类型颜色标识

---

## 9. 技术栈

- **状态管理**: hooks_riverpod + flutter_hooks
- **响应式**: sizer
- **路由**: go_router
- **主题**: flex_color_scheme (Material 3)
- **瀑布流**: flutter_staggered_grid_view
- **本地存储**: drift (SQLite)

---

## 10. 附录

### 10.1 国际化词条规划

#### 10.1.1 新增词条清单

**设置页 - 数据存储分组**
| 键名 | 中文 | 英文 |
|-----|------|------|
| `settingsDataStorage` | 数据存储 | Data Storage |
| `settingsCacheSize` | 缓存大小 | Cache Size |
| `settingsClearCache` | 清除缓存 | Clear Cache |
| `settingsClearCacheConfirm` | 确定要清除所有缓存吗？ | Clear all cache? |
| `settingsCacheCleared` | 缓存已清除 | Cache cleared |
| `settingsExportFavorites` | 导出收藏 | Export Favorites |
| `settingsImportFavorites` | 导入收藏 | Import Favorites |
| `settingsExportSuccess` | 导出成功 | Export successful |
| `settingsImportSuccess` | 导入成功 | Import successful |
| `settingsExportError` | 导出失败 | Export failed |
| `settingsImportError` | 导入失败 | Import failed |

**设置页 - 播放预览设置分组**
| 键名 | 中文 | 英文 |
|-----|------|------|
| `settingsPlayback` | 播放预览 | Playback & Preview |
| `settingsAutoPlay` | 自动播放 | Auto Play |
| `settingsAutoPlayOn` | 开启 | On |
| `settingsAutoPlayOff` | 关闭 | Off |
| `settingsDefaultQuality` | 默认画质 | Default Quality |
| `settingsQualityAuto` | 自动 | Auto |
| `settingsQualityHigh` | 高清 | High |
| `settingsQualityStandard` | 标清 | Standard |
| `settingsQualityLow` | 流畅 | Low |

**设置页 - 子页面通用**
| 键名 | 中文 | 英文 |
|-----|------|------|
| `settingsBack` | 返回 | Back |
| `settingsSave` | 保存 | Save |
| `settingsSaved` | 已保存 | Saved |

**发现页**
| 键名 | 中文 | 英文 |
|-----|------|------|
| `discoverFilterByType` | 筛选类型 | Filter by Type |
| `discoverRuleActive` | 当前规则 | Current Rule |

**搜索页**
| 键名 | 中文 | 英文 |
|-----|------|------|
| `searchClear` | 清除 | Clear |
| `searchDeleteHistory` | 删除此记录 | Delete from history |

**收藏页**
| 键名 | 中文 | 英文 |
|-----|------|------|
| `favoritesFilterAll` | 全部 | All |
| `favoritesCollectedAt` | 收藏于 | Collected at |
| `favoritesLastWatched` | 上次观看 | Last watched |

**通用操作**
| 键名 | 中文 | 英文 |
|-----|------|------|
| `actionConfirm` | 确认 | Confirm |
| `actionCancel` | 取消 | Cancel |
| `actionDelete` | 删除 | Delete |
| `actionEdit` | 编辑 | Edit |
| `actionShare` | 分享 | Share |
| `actionDownload` | 下载 | Download |
| `actionOpen` | 打开 | Open |
| `actionClose` | 关闭 | Close |
| `actionRetry` | 重试 | Retry |
| `actionLoading` | 加载中... | Loading... |
| `actionLoadMore` | 加载更多 | Load more |
| `actionNoMoreData` | 没有更多数据了 | No more data |

**内容类型标签（补充）**
| 键名 | 中文 | 英文 |
|-----|------|------|
| `contentTypeVideo` | 视频 | Video |
| `contentTypeMusic` | 音乐 | Music |
| `contentTypeNovel` | 小说 | Novel |
| `contentTypeComic` | 漫画 | Comic |
| `contentTypeImage` | 图片 | Image |
| `contentTypeUnknown` | 未知 | Unknown |

**时间格式化**
| 键名 | 中文 | 英文 |
|-----|------|------|
| `timeJustNow` | 刚刚 | Just now |
| `timeMinutesAgo` | {count}分钟前 | {count} min ago |
| `timeHoursAgo` | {count}小时前 | {count} hours ago |
| `timeDaysAgo` | {count}天前 | {count} days ago |
| `timeWeeksAgo` | {count}周前 | {count} weeks ago |
| `timeMonthsAgo` | {count}个月前 | {count} months ago |
| `timeYearsAgo` | {count}年前 | {count} years ago |

#### 10.1.2 ARB 文件更新示例

**intl_zh.arb 新增内容**:
```json
{
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
  "settingsDefaultQuality": "默认画质",
  "actionConfirm": "确认",
  "actionCancel": "取消",
  "actionDelete": "删除",
  "actionLoading": "加载中...",
  "actionLoadMore": "加载更多",
  "actionNoMoreData": "没有更多数据了",
  "timeJustNow": "刚刚",
  "timeMinutesAgo": "{count}分钟前",
  "@timeMinutesAgo": {
    "placeholders": {
      "count": {"type": "int"}
    }
  }
}
```

**intl_en.arb 新增内容**:
```json
{
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
  "settingsDefaultQuality": "Default Quality",
  "actionConfirm": "Confirm",
  "actionCancel": "Cancel",
  "actionDelete": "Delete",
  "actionLoading": "Loading...",
  "actionLoadMore": "Load more",
  "actionNoMoreData": "No more data",
  "timeJustNow": "Just now",
  "timeMinutesAgo": "{count} min ago",
  "@timeMinutesAgo": {
    "placeholders": {
      "count": {"type": "int"}
    }
  }
}
```

### 10.2 图标映射
| 内容类型 | 图标 | 颜色 |
|---------|------|------|
| 视频 | Icons.video_library_outlined | #00F5FF (Cyan) |
| 音乐 | Icons.music_note_outlined | #FFD700 (Gold) |
| 小说 | Icons.menu_book_outlined | #00FF9D (Green) |
| 漫画 | Icons.image_outlined | #FF00FF (Magenta) |
| 图片 | Icons.photo_library_outlined | #8B5CF6 (Violet) |

### 10.3 断点规则
| 断点 | 宽度 | 布局 |
|-----|------|------|
| Mobile | < 600dp | 底部导航，2列网格 |
| Tablet | 600-1024dp | 底部导航，3列网格 |
| Desktop | >= 1024dp | 侧边栏导航，4列网格 |

---

**文档结束**
