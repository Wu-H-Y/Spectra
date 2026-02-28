# Refactor Crawler Rule System - Technical Design

## Context

### 背景

基于对以下项目的深入研究：

1. **Legado (阅读)** - 小说聚合器
   - 使用 Jaccard Similarity 进行章节匹配，阈值 0.96
   - 搜索窗口 +-10 章节优化性能
   - 两阶段匹配: 相似度 -> 章节号回退

2. **TachiyomiSY** - 漫画聚合器
   - 手动源合并，用户配置优先级
   - `MergedMangaReference` 追踪每个源的引用
   - 并发获取 (Semaphore 限制 5 个)

3. **n8n / Node-RED** - 工作流引擎
   - 声明式节点定义 (displayName, inputs, outputs, properties)
   - connections 分离存储，与 nodes 解耦
   - JSON Schema 验证节点配置

4. **wreq** - Rust HTTP 客户端 (核心参考)
   - TLS 指纹伪装 (JA3/JA4)
   - HTTP/2 指纹模拟
   - 100+ 预置设备配置 (wreq-util)
   - 基于 BoringSSL，支持全平台

5. **flutter_rust_bridge** - Rust FFI 代码生成
   - 自动生成双向绑定 (Dart <-> Rust)
   - 支持高级类型和 async/await
   - 同时支持原生和 Web 平台 (WASM)

6. **rlibxml2** - Rust HTML/XML 解析库 (私有库)
   - 基于 libxml2 的安全封装
   - 完整 XPath 1.0 语法支持
   - 容错 HTML 解析
   - 线程安全 (Send + Sync)
   - 专为爬虫优化，精简编译配置
   - 跨平台支持 (Windows/macOS/Linux/Android/iOS)

### 约束

- **Flutter 跨平台**: Android, iOS, Windows, macOS, Linux
- **freezed 强制**: 所有数据模型使用 freezed
- **Pipeline 可序列化**: 支持字符串数组格式和 React Flow 格式
- **Rust 优先**: 所有爬虫核心逻辑在 Rust 层实现
- **Rust FFI**: 使用 flutter_rust_bridge 集成 Rust 模块
- **统一网络层**: 所有 HTTP 请求由 Rust wreq 处理
- **统一选择器**: HTML 解析和选择器由 Rust rlibxml2 处理

### 迁移到 Rust 的逻辑

| 功能 | 当前 Dart 实现 | Rust 实现 | API 暴露 |
|------|---------------|-----------|----------|
| HTTP 请求 | http 包 | wreq | **是** (fetch, HttpClient) |
| HTML 解析 | html 包 | rlibxml2 | **是** (parse_html) |
| XPath 选择器 | xml 包 | rlibxml2 | **是** (xpath_*) |
| JSONPath | json_path 包 | jsonpath-rust | **是** (jsonpath_*) |
| 正则表达式 | dart:core | regex | 内部使用 |
| JS 表达式 | flutter_js | rquickjs | 内部使用 |
| 文本变换 | dart:core | Rust 原生 | 内部使用 |
| 中文分词 | - | jieba-rs | **是** (segment) |
| 繁简转换 | - | ferrous-opencc | **是** (to_simplified/traditional) |
| 数字转中文 | - | chinese-number | **是** (number_to_chinese) |
| 相似度计算 | - | textdistance | **否** (内部使用) |
| 标题标准化 | - | Rust 原生 | **是** (normalize_title) |

### FFI API 策略

**暴露的 API** (Dart 可调用):
1. HTTP 客户端: `fetch`, `HttpClient`, `http_get`, `http_post`
2. HTML 解析: `parse_html`, `xpath_extract_texts`, `xpath_select`
3. JSONPath: `jsonpath_query`
4. Pipeline 执行: `execute_pipeline`
5. 文本处理: `segment`, `to_simplified`, `to_traditional`, `number_to_chinese`, `normalize_title`

**内部使用** (不暴露给 Dart):
- 相似度计算 (在 Rust 层被 Pipeline Executor 内部调用)
- 正则表达式处理
- JS 表达式执行
- 文本变换 (trim, replace, url 等)

---

## Goals / Non-Goals

### Goals

1. **设计 Pipeline DSL** - 字符串数组格式，支持可视化映射
2. **实现完整生命周期** - Explore, Search, Detail, TOC, Content 五阶段
3. **Rust 统一网络层** - 使用 wreq 处理所有 HTTP 请求，支持 TLS/HTTP2 指纹
4. **实现多源聚合** - Jaccard/Levenshtein 相似度匹配
5. **重构可视化编辑器** - React Flow 节点流编辑

### Non-Goals

1. **WebView Stealth** - 不实现自动 Cloudflare 解决，复杂场景由用户手动处理
2. **后端代理** - 不依赖远程服务器执行反爬
3. **第三方验证码服务** - 不集成付费验证码求解服务
4. **移动端 headless** - 移动端不支持 headless WebView

---

## Architecture

### 整体架构

```
+------------------------------------------------------------------+
|                        Flutter UI Layer                           |
|  +--------------------+  +--------------------+  +--------------+ |
|  | Rule Editor        |  | Rule List          |  | Settings     | |
|  | (React Flow)       |  |                    |  |              | |
|  +--------------------+  +--------------------+  +--------------+ |
+------------------------------------------------------------------+
                                |
                                | 规则配置 (JSON)
                                v
+------------------------------------------------------------------+
|                     Dart Business Layer                           |
|  +--------------------+  +--------------------+  +--------------+ |
|  | Rule Manager       |  | Source Aggregator  |  | Session Mgr  | |
|  | (CRUD + 验证)      |  | (调用 Rust FFI)    |  | (Cookie同步) | |
|  +--------------------+  +--------------------+  +--------------+ |
+------------------------------------------------------------------+
                                |
                                | FFI (flutter_rust_bridge)
                                v
+------------------------------------------------------------------+
|                        Rust Layer (核心爬虫引擎)                   |
|  +--------------------+  +--------------------+  +--------------+ |
|  | HTTP Client        |  | HTML Parser        |  | Pipeline     | |
|  | (wreq + TLS 指纹)  |  | (rlibxml2 + XPath) |  | Executor     | |
|  +--------------------+  +--------------------+  +--------------+ |
|  +--------------------+  +--------------------+  +--------------+ |
|  | Text Processor     |  | Similarity         |  | JSONPath     | |
|  | (jieba, opencc)    |  | (textdistance)     |  | (serde_json) | |
|  +--------------------+  +--------------------+  +--------------+ |
+------------------------------------------------------------------+
                                |
                                v
+------------------------------------------------------------------+
|                        Network / System                           |
|                    目标网站 (HTTP/HTTPS)                           |
+------------------------------------------------------------------+
```

