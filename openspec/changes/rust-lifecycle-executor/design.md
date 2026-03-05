## Context

当前 Rust FFI 暴露的 API 都是底层操作接口：
- `fetch()` - 原始 HTTP 请求
- `parse_html()` - HTML 解析
- `execute_pipeline()` - Pipeline 执行

Dart 侧需要手动编排这些底层调用，导致：
1. 代码重复 - 每个规则执行都需要相同的编排逻辑
2. 维护困难 - 错误处理逻辑分散
3. 类型不安全 - 返回原始字符串而非结构化数据
4. 格式单一 - 只支持 HTML，无法处理 JSON/XML

## Goals / Non-Goals

**Goals:**
- 实现高层 API `execute_lifecycle_phase()` 封装完整的执行流程
- 支持三种响应类型：HTML/JSON/XML（自动检测 + 规则配置）
- 内置 WAF 拦截检测
- 返回结构化数据
- 简化 Dart 侧代码

**Non-Goals:**
- 修改现有的规则模型结构（`CrawlerRule`, `Lifecycle` 等）
- 实现多源聚合逻辑（保留在 `source-aggregation-engine` change）
- 替换 WebView 交互（保留在 `webview-interactive-strategy` change）

## Decisions

### 1. API 设计

**决策**: 创建单一高层 API `execute_lifecycle_phase()`

**签名**:
```rust
#[frb]
pub async fn execute_lifecycle_phase(
    rule: CrawlerRule,
    phase: LifecyclePhase,
    context: PhaseContext,
) -> Result<PhaseResult, CrawlerError>
```

**理由**:
- 单一入口点简化 Dart 侧调用
- 明确的阶段参数避免混淆
- 统一的错误类型便于处理

### 2. 响应类型检测策略

**决策**: 混合策略 - 自动检测 + 规则配置覆盖

**实现**:
```rust
enum ContentType {
    Html,
    Json,
    Xml,
}

fn detect_content_type(response: &HttpResponse) -> ContentType {
    // 1. 优先检查规则中的显式配置
    if let Some(explicit_type) = rule.content_type_override {
        return explicit_type;
    }
    
    // 2. 自动检测 Content-Type header
    let content_type = response.headers.get("content-type");
    match content_type {
        Some(ct) if ct.contains("application/json") => ContentType::Json,
        Some(ct) if ct.contains("application/xml") || ct.contains("text/xml") => ContentType::Xml,
        _ => ContentType::Html, // 默认 HTML
    }
}
```

**理由**:
- 自动检测提供默认行为，减少配置负担
- 规则配置覆盖处理特殊情况（如错误的 Content-Type header）
- 两种策略互补，提供最大灵活性

### 3. 数据结构设计

**阶段枚举**:
```rust
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub enum LifecyclePhase {
    Explore,
    Search,
    Detail,
    Toc,
    Content,
}
```

**执行上下文**:
```rust
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct PhaseContext {
    /// URL (用于 detail/toc/content 阶段)
    pub url: Option<String>,
    /// 搜索关键词 (用于 search 阶段)
    pub keyword: Option<String>,
    /// 分页参数 (用于 explore/search 阶段)
    pub page: Option<u32>,
    /// 自定义变量 (用于 URL 模板替换)
    pub vars: Option<HashMap<String, String>>,
}
```

**执行结果**:
```rust
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct PhaseResult {
    pub success: bool,
    pub final_url: Option<String>,
    pub content_type: ContentType,
    pub raw_body: Option<String>, // 可选，用于调试
    pub data: Option<PhaseData>,
    pub error: Option<CrawlerError>,
}
```

**阶段数据**:
```rust
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub enum PhaseData {
    Explore(ExploreData),
    Search(SearchData),
    Detail(DetailData),
    Toc(TocData),
    Content(ContentData),
}

// 各阶段数据结构
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct SearchData {
    pub items: Vec<SearchItem>,
}

#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct SearchItem {
    pub title: String,
    pub url: String,
    pub cover: Option<String>,
    pub author: Option<String>,
    // ... 其他字段
}

// 类似地定义 DetailData, TocData, ContentData
```

**理由**:
- 类型安全 - 编译时检查而非运行时解析
- 可扩展 - 新增阶段或字段不影响现有代码
- Dart 友好 - FRB 自动生成 freezed 类型

### 4. 执行流程

**流程图**:
```
execute_lifecycle_phase(rule, phase, context)
    │
    ├─ 1. 构建 HTTP 请求
    │   - 根据阶段获取 URL 模板
    │   - 替换变量 ({{key}}, {{page}} 等)
    │   - 应用 rule.network 配置
    │
    ├─ 2. 发送 HTTP 请求
    │   - 使用 wreq + TLS 指纹
    │   - 应用浏览器模拟 (rule.network.emulation)
    │
    ├─ 3. WAF 拦截检测
    │   - 检查 403/503 状态码
    │   - 检查 Cloudflare headers (cf-ray, cf-mitigated)
    │   - 如果拦截 → 返回 CrawlerError::AuthRequired
    │
    ├─ 4. 响应类型检测
    │   - 检查规则配置覆盖
    │   - 自动检测 Content-Type
    │   - 确定 HTML/JSON/XML
    │
    ├─ 5. 执行 Pipeline
    │   - 根据阶段获取 pipeline 配置
    │   - 根据内容类型选择选择器
    │   - 执行节点操作
    │
    └─ 6. 返回结构化数据
        - 将 Vec<String> 转换为阶段特定数据结构
        - 返回 PhaseResult
```

