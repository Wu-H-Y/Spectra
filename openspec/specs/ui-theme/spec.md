# UI 主题规范

## 设计令牌

### Requirement: 核心颜色令牌

| 令牌名 | 深色主题 | 浅色主题 | 用途 |
|--------|----------|----------|------|
| primary | `#00F2FF` (Cyber Cyan) | `#0891B2` (Digital Teal) | 主要操作 |
| secondary | `#7000FF` (Electric Violet) | `#6366F1` (Deep Indigo) | 次要元素 |
| tertiary | `#FF0055` (Neon Pink) | `#E11D48` (Vibrant Rose) | 强调元素 |
| surface | `#0F172A` | `#FFFFFF` | 卡片/对话框背景 |
| scaffoldBackground | `#0B0E14` (Deep Void) | `#F8FAFC` | 页面背景 |

### Requirement: 间距令牌

| 令牌 | 值 | 用途 |
|------|-----|------|
| xs | 4dp | 紧凑间距 |
| sm | 8dp | 小间隙 |
| md | 16dp | 默认间距 |
| lg | 24dp | 区域间隔 |
| xl | 32dp | 大边距 |

### Requirement: 动画时长令牌

| 令牌 | 值 | 用途 |
|------|-----|------|
| fast | 150ms | 快速过渡 |
| normal | 300ms | 标准动画 |
| slow | 500ms | 强调动画 |

### Requirement: 圆角令牌

| 令牌 | 值 | 用途 |
|------|-----|------|
| sm | 8dp | 小圆角 (chips, tags) |
| md | 12dp | 中圆角 (buttons, inputs) |
| lg | 16dp | 大圆角 (cards) |
| xl | 24dp | 超大圆角 (modals) |
| full | 9999dp | 圆形/药丸 |

---

## 字体规范

### Requirement: 字体家族

| 文本样式 | 字体 | 用途 |
|----------|------|------|
| displayLarge/Medium/Small | Orbitron | 大标题 |
| headlineLarge/Medium/Small | Orbitron | 区块标题 |
| titleLarge | Orbitron | 页面标题 |
| titleMedium/Small | Noto Sans SC | 副标题 |
| bodyLarge/Medium/Small | Noto Sans SC | 正文 |
| labelLarge/Medium/Small | Noto Sans SC | 标签 |

### Requirement: 中文排版优化

- **最小正文字号**: 14dp
- **推荐正文字号**: 16dp
- **行高倍数**: 1.6 (比西文 1.5 略大)

---

## 视觉效果

### Requirement: 深色主题玻璃拟态

```dart
// 深色主题卡片效果
BoxDecoration(
  color: Colors.white.withOpacity(0.05),
  border: Border.all(color: Colors.white.withOpacity(0.1)),
  borderRadius: BorderRadius.circular(16),
);
```

### Requirement: 浅色主题柔和阴影

```dart
// 浅色主题卡片效果
BoxDecoration(
  color: Colors.white.withOpacity(0.8),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ],
  borderRadius: BorderRadius.circular(16),
);
```

### Requirement: 霓虹发光效果 (仅深色主题)

```dart
BoxShadow(
  color: primaryColor.withOpacity(0.3),
  blurRadius: 20,
  spreadRadius: 2,
);
```

### Requirement: 性能指南

| 效果 | 性能影响 | 建议 |
|------|----------|------|
| Backdrop blur | 高 | 避免在滚动列表中使用 |
| Neon glow | 中 | 限于静态元素 |
| Soft shadow | 低 | 所有场景可用 |

---

## 主题 Provider

### Requirement: 主题模式 Provider

```dart
@riverpod
class ThemeMode extends _$ThemeMode {
  @override
  AppThemeMode build() => AppThemeMode.system;
  
  void toggle() { /* ... */ }
}
```

#### Scenario: 主题持久化
- **WHEN** 用户更改主题
- **THEN** 保存到 Hive，重启后恢复

---

## 目录结构

