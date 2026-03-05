# Rust 生命周期执行器规范

## 目的

提供基于规则的高层 FFI API，执行完整的生命周期阶段（HTTP 请求、响应类型检测、数据解析、错误处理），返回结构化数据，简化 Dart 侧的调用复杂度。

---

## 核心需求

### Requirement: 生命周期阶段执行

系统 MUST 提供 `execute_lifecycle_phase()` FFI API，接受规则、阶段和上下文，返回结构化的阶段结果。

#### Scenario: 执行搜索阶段
- **WHEN** 调用 `execute_lifecycle_phase(rule, LifecyclePhase.search, PhaseContext { keyword: Some("关键词") })`
- **THEN** 系统：
  1. 根据规则构建搜索 URL（替换 `{{key}}` 变量）
  2. 使用规则中的网络配置发送 HTTP 请求
  3. 检测 WAF 拦截
  4. 检测响应类型（HTML/JSON/XML）
  5. 执行规则中定义的 Pipeline
  6. 返回 `PhaseResult { data: Some(PhaseData::Search(SearchData { ... })) }`

#### Scenario: 执行详情阶段
- **WHEN** 调用 `execute_lifecycle_phase(rule, LifecyclePhase.detail, PhaseContext { url: Some("https://...") })`
- **THEN** 系统返回结构化的详情数据

---

### Requirement: 响应类型自动检测

系统 MUST 通过 Content-Type header 自动检测响应类型（HTML/JSON/XML）。

#### Scenario: 自动检测 JSON 响应
- **WHEN** HTTP 响应的 Content-Type 为 `application/json`
- **THEN** 系统使用 JSON 解析器处理响应

#### Scenario: 自动检测 XML 响应
- **WHEN** HTTP 响应的 Content-Type 为 `application/xml` 或 `text/xml`
- **THEN** 系统使用 XML 解析器处理响应

#### Scenario: 默认为 HTML
- **WHEN** Content-Type 无法识别
- **THEN** 系统默认使用 HTML 解析器

---

### Requirement: 响应类型规则配置覆盖

系统 MUST 允许在规则中显式指定预期响应类型，覆盖自动检测。

#### Scenario: 规则配置覆盖
- **WHEN** 规则中指定 `content_type_override: Some(ContentType::Json)`
- **THEN** 系统使用 JSON 解析器，即使 Content-Type header 指示为 HTML

---

### Requirement: WAF 拦截检测

系统 MUST 自动检测 WAF 拦截（Cloudflare、Akamai 等）并返回特定错误类型。

#### Scenario: Cloudflare 拦截检测
- **WHEN** HTTP 响应状态码为 403/503 且包含 `cf-ray` 或 `cf-mitigated` header
- **THEN** 返回 `CrawlerError::AuthRequired` 错误

#### Scenario: 非 WAF 错误
- **WHEN** HTTP 响应状态码为 403/503 但不包含 WAF 标识 header
- **THEN** 返回普通 `HttpError` 错误

---

### Requirement: 结构化数据返回

系统 MUST 返回类型安全的结构化数据，而非原始字符串数组。

#### Scenario: 搜索结果结构化
- **WHEN** 执行搜索阶段成功
- **THEN** 返回 `PhaseData::Search(SearchData { items: Vec<SearchItem> })`，其中 `SearchItem` 包含 `title`、`url`、`cover` 等字段

#### Scenario: 详情数据结构化
- **WHEN** 执行详情阶段成功
- **THEN** 返回 `PhaseData::Detail(DetailData { ... })`

#### Scenario: 目录数据结构化
- **WHEN** 执行目录阶段成功
- **THEN** 返回 `PhaseData::Toc(TocData { chapters: Vec<Chapter> })`

---

## 数据结构需求

### Requirement: 生命周期阶段枚举

系统 MUST 定义 `LifecyclePhase` 枚举，包含以下阶段：
- `Explore` - 发现页
- `Search` - 搜索页
- `Detail` - 详情页
- `Toc` - 目录页
- `Content` - 内容页

#### Scenario: 阶段类型安全
- **WHEN** 调用 API 时传入无效阶段
- **THEN** 编译时报错（Rust 侧）或类型错误（Dart 侧）

---

### Requirement: 执行上下文结构

系统 MUST 定义 `PhaseContext` 结构，包含：
- `url: Option<String>` - 用于 detail/toc/content 阶段
- `keyword: Option<String>` - 用于 search 阶段
- `page: Option<u32>` - 用于 explore/search 阶段
- `vars: Option<HashMap<String, String>>` - 自定义变量

