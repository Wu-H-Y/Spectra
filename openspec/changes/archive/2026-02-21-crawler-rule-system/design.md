# Crawler Rule System - Technical Design

## Context

### 背景

Spectra 是一个跨平台多媒体数据采集应用，支持视频、音乐、小说、漫画、图片的采集。当前状态：

- ✅ 数据库表 `CrawlRules` 已定义，包含 `config`、`globalConfig`、`displayConfig` 字段
- ✅ 媒体类型枚举已定义：video, music, novel, comic, image, audio, rss, generic
- ❌ 规则 DSL 格式未定义
- ❌ 规则执行引擎未实现
- ❌ Web 编辑器未实现
- ❌ HTTP Server 未实现

### 约束

- **Flutter 优先**: 主应用是 Flutter，需要跨平台支持 (Android, iOS, Windows, macOS, Linux)
- **Web 编辑器**: 利用 Web 生态优势实现可视化编辑器
- **freezed 强制**: 所有数据模型必须使用 freezed 定义不可变类
- **代码生成**: 使用 build_runner 生成代码
- **响应式设计**: 使用 sizer 包实现跨设备自适应布局，支持移动端和桌面端

### 利益相关者

- **技术用户**: 手写 JSON 规则，需要灵活性和高级特性
- **非技术用户**: 使用可视化编辑器，需要简单易用的界面

---

## Goals / Non-Goals

### Goals

1. **定义规则 DSL** - JSON 格式，支持列表/详情/内容三层提取
2. **实现规则执行引擎** - 解释 DSL，执行采集任务
3. **实现反爬处理** - 动作序列、代理轮换、基础隐身
4. **实现 Web 编辑器** - Vue 3 + TypeScript，可视化规则编辑
5. **实现 HTTP Server** - Shelf 框架，为编辑器提供 API
6. **定义标准数据模型** - freezed 模型，覆盖所有媒体类型
7. **实现响应式 UI** - sizer 包，支持桌面端和移动端自适应布局

### Non-Goals

- 不实现复杂的验证码自动识别 (仅提供接口对接第三方服务)
- 不实现分布式采集 (单机版)
- 不实现规则市场/社区功能 (后续版本)
- 不实现增量更新 (每次全量采集)

---

## Decisions

### Decision 1: 规则存储格式

**选择**: JSON 格式存储在 `CrawlRules.config` 字段

**理由**:

- JSON 是通用格式，易于序列化/反序列化
- 可被 Dart 和 Web 前端同时解析
- 便于导入/导出和版本控制
- 支持 JSON Schema 验证

**备选方案**:

- YAML: 更易读，但 Flutter 解析库支持较弱
- 自定义 DSL: 灵活但实现复杂度高

### Decision 2: 规则 DSL 架构

**选择**: 分层提取模型 (list → detail → content)

```
┌─────────────────────────────────────────────────────────────┐
│                     规则 DSL 结构                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  extract:                                                   │
│    list:         # 列表页/发现页                            │
│      container: ".video-item"                               │
│      items: { title, cover, url, ... }                      │
│      pagination: { next, maxPages }                         │
│                                                             │
│    detail:       # 详情页                                   │
│      urlFromList: "a@href"                                  │
│      items: { title, description, author, ... }             │
│      chapters: { ... }                                      │
│                                                             │
│    content:      # 内容页 (播放/阅读)                       │
│      video: { url, qualities }                              │
│      comic: { images }                                      │
│      novel: { content }                                     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**理由**:

- 符合主流网站的三层结构 (列表 → 详情 → 内容)
- 每层独立配置，可灵活组合
- 支持部分规则 (只有 list，或只有 detail)

### Decision 3: 选择器类型

**选择**: 支持多选择器类型，优先 CSS

| 类型     | 用途       | 示例                             |
| -------- | ---------- | -------------------------------- |
| CSS      | 主要选择器 | `.video-title`                   |
| XPath    | 复杂结构   | `//div[@class='title']`          |
| Regex    | 文本提取   | `video_id=(\d+)`                 |
| JSONPath | API 响应   | `$.data.items[*]`                |
| JS       | 复杂逻辑   | `__playinfo__.dash.video[0].url` |

**理由**:

- CSS 选择器最常用，语法简单
- XPath 处理复杂嵌套场景
- Regex 处理非结构化文本
- JSONPath 处理 API 响应
- JS 处理加密/动态数据

### Decision 4: 模型定义方式

**选择**: freezed + json_serializable

```dart
@freezed
class VideoContent with _$VideoContent {
  const factory VideoContent({
    required String id,
    required String title,
    String? cover,
    String? description,
    Author? author,
    int? duration,
    String? playUrl,
    List<VideoQuality>? qualities,
    List<VideoChapter>? chapters,
    // ...
  }) = _VideoContent;

  factory VideoContent.fromJson(Map<String, dynamic> json) =>
      _$VideoContentFromJson(json);
}
```

