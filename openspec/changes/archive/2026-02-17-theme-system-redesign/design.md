# Theme System Redesign - Technical Design

## Context

### 当前状态
Spectra 是一个 Flutter 多平台应用（Android, iOS, Windows, macOS, Linux），当前使用 `flex_color_scheme` 实现主题系统：
- 深色主题：赛博朋克风格（Cyber Cyan + Electric Violet + Neon Pink）
- 浅色主题：简单的饱和度降低版本
- 字体：Orbitron (标题) + Inter (正文)

### 技术约束
- 必须支持原生平台（不含 Web）
- 使用 `flex_color_scheme` (v8.4.0+) 作为基础
- 使用 `google_fonts` (v8.0.1+) 加载字体
- 主题切换需持久化到 Hive

### 利益相关者
- 开发者：需要清晰的 API 和设计令牌
- 用户：需要舒适的阅读体验（深色/浅色）和品牌一致性

## Goals / Non-Goals

**Goals:**
- 建立完整的双主题系统（深色 + 浅色）
- 实现语义化设计令牌体系
- 优化中文字体渲染和混排
- 提供可复用的视觉效果组件
- 保持 WCAG AA 可访问性标准

**Non-Goals:**
- 不支持用户自定义主题色
- 不实现主题编辑器
- 不支持动态切换品牌色系
- 不实现 Web 平台适配

## Decisions

### 1. 设计令牌架构

**选择**: 分层令牌系统 (Core → Semantic → Component)

```
┌─────────────────────────────────────────────────────────────┐
│                    DESIGN TOKEN SYSTEM                       │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  CORE TOKENS              SEMANTIC TOKENS        COMPONENT  │
│  ┌─────────────┐         ┌─────────────┐       ┌─────────┐ │
│  │ cyberCyan   │ ──────▶ │ primary     │ ───▶ │ button  │ │
│  │ #00F2FF     │         │ onPrimary   │       │ bgColor │ │
│  └─────────────┘         └─────────────┘       └─────────┘ │
│                                                              │
│  ┌─────────────┐         ┌─────────────┐       ┌─────────┐ │
│  │ deepVoid    │ ──────▶ │ surface     │ ───▶ │ card    │ │
│  │ #0B0E14     │         │ onSurface   │       │ bgColor │ │
│  └─────────────┘         └─────────────┘       └─────────┘ │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

**文件结构**:
```
lib/core/theme/
├── theme.dart                    # 导出文件
├── spectra_theme.dart            # 主主题配置
├── app_spacing.dart              # 间距令牌 (保留)
├── app_durations.dart            # 动画时长 (保留)
└── tokens/
    ├── color_tokens.dart         # 颜色令牌
    ├── text_tokens.dart          # 字体令牌
    └── effect_tokens.dart        # 效果令牌
```

**理由**:
- 分层设计便于维护和扩展
- 语义化命名提高代码可读性
- 与 Material 3 ColorScheme 对齐

**替代方案**: 扁平化令牌系统 - 拒绝，因为难以维护语义一致性

### 2. 字体方案

**选择**: Orbitron + Noto Sans SC + JetBrains Mono

| 用途 | 字体 | 权重 | 特点 |
|------|------|------|------|
| Display | Orbitron | 400-700 | 科幻感，品牌标识 |
| Body | Noto Sans SC | 300-600 | 中英文混排优秀 |
| Code | JetBrains Mono | 400-500 | 现代编程字体 |

**实现方式**:
```dart
// 使用 google_fonts 加载
TextTheme({
  displayLarge: GoogleFonts.orbitron(...),
  bodyLarge: GoogleFonts.notoSansSc(...),
  bodyMedium: GoogleFonts.notoSansSc(...),
  labelLarge: GoogleFonts.notoSansSc(...),
});
```

**理由**:
- Noto Sans SC 是 Google 官方 CJK 字体，中文渲染优秀
- 与 Orbitron 风格互补，科技感与可读性兼顾
- JetBrains Mono 是目前最流行的现代编程字体

**替代方案**:
- 思源黑体 (Source Han Sans) - 拒绝，需要额外打包字体文件
- Exo 2 - 拒绝，中文支持依赖系统字体回退

### 3. 深色主题配色

**选择**: 增强版 Cyberpunk 配色

| 角色 | 颜色 | Hex | 用途 |
|------|------|-----|------|
| primary | Cyber Cyan | `#00F2FF` | 主按钮、图标 |
| onPrimary | Deep Void | `#003840` | 主色上文字 |
| secondary | Electric Violet | `#7000FF` | 次要元素 |
| tertiary | Neon Pink | `#FF0055` | 强调、警告 |
| surface | Dark Surface | `#0F172A` | 卡片背景 |
| surfaceContainer | Dark Container | `#1E293B` | 层级容器 |
| scaffoldBackground | Deep Void | `#0B0E14` | 页面背景 |