### 请求处理流程 (Rust 优先)

```
1. Flutter 配置规则 (JSON)
   |
   v
2. Dart 调用 Rust FFI: execute_pipeline(url, config, pipeline)
   |
   v
3. Rust wreq 处理请求:
   - 应用 TLS 指纹 (Chrome/Firefox/Safari)
   - 应用 HTTP/2 指纹
   - 设置请求头
   - 处理重定向
   |
   v
4. Rust rlibxml2 解析 HTML:
   - 容错解析 (处理脏 HTML)
   - 构建 DOM 树
   |
   v
5. Rust Pipeline Executor 执行选择器链:
   - XPath 选择器 (rlibxml2)
   - CSS 选择器 (scraper, 可选)
   - JSONPath (serde_json)
   - 正则表达式 (regex)
   - 文本变换 (trim, replace, url)
   - 聚合操作 (first, join)
   |
   v
6. 返回结构化数据给 Dart:
   - List<Map<String, String>> 结果
   - 错误信息 (如有)
```

---

## Rust 代码规范

### 1. 类型驱动设计 (Type-Driven Design)

#### 1.1 Newtype 模式 (语义类型)

使用 newtype 包装原始类型，提供类型安全和领域语义:

```rust
// rust/src/domain/types.rs

/// XPath 表达式 (newtype)。
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct XPath(String);

impl XPath {
    /// 创建 XPath 表达式。
    ///
    /// # Errors
    ///
    /// 如果表达式为空则返回错误。
    pub fn new(expr: impl Into<String>) -> Result<Self, ParseError> {
        let s = expr.into();
        if s.is_empty() {
            return Err(ParseError::EmptyExpression("XPath"));
        }
        Ok(Self(s))
    }

    /// 获取表达式引用。
    pub fn as_str(&self) -> &str {
        &self.0
    }
}

/// JSONPath 表达式 (newtype)。
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct JsonPath(String);

/// 正则表达式 (newtype)。
#[derive(Debug, Clone)]
pub struct Regex(regex::Regex);

/// URL (newtype，已验证)。
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Url(url::Url);

impl Url {
    /// 解析并验证 URL。
    pub fn parse(s: &str) -> Result<Self, ParseError> {
        let url = url::Url::parse(s)
            .map_err(|e| ParseError::InvalidUrl(e.to_string()))?;
        Ok(Self(url))
    }

    /// 解析相对 URL。
    pub fn join(&self, relative: &str) -> Result<Self, ParseError> {
        let url = self.0.join(relative)
            .map_err(|e| ParseError::InvalidUrl(e.to_string()))?;
        Ok(Self(url))
    }
}

/// CSS 选择器 (newtype)。
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct CssSelector(String);
```

#### 1.2 类型状态模式 (Type State)

使用类型状态模式表示 Pipeline 节点的不同类型:

```rust
// rust/src/domain/pipeline.rs

/// Pipeline 节点类型标记。
pub mod node_type {
    /// 选择器节点。
    pub struct Selector;
    /// 提取器节点。
    pub struct Extractor;
    /// 变换节点。
    pub struct Transform;
    /// 聚合节点。
    pub struct Aggregation;
}

/// Pipeline 节点 (类型状态)。
#[derive(Debug, Clone)]
pub struct PipelineNode<T> {
    /// 操作符。
    pub operator: Operator,
    /// 参数。
    pub argument: Option<String>,
    /// 类型标记 (零大小类型)。
    _marker: std::marker::PhantomData<T>,
}

impl<T> PipelineNode<T> {
    /// 创建节点。
    pub fn new(operator: Operator, argument: Option<String>) -> Self {
        Self {
            operator,
            argument,
            _marker: std::marker::PhantomData,
        }
    }
}

/// 节点操作符 (枚举，类型安全)。
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Operator {
    // 选择器
    Xpath,
    JsonPath,
    Regex,
    // 提取器
    Text,
    Attr,
    Html,
    // 变换
    Trim,
    Lower,
    Upper,
    Replace,
    Url,
    Number,
    Js,
    // 聚合
    First,
    Last,
    Join,
    Array,
}

impl Operator {
    /// 从字符串解析操作符。
    pub fn from_str(s: &str) -> Result<Self, ParseError> {
        match s {
            "xpath" => Ok(Self::Xpath),
            "jsonpath" => Ok(Self::JsonPath),
            "regex" => Ok(Self::Regex),
            "text" => Ok(Self::Text),
            "attr" => Ok(Self::Attr),
            "html" => Ok(Self::Html),
            "trim" => Ok(Self::Trim),
            "lower" => Ok(Self::Lower),
            "upper" => Ok(Self::Upper),
            "replace" => Ok(Self::Replace),
            "url" => Ok(Self::Url),
            "number" => Ok(Self::Number),
            "js" => Ok(Self::Js),
            "first" => Ok(Self::First),
            "last" => Ok(Self::Last),
            "join" => Ok(Self::Join),
            "array" => Ok(Self::Array),
            _ => Err(ParseError::UnknownOperator(s.to_string())),
        }
    }
}
```

#### 1.3 Builder 模式

使用 Builder 模式构建复杂结构:

```rust
// rust/src/domain/request.rs

/// HTTP 请求构建器。
#[derive(Debug, Default)]
pub struct HttpRequestBuilder {
    url: Option<String>,
    method: Option<String>,
    headers: HashMap<String, String>,
    body: Option<String>,
    emulation: Option<Emulation>,
    timeout_ms: Option<u32>,
}

impl HttpRequestBuilder {
    /// 创建构建器。
    pub fn new() -> Self {
        Self::default()
    }

    /// 设置 URL。
    pub fn url(mut self, url: impl Into<String>) -> Self {
        self.url = Some(url.into());
        self
    }

    /// 设置方法。
    pub fn method(mut self, method: impl Into<String>) -> Self {
        self.method = Some(method.into());
        self
    }

    /// 添加请求头。
    pub fn header(mut self, key: impl Into<String>, value: impl Into<String>) -> Self {
        self.headers.insert(key.into(), value.into());
        self
    }

    /// 设置请求体。
    pub fn body(mut self, body: impl Into<String>) -> Self {
        self.body = Some(body.into());
        self
    }

    /// 设置设备模拟。
    pub fn emulation(mut self, emulation: Emulation) -> Self {
        self.emulation = Some(emulation);
        self
    }

    /// 设置超时。
    pub fn timeout_ms(mut self, ms: u32) -> Self {
        self.timeout_ms = Some(ms);
        self
    }

    /// 构建请求。
    ///
    /// # Errors
    ///
    /// 如果 URL 未设置则返回错误。
    pub fn build(self) -> Result<HttpRequest, BuildError> {
        let url = self.url.ok_or(BuildError::MissingField("url"))?;
        Ok(HttpRequest {
            url,
            method: self.method.unwrap_or_else(|| "GET".to_string()),
            headers: if self.headers.is_empty() {
                None
            } else {
                Some(self.headers)
            },
            body: self.body,
            emulation: self.emulation.unwrap_or_default(),
            timeout_ms: self.timeout_ms.unwrap_or(15_000),
            follow_redirects: true,
        })
    }
}
```