**理由**:
- 清晰的步骤边界便于调试
- 每步都可独立测试
- 错误可以精确定位

### 5. 错误处理

**错误类型扩展**:
```rust
#[derive(Debug, Error)]
pub enum CrawlerError {
    // 现有错误...
    
    /// 阶段配置缺失
    #[error("规则缺少 {phase} 阶段配置")]
    MissingPhaseConfig { phase: String },
    
    /// URL 构建失败
    #[error("URL 模板替换失败: {reason}")]
    UrlTemplateError { reason: String },
    
    /// 不支持的响应类型
    #[error("不支持的响应类型: {content_type}")]
    UnsupportedContentType { content_type: String },
    
    /// 数据解析失败
    #[error("数据解析失败: {reason}")]
    DataParseError { reason: String },
}
```

**理由**:
- 精确的错误类型便于 Dart 侧处理
- 包含足够的上下文信息
- 可扩展新的错误类型

### 6. 底层 API 处理

**决策**: 保留底层 API 但标记为内部使用

**实现**:
```rust
// rust/src/api/mod.rs
pub mod lifecycle_executor; // 新的公开 API

pub(crate) mod html_parser; // 内部使用
pub(crate) mod http_client; // 内部使用
```

**理由**:
- 保持向后兼容性（短期内）
- 允许性能优化场景直接使用底层 API
- 逐步迁移而非破坏性变更

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│  Dart Application Layer                                     │
│  - 调用 execute_lifecycle_phase()                           │
│  - 接收结构化的 PhaseResult                                 │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  Rust FFI Layer (rust/src/api/lifecycle_executor.rs)        │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ execute_lifecycle_phase()                             │  │
│  │  1. URL 模板处理                                       │  │
│  │  2. HTTP 请求 (调用 http_client 内部 API)              │  │
│  │  3. WAF 检测                                           │  │
│  │  4. 响应类型检测                                       │  │
│  │  5. Pipeline 执行 (调用 html_parser 内部 API)          │  │
│  │  6. 数据结构化                                         │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  Rust Internal Layer                                         │
│  - http_client.rs (内部使用)                                 │
│  - html_parser.rs (内部使用)                                 │
│  - executor/ (选择器/变换执行)                                │
│  - domain/rule/ (规则模型)                                   │
└─────────────────────────────────────────────────────────────┘
```

## Risks / Trade-offs

### Risk 1: 响应类型检测不准确

**问题**: 某些网站返回错误的 Content-Type header

**缓解措施**:
- 提供规则配置覆盖机制
- 支持手动指定类型
- 日志记录检测决策

### Risk 2: 性能开销

**问题**: 新增的结构化转换可能影响性能

**缓解措施**:
- 保留底层 API 供性能关键场景使用
- 结构化转换仅在需要时执行
- 可通过 `raw_body` 获取原始数据

### Risk 3: 迁移成本

**问题**: 现有 Dart 代码需要迁移到新 API

**缓解措施**:
- 底层 API 保留（短期内）
- 提供迁移指南
- 新旧 API 可并行存在

### Risk 4: 灵活性降低

**问题**: 高层 API 可能无法满足所有场景

**缓解措施**:
- 保留底层 API 访问能力（内部使用）
- 提供扩展点（如自定义数据结构）
- 如果需要，可以暴露更多控制参数

## Migration Plan

### 阶段 1: 实现新 API (不影响现有代码)
1. 实现 `lifecycle_executor.rs`
2. 添加新的类型定义
3. 保留现有底层 API

### 阶段 2: Dart 侧迁移
1. 创建 Dart 侧的 `LifecycleExecutor` 服务
2. 更新 `CrawlerRuleExecutor` 使用新 API
3. 标记旧 API 为 deprecated

### 阶段 3: 清理
1. 移除或降级底层 API 的 FRB 导出
2. 更新文档
3. 删除废弃代码

### 回滚策略
- 底层 API 保留，可快速回退
- Dart 侧保持独立封装，易于切换

## Open Questions

1. **阶段数据结构的字段定义** - 需要确认各阶段返回的具体字段（SearchItem, DetailData 等）
2. **Pipeline 与阶段数据映射** - 如何将 Vec<String> 转换为结构化数据？是否需要额外的配置？
3. **错误重试策略** - 网络错误是否在 Rust 侧自动重试？重试次数如何配置？
4. **并发控制** - 是否在 Rust 侧实现并发请求？还是由 Dart 侧控制？