**视觉效果**:
- Neon Glow: `boxShadow: [BoxShadow(color: primary.withOpacity(0.3), blurRadius: 20)]`
- Glass Card: `color: Colors.white.withOpacity(0.05)` + `backdropFilter: ImageFilter.blur(10)`

**理由**:
- 保留现有品牌色，减少迁移成本
- 深色主题以视觉效果为主，对比度适当放宽
- Glassmorphism 增加现代感和层次感

### 4. 浅色主题配色

**选择**: Tech Refined 配色（独立设计，非深色降级版）

| 角色 | 颜色 | Hex | 用途 |
|------|------|-----|------|
| primary | Digital Teal | `#0891B2` | 主按钮、图标 |
| onPrimary | White | `#FFFFFF` | 主色上文字 |
| secondary | Deep Indigo | `#6366F1` | 次要元素 |
| tertiary | Vibrant Rose | `#E11D48` | 强调、警告 |
| surface | White | `#FFFFFF` | 卡片背景 |
| surfaceContainer | Light Gray | `#F1F5F9` | 层级容器 |
| scaffoldBackground | Light Void | `#F8FAFC` | 页面背景 |

**视觉效果**:
- Soft Shadow: `boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 4))]`
- Subtle Glass: `color: Colors.white.withOpacity(0.8)` + `backdropFilter`

**理由**:
- 独立配色避免"降级感"
- 降低饱和度减少视觉疲劳
- 清晰的边框系统增强层次感

### 5. 效果令牌系统

**选择**: 基于 BoxDecoration 的效果工具类

```dart
class AppEffects {
  // Dark Theme Effects
  static BoxDecoration get glassCardDark => BoxDecoration(
    color: Colors.white.withOpacity(0.05),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.white.withOpacity(0.1)),
  );

  static BoxDecoration get neonGlowDark => BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: AppColors.cyberCyan.withOpacity(0.3),
        blurRadius: 20,
        spreadRadius: 2,
      ),
    ],
  );

  // Light Theme Effects
  static BoxDecoration get softCardLight => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  );
}
```

**理由**:
- BoxDecoration 可直接应用于 Container
- 与主题系统解耦，可独立使用
- 便于后续扩展更多效果

### 6. 主题 Provider 设计

**选择**: 保持现有 Riverpod + Hive 架构

```dart
// 主题模式 Provider (保留)
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

// 新增：当前主题令牌 Provider
final currentThemeTokensProvider = Provider<ThemeTokens>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  return themeMode == ThemeMode.dark ? DarkTokens() : LightTokens();
});
```

**理由**:
- 最小化架构变更
- Hive 持久化已验证可用
- Riverpod 状态管理团队熟悉

## Risks / Trade-offs

### Risk 1: 字体加载延迟
- **风险**: Noto Sans SC 字体较大，首次加载可能延迟
- **缓解**: 使用 `google_fonts` 内置缓存；考虑在 pubspec.yaml 预打包核心字体

### Risk 2: API Breaking Change
- **风险**: `AppColors` 重构影响现有代码
- **缓解**:
  - 保留旧常量但标记 `@Deprecated`
  - 提供 `AppColorsLegacy` 兼容类
  - 编写迁移指南

### Risk 3: 性能影响
- **风险**: Glassmorphism 效果 (`backdropFilter`) 可能影响性能
- **缓解**:
  - 仅在静态卡片使用
  - 列表项避免使用 blur 效果
  - 提供简化版本供低端设备使用

### Risk 4: 对比度问题
- **风险**: 深色主题 Neon 效果可能对比度不足
- **缓解**:
  - 主要文字保持 WCAG AA 标准 (4.5:1)
  - Neon 效果仅用于装饰和非关键信息
  - 提供高对比度模式选项

## Migration Plan

### 阶段 1: 设计令牌系统
1. 创建 `tokens/` 目录和令牌类
2. 定义 Core Colors → Semantic Colors 映射
3. 创建 `AppEffects` 效果工具类

### 阶段 2: 主题重构
1. 拆分 `spectra_theme.dart` 为 `dark_theme.dart` 和 `light_theme.dart`
2. 更新字体配置（Inter → Noto Sans SC）
3. 更新颜色配置

### 阶段 3: 兼容层
1. 标记旧 `AppColors` 常量为 `@Deprecated`
2. 创建迁移文档
3. 更新现有组件代码

### 阶段 4: 测试验证
1. 视觉回归测试
2. 对比度验证
3. 性能测试（blur 效果）

## Open Questions

1. **是否预打包字体？**
   - 选项 A: 完全依赖 google_fonts 网络加载
   - 选项 B: 预打包 Noto Sans SC 常用字重
   - **建议**: 选项 B，优化首次启动体验

2. **高对比度模式支持？**
   - 是否需要为可访问性提供额外的高对比度主题？
   - **建议**: v2 考虑，v1 仅提供标准深色/浅色主题

3. **主题切换动画？**
   - 切换主题时是否需要平滑过渡动画？
   - **建议**: v1 使用 Flutter 默认动画，v2 可增强
