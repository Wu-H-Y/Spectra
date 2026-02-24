# Refactor Crawler Rule System

## Why

Spectra 当前的爬虫规则系统存在以下核心问题：

### 1. 规则模型不够灵活

- **Pipeline 不直观**: 当前的 Transform 数组形式 (`[{type, params}]`) 不适合可视化编辑
- **缺少发现页/搜索模块**: 无法配置分类浏览和多维度筛选
- **生命周期不完整**: 只有 List/Detail/Content 三段，缺少独立的 Search 和 TOC

### 2. 反爬能力不足

- **网络策略单一**: 只支持纯 HTTP 请求，无法应对 Cloudflare、Akamai 等高防护
- **缺少 TLS 指纹**: HTTP 客户端的 TLS 握手特征容易被识别
- **浏览器指纹缺失**: 无 headless 浏览器隐身配置
- **验证码处理薄弱**: 只能检测，无法自动求解

### 3. 缺少多源聚合

- **无法跨源搜索**: 搜索结果按来源分散，无法合并展示
- **缺少内容去重**: 同一内容在多个来源重复出现
- **无法自动优选**: 没有基于权重和连通率的源选择机制

### 4. 可视化编辑器不完善

- **非节点流模式**: 表单式编辑器难以直观展示数据流
- **缺少实时预览**: 修改选择器后无法立即看到效果
- **不支持 Pipeline 可视化**: 无法直观编辑 `@css → @text → @trim` 这样的管道

### 竞品/参考分析

| 项目 | 核心特性 | 可借鉴点 |
|------|---------|---------|
| **Legado (阅读)** | 多源聚合 + Jaccard 匹配 | 96% 相似度阈值，±10 章节搜索窗口 |
| **TachiyomiSY** | 手动源合并 + 优先级 | `MergedMangaReference` 引用追踪 |
| **n8n** | 节点流工作流 | 声明式节点定义，connections 分离 |
| **FlareSolverr** | Cloudflare bypass | 使用真实浏览器解决五秒盾 |
| **playwright-stealth** | 浏览器隐身 | 修补 headless 检测点 |

---

## What Changes

### 核心变更

1. **重新设计规则 DSL** - 采用节点流 Pipeline 模型
2. **完善反爬模块** - 支持多种网络策略和隐身配置
3. **实现多源聚合** - 模糊匹配 + 权重优选
4. **重构可视化编辑器** - React Flow 节点流编辑器

### 新增功能

#### A. Pipeline DSL

```json
{
  "title": ["@css:.video-title", "@text", "@trim"],
  "cover": ["@css:img.cover", "@attr:src", "@url"],
  "author": ["@css:.author-name", "@text", "@js: val.replace('作者：', '')"]
}
```

**特点**:
- 字符串数组形式，每个操作是一个节点
- 自动链式传递: 前一个节点的输出是后一个的输入
- 天然映射到 React Flow 可视化

#### B. 完整生命周期

```
┌─────────┐   ┌─────────┐   ┌─────────┐   ┌──────────┐
│ Explore │──▶│ Search  │──▶│ Detail  │──▶│ Content  │
│ 发现/分类│   │ 搜索    │   │ 详情    │   │ 播放/正文│
└─────────┘   └─────────┘   └────┬────┘   └──────────┘
                                │
                                ▼
                          ┌─────────┐
                          │   TOC   │
                          │ 目录/章节│
                          └─────────┘
```

#### C. 多维度反爬配置

```json
{
  "network": {
    "strategy": "webview_headless",
    "interceptors": {
      "onBeforeRequest": [{ "type": "@js", "script": "..." }],
      "onFallback": {
        "trigger": ["@status:403", "@regex:Cloudflare"],
        "action": "webview_solve"
      }
    }
  }
}
```

#### D. 多源聚合

```json
{
  "aggregation": {
    "enabled": true,
    "weight": 90,
    "matching": {
      "strategy": "fuzzy",
      "dimensions": [
        { "field": "title", "matchType": "fuzzy", "threshold": 0.96 },
        { "field": "author", "matchType": "fuzzy", "threshold": 0.90 }
      ]
    }
  }
}
```