**理由**:

- 不可变性: 防止意外修改
- copyWith: 方便创建修改副本
- 模式匹配: 支持密封类 (Sealed Classes)
- JSON 序列化: 自动生成
- 代码生成: 减少样板代码

### Decision 5: 单体架构 (Flutter + 内嵌 Web 前端)

**选择**: Flutter HTTP Server + 打包的 Web 前端

```
┌─────────────────────────────────────────────────────────────┐
│                    项目结构 (单体)                           │
├─────────────────────────────────────────────────────────────┤
│  spectra/                                                   │
│  ├── lib/                   # Flutter Dart 代码             │
│  ├── assets/                                               │
│  │   └── editor/            # Web 前端打包输出              │
│  │       ├── index.html                                    │
│  │       └── assets/                                       │
│  └── web-editor/            # Web 前端源码                  │
│      ├── src/               # Vue 3 + TypeScript            │
│      ├── package.json                                      │
│      └── vite.config.ts                                    │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    运行时架构                                │
├─────────────────────────────────────────────────────────────┤
│  Flutter 应用                                               │
│  ┌─────────────────────────────────────────────────────────┐│
│  │  Shelf HTTP Server                                      ││
│  │  ├── /api/*     → REST API (规则 CRUD, 执行)            ││
│  │  ├── /ws        → WebSocket (实时通信)                  ││
│  │  └── /*         → 静态文件 (Web 编辑器)                 ││
│  └─────────────────────────────────────────────────────────┘│
│  ├── 绑定地址: 0.0.0.0 (支持局域网访问)                     │
│  └── 端口: 随机或配置                                       │
└─────────────────────────────────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────────────┐
│  用户浏览器 (localhost 或局域网 IP)                         │
│  ├── 桌面端: http://localhost:端口                          │
│  └── 移动端: http://192.168.x.x:端口 (同一局域网)           │
└─────────────────────────────────────────────────────────────┘
```

**入口设计**:

- Flutter 设置页面提供"规则编辑器"入口
- 点击后显示访问地址 (含二维码方便移动端)
- 用户在任意浏览器中打开编辑

**开发流程**:

```
1. pnpm dev (web-editor/)  → 前端开发服务器
2. flutter run             → 后端 API 服务器
3. 前端代理 API 请求到后端
```

**构建流程**:

```
1. pnpm build (web-editor/) → 输出到 ../assets/editor/
2. flutter build            → 打包 Flutter 应用
```

**理由**:

- 单体架构，部署简单
- Web 编辑器生态丰富 (Monaco, 拖拽库, 表单库)
- 支持局域网访问，移动端友好
- 前后端独立开发，但最终打包在一起

**备选方案**:

- 前后端分离: 需要额外部署前端
- 内嵌 WebView: 浏览器功能受限，调试困难

### Decision 6: 规则执行引擎

**选择**: 基于 Playwright/Puppeteer 的解释执行

**理由**:

- 支持完整浏览器环境 (JS 执行、渲染)
- 支持 Headless 模式
- 支持反爬隐身配置
- 跨平台支持

**Flutter 实现方案**:

- 移动端: 通过后端服务代理执行
- 桌面端: 可集成原生浏览器引擎

### Decision 7: Web 编辑器技术栈

**选择**: React + TypeScript + Tailwind CSS + shadcn/ui

| 技术           | 用途     | 理由                         |
| -------------- | -------- | ---------------------------- |
| React 18       | 框架     | 生态最大、社区活跃、组件丰富 |
| TypeScript     | 类型     | 类型安全、IDE 支持           |
| Vite           | 构建     | 快速 HMR、ESM 原生           |
| Tailwind CSS   | 样式     | 原子化 CSS、开发效率高       |
| shadcn/ui      | 组件库   | 可定制、基于 Radix UI、美观  |
| React Flow     | 流程图   | 节点拖拽、连线可视化         |
| Monaco Editor  | 代码编辑 | VS Code 同款、JSON 高亮      |
| Zustand        | 状态管理 | 轻量、简单、TypeScript 友好  |
| TanStack Query | 数据请求 | 缓存、自动刷新、乐观更新     |

**理由**:

- React 生态最大
- shadcn/ui 是 2024-2025 最流行的组件库
- Tailwind CSS 开发效率高，与 shadcn 完美配合
- React Flow 是流程图/节点编辑的最佳选择
- 整体技术栈在 GitHub 上 star 数和活跃度最高

### Decision 8: 页面预览机制

**选择**: Flutter 应用内预览 + WebSocket 通信