### 2. 错误处理设计

#### 2.1 结构化错误类型

使用 `thiserror` 定义领域错误:

```rust
// rust/src/error.rs

use thiserror::Error;

/// 爬虫错误类型。
#[derive(Debug, Error)]
pub enum CrawlerError {
    /// HTTP 请求错误。
    #[error("HTTP 请求失败: {0}")]
    Http(String),

    /// HTML 解析错误。
    #[error("HTML 解析失败: {0}")]
    HtmlParse(String),

    /// XPath 查询错误。
    #[error("XPath 查询失败: {0}")]
    Xpath(String),

    /// JSONPath 查询错误。
    #[error("JSONPath 查询失败: {0}")]
    JsonPath(String),

    /// 正则表达式错误。
    #[error("正则表达式错误: {0}")]
    Regex(#[from] regex::Error),

    /// JS 执行错误。
    #[error("JS 执行错误: {0}")]
    Js(String),

    /// Pipeline 执行错误。
    #[error("Pipeline 节点 {node} 执行失败: {message}")]
    Pipeline {
        node: String,
        message: String,
    },

    /// 解析错误。
    #[error("解析错误: {0}")]
    Parse(#[from] ParseError),

    /// 构建错误。
    #[error("构建错误: {0}")]
    Build(#[from] BuildError),
}

/// 解析错误。
#[derive(Debug, Error)]
pub enum ParseError {
    #[error("空表达式: {0}")]
    EmptyExpression(&'static str),

    #[error("无效 URL: {0}")]
    InvalidUrl(String),

    #[error("未知操作符: {0}")]
    UnknownOperator(String),

    #[error("参数格式错误: {0}")]
    InvalidArgument(String),
}

/// 构建错误。
#[derive(Debug, Error)]
pub enum BuildError {
    #[error("缺少必填字段: {0}")]
    MissingField(&'static str),

    #[error("字段验证失败: {0}")]
    Validation(String),
}
```

#### 2.2 Result 类型别名

```rust
// rust/src/lib.rs

/// 爬虫操作结果类型。
pub type Result<T> = std::result::Result<T, CrawlerError>;
```

### 3. 模块组织结构

```
rust/src/
├── lib.rs                      # 库入口，导出公共 API
├── error.rs                    # 错误类型定义
├── frb_generated.rs            # FRB 自动生成
│
├── api/                        # FFI API 层 (暴露给 Dart)
│   ├── mod.rs
│   ├── http_client.rs          # HTTP 客户端 API
│   ├── html_parser.rs          # HTML 解析 API
│   ├── text_processor.rs       # 文本处理 API
│   └── pipeline.rs             # Pipeline 执行 API (统一入口)
│
├── domain/                     # 领域层 (内部实现)
│   ├── mod.rs
│   ├── types.rs                # Newtype 类型定义
│   ├── pipeline.rs             # Pipeline 节点和执行器
│   ├── request.rs              # 请求构建
│   └── response.rs             # 响应处理
│
├── executor/                   # 执行器层 (内部实现)
│   ├── mod.rs
│   ├── selector/               # 选择器实现
│   │   ├── mod.rs
│   │   ├── xpath.rs            # XPath 选择器
│   │   ├── jsonpath.rs         # JSONPath 选择器
│   │   └── regex.rs            # 正则选择器
│   ├── transform/              # 变换器实现
│   │   ├── mod.rs
│   │   ├── string_ops.rs       # 字符串操作
│   │   └── js.rs               # JS 表达式执行
│   └── aggregation.rs          # 聚合器实现
│
└── util/                       # 工具模块 (内部使用)
    ├── mod.rs
    ├── content_type.rs         # 内容类型检测
    └── url.rs                  # URL 处理
```

### 4. 并发安全设计

#### 4.1 JS 执行器 (需要同步访问)

rquickjs 的 `Runtime` 不是线程安全的，需要包装:

```rust
// rust/src/executor/transform/js.rs

use std::sync::{Arc, Mutex};
use rquickjs::Runtime;

/// JS 执行器 (线程安全封装)。
#[derive(Clone)]
pub struct JsExecutor {
    /// Runtime 需要互斥访问。
    runtime: Arc<Mutex<Runtime>>,
}

impl JsExecutor {
    /// 创建新的 JS 执行器。
    ///
    /// # Errors
    ///
    /// 如果 Runtime 创建失败则返回错误。
    pub fn new() -> Result<Self, CrawlerError> {
        let runtime = Runtime::new()
            .map_err(|e| CrawlerError::Js(format!("创建 Runtime 失败: {}", e)))?;
        Ok(Self {
            runtime: Arc::new(Mutex::new(runtime)),
        })
    }

    /// 执行 JS 表达式。
    pub fn eval(
        &self,
        code: &str,
        input: &str,
        variables: &HashMap<String, String>,
    ) -> Result<String, CrawlerError> {
        let runtime = self.runtime.lock()
            .map_err(|_| CrawlerError::Js("Runtime 被锁定".to_string()))?;

        // 执行表达式...
    }
}
```

#### 4.2 HTTP 客户端 (已经是 Arc-safe)

wreq 的 `Client` 是可以克隆的，内部使用 Arc:

```rust
// rust/src/api/http_client.rs

/// HTTP 客户端 (可克隆，内部使用 Arc)。
#[derive(Clone)]
pub struct HttpClient {
    client: Client,  // wreq Client 内部是 Arc
}
```

### 5. 性能优化建议

| 场景 | 建议 |
|------|------|
| 频繁字符串操作 | 使用 `Cow<str>` 避免不必要的克隆 |
| 大量 XPath 查询 | 复用 `HtmlDocument` 而非重复解析 |
| 批量请求 | 使用 `Stream` 并发控制 |
| 预分配 | `Vec::with_capacity()`, `String::with_capacity()` |

---

## Key Designs

### 1. Rust HTTP Client API