```
lib/core/theme/
├── theme.dart              # 导出文件
├── spectra_theme.dart      # 主题配置
├── app_spacing.dart        # 间距令牌
├── app_durations.dart      # 动画时长
└── tokens/
    ├── color_tokens.dart   # 颜色令牌
    ├── text_tokens.dart    # 字体令牌
    └── effect_tokens.dart  # 效果令牌
```

---

## 响应式布局

### Requirement: Sizer 集成

使用 sizer 包实现响应式布局：

- Sizer widget 包裹 MaterialApp
- 设备类型断点：mobile ≤ 599px, tablet ≤ 1024px
- 支持百分比尺寸单位 (`.w`, `.h`, `.sp`)

```dart
Sizer(
  maxMobileWidth: 599,
  maxTabletWidth: 1024,
  builder: (context, orientation, screenType) {
    return MaterialApp(...);
  },
)
```

---

### Requirement: 设备类型检测

| 类型 | 宽度范围 |
|------|----------|
| mobile | ≤ 599px |
| tablet | 600px - 1024px |
| desktop | > 1024px |

```dart
if (Device.screenType == ScreenType.mobile) {
  return MobileLayout();
} else if (Device.screenType == ScreenType.tablet) {
  return TabletLayout();
} else {
  return DesktopLayout();
}
```

---

### Requirement: 响应式尺寸单位

| 单位 | 用途 | 计算方式 |
|------|------|----------|
| `.w` | 宽度百分比 | 屏幕宽度 × 百分比 |
| `.h` | 高度百分比 | 屏幕高度 × 百分比 |
| `.sp` | 响应式字体 | 基于像素密度和屏幕比例 |
| `.dp` | 响应式 dp | 基于像素密度 |

```dart
Container(
  width: 80.w,      // 屏幕宽度的 80%
  height: 20.h,     // 屏幕高度的 20%
  padding: EdgeInsets.all(4.w),
)

Text('标题', style: TextStyle(fontSize: 16.sp))
```

---

### Requirement: 移动端布局

宽度 ≤ 599px：

- 单列内容布局
- 底部导航栏 (BottomNavigationBar)
- 全宽卡片和列表
- 抽屉式菜单 (Drawer)
- 悬浮操作按钮 (FAB)

---

### Requirement: 平板/桌面端布局

宽度 > 600px：

- 双列或多列布局
- 侧边导航栏 (NavigationRail / NavigationDrawer)
- 网格卡片布局
- 主从式界面 (Master-Detail)

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: Device.screenType == ScreenType.mobile ? 1 : 2,
    mainAxisSpacing: 2.h,
    crossAxisSpacing: 2.w,
    childAspectRatio: 0.7,
  ),
  itemBuilder: (context, index) => ContentCard(item: items[index]),
)
```

---

### Requirement: 屏幕方向适配

- 检测 `Device.orientation` 变化
- 竖屏和横屏布局切换
- 自动重新计算布局

```dart
Device.orientation == Orientation.portrait
  ? PortraitLayout()
  : LandscapeLayout();
```

---

### Requirement: 响应式间距和组件

**间距**: 使用百分比单位，不同设备类型使用不同基础间距

```dart
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: Device.screenType == ScreenType.mobile ? 4.w : 2.w,
    vertical: 2.h,
  ),
)
```

**图标和按钮**: 根据设备类型调整大小，移动端触摸目标 ≥ 48dp

```dart
Icon(
  Icons.menu,
  size: Device.screenType == ScreenType.mobile ? 24.sp : 20.sp,
)

IconButton(
  iconSize: 24.sp,
  constraints: BoxConstraints(minWidth: 12.w, minHeight: 12.w),
)
```

---

### Requirement: Web 编辑器响应式

使用 Tailwind CSS 响应式断点：

- `mobile`: max-width 599px
- `tablet`: min-width 600px  
- `desktop`: min-width 1024px

```tsx
<div className="flex flex-col tablet:flex-row">
  <aside className="w-full tablet:w-64">侧边栏</aside>
  <main className="flex-1">主内容</main>
</div>
```