```
┌─────────────────────────────────────────────────────────────┐
│                    页面预览交互流程                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Web 编辑器 (浏览器)              Flutter 应用               │
│  ┌─────────────────┐             ┌─────────────────┐        │
│  │ 1. 输入目标 URL │             │                 │        │
│  │ 2. 点击"预览"   │──POST /api─▶│ 3. 接收请求     │        │
│  │                 │  /preview   │ 4. 获取页面     │        │
│  │                 │  /open      │ 5. 打开预览界面 │        │
│  │                 │             │    (WebView)    │        │
│  │                 │             │                 │        │
│  │ 8. 自动填充     │◀──WebSocket─│ 6. 用户点选元素 │        │
│  │    选择器       │             │ 7. 生成选择器   │        │
│  │                 │             │    CSS/XPath    │        │
│  └─────────────────┘             └─────────────────┘        │
│                                                             │
│  WebSocket 消息格式:                                        │
│  {                                                          │
│    "type": "element_selected",                              │
│    "data": {                                                │
│      "selector": ".video-title",                            │
│      "selectorType": "css",                                 │
│      "text": "视频标题示例",                                │
│      "html": "<h1 class=\"video-title\">...</h1>"           │
│    }                                                        │
│  }                                                          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**理由**:
- 避免浏览器跨域限制
- Flutter 可以使用 http 包或 headless browser 获取页面
- 用户在原生应用中点选元素体验更好
- 支持更复杂的页面交互 (登录、滚动加载等)

**预览界面功能**:
- 加载目标 URL 页面
- 元素选择模式 (点击高亮)
- 自动生成 CSS/XPath 选择器
- 测试选择器匹配结果
- 截图分享

### Decision 9: 响应式 UI 设计

**选择**: 使用 sizer 包实现响应式布局

```dart
// Sizer 初始化 (包裹 MaterialApp)
Sizer(
  builder: (context, orientation, screenType) {
    return MaterialApp(
      home: HomePage(),
    );
  },
);

// 响应式尺寸
Container(
  width: 20.w,      // 屏幕宽度的 20%
  height: 30.5.h,   // 屏幕高度的 30.5%
  padding: EdgeInsets.all(16.dp),  // 响应式 dp
)

// 响应式字体
Text(
  '标题',
  style: TextStyle(fontSize: 16.sp),  // 响应式字体大小
)

// 设备类型判断
Device.screenType == ScreenType.tablet
  ? TabletLayout()   // 平板布局
  : MobileLayout();  // 手机布局

// 屏幕方向判断
Device.orientation == Orientation.portrait
  ? PortraitLayout()
  : LandscapeLayout();
```

**Sizer 配置**:

```dart
Sizer(
  maxMobileWidth: 599,    // 最大手机宽度
  maxTabletWidth: 1024,   // 最大平板宽度 (超过则为桌面)
  builder: (context, orientation, screenType) {
    // ...
  },
)
```

**尺寸单位说明**:

| 单位 | 用途 | 示例 |
|------|------|------|
| `.w` | 宽度百分比 | `20.w` = 屏幕宽度的 20% |
| `.h` | 高度百分比 | `30.5.h` = 屏幕高度的 30.5% |
| `.sp` | 响应式字体 | `16.sp` = 基于密度的响应式字体 |
| `.dp` | 响应式 dp | `16.dp` = 基于像素密度的 dp |
| `.sw` | SafeArea 宽度百分比 | 去除安全区域后的宽度 |
| `.sh` | SafeArea 高度百分比 | 去除安全区域后的高度 |

**设备类型**:

| ScreenType | 条件 | 布局策略 |
|------------|------|----------|
| mobile | width ≤ 599px | 单列布局，底部导航 |
| tablet | 600px < width ≤ 1024px | 双列布局，侧边导航 |
| desktop | width > 1024px | 多列布局，宽屏优化 |

**理由**:
- sizer 是 Flutter 生态中最流行的响应式布局包 (1.8k likes, 178k downloads)
- 简单直观的 API，学习成本低
- 支持所有平台 (Android, iOS, Web, Windows, macOS, Linux)
- 百分比单位天然适应不同屏幕尺寸
- 设备类型判断方便实现自适应布局

**备选方案**:

- MediaQuery + LayoutBuilder: 需要手动计算，代码繁琐
- flutter_screenutil: 类似功能，但 sizer 的 API 更简洁
- 自定义响应式框架: 开发成本高，维护困难

**布局适配策略**:

```
┌─────────────────────────────────────────────────────────────┐
│                    移动端 (width ≤ 599px)                   │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────┐    │
│  │                    AppBar                            │    │
│  ├─────────────────────────────────────────────────────┤    │
│  │                                                     │    │
│  │                 主内容区域                           │    │
│  │              (单列/全宽卡片)                         │    │
│  │                                                     │    │
│  ├─────────────────────────────────────────────────────┤    │
│  │               底部导航栏                             │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                  平板/桌面端 (width > 600px)                │
├─────────────────────────────────────────────────────────────┤
│  ┌──────────┬────────────────────────────────────────────┐  │
│  │          │                                            │  │
│  │  侧边    │              主内容区域                     │  │
│  │  导航    │           (多列/网格布局)                   │  │
│  │  栏      │                                            │  │
│  │          │                                            │  │
│  │ (20.w)   │                (80.w)                      │  │
│  └──────────┴────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

