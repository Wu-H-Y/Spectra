# Crawler Rule System

## Why

Spectra 需要一套灵活、可扩展的爬虫规则系统，支持用户自定义规则来采集视频、漫画、小说、音乐、图片等多媒体内容。当前系统仅有数据库表定义，缺乏：

1. **规则定义格式** - 无法描述如何从网页提取数据
2. **规则执行引擎** - 无法运行规则进行实际采集
3. **可视化编辑器** - 非技术用户无法创建/修改规则
4. **标准数据模型** - 不同来源的数据无法统一展示

竞品分析（Web Scraper、Octoparse、后羿采集器）表明，成功的采集系统需要：
- 声明式规则定义（JSON格式）
- 支持多种选择器（CSS、XPath、正则、JS执行）
- 反爬处理能力（动作序列、代理、隐身）
- 可视化编辑支持

## What Changes

### 新增功能
- **规则 DSL 定义** - JSON 格式的爬虫规则描述语言，支持列表/详情/内容三层提取
- **标准数据模型** - 统一的视频、漫画、小说、音乐、图片数据结构（使用 freezed 定义不可变模型）
- **规则执行引擎** - 基于 Playwright/Puppeteer 的规则解释器
- **反爬处理系统** - 动作序列、代理轮换、浏览器隐身
- **Web 规则编辑器** - React + shadcn/ui + Tailwind CSS 实现，支持可视化规则编辑
- **页面预览功能** - Flutter 应用内预览目标页面，点选元素生成选择器，通过 WebSocket 返回编辑器
- **Flutter HTTP Server** - 内嵌 Shelf 服务器，支持 localhost 和局域网访问
- **响应式 UI 设计** - 使用 sizer 包实现跨设备自适应布局，支持桌面端和移动端

### 技术约束
- **所有数据模型必须使用 freezed** - 包括规则模型、媒体内容模型、API 请求/响应模型
- freezed 提供不可变性、copyWith、JSON 序列化、模式匹配等特性
- 配合 freezed_annotation + json_serializable + build_runner 生成代码

### 修改内容
- **CrawlRules 表** - `config` 字段的 JSON Schema 明确化
- **Flutter UI** - 新增规则编辑器入口、页面预览界面

## Capabilities

### New Capabilities

- **crawler-rule-dsl**: 爬虫规则 DSL 定义，包括选择器、字段映射、动作序列、检测配置
- **media-data-model**: 标准媒体数据模型，覆盖视频/漫画/小说/音乐/图片的通用字段和特有字段
- **rule-execution-engine**: 规则执行引擎，解释 DSL 并执行采集任务
- **anti-crawl-handling**: 反爬处理系统，包括代理轮换、浏览器隐身、验证码检测
- **web-rule-editor**: Web 规则编辑器 (React + shadcn/ui)，可视化创建/编辑规则
- **page-preview**: 页面预览功能，Flutter 应用内预览目标页面并点选生成选择器
- **embedded-http-server**: Flutter 内嵌 HTTP 服务器，支持 localhost 和局域网访问
- **responsive-ui**: 响应式 UI 设计，使用 sizer 包实现跨设备自适应布局

### Modified Capabilities

- 无（新功能，不修改现有规格）

## Impact

### 代码结构