#### Scenario: 上下文字段验证
- **WHEN** 使用不匹配的阶段和上下文字段（如 search 阶段但未提供 keyword）
- **THEN** 返回 `CrawlerError::MissingRequiredContext` 错误

---

### Requirement: 执行结果结构

系统 MUST 定义 `PhaseResult` 结构，包含：
- `success: bool` - 是否成功
- `final_url: Option<String>` - 最终 URL（重定向后）
- `content_type: ContentType` - 响应类型
- `raw_body: Option<String>` - 原始响应体（调试用）
- `data: Option<PhaseData>` - 结构化数据
- `error: Option<CrawlerError>` - 错误信息

#### Scenario: 成功结果
- **WHEN** 阶段执行成功
- **THEN** `success: true`，`data: Some(...)`，`error: None`

#### Scenario: 失败结果
- **WHEN** 阶段执行失败
- **THEN** `success: false`，`data: None`，`error: Some(...)`

---

### Requirement: 阶段数据联合类型

系统 MUST 定义 `PhaseData` 枚举，对应各阶段的结构化数据：
- `Explore(ExploreData)`
- `Search(SearchData)`
- `Detail(DetailData)`
- `Toc(TocData)`
- `Content(ContentData)`

#### Scenario: 类型安全的数据访问
- **WHEN** Dart 侧访问 `PhaseResult.data`
- **THEN** 使用 switch/match 语句处理不同阶段类型

---

## 错误处理需求

### Requirement: 扩展错误类型

系统 MUST 扩展 `CrawlerError` 枚举，包含以下新错误：
- `MissingPhaseConfig { phase: String }` - 阶段配置缺失
- `UrlTemplateError { reason: String }` - URL 模板替换失败
- `UnsupportedContentType { content_type: String }` - 不支持的响应类型
- `DataParseError { reason: String }` - 数据解析失败
- `MissingRequiredContext { field: String }` - 缺少必需的上下文字段

#### Scenario: 缺少阶段配置
- **WHEN** 规则中未配置请求的阶段（如调用 search 但规则中 search 为 None）
- **THEN** 返回 `CrawlerError::MissingPhaseConfig { phase: "search" }`

#### Scenario: URL 模板错误
- **WHEN** URL 模板包含无效变量（如 `{{invalid}}`）且上下文中未提供
- **THEN** 返回 `CrawlerError::UrlTemplateError { reason: "缺少变量: invalid" }`

---

## 底层 API 需求

### Requirement: 底层 API 降级

系统 MUST 将现有底层 API（`fetch()`, `parse_html()`, `execute_pipeline()`）标记为内部使用（`pub(crate)`），仅在新 API 内部调用，不直接暴露给 Dart。

#### Scenario: 底层 API 可用性
- **WHEN** 从 Dart 侧调用
- **THEN** `fetch()` 等底层 API 不可见（移除 FRB 导出）

#### Scenario: 内部使用
- **WHEN** 在 Rust 内部实现中
- **THEN** 可以调用 `fetch()` 等底层 API

---

## 兼容性需求

### Requirement: 向后兼容过渡期

系统 SHOULD 在过渡期内保留底层 API 的内部实现，允许性能关键场景直接使用。

#### Scenario: 性能优化场景
- **WHEN** 需要极低延迟
- **THEN** 可在 Rust 内部直接使用底层 API（不暴露给 Dart）

---

## 性能需求

### Requirement: 性能不低于当前实现

系统 MUST 确保新 API 的性能不低于当前底层 API 实现。

#### Scenario: 性能基准
- **WHEN** 使用新 API 执行规则
- **THEN** 响应时间不超过使用底层 API 的实现

---

## 可测试性需求

### Requirement: 每个阶段可独立测试

系统 MUST 支持对每个生命周期阶段进行独立的单元测试。

#### Scenario: 搜索阶段测试
- **WHEN** 提供模拟的规则和上下文
- **THEN** 可以测试搜索阶段的完整流程

#### Scenario: 响应类型检测测试
- **WHEN** 提供不同 Content-Type 的模拟响应
- **THEN** 可以验证自动检测逻辑

---

## 扩展性需求

### Requirement: 支持新增阶段

系统 MUST 支持在未来添加新的生命周期阶段，而不破坏现有代码。

#### Scenario: 新增阶段
- **WHEN** 在 `LifecyclePhase` 枚举中添加新阶段
- **THEN** Dart 侧收到编译警告（match 不完整），而不是运行时错误

---

### Requirement: 支持新增响应类型

系统 MUST 支持在未来添加新的响应类型（如 YAML、Protocol Buffers）。

#### Scenario: 新增响应类型
- **WHEN** 在 `ContentType` 枚举中添加新类型
- **THEN** 可以通过扩展检测逻辑和解析器来支持