**Web 编辑器响应式策略**:

Web 编辑器使用 Tailwind CSS 的响应式断点，与 Flutter 端保持一致：

```css
/* Tailwind 配置 */
screens: {
  'mobile': '599px',
  'tablet': '600px',
  'desktop': '1024px',
}
```

```tsx
// 响应式组件示例
<div className="grid grid-cols-1 tablet:grid-cols-2 desktop:grid-cols-3 gap-4">
  {items.map(item => <RuleCard key={item.id} item={item} />)}
</div>
```

---

## Risks / Trade-offs

### Risk 1: 规则兼容性

**风险**: 不同网站结构差异大，统一 DSL 难以覆盖所有场景

**缓解**:

- 支持 JS 脚本执行，覆盖复杂场景
- 提供规则模板库，降低学习成本
- 版本化 DSL，支持向后兼容

### Risk 2: 反爬检测

**风险**: 高防护网站可能检测到自动化行为

**缓解**:

- 实现浏览器隐身配置
- 支持代理轮换
- 支持行为模拟 (鼠标、滚动)
- 预留第三方验证码服务接口

### Risk 3: Web 编辑器安全性

**风险**: HTTP Server 暴露局域网访问，可能被恶意调用

**缓解**:

- 显示访问地址时提示安全风险
- 添加简单的 Token 验证 (首次访问生成)
- 敏感操作 (删除、导出) 需要用户确认
- 可配置仅允许 localhost 访问

### Risk 4: freezed 代码生成

**风险**: 模型变更需要重新运行 build_runner

**缓解**:

- 使用 watch 模式自动重新生成
- 模型设计时考虑扩展性 (optional 字段)

### Risk 5: 跨平台浏览器支持

**风险**: 移动端无法直接运行 Playwright

**缓解**:

- Phase 1 先实现桌面端完整功能
- 移动端通过后端服务代理执行
- 或使用 flutter_inappwebview 的 headless 模式

---

## Migration Plan

### Phase 1: 核心模型 (1-2 周)

1. 添加 freezed 相关依赖
2. 添加 sizer 依赖用于响应式布局
3. 定义基础媒体数据模型 (BaseContent, Author, ContentStats)
4. 定义各媒体类型模型 (VideoContent, ComicContent, ...)
5. 定义规则模型 (CrawlerRule, ExtractConfig, FieldMapping, ...)
6. 运行 build_runner 生成代码

### Phase 2: HTTP Server (1 周)

1. 添加 shelf 相关依赖
2. 实现基础路由和 CORS 中间件
3. 实现静态文件服务 (assets/editor/)
4. 实现规则 CRUD API
5. 实现 WebSocket 通道
6. 实现服务器入口 (设置页面)

### Phase 3: 规则执行引擎 (2-3 周)

1. 实现选择器引擎 (CSS, XPath, Regex, JSONPath, JS)
2. 实现规则解析器
3. 实现分页处理
4. 实现反爬动作序列
5. 集成浏览器 (桌面端 Playwright / 移动端 WebView)

### Phase 4: Web 编辑器 (2-3 周)

1. 初始化 Vue 3 项目 (web-editor/)
2. 配置 Vite 构建输出到 assets/editor/
3. 实现规则表单编辑器
4. 实现页面预览组件
5. 实现选择器可视化 (元素点选)
6. 集成 Monaco 代码编辑器
7. 配置开发时代理到 Flutter API

### Phase 5: 集成测试 (1 周)

1. 编写几个典型网站规则
2. 端到端测试
3. 性能优化

---

## Open Questions

1. **移动端浏览器引擎方案**
   - 选项 A: 后端代理服务
   - 选项 B: flutter_inappwebview headless 模式
   - 需要进一步技术验证

2. **规则版本迁移策略**
   - 当 DSL 升级时，旧规则如何兼容？
   - 是否需要规则版本号和迁移脚本？

3. **错误处理和重试策略**
   - 网络失败、超时、验证码等如何处理？
   - 是否需要断点续采？

4. **规则测试功能**
   - 是否需要规则调试器 (断点、变量查看)？
   - 预览数据量限制？
