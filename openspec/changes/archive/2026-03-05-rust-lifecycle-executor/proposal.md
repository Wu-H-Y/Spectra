## Why

当前 Rust FFI 暴露的是底层接口（HTTP 请求、HTML 解析等），Dart 侧需要手动编排 HTTP + 解析 + 错误处理流程，导致代码重复、维护困难且容易不一致。此外，当前 API 只支持 HTML 数据格式，无法处理 JSON/XML 响应。

需要将 Rust API 提升为基于规则的高层抽象，让 Rust 侧负责完整的执行流程（HTTP 请求、响应类型检测、解析、错误处理），Dart 侧只需调用一个简单的 API 即可获得结构化数据。

## What Changes

- **新增 Rust FFI API**: `execute_lifecycle_phase(rule, phase, context) -> Result<PhaseResult, CrawlerError>`
  - 执行规则的指定生命周期阶段（explore/search/detail/toc/content）
  - 支持三种响应类型：HTML/JSON/XML
  - **响应类型检测策略**：
    - 自动检测：通过 Content-Type header 自动判断响应类型
    - 规则配置：允许在规则中显式指定预期类型（覆盖自动检测）
  - 内置 WAF 拦截检测（403/503 + Cloudflare headers）
  - 返回结构化数据（SearchData/DetailData/TocData 等）

- **废弃底层 API**：移除或降级 `fetch()`, `parse_html()`, `execute_pipeline()` 等底层接口

- **简化现有 changes**：
  - `dart-http-strategy`: 不再需要独立的 HTTP 策略层
  - `webview-interactive-strategy`: 简化回退逻辑，Rust 侧自动返回 AuthRequired 错误
  - `source-aggregation-engine`: 可使用新 API 简化调用（或移到 Rust 侧）

## Capabilities

### New Capabilities

- `rust-lifecycle-executor`: 基于规则的高层 FFI API，执行完整的生命周期阶段并返回结构化数据

### Modified Capabilities

- `crawler-rule-executor`: 执行器将使用新的 `execute_lifecycle_phase()` API 而非手动编排底层调用
- `http-strategy`: 降级为内部实现细节，不再对外暴露

## Impact

### 新增文件
- `rust/src/api/lifecycle_executor.rs`: 核心实现
  - `execute_lifecycle_phase()` 主函数
  - 响应类型检测逻辑
  - WAF 拦截检测
  - 结构化数据转换

- `rust/src/domain/phase.rs`: 阶段相关类型定义
  - `LifecyclePhase` 枚举
  - `PhaseContext` 结构
  - `PhaseResult` 结构
  - `PhaseData` 枚举
  - 各阶段数据结构（SearchData/DetailData/TocData/ContentData）

### 修改文件
- `rust/src/api/mod.rs`: 导出 lifecycle_executor 模块
- `rust/src/api/html_parser.rs`: 标记为内部使用，移除 FRB 导出
- `rust/src/api/http_client.rs`: 标记为内部使用，移除部分 FRB 导出

### Dart 侧影响
- `lib/core/rust/api/`: 自动生成新的 Dart 类型
- `lib/core/crawler/`: 简化规则执行逻辑，使用新 API

## Success Criteria

- [ ] `execute_lifecycle_phase()` API 可从 Dart 调用
- [ ] 支持 HTML/JSON/XML 三种响应类型
- [ ] 响应类型自动检测工作正常（通过 Content-Type）
- [ ] 响应类型可通过规则配置覆盖
- [ ] WAF 拦截能正确检测并返回 `AuthRequired` 错误
- [ ] 返回的结构化数据可被 Dart 正确解析
- [ ] 现有规则无需修改即可使用新 API
- [ ] 性能不低于当前实现（底层 API 仍可用）
