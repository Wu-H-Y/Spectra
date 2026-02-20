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
