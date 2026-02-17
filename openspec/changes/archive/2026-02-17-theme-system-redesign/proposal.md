# Theme System Redesign Proposal

## Why

当前 Spectra 主题系统虽然具备赛博朋克风格基础，但存在以下问题：
1. **浅色主题不完善** - 仅通过降低饱和度实现，缺乏独立设计语言
2. **字体中文支持不足** - Inter 字体对中文渲染效果一般，需要更好的 CJK 字体方案
3. **视觉效果单一** - 缺少 Glassmorphism、Neon Glow 等现代视觉效果支持
4. **颜色系统不够语义化** - 缺少 surface、onSurface 等语义化颜色令牌

现在重设计可以建立一套更专业、更完整的双主题系统，提升用户体验和品牌识别度。

## What Changes

### 深色主题增强
- 保留 Cyberpunk 核心风格 (Neon Glow, 深色背景)
- 添加 Glassmorphism 卡片效果
- 优化颜色对比度，符合 WCAG AA 标准

### 全新浅色主题
- 设计独立的浅色配色方案 (Digital Teal + Deep Indigo + Vibrant Rose)
- 采用 Soft Glassmorphism 风格
- 清晰的视觉层次和边框系统

### 字体系统升级
- **Display 字体**: Orbitron (科幻感标题)
- **Body 字体**: Noto Sans SC (优秀的中英文混排支持)
- **Monospace 字体**: JetBrains Mono (代码/数据展示)

### 设计令牌系统
- 新增语义化颜色令牌 (surface, onSurface, surfaceContainer 等)
- 新增视觉效果令牌 (shadows, blurs, glows)
- 完善组件主题定制

## Capabilities

### New Capabilities

- `design-tokens`: 语义化设计令牌系统，包含颜色、间距、动画、效果等令牌定义
- `visual-effects`: 视觉效果系统，支持 Glassmorphism、Neon Glow、Soft Shadows 等效果
- `chinese-typography`: 中文字体支持系统，优化 CJK 字体渲染和混排

### Modified Capabilities

- `app-theme`: 主题规格变更
  - 新增浅色主题独立配色方案
  - 字体从 Inter + Orbitron 改为 Noto Sans SC + Orbitron
  - 新增语义化颜色令牌需求
  - 新增视觉效果配置需求

## Impact

### 代码影响
- `lib/core/theme/app_colors.dart` - 重构为语义化颜色令牌
- `lib/core/theme/spectra_theme.dart` - 拆分为 dark_theme.dart 和 light_theme.dart
- `lib/core/theme/` - 新增 tokens/ 目录存放设计令牌

### API 影响
- **BREAKING**: `AppColors` 类从扁平化常量改为语义化分组
- 新增 `AppTheme` 扩展，提供快速访问主题令牌的方法

### 依赖影响
- `google_fonts` - 继续使用，添加 Noto Sans SC 字体
- `flex_color_scheme` - 继续使用，优化配置

### 兼容性
- 现有使用 `Theme.of(context).colorScheme` 的代码无需修改
- 直接引用 `AppColors.cyberCyan` 的代码需要迁移到新 API