使用 wreq 库实现 HTTP 客户端，支持 TLS 指纹伪装。

```rust
// rust/src/api/http_client.rs
use wreq::{Client, Response};
use wreq_util::Emulation;

/// 浏览器设备类型
pub enum BrowserEmulation {
    Chrome131,
    Chrome120,
    Firefox133,
    Safari18,
    Edge127,
}

/// HTTP 请求配置
pub struct HttpRequest {
    pub url: String,
    pub method: String,
    pub headers: Option<HashMap<String, String>>,
    pub body: Option<String>,
    pub emulation: BrowserEmulation,
    pub timeout_ms: u32,
    pub follow_redirects: bool,
}

/// HTTP 响应
pub struct HttpResponse {
    pub status: u16,
    pub headers: HashMap<String, String>,
    pub body: String,
    pub url: String,  // 最终 URL (重定向后)
}

/// 发送 HTTP 请求
pub async fn fetch(request: HttpRequest) -> Result<HttpResponse, String> {
    let emulation = match request.emulation {
        BrowserEmulation::Chrome131 => Emulation::Chrome131,
        BrowserEmulation::Chrome120 => Emulation::Chrome120,
        BrowserEmulation::Firefox133 => Emulation::Firefox133,
        BrowserEmulation::Safari18 => Emulation::Safari18,
        BrowserEmulation::Edge127 => Emulation::Edge127,
    };

    let client = Client::builder()
        .emulation(emulation)
        .timeout(Duration::from_millis(request.timeout_ms as u64))
        .redirect(if request.follow_redirects {
            wreq::redirect::Policy::default()
        } else {
            wreq::redirect::Policy::none()
        })
        .build()
        .map_err(|e| e.to_string())?;

    let mut req = match request.method.as_str() {
        "GET" => client.get(&request.url),
        "POST" => client.post(&request.url),
        _ => return Err(format!("Unsupported method: {}", request.method)),
    };

    if let Some(headers) = request.headers {
        for (key, value) in headers {
            req = req.header(&key, &value);
        }
    }

    if let Some(body) = request.body {
        req = req.body(body);
    }

    let response = req.send().await.map_err(|e| e.to_string())?;

    Ok(HttpResponse {
        status: response.status().as_u16(),
        headers: response.headers().iter()
            .map(|(k, v)| (k.to_string(), v.to_str().unwrap_or("").to_string()))
            .collect(),
        body: response.text().await.map_err(|e| e.to_string())?,
        url: response.url().to_string(),
    })
}
```

### 1.1 Rust HTML Parser API (新增)

使用 rlibxml2 库实现 HTML 解析和 XPath 选择器。

```rust
// rust/src/api/html_parser.rs
use rlibxml::{Document, ParseOptions, XPathResult};

/// HTML 解析器配置。
pub struct ParserOptions {
    /// 容错模式 (默认 true)
    pub recover: bool,
    /// 抑制错误 (默认 true)
    pub no_error: bool,
    /// 抑制警告 (默认 true)
    pub no_warning: bool,
    /// 移除空白节点 (默认 false)
    pub no_blanks: bool,
}

/// XPath 查询结果。
pub enum XPathQueryResult {
    /// 节点集合
    Nodes(Vec<SelectedNode>),
    /// 字符串值
    String(String),
    /// 数字值
    Number(f64),
    /// 布尔值
    Boolean(bool),
}

/// 选中的节点。
pub struct SelectedNode {
    /// 标签名
    pub tag_name: String,
    /// 文本内容
    pub text: String,
    /// 属性列表
    pub attributes: HashMap<String, String>,
    /// XPath 路径
    pub path: String,
    /// 内部 HTML
    pub inner_html: String,
    /// 外部 HTML
    pub outer_html: String,
}

/// 解析 HTML 文档。
///
/// # Errors
///
/// 返回错误字符串，包含解析失败原因。
#[frb]
pub fn parse_html(html: String, options: Option<ParserOptions>) -> Result<HtmlDocument, String> {
    let opts = options.unwrap_or(ParserOptions {
        recover: true,
        no_error: true,
        no_warning: true,
        no_blanks: false,
    });

    let parse_opts = ParseOptions {
        recover: opts.recover,
        no_error: opts.no_error,
        no_warning: opts.no_warning,
        no_blanks: opts.no_blanks,
    };

    Document::parse_html_with_options(&html, parse_opts)
        .map(|doc| HtmlDocument { inner: doc })
        .map_err(|e| format!("HTML 解析失败: {}", e))
}

/// HTML 文档 (封装 rlibxml2 Document)。
pub struct HtmlDocument {
    inner: Document,
}

impl HtmlDocument {
    /// 执行 XPath 查询，返回文本列表。
    #[frb]
    pub fn xpath_extract_texts(&self, expression: String) -> Result<Vec<String>, String> {
        self.inner
            .extract_texts(&expression)
            .map_err(|e| format!("XPath 查询失败: {}", e))
    }

    /// 执行 XPath 查询，返回第一个文本。
    #[frb]
    pub fn xpath_extract_first(&self, expression: String) -> Result<Option<String>, String> {
        let texts = self.xpath_extract_texts(expression)?;
        Ok(texts.first().cloned())
    }

    /// 执行 XPath 查询，返回节点列表。
    #[frb]
    pub fn xpath_select(&self, expression: String) -> Result<Vec<SelectedNode>, String> {
        let nodes = self.inner
            .select(&expression)
            .map_err(|e| format!("XPath 查询失败: {}", e))?;

        Ok(nodes
            .iter()
            .map(|node| SelectedNode {
                tag_name: node.tag_name(),
                text: node.text(),
                attributes: node.attrs(),
                path: node.path(),
                inner_html: node.inner_html(),
                outer_html: node.outer_html(),
            })
            .collect())
    }

    /// 执行 XPath 查询，提取属性值。
    #[frb]
    pub fn xpath_extract_attr(
        &self,
        expression: String,
        attr_name: String,
    ) -> Result<Vec<String>, String> {
        let nodes = self.xpath_select(expression)?;
        let attrs: Vec<String> = nodes
            .iter()
            .filter_map(|n| n.attributes.get(&attr_name).cloned())
            .collect();
        Ok(attrs)
    }

    /// 提取数字 (如 count(//div))。
    #[frb]
    pub fn xpath_extract_number(&self, expression: String) -> Result<f64, String> {
        self.inner
            .extract_number(&expression)
            .map_err(|e| format!("XPath 数字提取失败: {}", e))
    }

    /// 提取布尔值。
    #[frb]
    pub fn xpath_extract_boolean(&self, expression: String) -> Result<bool, String> {
        self.inner
            .extract_boolean(&expression)
            .map_err(|e| format!("XPath 布尔提取失败: {}", e))
    }
}
```