```
spectra/
├── lib/
│   ├── core/
│   │   ├── server/                    # 新增: HTTP 服务器
│   │   │   ├── server_provider.dart
│   │   │   ├── router.dart
│   │   │   ├── handlers/
│   │   │   └── static_handler.dart    # 静态文件服务
│   │   ├── crawler/                   # 新增: 爬虫规则引擎
│   │   │   ├── models/               # 规则模型 (freezed)
│   │   │   │   ├── crawler_rule.dart
│   │   │   │   ├── crawler_rule.freezed.dart
│   │   │   │   └── crawler_rule.g.dart
│   │   │   ├── parser/               # DSL 解析器
│   │   │   ├── engine/               # 执行引擎
│   │   │   └── selectors/            # 选择器实现
│   │   └── media/                     # 新增: 媒体数据模型
│   │       └── models/               # (freezed)
│   │           ├── base_content.dart
│   │           ├── video_content.dart
│   │           ├── comic_content.dart
│   │           ├── novel_content.dart
│   │           ├── music_content.dart
│   │           ├── image_content.dart
│   │           └── *.freezed.dart / *.g.dart
│   ├── features/
│   │   └── settings/                  # 修改: 添加编辑器入口
│   │       └── presentation/
│   │           └── rule_editor_entry.dart
│   └── shared/
│       └── models/                    # 通用模型 (freezed)
│           ├── author.dart
│           ├── content_stats.dart
│           ├── content_source.dart
│           └── *.freezed.dart / *.g.dart
├── assets/
│   └── editor/                        # 新增: Web 前端打包输出
│       ├── index.html
│       └── assets/
└── web-editor/                        # 新增: Web 前端源码
    ├── src/
    │   ├── components/               # shadcn/ui 组件
    │   ├── views/                    # 页面组件
    │   ├── hooks/                    # React Hooks
    │   ├── api/                      # API 调用 (TanStack Query)
    │   └── stores/                   # Zustand 状态
    ├── package.json
    ├── vite.config.ts
    ├── tailwind.config.js
    └── tsconfig.json
```

### 外部依赖

| 依赖 | 用途 | 状态 |
|------|------|------|
| freezed_annotation | 不可变模型注解 | 需新增 |
| freezed (dev) | 代码生成 | 需新增 |
| json_serializable (dev) | JSON 序列化生成 | 需新增 |
| build_runner (dev) | 代码生成运行器 | 已有 |
| shelf | HTTP 服务器框架 | 需新增 |
| shelf_router | 路由支持 | 需新增 |
| shelf_websocket | WebSocket 支持 | 需新增 |
| flutter_inappwebview | WebView 容器 | 需新增 |
| sizer | 响应式 UI 布局 | 需新增 |

### API 接口

```
# 规则管理
GET    /api/rules                 # 获取规则列表
GET    /api/rules/:id             # 获取单个规则
POST   /api/rules                 # 创建规则
PUT    /api/rules/:id             # 更新规则
DELETE /api/rules/:id             # 删除规则
POST   /api/rules/import          # 导入规则
GET    /api/rules/:id/export      # 导出规则

# 规则执行
POST   /api/execute               # 执行规则采集
POST   /api/validate              # 验证规则语法

# 页面预览 (在应用中展示)
POST   /api/preview/open          # 打开预览页面 (应用内 WebView)
POST   /api/preview/select        # 进入元素选择模式
POST   /api/preview/highlight     # 高亮匹配元素
GET    /api/preview/screenshot   # 获取页面截图

# WebSocket
WS     /api/ws                    # 实时通信 (选择器返回、进度推送)
```

### 技术架构

```
┌─────────────────────────────────────────────────────────────┐
│                    Flutter 应用 (后端 + 预览)                │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │  数据展示层  │  │  采集引擎   │  │  Shelf HTTP Server  │  │
│  │  (固定 UI)  │  │ (规则执行)  │  │  localhost / LAN    │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  页面预览 (WebView / headless browser)                │  │
│  │  - 获取目标页面内容                                    │  │
│  │  - 渲染页面供用户点选元素                              │  │
│  │  - 生成选择器并通过 WebSocket 返回编辑器               │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                             │
│  入口: 设置页面 → 规则编辑器 → 显示访问地址 + 二维码         │
└─────────────────────────────────────────────────────────────┘
                              │ HTTP/WS
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Web 编辑器 (浏览器)                       │
│                                                             │
│  技术栈: React + TypeScript + Vite                         │
│  样式: Tailwind CSS + shadcn/ui                            │
│  流程图: React Flow (节点拖拽)                              │
│  代码编辑: Monaco Editor                                    │
│  状态: Zustand                                              │
│                                                             │
│  ┌─────────────┐                    ┌─────────────────────┐ │
│  │  规则编辑器  │◀───WebSocket──────│  页面预览触发       │ │
│  │  (可视化)   │    返回选择器      │  (发送URL到应用)    │ │
│  │  自动填充    │                    │  应用中预览+点选   │ │
│  └─────────────┘                    └─────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```
