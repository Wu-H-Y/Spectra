# Spectra Cyber Theme - Technical Design

## Context

Spectra 是一个 Flutter 多平台应用（Android, iOS, Windows, macOS, Linux），目前使用 Flutter 默认 Demo 主题。本次设计目标是建立一套完整的赛博朋克风格视觉系统。

**当前状态**：
- ✅ 品牌图标已完成（`assets/icon.svg`），所有平台 launcher icon 已配置
- ✅ 主题系统已实现
- ✅ 启动页动画已实现
- ✅ 主页已实现

**技术约束**：
- 支持原生平台：Android, iOS, Windows, macOS, Linux（不包含 Web）
- 动画需保持 60fps 性能
- 主题需支持深色/浅色模式切换

## Goals / Non-Goals

**Goals:**
- 建立基于 `flex_color_scheme` 的可扩展主题系统
- 实现专业级启动体验：原生启动屏 + 窗口管理器
- 创建模拟主页作为应用首页
- 配置科幻风格的品牌字体
- 确保主题代码可复用、可维护

**Non-Goals:**
- 不实现复杂的主题编辑器
- 不支持运行时动态切换主题色（用户自定义配色）
- 不实现 SVG 图标的运行时渲染（仅用于 App Icon）

## Decisions

### 1. 主题管理：选择 `flex_color_scheme`

**选择**: `flex_color_scheme` (v8.4.0+)

**理由**:
- 自动生成 Material 3 兼容的深色/浅色主题
- 内置颜色混合算法，避免手动调色
- 支持细粒度的组件样式定制
- 活跃维护，社区认可度高

### 2. 字体方案：Google Fonts

**选择**: `google_fonts` (v8.0.1+)

**字体配置**:
| 用途 | 字体 | 特点 |
|------|------|------|
| 标题 (displayLarge, displayMedium, titleLarge) | Orbitron | 科幻感强，适合品牌标识 |
| 正文 (bodyLarge, bodyMedium) | Inter / Noto Sans SC | 高可读性，中文支持 |

### 3. 启动方案：原生启动屏 + 窗口管理器

**选择**: `flutter_native_splash` + `window_manager` 组合方案

**架构流程**:
```
App 启动
    │
    ▼
┌─────────────────────────────────────┐
│  flutter_native_splash (preserve)   │  ← 原生静态启动屏
│  - 纯色背景 (Deep Void #0B0E14)      │
│  - 品牌 Logo (splash.png)            │
│  - 零延迟，遮挡白屏                  │
└─────────────────────────────────────┘
    │
    ▼ (main() 初始化)
┌─────────────────────────────────────┐
│  window_manager 配置                 │  ← 窗口管理
│  - 设置窗口大小 (1280x720)           │
│  - 窗口居中                          │
│  - 暂不显示 (waitUntilReadyToShow)   │
└─────────────────────────────────────┘
    │
    ▼ (后台初始化任务)
┌─────────────────────────────────────┐
│  _initializeHeavyTasks()             │  ← 后台任务
│  - 数据库初始化                      │
│  - 配置加载                          │
│  - 引擎预热                          │
└─────────────────────────────────────┘
    │
    ▼ (runApp)
┌─────────────────────────────────────┐
│  HomePage 首帧渲染完成               │  ← Flutter 层
│  - addPostFrameCallback 触发         │
└─────────────────────────────────────┘
    │
    ▼
┌─────────────────────────────────────┐
│  显示窗口 + 移除启动屏               │  ← 完美呈现
│  - windowManager.show()              │
│  - windowManager.focus()             │
│  - FlutterNativeSplash.remove()      │
└─────────────────────────────────────┘
```

**关键配置**:

```yaml
flutter_native_splash:
  color: "#0B0E14"           # 与 App 背景色一致
  image: assets/splash.png   # 品牌 Logo (1024x1024 PNG)
  android: true
  ios: true
  web: false
  windows: true
  macos: true
  linux: true
  android_12:
    image: assets/splash.png
    color: "#0B0E14"
```

**代码实现要点**:

```dart
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // 1. 保持原生启动屏
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 2. 初始化窗口管理器
  await windowManager.ensureInitialized();
  await windowManager.waitUntilReadyToShow(windowOptions, () async {});

  // 3. 执行后台初始化
  await _initializeHeavyTasks();

  runApp(const MyApp());
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await windowManager.show();  // 显示窗口
      await windowManager.focus(); // 聚焦窗口
      FlutterNativeSplash.remove(); // 移除启动屏
    });
  }
}
```

**理由**:
- `flutter_native_splash` 提供**零延迟**的原生启动屏，遮挡 Flutter 引擎加载
- `window_manager` 控制窗口显示时机，避免窗口闪烁/位置跳动
- 背景色与 App 主题一致，实现**无缝视觉衔接**
- 桌面端支持完善（Windows/macOS/Linux）

### 4. 文件结构

```
lib/
├── main.dart              # 应用入口 (启动流程控制)
├── theme/
│   ├── theme.dart         # 导出文件
│   ├── spectra_theme.dart # 主题配置 (FlexColorScheme)
│   └── app_colors.dart    # 品牌色常量
└── pages/
    ├── home/
    │   └── home_page.dart     # 主页
    └── splash/
        ├── splash_page.dart   # (可选) 动画启动页
        └── painters/
            ├── grid_painter.dart
            └── beam_painter.dart

assets/
├── icon.svg               # SVG 源图标
└── splash.png             # 启动屏 PNG (1024x1024)
```

### 5. 依赖版本

| 包 | 版本 | 用途 |
|---|---|---|
| `flex_color_scheme` | ^8.4.0 | 主题系统 |
| `google_fonts` | ^8.0.1 | 品牌字体 |
| `flutter_native_splash` | ^2.4.7 | 原生启动屏 (dev) |
| `window_manager` | ^0.4.3 | 窗口管理 (桌面端) |

## Risks / Trade-offs

### Risk 1: Google Fonts 网络依赖
- **风险**: 首次启动时字体可能需要下载
- **缓解**: 使用 `google_fonts` 内置缓存，或打包核心字体文件

### Risk 2: 启动屏图片模糊
- **风险**: 图片在不同设备上可能模糊
- **缓解**: 提供 1024x1024 高清 PNG

### Risk 3: 窗口管理器权限
- **风险**: 部分平台可能需要额外配置
- **缓解**: 按官方文档配置平台特定设置

## Migration Plan

### 阶段 1: 依赖安装 ✅
```bash
flutter pub add flex_color_scheme google_fonts window_manager
flutter pub add dev:flutter_native_splash
```

### 阶段 2: 主题系统 ✅
- 创建品牌色常量和主题配置

### 阶段 3: 原生启动屏
1. 导出 splash.png (1024x1024)
2. 配置 flutter_native_splash
3. 运行 `dart run flutter_native_splash:create`

### 阶段 4: 窗口管理器
1. 配置 window_manager
2. 修改 main.dart 启动流程
3. 平台特定配置（Windows/macOS/Linux）

### 阶段 5: 主页 ✅
- 实现 HomePage

## Open Questions

1. **是否保留 SplashPage 动画？**
   - 方案 A: 完全使用原生静态启动屏，移除 SplashPage
   - 方案 B: 保留 SplashPage 动画作为可选功能（设置页面预览）
   - **当前选择**: 方案 A，简化启动流程