#### E. 节点流可视化编辑器

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  三栏布局                                                                    │
├──────────────────────┬────────────────────────────────┬────────────────────┤
│  📱 WebView 预览      │  🔗 节点流编辑器 (React Flow)   │  📊 实时预览       │
│  - 目标网页          │  - Pipeline 节点连线           │  - JSON 输出       │
│  - 元素拾取模式      │  - 拖拽添加节点                │  - 提取结果统计    │
│  - 生成选择器        │  - 实时数据流预览              │  - 错误提示        │
└──────────────────────┴────────────────────────────────┴────────────────────┘
```

### 修改内容

- **重构 `lib/core/crawler/`** - 新的 Pipeline 模型
- **重构 `web-editor/`** - React Flow 节点编辑器
- **新增 `lib/core/aggregation/`** - 多源聚合引擎
- **新增 `lib/core/network/`** - 网络策略实现
- **扩展 `lib/core/server/`** - 增强现有 relic 服务器 (WebSocket + API)
- **新增 `lib/shared/webview/`** - WebView 抽象层 (双引擎支持)

### 技术约束

- **所有模型使用 freezed** - 不可变 + JSON 序列化
- **Pipeline 节点可序列化为字符串数组** - 便于存储和可视化
- **反爬配置完全声明式** - 无需写代码即可配置

---

## Capabilities

### New Capabilities

| Capability | 描述 |
|------------|------|
| `pipeline-dsl` | 节点流 Pipeline DSL，字符串数组形式的选择器和变换链 |
| `rule-lifecycle` | 完整的五阶段生命周期: Explore → Search → Detail → TOC → Content |
| `dynamic-variables` | 动态变量插值: `{{host}}`, `{{key}}`, `{{page}}`, `{{category}}` |
| `network-strategies` | 多种网络策略: http, webview_headless, webview_interact |
| `request-interceptors` | 请求拦截器: onBeforeRequest, onFallback |
| `tls-fingerprint` | TLS 指纹伪装，模拟真实浏览器 JA3 |
| `browser-fingerprint` | 浏览器指纹隐身，修补 headless 检测点 |
| `captcha-handling` | 验证码检测 + 第三方求解服务集成 (2Captcha, CapSolver) |
| `sniff-strategy` | 媒体嗅探策略，用于视频/音频 URL 提取 |
| `source-aggregation` | 多源聚合搜索，支持: ① 搜索词验证(最小2字) ② 全字匹配+模糊匹配(分词多次搜索) ③ 源过滤(媒体类型/源分组/全部/指定源) ④ 结果按相似度排序 |
| `visual-rule-editor` | React Flow 节点流可视化编辑器 |
| `element-picker` | WebView 元素拾取，自动生成 CSS/XPath |
| `realtime-preview` | 实时预览，修改规则后立即看到提取结果 |
| `webview-abstraction` | WebView 抽象层，支持 flutter_inappwebview 和 webview_flutter 双引擎 |
| `rust-ffi-chinese` | Rust FFI 中文处理模块 (jieba-rs 分词, ferrous-opencc 繁简转换, chinese-number 数字转中文, Jaccard/Levenshtein 相似度, 标题标准化) |
| `isolate-executor` | 基于 Squadron 的 Isolate 并行执行器，爬虫任务在独立线程执行，避免阻塞 UI，支持 Worker Pool 和流式进度返回 |

### Modified Capabilities

| Capability | 变更 |
|------------|------|
| `crawler-rule-model` | 重构为新的 Pipeline 模型 |
| `rule-execution-engine` | 支持新的网络策略和 Pipeline 执行 |
| `web-editor` | 从表单式改为节点流可视化编辑器 |

---

## Impact

### 代码结构

```
spectra/
├── rust/                            # 新增: Rust FFI 模块 (flutter_rust_bridge)
│   ├── Cargo.toml                   # Rust 依赖 (jieba-rs, ferrous-opencc, chinese-number, flutter_rust_bridge)
│   ├── rust-toolchain.toml          # Rust 工具链版本
│   └── src/
│       ├── lib.rs                   # 库入口
│       ├── frb_generated.rs         # FRB 自动生成 (不需要手动编辑)
│       └── api/                     # FRB API 模块
│           ├── mod.rs               # API 模块入口
│           ├── text_processor.rs    # 中文处理 API (分词、繁简转换)
│           └── similarity.rs        # 相似度计算 API (Jaccard, Levenshtein)
│
├── lib/src/rust/                    # 新增: FRB 自动生成的 Dart 代码
│   ├── api/                         # Dart API (自动生成)
│   │   ├── text_processor.dart
│   │   └── similarity.dart
│   ├── frb_generated.dart           # FRB 框架代码 (自动生成)
│   ├── frb_generated.io.dart        # 原生平台绑定 (自动生成)
│   └── frb_generated.web.dart       # Web 平台绑定 (自动生成)
│
├── lib/core/
│   ├── crawler/                    # 重构
│   │   ├── models/
│   │   │   ├── crawler_rule.dart       # 新规则模型
│   │   │   ├── pipeline_node.dart      # Pipeline 节点定义
│   │   │   ├── network_config.dart     # 网络配置
│   │   │   ├── aggregation_config.dart # 聚合配置
│   │   │   └── lifecycle/              # 生命周期模型
│   │   │       ├── explore.dart
│   │   │       ├── search.dart
│   │   │       ├── detail.dart
│   │   │       ├── toc.dart
│   │   │       └── content.dart
│   │   ├── executor/
│   │   │   ├── pipeline_executor.dart  # Pipeline 执行器
│   │   │   ├── node_handlers/          # 节点处理器
│   │   │   │   ├── selector_nodes.dart
│   │   │   │   ├── transform_nodes.dart
│   │   │   │   └── aggregation_nodes.dart
│   │   │   └── lifecycle_executor.dart
│   │   └── selector/                   # 保留现有选择器
│   │   │
│   ├── network/                    # 新增
│   │   ├── strategies/
│   │   │   ├── http_strategy.dart
│   │   │   ├── webview_headless_strategy.dart
│   │   │   └── webview_interact_strategy.dart
│   │   ├── interceptors/
│   │   │   ├── request_interceptor.dart
│   │   │   └── fallback_handler.dart
│   │   ├── fingerprint/
│   │   │   ├── tls_fingerprint.dart
│   │   │   └── browser_fingerprint.dart
│   │   └── captcha/
│   │       ├── captcha_detector.dart
│   │       └── captcha_solver.dart
│   │
│   ├── aggregation/                # 新增
│   │   ├── similarity/
│   │   │   ├── jaccard_similarity.dart
│   │   │   ├── levenshtein_distance.dart
│   │   │   └── title_normalizer.dart
│   │   ├── merger/
│   │   │   ├── source_merger.dart
│   │   │   └── chapter_deduplicator.dart
│   │   └── router/
│   │       └── source_router.dart
│   │
│   ├── sniff/                      # 新增
│   │   ├── media_sniffer.dart
│   │   └── url_extractor.dart
│   │
│   └── server/                     # 已有 (relic)
│       ├── server_provider.dart    # 扩展 API
│       ├── routes/
│       └── middleware/
│
├── lib/shared/                     # 共享模块
│   └── webview/                    # 新增: WebView 抽象层
│       ├── webview_strategy.dart
│       ├── inapp_webview_strategy.dart
│       └── official_webview_strategy.dart
│
├── flutter_rust_bridge.yaml        # 新增: flutter_rust_bridge 配置
│
└── web-editor/                     # 重构
    ├── src/
    │   ├── components/
    │   │   ├── flow/               # React Flow 组件
    │   │   │   ├── FlowEditor.tsx
    │   │   │   ├── nodes/          # 自定义节点
    │   │   │   │   ├── SelectorNode.tsx
    │   │   │   │   ├── TransformNode.tsx
    │   │   │   │   └── OutputNode.tsx
    │   │   │   └── edges/
    │   │   ├── preview/            # 预览组件
    │   │   │   ├── WebViewPanel.tsx
    │   │   │   ├── ElementPicker.tsx
    │   │   │   └── ResultPreview.tsx
    │   │   └── config/             # 规则配置表单
    │   ├── stores/
    │   │   ├── flowStore.ts        # React Flow 状态
    │   │   └── ruleStore.ts        # 规则状态
    │   └── utils/
    │       ├── pipelineSerializer.ts
    │       └── selectorGenerator.ts
    └── package.json