### 1.2 Rust Pipeline Executor API (新增)

在 Rust 层执行完整的 Pipeline 链，支持 HTML/XML/JSON 三种内容类型。

```rust
// rust/src/api/pipeline_executor.rs
use serde::{Deserialize, Serialize};
use jsonpath_rust::JsonPath;

/// 内容类型。
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ContentType {
    /// HTML 内容
    Html,
    /// XML 内容
    Xml,
    /// JSON 内容
    Json,
    /// 纯文本
    Text,
}

/// 解析后的文档 (统一抽象)。
pub enum ParsedDocument {
    /// HTML/XML 文档 (rlibxml2)
    Html(HtmlDocument),
    /// JSON 文档 (serde_json)
    Json(serde_json::Value),
    /// 纯文本
    Text(String),
}

/// Pipeline 节点定义。
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PipelineNode {
    /// 节点类型: selector, extractor, transform, aggregation
    pub node_type: String,
    /// 操作符: xpath, jsonpath, regex, text, attr, trim, replace, etc.
    pub operator: String,
    /// 参数 (如 XPath 表达式、JSONPath 路径、正则模式等)
    pub argument: Option<String>,
}

/// Pipeline 执行请求。
pub struct PipelineExecuteRequest {
    /// 内容 (HTML/XML/JSON/Text)
    pub content: String,
    /// 内容类型 (自动检测如果为 None)
    pub content_type: Option<ContentType>,
    /// Pipeline 节点链
    pub nodes: Vec<PipelineNode>,
    /// 变量上下文
    pub variables: HashMap<String, String>,
}

/// Pipeline 执行结果。
pub struct PipelineExecuteResult {
    /// 提取的值列表
    pub values: Vec<String>,
    /// 错误信息
    pub errors: Vec<String>,
}

/// 自动检测内容类型。
fn detect_content_type(content: &str) -> ContentType {
    let trimmed = content.trim();

    // JSON 检测
    if trimmed.starts_with('{') || trimmed.starts_with('[') {
        if serde_json::from_str::<serde_json::Value>(trimmed).is_ok() {
            return ContentType::Json;
        }
    }

    // XML 检测
    if trimmed.starts_with("<?xml") || trimmed.starts_with("<") {
        // 检查是否是 HTML
        if trimmed.contains("<!DOCTYPE html") || trimmed.contains("<html") {
            return ContentType::Html;
        }
        return ContentType::Xml;
    }

    ContentType::Text
}

/// 解析内容为文档。
fn parse_content(content: &str, content_type: ContentType) -> Result<ParsedDocument, String> {
    match content_type {
        ContentType::Html | ContentType::Xml => {
            let doc = parse_html(content.to_string(), None)?;
            Ok(ParsedDocument::Html(doc))
        }
        ContentType::Json => {
            let json = serde_json::from_str(content)
                .map_err(|e| format!("JSON 解析失败: {}", e))?;
            Ok(ParsedDocument::Json(json))
        }
        ContentType::Text => {
            Ok(ParsedDocument::Text(content.to_string()))
        }
    }
}

/// 执行 Pipeline 链。
///
/// 在 Rust 层完成整个选择器链的执行，支持 HTML/XML/JSON 三种内容类型。
#[frb]
pub fn execute_pipeline(request: PipelineExecuteRequest) -> Result<PipelineExecuteResult, String> {
    // 检测或使用指定的内容类型
    let content_type = request.content_type
        .unwrap_or_else(|| detect_content_type(&request.content));

    // 解析内容
    let doc = parse_content(&request.content, content_type)?;

    let mut current_values: Vec<String> = vec![];
    let mut errors: Vec<String> = vec![];

    for node in request.nodes {
        let result = execute_node(&doc, &current_values, &node, &request.variables);
        match result {
            Ok(values) => current_values = values,
            Err(e) => {
                errors.push(format!("节点执行失败 [{}]: {}", node.operator, e));
                if current_values.is_empty() {
                    return Ok(PipelineExecuteResult {
                        values: vec![],
                        errors,
                    });
                }
            }
        }
    }

    Ok(PipelineExecuteResult {
        values: current_values,
        errors,
    })
}

/// 执行单个节点。
fn execute_node(
    doc: &ParsedDocument,
    input: &[String],
    node: &PipelineNode,
    variables: &HashMap<String, String>,
) -> Result<Vec<String>, String> {
    match node.node_type.as_str() {
        "selector" => execute_selector(doc, input, node),
        "extractor" => execute_extractor(input, node),
        "transform" => execute_transform(input, node, variables),
        "aggregation" => execute_aggregation(input, node),
        _ => Err(format!("未知节点类型: {}", node.node_type)),
    }
}

/// 执行选择器节点。
fn execute_selector(
    doc: &ParsedDocument,
    _input: &[String],
    node: &PipelineNode,
) -> Result<Vec<String>, String> {
    let expr = node.argument.as_ref().ok_or("选择器表达式不能为空")?;

    match node.operator.as_str() {
        "xpath" => {
            match doc {
                ParsedDocument::Html(html_doc) => html_doc.xpath_extract_texts(expr.clone()),
                ParsedDocument::Json(_) => Err("XPath 不适用于 JSON 内容".to_string()),
                ParsedDocument::Text(_) => Err("XPath 不适用于纯文本".to_string()),
            }
        }
        "jsonpath" => {
            match doc {
                ParsedDocument::Json(json) => {
                    // 使用 jsonpath-rust 库
                    let path = JsonPath::from_str(expr)
                        .map_err(|e| format!("JSONPath 解析失败: {}", e))?;
                    let result = path.find(json);
                    // 将结果转换为字符串列表
                    Ok(json_values_to_strings(result))
                }
                ParsedDocument::Html(_) => Err("JSONPath 不适用于 HTML 内容".to_string()),
                ParsedDocument::Text(_) => Err("JSONPath 不适用于纯文本".to_string()),
            }
        }
        "regex" => {
            let content = match doc {
                ParsedDocument::Html(_) | ParsedDocument::Text(_) => {
                    // 使用原始内容
                    _input.first().map(|s| s.as_str()).unwrap_or("")
                }
                ParsedDocument::Json(json) => {
                    // 将 JSON 转换为字符串
                    &json.to_string()
                }
            };
            let re = regex::Regex::new(expr)
                .map_err(|e| format!("正则表达式错误: {}", e))?;
            Ok(re
                .find_iter(content)
                .map(|m| m.as_str().to_string())
                .collect())
        }
        _ => Err(format!("未知选择器类型: {}", node.operator)),
    }
}

/// 将 JSON 值列表转换为字符串列表。
fn json_values_to_strings(values: Vec<&serde_json::Value>) -> Vec<String> {
    values
        .iter()
        .map(|v| {
            match v {
                serde_json::Value::String(s) => s.clone(),
                serde_json::Value::Number(n) => n.to_string(),
                serde_json::Value::Bool(b) => b.to_string(),
                serde_json::Value::Null => String::new(),
                _ => v.to_string(),
            }
        })
        .collect()
}

/// 执行提取器节点。
fn execute_extractor(input: &[String], node: &PipelineNode) -> Result<Vec<String>, String> {
    // 从输入值中提取数据
    match node.operator.as_str() {
        "text" => Ok(input.iter().map(|s| s.trim().to_string()).collect()),
        "attr" => {
            // 属性提取在 XPath 层完成
            Ok(input.to_vec())
        }
        "html" => Ok(input.to_vec()),
        _ => Err(format!("未知提取器类型: {}", node.operator)),
    }
}

/// 执行变换节点。
fn execute_transform(
    input: &[String],
    node: &PipelineNode,
    variables: &HashMap<String, String>,
) -> Result<Vec<String>, String> {
    let transformed: Result<Vec<String>, String> = input
        .iter()
        .map(|s| {
            match node.operator.as_str() {
                "trim" => Ok(s.trim().to_string()),
                "lower" => Ok(s.to_lowercase()),
                "upper" => Ok(s.to_uppercase()),
                "replace" => {
                    let arg = node.argument.as_ref()
                        .ok_or("replace 需要参数")?;
                    let parts: Vec<&str> = arg.split("→").collect();
                    if parts.len() != 2 {
                        return Err("replace 参数格式: from→to".to_string());
                    }
                    Ok(s.replace(parts[0], parts[1]))
                }
                "url" => {
                    // 解析相对 URL
                    if s.starts_with("http://") || s.starts_with("https://") {
                        Ok(s.clone())
                    } else if let Some(base) = variables.get("baseUrl") {
                        let base_url = url::Url::parse(base)
                            .map_err(|e| format!("URL 解析失败: {}", e))?;
                        base_url.join(s)
                            .map(|u| u.to_string())
                            .map_err(|e| format!("URL 拼接失败: {}", e))
                    } else {
                        Ok(s.clone())
                    }
                }
                "number" => {
                    let re = regex::Regex::new(r"-?\d+(\.\d+)?")
                        .map_err(|e| format!("正则错误: {}", e))?;
                    Ok(re.find(s).map(|m| m.as_str().to_string()).unwrap_or_default())
                }
                "js" => {
                    // 使用 rquickjs 执行 JS 表达式
                    let code = node.argument.as_ref()
                        .ok_or("js 需要代码参数")?;
                    execute_js_expression(s, code, variables)
                }
                _ => Err(format!("未知变换类型: {}", node.operator)),
            }
        })
        .collect();

    transformed
}

/// 执行聚合节点。
fn execute_aggregation(input: &[String], node: &PipelineNode) -> Result<Vec<String>, String> {
    match node.operator.as_str() {
        "first" => Ok(input.first().map(|s| vec![s.clone()]).unwrap_or_default()),
        "last" => Ok(input.last().map(|s| vec![s.clone()]).unwrap_or_default()),
        "join" => {
            let sep = node.argument.as_deref().unwrap_or(",");
            Ok(vec![input.join(sep)])
        }
        "array" => Ok(input.to_vec()),
        _ => Err(format!("未知聚合类型: {}", node.operator)),
    }
}

/// 执行 JS 表达式 (使用 rquickjs)。
///
/// # Arguments
/// * `input` - 输入字符串 (在 JS 中为 `val`)
/// * `code` - JS 表达式代码
/// * `variables` - 变量上下文
///
/// # Returns
/// * `Ok(String)` - 表达式执行结果
/// * `Err(String)` - 执行错误
fn execute_js_expression(
    input: &str,
    code: &str,
    variables: &HashMap<String, String>,
) -> Result<String, String> {
    use rquickjs::{Runtime, Context};

    let runtime = Runtime::new().map_err(|e| format!("JS 运行时创建失败: {}", e))?;
    let ctx = Context::full(&runtime).map_err(|e| format!("JS 上下文创建失败: {}", e))?;

    ctx.with(|ctx| {
        // 设置全局变量
        let globals = ctx.globals();

        // 设置输入值
        globals.set("val", input)
            .map_err(|e| format!("设置 val 失败: {}", e))?;

        // 设置变量上下文
        let vars_obj = rquickjs::Object::new(ctx.clone())
            .map_err(|e| format!("创建变量对象失败: {}", e))?;
        for (key, value) in variables {
            vars_obj.set(key.as_str(), value.as_str())
                .map_err(|e| format!("设置变量 {} 失败: {}", key, e))?;
        }
        globals.set("vars", vars_obj)
            .map_err(|e| format!("设置 vars 失败: {}", e))?;

        // 执行表达式
        let result: String = ctx.eval(code)
            .map_err(|e| format!("JS 执行错误: {:?}", e))?;

        Ok(result)
    })
}
```

