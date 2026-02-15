# Spectra Cyber Theme

## Why

Spectra 是一款现代化的多媒体数据采集应用，目前使用的是 Flutter 默认的 Demo 主题（紫色），缺乏品牌辨识度和视觉冲击力。为了打造一款具有"高性能爬虫"气质的应用，需要建立一套独特的赛博朋克风格视觉系统，包括复杂的品牌图标、统一的配色方案和炫酷的启动动画。

## What Changes

- ✅ **Spectra Hyper-Core 品牌图标**：超复杂 SVG 图标已完成，多平台 launcher icon 已配置
- 新增 **Cyber-Spectra 主题系统**：基于 `flex_color_scheme` 的原生平台（Android, iOS, Windows, macOS, Linux）配色方案，支持深色/浅色模式
- 新增 **混合启动页方案**：
  - 原生启动屏（`flutter_native_splash`）：全平台零延迟显示
  - Flutter 动画页（`CustomPainter`）：粒子光效动画 + 后台初始化
- 新增 **模拟主页**：品牌风格的应用首页
- 新增 **品牌字体配置**：标题使用科幻风格的 Orbitron 字体，正文使用易读的 Inter 字体
- 修改 `main.dart`：替换默认 Demo 代码为 Spectra 应用入口
- 新增依赖：`flex_color_scheme`、`google_fonts`、`flutter_native_splash`

## Capabilities

### New Capabilities

- `app-theme`: 应用主题系统，定义品牌色彩、字体、组件样式的全局配置，支持深色/浅色模式切换
- `app-icon`: 应用图标系统，包含复杂 SVG 源文件和多平台 launcher icon 配置
- `splash-screen`: 启动页系统，包含原生启动屏（全平台）和 Flutter 动画初始化页
- `home-page`: 应用主页，品牌风格的应用入口界面

### Modified Capabilities

无。现有的 specs（branch-protection, commit-convention, contribution-guide, git-hooks, release-workflow）均为 Git 工作流相关，与本次 UI 变更无关。

## Impact

### 代码影响

- `lib/main.dart` - 完全重写，应用新主题和路由
- `lib/theme/` - 新增目录，包含主题配置代码
- `lib/pages/splash/` - 新增目录，包含启动页实现
- `lib/pages/home/` - 新增目录，包含主页实现
- `assets/icon.svg` - SVG 图标源文件
- `pubspec.yaml` - 新增依赖项

### 依赖新增

```yaml
dependencies:
  flex_color_scheme: ^8.4.0
  google_fonts: ^8.0.1

dev_dependencies:
  flutter_native_splash: ^2.4.7
```

### 平台支持

原生平台：Android, iOS, Windows, macOS, Linux（不包含 Web）

### 视觉规范

| 元素 | 色值 | 用途 |
|------|------|------|
| Cyber Cyan | `#00F2FF` | 主色调 |
| Electric Violet | `#7000FF` | 次色调 |
| Neon Pink | `#FF0055` | 强调色 |
| Deep Void | `#0B0E14` | 深色背景 |

### 启动流程

```
App 启动
    │
    ▼
┌─────────────────────────────────┐
│  flutter_native_splash          │  ← 原生层（全平台）
│  - 纯色背景 + 静态图标            │
│  - 零延迟                        │
└─────────────────────────────────┘
    │
    ▼
┌─────────────────────────────────┐
│  SplashPage (初始化页)           │  ← Flutter 层
│  - 动画 + 后台任务               │
│  - 完成后 pushReplacement        │
└─────────────────────────────────┘
    │
    ▼
┌─────────────────────────────────┐
│  HomePage (主页)                 │  ← 应用首页
└─────────────────────────────────┘
```