```

### 外部依赖

| 依赖 | 用途 | 状态 |
|------|------|------|
| freezed | 不可变模型 | 已有 |
| relic | HTTP 服务器 (已有) | ✅ 已有 |
| webview_flutter | 官方 WebView (备选) | 需新增 |
| flutter_inappwebview | WebView 容器 (主力) | 需新增 |
| (Dart) levenshtein | 编辑距离算法 | 需新增 |
| (Web) @xyflow/react | React Flow | 需新增 |
| flutter_rust_bridge | Rust FFI 代码生成器 | 需新增 |
| flutter_rust_bridge_codegen | FRB 代码生成 CLI | 需新增 |
| squadron | Isolate 并行执行器 | 需新增 |
| squadron_builder | Squadron 代码生成 | 需新增 |

### Rust 依赖 (flutter_rust_bridge)

| 依赖 | 用途 |
|------|------|
| flutter_rust_bridge | FRB Rust 运行时 |
| jieba-rs | 中文分词 |
| chinese-number | 数字转中文 |
| ferrous-opencc | 繁简体转换 |

### API 变更

```
# 现有 API (保留)
GET    /api/rules                 # 获取规则列表
GET    /api/rules/:id             # 获取单个规则
POST   /api/rules                 # 创建规则
PUT    /api/rules/:id             # 更新规则
DELETE /api/rules/:id             # 删除规则

# 新增 API
POST   /api/rules/:id/execute     # 执行规则 (支持指定阶段)
POST   /api/rules/:id/validate    # 验证规则
POST   /api/rules/:id/test-pipeline  # 测试 Pipeline
GET    /api/rules/:id/preview     # 获取预览数据

# 聚合 API (新增)
POST   /api/aggregate/search      # 多源聚合搜索
GET    /api/aggregate/sources     # 获取可用源列表

# 网络 API (新增)
POST   /api/network/solve-captcha # 求解验证码
GET    /api/network/proxy-status  # 代理状态
```

---

## Open Questions

1. **移动端 WebView 限制**
   - 移动端能否完整支持 webview_interact 策略？
   - 是否需要后端代理执行复杂反爬？

2. **Pipeline 执行顺序**
   - 多个字段并行执行还是串行？
   - 如何处理字段间依赖？

3. **聚合算法阈值**
   - 默认相似度阈值是否合适？(title: 0.96, author: 0.90)
   - 是否需要支持用户自定义阈值？

4. **规则迁移**
   - 旧规则如何迁移到新格式？
   - 是否需要版本号和自动迁移？