### 1.3 Rust JS Executor API (内部使用)

使用 rquickjs 库执行 JS 表达式，支持以下特性:

- **输入值**: `val` 变量包含当前处理的字符串
- **变量上下文**: `vars.host`, `vars.key`, `vars.page` 等
- **内置方法**: `replace()`, `toLowerCase()`, `toUpperCase()`, `trim()` 等

```rust
// rust/src/api/js_executor.rs (内部模块，不暴露 FFI)

use rquickjs::{Runtime, Context, Error};

/// JS 执行器 (线程安全封装)。
pub struct JsExecutor {
    runtime: Runtime,
}

impl JsExecutor {
    /// 创建新的 JS 执行器。
    pub fn new() -> Result<Self, String> {
        let runtime = Runtime::new()
            .map_err(|e| format!("创建 JS 运行时失败: {}", e))?;
        Ok(Self { runtime })
    }

    /// 执行 JS 表达式。
    ///
    /// # Example
    /// ```ignore
    /// let executor = JsExecutor::new()?;
    /// let result = executor.eval("val.replace(/作者：/, '').trim()", "作者：张三")?;
    /// assert_eq!(result, "张三");
    /// ```
    pub fn eval(&self, code: &str, input: &str, variables: &HashMap<String, String>) -> Result<String, String> {
        let ctx = Context::full(&self.runtime)
            .map_err(|e| format!("创建 JS 上下文失败: {}", e))?;

        ctx.with(|ctx| {
            let globals = ctx.globals();

            // 设置输入值
            globals.set("val", input)?;

            // 设置变量
            let vars = rquickjs::Object::new(ctx.clone())?;
            for (k, v) in variables {
                vars.set(k.as_str(), v.as_str())?;
            }
            globals.set("vars", vars)?;

            // 执行并返回结果
            let result: String = ctx.eval(code)?;
            Ok(result)
        })
    }
}

/// 示例 JS 表达式:
///
/// | 表达式 | 说明 |
/// |--------|------|
/// | `val.replace('作者：', '')` | 去除前缀 |
/// | `val.replace(/^(作者|author|by)[：:]\s*/i, '')` | 正则替换 |
/// | `val.trim().toLowerCase()` | 去空白并转小写 |
/// | `vars.host + val` | 拼接变量 |
/// | `parseInt(val) * 2` | 数字运算 |
///
/// ## 依赖
///
/// ```toml
/// [dependencies]
/// rquickjs = "0.6"
/// rquickjs-sys = "0.6"  # 可选，用于底层控制
/// ```
///
/// ## Serde 支持
///
/// 使用 [rquickjs-serde](https://github.com/rquickjs/rquickjs-serde) 支持
/// Rust 结构体与 JS 对象之间的自动序列化:
///
/// ```rust
/// use rquickjs_serde::from_js;
/// use serde::Deserialize;
///
/// #[derive(Deserialize)]
/// struct SearchResult {
///     title: String,
///     url: String,
/// }
///
/// // 从 JS 对象反序列化
/// let result: SearchResult = from_js(ctx, js_object)?;
/// ```
```

### 2. Network Config Model

```dart
// lib/core/crawler/models/network_config.dart

/// 设备模拟类型
enum BrowserEmulation {
  chrome131,
  chrome120,
  firefox133,
  safari18,
  edge127,
}

/// 网络策略
enum NetworkStrategy {
  /// HTTP 请求 (Rust wreq)
  http,

  /// 用户交互 WebView
  webviewInteractive,
}

/// 网络配置
@freezed
class NetworkConfig with _$NetworkConfig {
  const factory NetworkConfig({
    /// 网络策略
    @Default(NetworkStrategy.http) NetworkStrategy strategy,

    /// 设备模拟
    @Default(BrowserEmulation.chrome131) BrowserEmulation emulation,

    /// 请求头
    Map<String, String>? headers,

    /// Cookie
    Map<String, String>? cookies,

    /// 超时 (ms)
    @Default(15000) int timeout,

    /// 重定向
    @Default(true) bool followRedirects,

    /// 回退配置
    FallbackConfig? fallback,

    /// 代理配置
    ProxyConfig? proxy,
  }) = _NetworkConfig;
}

/// 回退配置
@freezed
class FallbackConfig with _$FallbackConfig {
  const factory FallbackConfig({
    /// 触发条件
    required List<TriggerCondition> trigger,

    /// 回退动作
    @Default(FallbackAction.webviewInteractive) FallbackAction action,

    /// 超时 (ms)
    @Default(60000) int timeout,
  }) = _FallbackConfig;
}

/// 触发条件
@freezed
class TriggerCondition with _$TriggerCondition {
  const factory TriggerCondition({
    /// 状态码
    int? statusCode,

    /// 正则匹配响应体
    String? bodyRegex,
  }) = _TriggerCondition;
}

/// 回退动作
enum FallbackAction {
  /// 切换到 WebView Interactive (用户手动鉴权)
  webviewInteractive,

  /// 放弃
  abort,
}
```

### 3. HTTP Strategy Implementation

```dart
// lib/core/crawler/executor/http_strategy.dart

/// HTTP 策略实现 (调用 Rust FFI)
class HttpStrategy {
  final RustHttpClient _client;

  HttpStrategy(this._client);

  /// 发送请求
  Future<Either<Failure, String>> fetch({
    required String url,
    required NetworkConfig config,
    String? method,
    String? body,
  }) async {
    try {
      final response = await _client.fetch(
        HttpRequest(
          url: url,
          method: method ?? 'GET',
          headers: config.headers,
          body: body,
          emulation: _mapEmulation(config.emulation),
          timeoutMs: config.timeout,
          followRedirects: config.followRedirects,
        ),
      );

      // 检查回退触发条件
      if (config.fallback != null) {
        if (_shouldFallback(response, config.fallback!.trigger)) {
          return Left(FallbackRequiredFailure(config.fallback!));
        }
      }

      if (response.status >= 400) {
        return Left(HttpFailure(
          statusCode: response.status,
          message: 'HTTP ${response.status}',
        ));
      }

      return Right(response.body);
    } on Exception catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  bool _shouldFallback(HttpResponse response, List<TriggerCondition> triggers) {
    for (final trigger in triggers) {
      if (trigger.statusCode != null && response.status == trigger.statusCode) {
        return true;
      }
      if (trigger.bodyRegex != null) {
        final regex = RegExp(trigger.bodyRegex!);
        if (regex.hasMatch(response.body)) {
          return true;
        }
      }
    }
    return false;
  }

  BrowserEmulation _mapEmulation(BrowserEmulation dart) {
    // 映射 Dart enum 到 Rust enum
    return dart;
  }
}
```

### 4. Pipeline Executor

```dart
// lib/core/crawler/executor/pipeline_executor.dart

/// Pipeline 执行器
class PipelineExecutor {
  final HttpStrategy _httpStrategy;
  final WebViewInteractiveStrategy _webViewStrategy;

  PipelineExecutor(this._httpStrategy, this._webViewStrategy);

  /// 执行 Pipeline
  Future<Either<Failure, Map<String, dynamic>>> execute({
    required String url,
    required NetworkConfig networkConfig,
    required Map<String, List<String>> pipeline,
  }) async {
    // 1. 获取页面内容
    final contentResult = await _fetchContent(url, networkConfig);
    if (contentResult.isLeft()) {
      return contentResult.fold(
        (failure) => Left(failure),
        (_) => throw StateError('Unexpected'),
      );
    }

    final content = contentResult.getRight()!;

    // 2. 执行 Pipeline
    final result = <String, dynamic>{};
    for (final entry in pipeline.entries) {
      final fieldResult = _executePipeline(content, entry.value);
      result[entry.key] = fieldResult;
    }

    return Right(result);
  }

  /// 获取内容 (处理回退)
  Future<Either<Failure, String>> _fetchContent(
    String url,
    NetworkConfig config,
  ) async {
    final result = await _httpStrategy.fetch(url: url, config: config);

    return result.fold(
      (failure) {
        // 处理回退
        if (failure is FallbackRequiredFailure) {
          return _handleFallback(url, failure.config);
        }
        return Left(failure);
      },
      (content) => Right(content),
    );
  }

  /// 处理回退
  Future<Either<Failure, String>> _handleFallback(
    String url,
    FallbackConfig config,
  ) async {
    switch (config.action) {
      case FallbackAction.webviewInteractive:
        return _webViewStrategy.fetch(url: url, timeout: config.timeout);
      case FallbackAction.abort:
        return Left(AbortFailure('Request aborted by fallback'));
    }
  }

  /// 执行单条 Pipeline
  dynamic _executePipeline(String input, List<String> pipeline) {
    dynamic value = input;
    for (final node in pipeline) {
      value = _executeNode(value, node);
    }
    return value;
  }

  /// 执行单个节点
  dynamic _executeNode(dynamic input, String node) {
    final parsed = parsePipelineNode(node);
    switch (parsed.type) {
      case NodeType.css:
        return _cssSelector(input, parsed.param);
      case NodeType.xpath:
        return _xpathSelector(input, parsed.param);
      case NodeType.text:
        return _extractText(input);
      case NodeType.attr:
        return _extractAttr(input, parsed.param);
      case NodeType.trim:
        return (input as String).trim();
      case NodeType.replace:
        return _replace(input, parsed.param);
      // ... 其他节点类型
    }
  }
}
```

### 5. WebView Interactive Strategy

用于需要用户手动操作的场景（登录、复杂验证码等）。

```dart
// lib/core/crawler/executor/webview_interactive_strategy.dart

/// 用户交互 WebView 策略
class WebViewInteractiveStrategy {
  final WebViewStrategy _webView;
  final SessionManager _sessionManager;

  WebViewInteractiveStrategy(this._webView, this._sessionManager);

  /// 获取内容 (用户交互)
  Future<Either<Failure, String>> fetch({
    required String url,
    required int timeout,
  }) async {
    try {
      // 1. 检查是否有保存的会话
      final session = await _sessionManager.loadSession(url);
      if (session != null) {
        // 尝试使用保存的 Cookie
        final result = await _tryWithSession(url, session);
        if (result.isRight()) {
          return result;
        }
      }

      // 2. 显示 WebView 让用户操作
      final completer = Completer<Either<Failure, String>>();

      await _webView.loadUrl(
        url,
        onComplete: (html) {
          completer.complete(Right(html));
        },
        onError: (error) {
          completer.complete(Left(WebviewFailure(error)));
        },
      );

      // 3. 等待用户完成或超时
      return completer.future.timeout(
        Duration(milliseconds: timeout),
        onTimeout: () => Left(TimeoutFailure('User interaction timeout')),
      );
    } on Exception catch (e) {
      return Left(WebviewFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> _tryWithSession(
    String url,
    Session session,
  ) async {
    // 使用保存的 Cookie 尝试请求
    await _webView.setCookies(session.cookies);
    // ... 尝试逻辑
  }
}
```

---

## Platform Support

| 平台 | HTTP (Rust wreq) | WebView Interactive | 说明 |
|------|------------------|---------------------|------|
| Windows | 支持 | 支持 (InAppWebView) | 官方 CI 验证 |
| macOS | 支持 | 支持 (InAppWebView) | 官方 CI 验证 |
| Linux | 支持 | 支持 (InAppWebView) | 官方 CI 验证 |
| Android | 支持 | 支持 (Both) | 官方 CI 验证 (cargo-ndk) |
| iOS | 支持 | 支持 (Both) | 社区验证，需配置 |
| Web | 支持 (WASM) | 支持 (Official) | flutter_rust_bridge WASM |

### iOS 特殊配置

iOS 平台需要额外配置：

```toml
# Cargo.toml - 避免 Debug 模式栈溢出
[profile.dev]
opt-level = 1
```

```bash
# 添加 iOS 目标
rustup target add aarch64-apple-ios aarch64-apple-ios-sim

# 编译
cargo build --target aarch64-apple-ios --release
cargo build --target aarch64-apple-ios-sim --release
```

**已知问题**:
- Debug 模式栈溢出：设置 `opt-level = 1` 或更新到 wreq-util v3.0.0-rc.2+
- Xcode 16.4+ bindgen：更新 bindgen 到最新版本

**策略选择建议**:
1. 优先使用 HTTP (Rust wreq) 策略
2. 遇到反爬 (403/Cloudflare) 时回退到 WebView Interactive
3. 移动端和桌面端策略一致

---

## Dependencies

### Rust (Cargo.toml)

```toml
[dependencies]
flutter_rust_bridge = "=2.11.1"

# HTTP 客户端 (TLS 指纹)
wreq = "6.0.0-rc.28"
wreq-util = "3.0.0-rc.10"

# 中文处理
jieba-rs = { version = "0.8.1", features = ["default-dict", "tfidf"] }
chinese-number = "0.7.8"
ferrous-opencc = "0.3.1"

# 相似度计算
textdistance = "1.1.1"

# 日志
log = "0.4.29"
```

### Dart (pubspec.yaml)

```yaml
dependencies:
  # 已有
  freezed: latest
  freezed_annotation: latest
  json_serializable: latest
  build_runner: latest
  relic: ^1.0.0

  # Rust FFI
  flutter_rust_bridge: ^2.11.1

  # Isolate 并行
  squadron: latest
  squadron_builder: latest

  # WebView (用户交互)
  flutter_inappwebview: ^6.2.0-beta.3
  webview_flutter: ^4.13.1
```

---

## Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| wreq 编译复杂 | 高 | 提供预编译脚本，CI/CD 自动构建 |
| BoringSSL 符号冲突 | 中 | 使用 prefix-symbols feature |
| WebView 交互体验 | 中 | 提供清晰的用户引导 |
| TLS 指纹被检测 | 中 | 定期更新 wreq-util 设备配置 |

---

## Implementation Notes

1. **wreq 编译**
   - Linux: 需要 build-essential, cmake, perl, pkg-config, libclang-dev
   - Windows: 需要 Visual Studio Build Tools
   - macOS: 需要 Xcode Command Line Tools

2. **Cookie 同步**
   - Rust HTTP 和 WebView 之间的 Cookie 需要手动同步
   - 使用 SessionManager 统一管理

3. **错误处理**
   - 所有错误使用 Either<Failure, T> 返回
   - 用户看到的错误信息需要国际化
