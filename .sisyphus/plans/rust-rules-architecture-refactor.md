# Rust 规则引擎与可视化编辑架构重构（全栈）

## TL;DR
> **Summary**: 用“版本化规则 IR + 强校验 + 有端口/类型的图执行 + 节点事件流”重建 Spectra 规则体系，并打通 Flutter 存储/HTTP API 与 Web-editor 节点化编辑、固定 Flutter 页面渲染。
> **Deliverables**:
> - Rust：新规则 IR（版本化）+ Validator + Graph Engine + NodeEvent 流 + 规范化内容模型
> - Flutter：规则 CRUD/Validate/Execute/Preview API + WS 转发 + DB schema 版本字段 + 固定模板页面渲染入口
> - Web-editor：切换到新 IR 类型 + 节点图编辑器 + 流式调试面板（节点级输出/错误/溯源）
> **Effort**: XL
> **Parallel**: YES - 6 waves
> **Critical Path**: 旧代码清理/现状冻结 → IR/协议定稿 → Rust 引擎可跑 → Flutter API/存储打通 → Web-editor 节点图 UI → 固定模板渲染

## Context
### Original Request
- 完全重构 Rust 规则与架构；吸收 Legado 等经验；规则更全面；支持固定模板渲染；支持节点流式可视化编辑；更符合 Rust 规范。

### Interview Summary
- 范围：全栈（Rust + Flutter server/storage + web-editor）；如 Flutter 壳层确有阻塞，可另做 Tauri2 评估。
- 渲染：固定 Flutter 页面（规则产出规范化模型）。
- 可视化：至少“节点级流式结果”。
- 旧规则：不兼容 `web-editor/public/sample-rules.json` 旧 schema。
- 新增重点：对标 Legado 教程中的能力集（cache/cookie/编解码/加密解密/变量 put-get/网页交互），并增强反爬处理（验证码、Cloudflare/WAF）。
- WebView 能力（用于“合规的用户交互式登录/挑战处理→获取并复用 Cookie”）：桌面端默认用 Playwright/Chromium runner；移动端必须支持 Flutter WebView（优先 `flutter_inappwebview`）提交 cookies；Linux 桌面 Flutter WebView（`flutter_inappwebview` 6.2.0-beta.3 起）仅作为 gated spike 验证，不作为主路径。

### Repo Findings（Task 0 之前的现状，仅用于背景）
- Rust 现状（将被 Task 0 删除，不作为复用依据）：
  - 规则域模型：`rust/src/domain/rule/*`（`PipelineGraph` + `NodePayload`）。
  - 执行：`rust/src/api/lifecycle_executor.rs`（拓扑→线性 `PipelineOperation`）+ `rust/src/internal/html_parser.rs` 顺序执行。
- Flutter server 现状：仅 `lib/core/server/server_provider.dart` 提供 `/api/server/*` + `/ws` 与静态 editor 资源（`assets/editor`）；未发现 web-editor 期望的 `/api/rules|validate|execute|preview/open`。
- Web-editor 现状：实际使用自定义 schema：`web-editor/src/api/types.ts` + `web-editor/public/sample-rules.json`，与 Rust ts-rs 生成的 `web-editor/src/types/rule.ts` 不一致。
- DB 现状：`lib/core/database/drift/tables/crawl_rules.dart` 已预留 `config/globalConfig/displayConfig`，但未发现完整 CRUD/业务使用链路。

### External Research (to verify during execution)
- Legado 经验点（以官方教程为准，执行阶段需再核对实现细节）：https://mgz0227.github.io/The-tutorial-of-Legado/Rule/source.html
- Oracle 建议：采用“RuleSource→RuleIR→RulePlan + Validator + 可观测图执行 + NodeEvent 事件流 + 规范化内容模型映射层”。
- Tauri v2.4.0 cookie API（用于 gated spike，执行阶段需核对平台差异/已知问题）：https://v2.tauri.app/release/tauri/v2.4.0/
- wry/tauri cookie 已知限制（用于 gated spike 风险评估，执行阶段需核对最新状态）：https://github.com/tauri-apps/wry/issues/785
- `flutter_inappwebview` 6.2.0-beta.3 Linux 支持（用于 gated spike，执行阶段需核对依赖与能力覆盖）：https://pub.dev/packages/flutter_inappwebview/versions/6.2.0-beta.3

## Work Objectives
### Core Objective
建立一套 Rust-idiomatic 的规则体系与执行引擎：
- 规则 = 版本化 IR（可迁移、可诊断、可视化编辑友好）
- 执行 = typed-port graph runtime（可流式事件、可溯源、可控资源）
- 输出 = 规范化内容模型（固定 Flutter 页面渲染稳定）

### Definition of Done（可验证）
- `cargo test` 在 `rust/` 通过。
- `cargo clippy --all-targets --all-features -- -D warnings` 在 `rust/` 通过。
- `flutter analyze --fatal-infos` 通过。
- `flutter test` 通过。
- `web-editor`：`bun run lint`、`bun run build` 通过。
- 启动 Flutter 内置 server 后（端口由 `/api/server/status` 返回）：
  - `GET /api/rules`、`POST /api/rules`、`PUT /api/rules/:id`、`DELETE /api/rules/:id` 可用。
  - `POST /api/rules/validate` 返回结构化诊断（含 nodeId/path/code/message）。
  - `POST /api/rules/execute` 返回 `runId`，并在 `/ws` 推送带单调递增 `seq` 的 `NodeEvent`。
  - Web-editor 能加载/编辑/执行一条示例规则，并在节点图上实时看到节点中间结果与错误定位。
  - Flutter 固定页面能用同一份“规范化内容模型”渲染至少 `Search → Detail → Toc → Content` 的基础字段。
  - 当命中 WAF/验证码/需要交互时：
    - execute 返回结构化错误（例如 `ChallengeRequired`），NodeEvent 给出可执行的下一步提示（例如启动交互式会话）。

### Must NOT Have（护栏）
- 不引入旧 schema 兼容层（不支持导入 `sample-rules.json` 旧结构）。
- 不保留 `rust/src/` 下的旧模块树（最终仅允许手写 `rust/src/lib.rs`；`rust/src/frb_generated.rs` 为生成文件，可删除并按需重新生成）。
- 不在第一轮实现多人协作/CRDT（默认单用户本地编辑；多客户端仅订阅调试事件）。
- 不在主线中切换到 Tauri2（仅作为 gated spike）。
- 不把编辑器预览/选元素能力绑定到 Flutter WebView（编辑器预览优先可控 Chromium 方案）。
- 不提供或记录任何用于“绕过/破解/规避”验证码或访问控制的具体实现步骤；仅支持合规的交互式登录/挑战处理、会话复用、诊断与速率控制；交互式会话默认禁止 headless 自动化登录脚本（必须由用户手动完成）。

## Verification Strategy
- 测试策略：tests-after（先定协议/IR，再补齐单测与端到端 smoke）。
- 证据输出：每个关键任务写入 `.sisyphus/evidence/task-{N}-{slug}.md`（包含命令、输出摘要、截图/日志路径）。

## Execution Strategy
### Parallel Execution Waves
Wave 1（旧代码清理 + 契约定稿）: 旧代码清理/现状冻结 + IR v1 + NodeEvent 协议 + API 契约 + DB schema 版本策略
Wave 2（Rust 核心）: Validator + Engine（typed ports）+ NodeEvent 产出 + 规范化模型
Wave 3（Flutter 后端）: DB CRUD + HTTP API + WS 转发 + preview 打通
Wave 4（Web-editor）: 切换类型 + 节点图 UI + 调试面板 + 与后端协议对接
Wave 5（固定模板渲染）: Flutter 固定页面消费规范化模型 + 最小渲染闭环
Wave 6（加固与收尾）: 性能/资源配额/安全（JS）+ 文档 + 回归

### Dependency Matrix (high level)
- 旧代码清理（0）→ IR/协议（1）→ Rust 引擎（2）→ Flutter API（3）→ Web-editor UI（4）→ Flutter 模板页面（5）→ 加固（6）



## TODOs
> 说明：每个任务“实现+测试/验证”必须同一个任务完成。

- [ ] 0. 旧代码清理（第一步）：直接删除旧 Rust 实现与现有生成物（Flutter/Web）并搭建新 workspace 骨架

  **What to do**:
  - 决策（已确认）：项目初建阶段不需要旧规则数据兼容；旧 Rust 代码不保留，直接删除，全部按新架构重写。
  - 目标（强约束）：
    - 最终 `rust/src/` 目录只允许存在手写 `lib.rs`；`frb_generated.rs` 作为生成文件允许存在或删除后重生。
    - 最终 Flutter 侧不再保留旧 FRB 生成物：删除 `lib/core/rust/**`（后续在新 IR/新 FFI 完成后再重新生成）。
    - 最终 Web-editor 侧不再保留旧 Rust 生成 TS 类型：删除 `web-editor/src/types/rule.ts`（后续由新 IR 重新生成）。
  - 具体步骤（必须按顺序，且每步都要保证 Flutter/Rust 编译链路不被卡死）：
    1) 删除旧 Rust 源码（一次性清空）：删除 `rust/src/` 下除 `lib.rs` 外的所有手写源码与目录（`api/ domain/ executor/ internal/ error.rs` 等）。
       - `rust/src/frb_generated.rs` 直接删除（生成文件），后续需要 FRB 时再生成。
    1.1) 将 `rust/src/lib.rs` 改为“最小可编译门面”（决策已定）：
       - 仅保留一个空的内联模块以占位 FRB 入口：`pub mod api {}`
       - 不再 `pub mod domain;` / `pub mod executor;` 等引用已删除的模块
    2) 将 `rust/` 调整为 workspace（crate + workspace 同文件）：保留根 crate `[package]`（`spectra_native` 仍是 cdylib/staticlib），新增 `[workspace]` 并注册新 crates（先建空骨架即可）。
    3) 立即创建并注册新架构 crates（空实现但可编译）：
       - `rust/crates/rules_ir`
       - `rust/crates/rules_validate`
       - `rust/crates/rules_engine`
       - `rust/crates/io_http`
       - `rust/crates/ffi`
    4) 删除 Flutter 侧旧 FRB 生成物与其唯一引用点：
       - 删除整个目录：`lib/core/rust/**`（含 `frb_generated.dart`、`api/*`、`domain/*` 等）。
       - 删除 `lib/core/crawler/phase_executor.dart`（当前唯一直接 import 旧 FRB 生成物的文件）。
    5) 删除 Web-editor 侧旧 Rust 生成 TS 类型：删除 `web-editor/src/types/rule.ts`（当前未被引用，但会误导后续重构）。
    6) FRB 配置文件处理（决策已定）：
       - 保留 `flutter_rust_bridge.yaml` 但不再运行生成；后续在 Task 10（新 `crates/ffi` API 明确后）再恢复生成 `lib/core/rust/**`。
       - `pubspec.yaml` 中的 `flutter_rust_bridge` 与 `spectra_native` 依赖先保留（不影响编译），避免后续版本漂移；如要彻底移除依赖，必须同步更新 `rust_builder` 与构建脚本（不在 Task 0 范围）。

  - 重要说明：本任务是“硬重置基线”。从此开始，旧实现彻底消失；任何需要的能力都由后续任务在新 crates 中重写。

  **Must NOT do**:
  - 不尝试从旧代码中“迁移/复用”实现（决策已定：全部重写）。
  - 不把任何手写实现留在 `rust/src/**`（`lib.rs` 例外；`frb_generated.rs` 为生成文件例外）。

  **Recommended Agent Profile**:
  - Category: `unspecified-high` — Reason: workspace/FRB/Flutter 编译链路改动面大，需一次性梳理到可编译。
  - Skills: `[]`

  **Parallelization**: Can Parallel: NO | Wave 1 | Blocks: 1-33 | Blocked By: -

  **References**:
  - FRB 配置（本任务不运行生成）：`flutter_rust_bridge.yaml`
  - 根 crate：`rust/Cargo.toml`
  - `rust/src/lib.rs`（Task 0 后仅保留此手写文件）：`rust/src/lib.rs`

  **Acceptance Criteria** (agent-executable):
  - [ ] `cargo test`（在 `rust/`）通过。
  - [ ] `cargo clippy --all-targets --all-features -- -D warnings`（在 `rust/`）通过。
  - [ ] `rust/src/` 下除 `lib.rs` 外不再存在任何手写 `.rs` 文件（`frb_generated.rs` 例外）。
  - [ ] `flutter analyze --fatal-infos` 通过（避免 Dart 侧因 FRB 生成物变化导致编译失败）。
  - [ ] `rg "core/rust" lib` 0 命中（确保旧生成物引用彻底清除）。

  **QA Scenarios**:
  ```
  Scenario: Rust workspace 与 FRB 入口可编译
    Tool: Bash
    Steps:
      - 在 rust/ 运行 cargo test
      - 在 rust/ 运行 cargo clippy --all-targets --all-features -- -D warnings
      - 检查 rust/src 目录仅剩 lib.rs（以及可能的 frb_generated.rs）
      - 在 repo 根运行 flutter analyze --fatal-infos
      - rg "core/rust" lib
    Expected: 命令退出码 0；目录结构符合约束
    Evidence: .sisyphus/evidence/task-0-rust-hard-reset.md
  ```

  **Commit**: YES | Message: `refactor(rust): delete legacy rust code and scaffold new workspace` | Files: `rust/**`, `flutter_rust_bridge.yaml`（如需）

- [ ] 1. 定稿 IR v1（RuleIR + 版本封套）与 schemaVersion 策略

  **What to do**:
  - 定义 `RuleEnvelope { irVersion, metadata, graph, normalizedOutputs, capabilities }` 的 JSON 结构与版本号策略（硬切/升级函数）。
  - 明确：生命周期阶段（Explore/Search/Detail/Toc/Content）在 IR 中的表达（子图或阶段入口）。
  - 明确：端口类型系统（Text/Html/Json/Url/List/Record/NormalizedModel）。

  **Must NOT do**:
  - 不引入旧 web-editor schema 映射。

  **Recommended Agent Profile**:
  - Category: `deep` — Reason: 需要把 IR/验证/执行/编辑器契约一次定清。
  - Skills: `[]`

  **Parallelization**: Can Parallel: NO | Wave 1 | Blocks: 2-30 | Blocked By: 0

  **References**:
  - Greenfield：Task 0 后不再依赖/复用旧 Rust 代码
  - DB placeholder fields: `lib/core/database/drift/tables/crawl_rules.dart`
  - Legado tutorial: https://mgz0227.github.io/The-tutorial-of-Legado/Rule/source.html

  **Acceptance Criteria**:
  - [ ] 新 IR v1 在文档中完整描述（字段/类型/示例 JSON）。
  - [ ] 明确升级策略：同 major 是否兼容、如何处理破坏性变更。

  **QA Scenarios**:
  ```
  Scenario: IR 示例可被反序列化
    Tool: Bash
    Steps: 构造 fixtures/ir_v1_min.json（最小可执行图），运行 rust 单测解析
    Expected: 单测通过，diagnostics 为空
    Evidence: .sisyphus/evidence/task-1-ir-v1.md

  Scenario: 非法 IR 被诊断
    Tool: Bash
    Steps: 构造 fixtures/ir_v1_invalid_edge.json（类型不匹配/断边/环），运行 validator
    Expected: 返回 errors 且包含 nodeId/path/code
    Evidence: .sisyphus/evidence/task-1-ir-v1-invalid.md
  ```

  **Commit**: YES | Message: `feat(rules-ir): define v1 rule envelope schema` | Files: `rust/`（新 IR 类型与序列化）, `fixtures/`, `docs/`

- [ ] 2. 定稿 NodeEvent 流协议（WS 消息结构 + seq + reconnect）

  **What to do**:
  - 定义 `NodeEvent` 枚举：RunStarted/NodeStarted/PortEmit/NodeLog/NodeError/NodeFinished/RunFinished。
  - 规定 `runId`、`seq`（单调递增）、`traceId/spanId`、`nodeId/port`、payload preview 截断规则。
  - 定义心跳（ping/pong）与断线策略；定义是否支持“补拉最近 N 条”（默认：内存 ring buffer）。
  - 统一 WS 外层封套（决策已定，执行时不再讨论）：
    - `WsMessageV1 = { v: 1, type: string, data?: unknown }`
    - 服务端→客户端：必须带 `v=1`；客户端→服务端：允许缺省 `v`（兼容早期实现），但服务端会按 v1 语义解析。
  - WS 安全握手（决策已定）：
    - 连接建立后，客户端第一条消息必须为 `{v:1,type:"auth",data:{token}}`；未鉴权前服务端拒绝执行任何命令类消息（start_selection/commit 等）。
    - `token` 来源：`GET /api/server/status`（任务 3 中定义新增字段）。
  - WS 消息类型集合（v1）：
    - `node_event`（NodeEvent 流）
    - `session_event`（交互式会话：opened/committed/closed/error）
    - `preview_event`（预览/选元素：selection_started/selection_cancelled/element_selected/screenshot）
    - `subscribe`/`unsubscribe`（按 runId/sessionId/previewSessionId 订阅过滤，避免全量广播）

  **Must NOT do**:
  - 不做持久化 event store（仅内存 ring buffer）。

  **Recommended Agent Profile**:
  - Category: `deep` — Reason: 协议一旦定错会连锁返工。
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 1 | Blocks: 9-30 | Blocked By: 1

  **References**:
  - Existing WS: `lib/core/server/server_provider.dart`

  **Acceptance Criteria**:
  - [ ] 协议文档包含 JSON 示例与字段含义。
  - [ ] 明确事件顺序与丢弃/backpressure 行为。
  - [ ] 明确 WS 鉴权与订阅过滤规则（含示例）。

  **QA Scenarios**:
  ```
  Scenario: WS event 顺序
    Tool: Bash
    Steps: 用 node 脚本连接 ws://localhost:<port>/ws，触发一次 execute，记录 seq
    Expected: seq 严格递增；同 runId 的事件不交错破坏顺序
    Evidence: .sisyphus/evidence/task-2-nodeevent-order.md
  ```

  **Commit**: YES | Message: `feat(protocol): add nodeevent v1 spec and examples` | Files: `docs/`, `rust/`（事件类型/测试）, `web-editor/`（ws 消费契约）

- [ ] 3. 定义 HTTP API 契约（rules CRUD/validate/execute/preview）

  **What to do**:
  - 定义 endpoints、request/response、错误码、诊断结构（path/code/message/nodeId）。
  - 明确 `/api/server/status` 与新 `/api/*` 的关系（同一 server 下挂载）。
  - 定义 preview 打开页面与 selector 选择的消息流（与现有 element_selected 兼容或版本化）。
  - 将交互式会话与 cookie commit 纳入 API 契约（与任务 35-37 对齐）：
    - `POST /api/sessions`（创建交互式会话）
    - `POST /api/sessions/{sessionId}/commit-cookies`（提交 cookies 到规则 CookieJar，不返回明文）
    - `DELETE /api/sessions/{sessionId}`（关闭会话）
  - 将 preview API 补齐到契约并与 web-editor 现状对齐：
    - `POST /api/preview/open`
    - `POST /api/preview/test-selector`
  - API/WS 鉴权（决策已定）：
    - `GET /api/server/status` 增加 `serverToken` 字段；除 `/api/server/status` 外，所有 `/api/*` 必须携带 `Authorization: Bearer <serverToken>`。
    - `/ws` 必须先发 `auth` 消息（任务 2）。
  - 网络暴露策略（决策已定）：服务端默认仅绑定 `127.0.0.1`；如需 LAN 访问必须显式开关并在 UI 提示风险。

  **Must NOT do**:
  - 不以旧 web-editor schema 作为契约权威；以新 IR + 引擎语义为准。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 1 | Blocks: 10-30 | Blocked By: 1-2

  **References**:
  - Existing server routes: `lib/core/server/routes/server_routes.dart`
  - Existing client: `web-editor/src/api/client.ts`

  **Acceptance Criteria**:
  - [ ] API 文档包含 curl 示例（list/create/update/validate/execute）。
  - [ ] API 文档包含 session/preview 的 curl 示例（含鉴权 header）。

  **QA Scenarios**:
  ```
  Scenario: validate 返回结构化错误
    Tool: Bash
    Steps: curl POST /api/rules/validate -d @fixtures/ir_v1_invalid_edge.json
    Expected: HTTP 200 + valid=false + errors[] 含 code/path/nodeId
    Evidence: .sisyphus/evidence/task-3-validate-contract.md
  ```

  **Commit**: YES | Message: `docs(api): specify rules CRUD/validate/execute/preview contracts` | Files: `docs/`

- [ ] 4. DB 存储契约与 drift schema 版本字段设计

  **What to do**:
  - 在 `CrawlRules` 的 `config/globalConfig/displayConfig` 基础上，定义“新规则存储最小字段集”：
    - `irVersion`（整数或语义化字符串）
    - `ruleEnvelopeJson`（新 IR 全量 JSON）
    - `displayConfigJson`（固定 Flutter 模板渲染所需的展示配置，可为空）
    - `capabilities`/`enabled`/`updatedAt` 等元数据
  - 新增规则级持久化能力字段（对标 Legado cookie/cache 能力的可持续使用）：
    - `cookieJarEncrypted`：规则级 CookieJar（跨应用重启）
    - `kvStoreEncrypted`：规则级 KV store（跨应用重启；CacheGet/CachePut 的 rule scope 依赖此字段）
  - 加密策略（决策已定，执行时不再讨论）：
    - Flutter 端使用平台安全存储保存“设备主密钥”（建议 `flutter_secure_storage`）
    - 用主密钥派生 per-rule 数据密钥（HKDF 或等价）
    - 对 `cookieJarEncrypted` 与 `kvStoreEncrypted` 使用 AEAD（优先 ChaCha20-Poly1305，其次 AES-GCM）
  - 明确“旧记录处理策略”：旧字段不迁移，标记为 legacy 并在 UI 不展示（硬切）。
  - 设计 drift migration（新增列/默认值/索引）。

  **Must NOT do**:
  - 不尝试把旧 schema 自动转换为新 IR。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: [`flutter-dart-guide`] — Reason: drift 迁移与 Flutter 侧读写契约。

  **Parallelization**: Can Parallel: YES | Wave 1 | Blocks: 11-16, 21-22 | Blocked By: 1-3

  **References**:
  - Table: `lib/core/database/drift/tables/crawl_rules.dart`
  - Migration: `lib/core/database/drift/app_database.dart`

  **Acceptance Criteria**:
  - [ ] drift migration 方案写入计划（from/to 版本、列定义、默认值、旧数据处理）。
  - [ ] 加密/解密最小单测：同一 ruleId 写入 cookieJarEncrypted 后可成功解密并恢复。

  **QA Scenarios**:
  ```
  Scenario: DB 迁移可用
    Tool: Bash
    Steps: flutter test（含数据库打开/迁移用例，如无则补齐最小迁移单测）
    Expected: schemaVersion 升级不抛异常
    Evidence: .sisyphus/evidence/task-4-drift-migration.md
  ```

  **Commit**: YES | Message: `feat(db): add rule ir storage fields` | Files: `lib/core/database/drift/tables/crawl_rules.dart`, `lib/core/database/drift/app_database.dart`

- [ ] 5. Rust crate 重组（workspace + 清晰模块边界）

  **What to do**:
  - 前置说明：Task 0 已完成“旧实现删除 + workspace 骨架”；本任务负责把 crate 边界与依赖关系做实，并把根 crate 的 FRB 入口稳定为“薄门面”。
  - 在 workspace 中新增并注册以下 crates（仅建骨架 + Cargo 依赖边界，不引入业务功能）：
    - `crates/rules_ir`（RuleEnvelope/Graph/Node/Port/Diagnostics/NormalizedModel）
    - `crates/rules_validate`（validator/plan compiler）
    - `crates/rules_engine`（runtime + NodeEvent + provenance）
    - `crates/io_http`（wreq 封装、rate limit、缓存键）
    - `crates/ffi`（FRB 暴露面，尽量薄）
    - 顶层 `spectra_native` 作为 cdylib/staticlib facade
  - 约束（决策已定）：
    - 只有 `crates/ffi` 暴露 Flutter 侧会调用的 Rust API；其他 crates 不依赖 Flutter。
    - `rust/src` 仍只允许 `lib.rs`（手写）+ `frb_generated.rs`（生成）。
  - FRB 入口策略（决策已定，避免生成规则变化太大）：
    - 保持 `flutter_rust_bridge.yaml` 的 `rust_input: crate::api`。
    - 根 crate 的 `crate::api` 模块在 `rust/src/lib.rs` 内联定义，仅做薄转发：`pub fn/async fn` 调用 `crates/ffi` 中的实现。
    - 禁止引入任何 `legacy_*` 过渡 crate；旧实现已在 Task 0 删除，新代码一律写入 `crates/*`。

  **Must NOT do**:
  - 不在重组阶段引入新功能；先保证编译/测试绿。

  **Recommended Agent Profile**:
  - Category: `unspecified-high` — Reason: 需要细致搬迁与依赖梳理。
  - Skills: [`rust-ffi-guide`] — Reason: 确保 FRB 生成与 crate 边界不破。

  **Parallelization**: Can Parallel: NO | Wave 2 | Blocks: 6-10 | Blocked By: 0

  **References**:
  - Current root crate: `rust/Cargo.toml`
  - Current modules: `rust/src/lib.rs`

  **Acceptance Criteria**:
  - [ ] `cargo test` 通过（以新 crates 的最小单测/编译测试为准）。
  - [ ] `rust/src/` 仍符合“仅 `lib.rs`（手写）+ 生成文件”约束。

  **QA Scenarios**:
  ```
  Scenario: workspace 编译与测试
    Tool: Bash
    Steps: 在 rust/ 运行 cargo test
    Expected: 退出码 0
    Evidence: .sisyphus/evidence/task-5-rust-workspace.md
  ```

  **Commit**: YES | Message: `refactor(rust): scaffold new workspace crates and ffi facade` | Files: `rust/Cargo.toml`, `rust/crates/**`, `rust/src/lib.rs`, `flutter_rust_bridge.yaml`（如需）

- [ ] 6. 实现 RuleEnvelope/Graph/Port/Type 系统（Rust）并导出 TS/Dart

  **What to do**:
  - 在 `rules_ir` 定义：
    - `DataType`（强类型端口）
    - `PortRef`（nodeId+portName）
  - `NodeKind`（Fetch/Parse/Select/Transform/Join/Branch/MapToModel/Loop/Filter/Assert 等，至少覆盖当前能力 + 映射到规范化模型）
    - `Graph`（nodes/edges + metadata + layout）
    - `Diagnostic`（code/severity/path/nodeId/message）
    - `NormalizedModel`（Search/Detail/Toc/Content + media 扩展）
  - 使用 `serde` + `#[serde(tag="type")]`（或等价明确 tag）+ `rename_all = "camelCase"`，确保 TS/Dart 友好。
  - 用 `ts-rs` 导出到 `web-editor/src/types/rule.ts`（替换/废弃旧 `web-editor/src/api/types.ts` 的规则部分）。
  - 用 FRB 生成 Dart models（落到 `lib/core/rust/domain/rule/*` 或新路径）。

  **Must NOT do**:
  - 不把生成产物与手写类型混用；以 Rust 为单一真源。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: [`rust-ffi-guide`] — Reason: FRB/ts-rs 导出契约很容易踩坑。

  **Parallelization**: Can Parallel: NO | Wave 2 | Blocks: 7-22 | Blocked By: 5

  **References**:
  - Existing ts-rs export pattern（旧实现已删除；需重新实现 ts-rs 导出模式）：从 `ts-rs` 官方示例/仓库内新 crate 代码为准。
  - Existing generated TS: `web-editor/src/types/rule.ts`

  **Acceptance Criteria**:
  - [ ] TS 侧能 import 新类型并通过 `web-editor` build。
  - [ ] Dart 侧能反序列化 RuleEnvelope JSON。

  **QA Scenarios**:
  ```
  Scenario: TS 类型可编译
    Tool: Bash
    Steps: web-editor 下 bun run build
    Expected: 退出码 0
    Evidence: .sisyphus/evidence/task-6-ts-build.md

  Scenario: Dart JSON 反序列化
    Tool: Bash
    Steps: flutter test（添加最小 JSON roundtrip 用例）
    Expected: 通过
    Evidence: .sisyphus/evidence/task-6-dart-json.md
  ```

  **Commit**: YES | Message: `feat(rules-ir): add typed graph ir and exports` | Files: `rust/`（rules_ir）, `web-editor/src/types/rule.ts`, `lib/core/rust/domain/rule/*`

- [ ] 7. Validator v1：结构校验 + 类型校验 + 拓扑/环检测 + capability 校验

  **What to do**:
  - 实现：
    - 节点/端口存在性与边合法性
    - DataType 兼容性
    - DAG 校验（允许哪些环：默认不允许；如需要 Loop 节点则显式）
    - capability gate：JS/HTTP/Proxy/WebView 等是否允许
  - 输出 `Vec<Diagnostic>`，并保证错误码稳定。

  **Must NOT do**:
  - 不把校验失败变成 panic；必须返回 diagnostics。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 2 | Blocks: 8-22 | Blocked By: 6

  **References**:
  - Diagnostic 类型（Task 6 产出）：`rust/crates/rules_ir/src/diagnostic.rs`

  **Acceptance Criteria**:
  - [ ] fixtures 中至少覆盖：断边、类型不匹配、未知节点、环。

  **QA Scenarios**:
  ```
  Scenario: validator fixtures
    Tool: Bash
    Steps: cargo test -p rules_validate
    Expected: 通过
    Evidence: .sisyphus/evidence/task-7-validator.md
  ```

  **Commit**: YES | Message: `feat(rules-validate): add v1 validator diagnostics` | Files: `rust/`（rules_validate）, `fixtures/`

- [ ] 8. Graph Engine v1：单机执行 + bounded channels + NodeEvent 产出

  **What to do**:
  - 以 `tokio` 实现 runtime：每个 node 一个 task，边用有界队列传递。
  - 最小执行语义：线性链 + 简单分叉（fan-out）+ Join(First/Last/Join/Array) 复刻现有能力。
  - 每个节点产出 `NodeEvent`，携带 `runId/seq/traceId/nodeId`。
  - 引擎输出：
    - `runResult`（最终 NormalizedModel 或阶段结果）
    - `stats`（每节点耗时/条数/错误数）

  **Must NOT do**:
  - 不做持久化任务队列/分布式。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: `[]`

  **Parallelization**: Can Parallel: NO | Wave 2 | Blocks: 9-22 | Blocked By: 6-7

  **References**:
  - Engine 与事件类型（Task 6/7 之后的新代码）：`rust/crates/rules_engine/src/**`

  **Acceptance Criteria**:
  - [ ] 对“链式图”执行结果与 fixtures 中的期望输出一致（同输入 HTML/JSON）。
  - [ ] NodeEvent `seq` 单调递增。

  **QA Scenarios**:
  ```
  Scenario: 链式图 fixtures 一致性
    Tool: Bash
    Steps: cargo test -p rules_engine（用 fixtures 驱动测试并断言输出）
    Expected: 输出与 fixtures 期望一致
    Evidence: .sisyphus/evidence/task-8-engine-parity.md
  ```

  **Commit**: YES | Message: `feat(rules-engine): add typed graph runtime and node events` | Files: `rust/`（rules_engine）, `fixtures/`

- [ ] 9. 规范化内容模型（NormalizedModel）与固定 Flutter 页面字段集定稿

  **What to do**:
  - 定义最小字段集（用于固定页面渲染）：
    - Search: items(title, url, cover?, author?)
    - Detail: title, cover?, author?, description?, tags?
    - Toc: chapters(title, url?)
    - Content: contentTextHtml/plain + mediaAssets[]
  - 明确 media 扩展（video/music/novel/comic/image）以“可选扩展字段”方式实现。
  - 规则引擎输出必须落在该模型（而不是散乱的 string list）。

  **Must NOT do**:
  - 不在 UI 端依赖抓取中间结果结构。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: [`flutter-dart-guide`] — Reason: 固定页面渲染字段需要 Flutter 侧落地。

  **Parallelization**: Can Parallel: YES | Wave 2 | Blocks: 20-22 | Blocked By: 1,6

  **References**:
  - NormalizedModel 定义位置（Task 6/9 新代码）：`rust/crates/rules_ir/src/normalized_model.rs`

  **Acceptance Criteria**:
  - [ ] Rust/TS/Dart 三端类型一致并能序列化。

  **QA Scenarios**:
  ```
  Scenario: NormalizedModel JSON roundtrip
    Tool: Bash
    Steps: cargo test -p rules_ir
    Expected: 通过
    Evidence: .sisyphus/evidence/task-9-normalizedmodel.md
  ```

  **Commit**: YES | Message: `feat(model): add normalized content models for templates` | Files: `rust/`（rules_ir）, `web-editor/src/types/rule.ts`, `lib/core/rust/domain/**`

- [ ] 10. Rust FFI/API：暴露 validate/execute（返回 runId + 可选结果）

  **What to do**:
  - 在 `ffi` crate 暴露：
    - `validate_rule(envelope_json) -> ValidationResult(diagnostics)`
    - `execute_rule(envelope_json, context) -> ExecuteResponse(runId, initialResult?)`
  - NodeEvent 通过独立流通道推送（WS 由 Flutter server 转发，不直接走 FRB stream）。

  **Must NOT do**:
  - 不把 web-editor 相关类型直接暴露到 Rust API。

  **Recommended Agent Profile**:
  - Category: `unspecified-high`
  - Skills: [`rust-ffi-guide`]

  **Parallelization**: Can Parallel: NO | Wave 2 | Blocks: 11-15 | Blocked By: 6-9

  **References**:
  - FRB 配置：`flutter_rust_bridge.yaml`（在本任务内恢复生成 `lib/core/rust/**`）

  **Acceptance Criteria**:
  - [ ] Flutter 侧可调用 validate/execute 并拿到 structured errors。

  **QA Scenarios**:
  ```
  Scenario: FFI validate
    Tool: Bash
    Steps: flutter test（调用 validateRule 并断言 errors）
    Expected: 通过
    Evidence: .sisyphus/evidence/task-10-ffi-validate.md
  ```

  **Commit**: YES | Message: `feat(ffi): expose rule validate and execute` | Files: `rust/`（ffi crate）, `lib/core/rust/**`

- [ ] 11. Flutter server：新增 `/api/rules*` 路由与 CRUD（读写 DB）

  **What to do**:
  - 在 `RelicApp` 下挂载新 Router（例如 `/api/rules`）。
  - 实现 list/get/create/update/delete：
    - 存储 RuleEnvelope JSON
    - 返回 schemaVersion、updatedAt
  - 与 web-editor `rulesApi` 对齐（更新 `web-editor/src/api/client.ts` 如需）。

  **Must NOT do**:
  - 不返回旧 schema 字段。

  **Recommended Agent Profile**:
  - Category: `unspecified-high`
  - Skills: [`flutter-dart-guide`]

  **Parallelization**: Can Parallel: YES | Wave 3 | Blocks: 12-18 | Blocked By: 3-4,10

  **References**:
  - Server: `lib/core/server/server_provider.dart`
  - Current server routes pattern: `lib/core/server/routes/server_routes.dart`
  - DB: `lib/core/database/drift/app_database.dart`

  **Acceptance Criteria**:
  - [ ] curl 可以 CRUD 一条 RuleEnvelope。

  **QA Scenarios**:
  ```
  Scenario: CRUD smoke
    Tool: Bash
    Steps: 启动 app server；curl POST 创建规则；GET 列表；PUT 更新；DELETE 删除
    Expected: HTTP 状态码正确且 JSON 可解析
    Evidence: .sisyphus/evidence/task-11-crud.md
  ```

  **Commit**: YES | Message: `feat(server): add rules CRUD api` | Files: `lib/core/server/**`, `lib/core/database/**`, `web-editor/src/api/client.ts`

- [ ] 12. Flutter server：实现 `/api/rules/validate`（调用 Rust validate）

  **What to do**:
  - 接收 RuleEnvelope JSON，调用 Rust `validate_rule`，返回 diagnostics。
  - 统一错误结构（bad request / internal error）。

  **Recommended Agent Profile**:
  - Category: `quick`
  - Skills: [`flutter-dart-guide`]

  **Parallelization**: Can Parallel: YES | Wave 3 | Blocks: 13-18 | Blocked By: 10-11

  **References**:
  - FRB: `lib/core/rust/frb_generated.dart`

  **Acceptance Criteria**:
  - [ ] validate API 返回与 Rust diagnostics 一致。

  **QA Scenarios**:
  ```
  Scenario: validate endpoint
    Tool: Bash
    Steps: curl POST /api/rules/validate -d @fixtures/ir_v1_invalid_edge.json
    Expected: valid=false 且 errors[].code/path/nodeId
    Evidence: .sisyphus/evidence/task-12-validate-endpoint.md
  ```

  **Commit**: YES | Message: `feat(server): add rules validate endpoint` | Files: `lib/core/server/**`, `lib/core/rust/**`

- [ ] 13. Flutter server：实现 `/api/rules/execute`（触发 runId + 推送 NodeEvent）

  **What to do**:
  - 接收 RuleEnvelope + context(url/keyword/page/vars)，调用 Rust `execute_rule`。
  - 生成 `runId`，把 NodeEvent 转发到 `/ws`（所有连接或按订阅过滤）。
  - 为每个 run 维护内存 ring buffer（最近 N 条）用于断线补拉（可选但推荐）。

  **Must NOT do**:
  - 不把 NodeEvent 持久化到 DB。

  **Recommended Agent Profile**:
  - Category: `unspecified-high`
  - Skills: [`flutter-dart-guide`]

  **Parallelization**: Can Parallel: NO | Wave 3 | Blocks: 14-18 | Blocked By: 2-3,10-12

  **References**:
  - Existing WS broadcast: `lib/core/server/server_provider.dart`

  **Acceptance Criteria**:
  - [ ] execute 返回 `runId`。
  - [ ] WS 收到同 runId 的 NodeEvent 且 `seq` 单调递增。

  **QA Scenarios**:
  ```
  Scenario: execute + ws
    Tool: Bash
    Steps: node ws client 连接 /ws；curl POST /api/rules/execute
    Expected: 收到 RunStarted/NodeStarted/PortEmit/NodeFinished/RunFinished
    Evidence: .sisyphus/evidence/task-13-execute-ws.md
  ```

  **Commit**: YES | Message: `feat(server): execute rules and stream node events` | Files: `lib/core/server/server_provider.dart`, `lib/core/rust/**`

- [ ] 14. Preview 能力：补齐 `/api/preview/open` 与选择器回传的协议一致性

  **What to do**:
  - 将 Preview 设计为“桌面调试优先”的可控 Chromium 方案，避免 Flutter WebView 性能/能力短板：
    1) Flutter server 提供 `/api/preview/open`：创建 preview session（返回 `sessionId`、debugUrl、wsChannel）。
    2) Preview runtime 使用 Playwright（推荐）或 CDP：
       - 启动 Chromium（headed）并打开目标 URL
       - 注入选择器采集脚本（点击元素→计算 CSS/XPath→返回 outerHtml/text/rect）
       - 通过 server 的 `/ws` 推送 `element_selected`（含 selectorType）
    3) Web-editor 通过现有选择器应用回调机制回填到节点配置。
  - 平台策略（已决策）：仅 Desktop 完整支持（Chromium + 选元素）。

  **Recommended Agent Profile**:
  - Category: `unspecified-high`
  - Skills: [`flutter-dart-guide`]

  **Parallelization**: Can Parallel: YES | Wave 3 | Blocks: 16-18 | Blocked By: 3,13

  **References**:
  - Web-editor preview call: `web-editor/src/components/preview/PreviewPanel.tsx`
  - Existing WS types: `web-editor/src/hooks/useWebSocket.ts`

  **Acceptance Criteria**:
  - [ ] `/api/preview/open` 返回成功并可触发选择器拾取。

  **QA Scenarios**:
  ```
  Scenario: preview open
    Tool: Playwright
    Steps: 启动 Flutter server + editor；在 web-editor 输入 URL 点预览
    Expected: 页面打开，选择器可回传 element_selected
    Evidence: .sisyphus/evidence/task-14-preview-open.md
  ```

  **Commit**: YES | Message: `feat(preview): implement preview open and selector return` | Files: `lib/core/server/**`, `web-editor/src/components/preview/PreviewPanel.tsx`

- [ ] 15. Web-editor：移除旧规则 schema，切换到新 `web-editor/src/types/rule.ts`

  **What to do**:
  - 把 `rulesApi` 的类型从 `web-editor/src/api/types.ts` 迁移到 Rust 生成类型。
  - 删除/隔离旧表单编辑器（或改为读取/编辑 RuleEnvelope）。
  - 保留 i18n 规则（不得硬编码字符串）。

  **Must NOT do**:
  - 不保留旧 `sample-rules.json` 导入路径。

  **Recommended Agent Profile**:
  - Category: `unspecified-high`
  - Skills: [`react-web-editor-guide`]

  **Parallelization**: Can Parallel: NO | Wave 4 | Blocks: 16-18 | Blocked By: 6,11-14

  **References**:
  - Generated TS: `web-editor/src/types/rule.ts`
  - Current editor page: `web-editor/src/pages/rules/RuleEditorPage.tsx`

  **Acceptance Criteria**:
  - [ ] `bun run build` 通过。

  **QA Scenarios**:
  ```
  Scenario: web-editor compile
    Tool: Bash
    Steps: web-editor 下 bun run build
    Expected: 退出码 0
    Evidence: .sisyphus/evidence/task-15-web-editor-build.md
  ```

  **Commit**: YES | Message: `refactor(web-editor): migrate rule types to new ir` | Files: `web-editor/src/**`

- [ ] 16. Web-editor：引入节点图编辑器（ReactFlow/xyflow）并实现 Graph 编辑

  **What to do**:
  - 选择库：`@xyflow/react`（ReactFlow）作为节点画布。
  - 实现：节点/边增删改、拖拽布局、端口连接、选中节点编辑 config。
  - Graph 序列化为 RuleEnvelope.graph。

  **Recommended Agent Profile**:
  - Category: `visual-engineering`
  - Skills: [`react-web-editor-guide`, `frontend-ui-ux`]

  **Parallelization**: Can Parallel: YES | Wave 4 | Blocks: 17-18 | Blocked By: 15

  **References**:
  - Current state store: `web-editor/src/stores/index.ts`

  **Acceptance Criteria**:
  - [ ] 能新增一个最小链式图并保存到后端。

  **QA Scenarios**:
  ```
  Scenario: create graph
    Tool: Playwright
    Steps: 打开规则编辑；新增节点；连线；保存
    Expected: 保存成功且刷新后图存在
    Evidence: .sisyphus/evidence/task-16-graph-edit.md
  ```

  **Commit**: YES | Message: `feat(web-editor): add node graph editor` | Files: `web-editor/src/**`, `web-editor/package.json`

- [ ] 17. Web-editor：流式调试面板（订阅 NodeEvent 并高亮节点）

  **What to do**:
  - 通过 `/ws` 订阅 NodeEvent；按 `runId` 过滤。
  - UI：节点状态（running/success/error）、展示 PortEmit preview（截断）、错误诊断跳转。
  - 断线：重连后从 ring buffer 续拉（如果实现）。

  **Recommended Agent Profile**:
  - Category: `visual-engineering`
  - Skills: [`react-web-editor-guide`]

  **Parallelization**: Can Parallel: YES | Wave 4 | Blocks: 18 | Blocked By: 2,13,16

  **Acceptance Criteria**:
  - [ ] 运行一次 execute 时，节点图实时高亮并显示中间结果。

  **QA Scenarios**:
  ```
  Scenario: streaming debug
    Tool: Playwright
    Steps: 点击执行；观察节点事件与结果面板
    Expected: 顺序事件可见，错误定位到 nodeId
    Evidence: .sisyphus/evidence/task-17-streaming-debug.md
  ```

  **Commit**: YES | Message: `feat(web-editor): add streaming debug panel` | Files: `web-editor/src/**`

- [ ] 18. Web-editor：执行/校验/保存闭环对接新 API

  **What to do**:
  - 将 validate/execute 按新 API 调用。
  - execute 支持输入 context（url/keyword/page/vars）。

  **Recommended Agent Profile**:
  - Category: `unspecified-high`
  - Skills: [`react-web-editor-guide`]

  **Parallelization**: Can Parallel: NO | Wave 4 | Blocks: 21-22 | Blocked By: 11-17

  **Acceptance Criteria**:
  - [ ] Web-editor 能保存/校验/执行同一条规则。

  **QA Scenarios**:
  ```
  Scenario: full editor loop
    Tool: Playwright
    Steps: 新建规则 → 保存 → 校验（无错）→ 执行
    Expected: 执行成功 + debug 面板有事件
    Evidence: .sisyphus/evidence/task-18-editor-loop.md
  ```

  **Commit**: YES | Message: `feat(web-editor): wire save/validate/execute to new api` | Files: `web-editor/src/**`

- [ ] 19. Rust：实现 Fetch/Parse/Select/Transform 基础节点并复用现有执行器

  **What to do**:
  - 从零实现 selector/transform 节点执行（不复用已删除的旧实现），并把实现落在新 crate 路径：
    - `rust/crates/rules_engine/src/nodes/fetch.rs`
    - `rust/crates/rules_engine/src/nodes/parse.rs`
    - `rust/crates/rules_engine/src/nodes/select.rs`（CSS/XPath/JSONPath/Regex）
    - `rust/crates/rules_engine/src/nodes/transform.rs`（Trim/Lower/Upper/Text/Url/JS 等）
  - 修正 attr 提取语义：不再用 `"*"` hack；Selector 节点或 AttrTransform 节点应明确输入是 DOM selection。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 2-3 | Blocks: 13,20 | Blocked By: 8

  **Acceptance Criteria**:
  - [ ] 新节点单测覆盖每种 selector/transform。

  **QA Scenarios**:
  ```
  Scenario: selector nodes tests
    Tool: Bash
    Steps: cargo test -p rules_engine
    Expected: 通过
    Evidence: .sisyphus/evidence/task-19-selector-nodes.md
  ```

  **Commit**: YES | Message: `feat(rules-engine): implement fetch/parse/select/transform nodes` | Files: `rust/crates/rules_engine/**`, `fixtures/`

- [ ] 20. Rust：实现阶段输出到 NormalizedModel 的 MapToModel 节点

  **What to do**:
  - 为 Explore/Search/Detail/Toc/Content 提供映射节点，把 Record/List 投影到 NormalizedModel。
  - 映射失败输出 diagnostics（缺字段/类型不符）。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 2-3 | Blocks: 21-22 | Blocked By: 9,19

  **Acceptance Criteria**:
  - [ ] 对最小示例规则可产出 NormalizedModel。

  **QA Scenarios**:
  ```
  Scenario: map to model
    Tool: Bash
    Steps: cargo test -p rules_engine（fixture html → execute → model）
    Expected: model 字段符合预期
    Evidence: .sisyphus/evidence/task-20-map-to-model.md
  ```

  **Commit**: YES | Message: `feat(rules-engine): map outputs to normalized models` | Files: `rust/`（rules_engine）, `rust/`（rules_ir）

- [ ] 21. Flutter：固定模板页面渲染（Search/Detail/Toc/Content）最小闭环

  **What to do**:
  - 基于 NormalizedModel 实现固定页面组件：列表、详情、目录、内容。
  - 通过 `/api/rules/execute`（任务 13）展示结果（不依赖 web-editor）。
  - i18n：所有字符串走 `lib/l10n/*`。

  **Recommended Agent Profile**:
  - Category: `visual-engineering`
  - Skills: [`flutter-dart-guide`, `frontend-ui-ux`]

  **Parallelization**: Can Parallel: YES | Wave 5 | Blocks: 22 | Blocked By: 9,13,20

  **References**:
  - i18n: `lib/l10n/intl_zh.arb`

  **Acceptance Criteria**:
  - [ ] 固定页面能渲染一条示例规则的输出。

  **QA Scenarios**:
  ```
  Scenario: render normalized model
    Tool: Playwright (or flutter driver)
    Steps: 运行 app，触发 execute，进入页面
    Expected: 基础字段可见且无硬编码文案
    Evidence: .sisyphus/evidence/task-21-flutter-render.md
  ```

  **Commit**: YES | Message: `feat(ui): render normalized models in fixed pages` | Files: `lib/`（UI 页面与路由）, `lib/l10n/**`

- [ ] 22. 示例与夹具：提供 2-3 条新 IR 示例规则（HTML/JSON）

  **What to do**:
  - 写入 `fixtures/`：
    - HTML 示例（列表+详情+目录+内容）
    - JSON API 示例
  - 对应新 IR RuleEnvelope 示例（用于 CI smoke 与 web-editor demo）。

  **Recommended Agent Profile**:
  - Category: `writing`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 2-5 | Blocks: F* | Blocked By: 1,6,9

  **Acceptance Criteria**:
  - [ ] fixtures 覆盖 validate/execute/render 三条链路。

  **QA Scenarios**:
  ```
  Scenario: fixtures used by tests
    Tool: Bash
    Steps: cargo test + flutter test + web-editor build
    Expected: 全通过
    Evidence: .sisyphus/evidence/task-22-fixtures.md
  ```

  **Commit**: YES | Message: `test(fixtures): add ir v1 examples for smoke tests` | Files: `fixtures/`

- [ ] 23. JS 安全与配额：QuickJS 执行超时/内存限制 + capability gate

  **What to do**:
  - 为 JS 节点设置最大执行时长、最大输出大小、禁用危险 API。
  - validator 在能力不允许时阻止 JS 节点。
  - 参照 Legado 常用内置能力，新增“非 JS 依赖”的内建节点（见任务 31-33），优先用节点替代把能力全塞进 JS 引擎。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 6 | Blocks: F* | Blocked By: 7-8

  **References**:
  - JS 节点实现位置（新代码）：`rust/crates/rules_engine/src/nodes/transform.rs`
  - QuickJS 封装建议位置：`rust/crates/rules_engine/src/runtime/js_runtime.rs`

  **Acceptance Criteria**:
  - [ ] 恶意/死循环脚本被超时终止并返回 NodeError。

  **QA Scenarios**:
  ```
  Scenario: js timeout
    Tool: Bash
    Steps: 执行含 while(true) 的 JS 节点规则
    Expected: NodeError code=JS_TIMEOUT，run 结束
    Evidence: .sisyphus/evidence/task-23-js-timeout.md
  ```

- [ ] 24. HTTP 反爬/回退策略节点化（最小实现）

  **What to do**:
  - 将反爬处理提升为 IR 的一等能力（对标 Legado `webView:true` 的“交互式会话”思想；仅做合规的交互式挑战处理与会话复用，不做“绕过”）：
    1) 检测：扩展 WAF/挑战检测信号（状态码 403/503 + cf 相关 header + body 关键字），统一产出结构化错误 `ChallengeRequired`。
    2) 策略：在 IR 中定义 `AntiBotPolicy`：
       - `onChallenge = abort | interactive_session`
       - `maxRetries`、`backoff`、`rateLimit`（与任务 25 协同）
    3) 交互式会话：
       - Desktop 用 Chromium runner（任务 34）提供 `interactive_session`
       - 用户完成登录/验证后，提取 cookie/session 写入规则级 CookieJar（任务 32）
       - 之后 HTTP 请求复用 cookie 继续执行
    4) wreq 指纹模拟：作为“浏览器兼容性提升”配置项暴露（已有 emulation 枚举），用于减少误拦截；若仍触发 `ChallengeRequired`，必须走 `interactive_session` 或 abort。
    5) 诊断：NodeEvent 必须明确告知原因与下一步（启动交互会话/检查代理/降低频率）。
  - 第一阶段交付：
    - `abort` + `ChallengeRequired` 诊断
    - Desktop `interactive_session`（复用任务 34 runner）

  **Recommended Agent Profile**:
  - Category: `unspecified-high`
  - Skills: [`flutter-dart-guide`]

  **Parallelization**: Can Parallel: YES | Wave 6 | Blocks: F* | Blocked By: 13,19

  **References**:
  - WAF/挑战检测建议实现位置：`rust/crates/io_http/src/antibot.rs`
  - 结构化错误码（与 NodeEvent 对齐）：`rust/crates/rules_ir/src/diagnostic.rs`

  **Acceptance Criteria**:
  - [ ] WAF/挑战触发时返回 `ChallengeRequired` 并在 UI 有提示。
  - [ ] Desktop interactive_session 完成后，cookie 写入 jar，后续请求可继续执行。

  **QA Scenarios**:
  ```
  Scenario: challenge required
    Tool: Bash
    Steps: 使用 fixture 模拟 403 + cf-ray header
    Expected: NodeError/ChallengeRequired（结构化 code）
    Evidence: .sisyphus/evidence/task-24-waf.md
  ```

  **Commit**: YES | Message: `feat(antibot): add challenge detection and interactive fallback` | Files: `rust/`（io_http/rules_engine）, `lib/`（server/UI 入口）, `tools/`（runner，如复用）

- [ ] 25. 限速/并发策略（参考 Legado concurrentRate）

  **What to do**:
  - 在 HTTP IO 层实现 per-rule rate limit（例如 `count/period_ms`）。
  - 在 IR 中增加可选字段（规则级并发/限速）。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 6 | Blocks: F* | Blocked By: 6,19

  **Acceptance Criteria**:
  - [ ] 超过速率时请求被延迟且 NodeEvent 有 log。

  **QA Scenarios**:
  ```
  Scenario: rate limit
    Tool: Bash
    Steps: 连续触发多次 fetch 节点
    Expected: 延迟生效且无崩溃
    Evidence: .sisyphus/evidence/task-25-rate-limit.md
  ```

- [ ] 26. 缓存与可复现性（最小：输入 hash 缓存 + 事件 seq）

  **What to do**:
  - 将缓存分两层：
    - Engine 内部透明缓存：`ruleVersion + nodeId + inputHash`
    - 规则可编排缓存：通过 CacheGet/CachePut 节点访问的 KV store（scope: run/rule）
  - Cookie 能力不要通过“缓存模拟”，而是单独的 CookieJar（任务 32）。

  **Recommended Agent Profile**:
  - Category: `unspecified-high`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 6 | Blocks: F* | Blocked By: 8

  **Acceptance Criteria**:
  - [ ] 同输入重复执行命中透明缓存（NodeEvent 标记 cacheHit）。
  - [ ] CachePut→CacheGet 在同一 run scope 内可读写。
  - [ ] CachePut/CacheGet 的 rule scope 跨重启可用（依赖任务 4 `kvStoreEncrypted`）。

  **QA Scenarios**:
  ```
  Scenario: cache hit
    Tool: Bash
    Steps: 对同 URL 执行两次
    Expected: 第二次 cacheHit=true
    Evidence: .sisyphus/evidence/task-26-cache.md
  ```

- [ ] 27. Build/发布链路：web-editor 构建产物集成到 `assets/editor`

  **What to do**:
  - 明确 `bun run build:web` 的输出路径，并确保 Flutter server 静态资源可服务。
  - 在 CI 中补齐 `web-editor` lint/build（目前 CI 仅 Flutter）。

  **Recommended Agent Profile**:
  - Category: `unspecified-high`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 6 | Blocks: F* | Blocked By: 15-16

  **References**:
  - Static handler: `lib/core/server/handlers/static_handler.dart`
  - CI: `.github/workflows/ci.yml`

  **Acceptance Criteria**:
  - [ ] CI 失败会在 web-editor lint/build 失败时阻断。

  **QA Scenarios**:
  ```
  Scenario: editor assets served
    Tool: Bash
    Steps: 构建 editor 到 assets/editor；启动 server；curl GET / 返回 index.html
    Expected: 200 且 content-type 正确
    Evidence: .sisyphus/evidence/task-27-static-assets.md
  ```

- [ ] 28. 文档：规则 IR/节点库/调试协议/固定模板字段说明（中文）

  **What to do**:
  - 写开发文档：
    - IR v1 schema
    - NodeEvent 协议
    - Node 库（每个节点输入输出端口、DataType、示例）
    - NormalizedModel 字段
  - 文档必须无表情符号。

  **Recommended Agent Profile**:
  - Category: `writing`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 6 | Blocks: F* | Blocked By: 1-3,9

  **Acceptance Criteria**:
  - [ ] 文档可直接指导新规则编写与调试。

  **QA Scenarios**:
  ```
  Scenario: docs completeness
    Tool: Bash
    Steps: rg 检查关键术语（irVersion/nodeId/seq/NormalizedModel）都在文档出现
    Expected: 命中且示例齐全
    Evidence: .sisyphus/evidence/task-28-docs.md
  ```

- [ ] 29. Gated spike：Flutter 是否阻塞的 Tauri2 评估（不进主线）

  **What to do**:
  - 只做评估与 PoC：
    - 复用同一 Rust 引擎
    - 用 Tauri2 起一个 minimal UI 打开 web-editor 或内置节点编辑器
    - 输出成本/收益/风险对比

  **Must NOT do**:
  - 不在未证明 Flutter 阻塞前替换主架构。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 6 | Blocks: - | Blocked By: 1-3

  **Acceptance Criteria**:
  - [ ] 产出评估报告（技术/维护/发布/体积/权限）。

  **QA Scenarios**:
  ```
  Scenario: tauri poc builds
    Tool: Bash
    Steps: tauri build（如果 PoC 实现）
    Expected: 能启动并调用同一引擎接口
    Evidence: .sisyphus/evidence/task-29-tauri2.md
  ```

- [ ] 30. 清理与收尾：删除旧 web-editor 规则 schema 与死代码路径

  **What to do**:
  - 删除 `web-editor/src/api/types.ts` 中与旧规则相关的类型与 UI 依赖。
  - 清理 sample 旧规则文件的入口（保留文件本身可选，但不得再被 UI/逻辑引用）。
  - Rust/Flutter 中删除线性 pipeline 旧路径或标记 deprecated 并移除调用。

  **Recommended Agent Profile**:
  - Category: `unspecified-high`
  - Skills: `[]`

  **Parallelization**: Can Parallel: NO | Wave 6 | Blocks: F* | Blocked By: 15-22

  **Acceptance Criteria**:
  - [ ] `rg "sample-rules.json"` 不再出现在运行路径。

  **QA Scenarios**:
  ```
  Scenario: no legacy usage
    Tool: Bash
    Steps: rg "sample-rules.json|ExtractConfig|FieldMapping" web-editor/src
    Expected: 仅保留非运行时文档或 0 命中（按设计）
    Evidence: .sisyphus/evidence/task-30-cleanup.md
  ```

- [ ] 31. 规则运行时 KV/Cache 能力：CacheGet/CachePut 节点（对标 Legado cache）

  **What to do**:
  - 在引擎上下文加入 KV store 抽象：
    - scope=`run`：仅本次执行可见（调试友好）
    - scope=`rule`：同一规则多次执行可复用（默认：仅内存；后续可接 DB）
  - 新增节点：
    - `CachePut(key, value, scope)`
    - `CacheGet(key, scope, default?)`
  - Validator：校验 key 非空、scope 合法；限制 value 大小（防止内存爆）。
  - NodeEvent：对 cache hit/miss 发 log。

  **Must NOT do**:
  - 不做跨设备/云同步缓存。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 6 | Blocks: F* | Blocked By: 6-8

  **References**:
  - Legado: cache get/put（以教程与实际实现核对为准）https://mgz0227.github.io/The-tutorial-of-Legado/Rule/source.html

  **Acceptance Criteria**:
  - [ ] CachePut→CacheGet 在同 run scope 下返回一致结果。
  - [ ] rule scope 跨应用重启生效（落盘加密）。

  **QA Scenarios**:
  ```
  Scenario: cache nodes
    Tool: Bash
    Steps: 执行包含 CachePut/CacheGet 的最小规则两次；模拟重启后再执行一次
    Expected: 第一次 miss，第二次 rule-scope hit；重启后仍 hit
    Evidence: .sisyphus/evidence/task-31-cache-nodes.md
  ```

  **Commit**: YES | Message: `feat(rules-engine): add cache get/put nodes` | Files: `rust/`（rules_engine）, `fixtures/`

- [ ] 32. CookieJar 能力：CookieGet/CookiePut 节点 + HTTP client 共享 jar（对标 Legado cookie）

  **What to do**:
  - 明确 cookie jar 生命周期：
    - per-rule 持久化：跨应用重启保留（落盘加密，见任务 4）
    - 按 domain 分桶；默认仅允许当前请求域或 allowlist
  - 在 HTTP client（wreq cookies）与引擎上下文共享 CookieJar。
  - 新增节点：
    - `CookiePut(name, value, domain?, path?, expires?, secure?, httpOnly?)`
    - `CookieGet(name, domain?)`
  - Validator：限制可写 cookie 的 domain（默认只允许当前请求域或 allowlist）。

  **Must NOT do**:
  - 不做全局跨规则共享 cookie（仅规则级）。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 6 | Blocks: F* | Blocked By: 19,25

  **References**:
  - wreq cookies 已启用：`rust/Cargo.toml`
  - HTTP client（新代码）：`rust/crates/io_http/src/client.rs`

  **Acceptance Criteria**:
  - [ ] CookiePut 后的请求能自动携带 cookie（同域）。
  - [ ] CookieGet 能读取到 jar 中值。
  - [ ] 重启后仍可读取到同规则 cookie（通过 DB 解密导入）。

  **QA Scenarios**:
  ```
  Scenario: cookie jar
    Tool: Bash
    Steps: 用本地 mock server/fixture 响应 set-cookie；再发第二次请求；模拟重启（重新加载 jar）再发第三次请求
    Expected: 第二次与第三次请求 header 含 cookie
    Evidence: .sisyphus/evidence/task-32-cookie-jar.md
  ```

  **Commit**: YES | Message: `feat(net): add cookie jar get/put and nodes` | Files: `rust/`（io_http/rules_engine）

- [ ] 33. 编解码/加密解密能力：Codec/Crypto 节点（对标 Legado 常用工具）

  **What to do**:
  - 第一阶段按 Legado 教程中的常用工具能力对齐（节点化，避免把能力都塞进 JS 引擎）：
    - Base64：encode/decode（String 与 bytes 两套）
    - MD5：32 位与 16 位（兼容 legado 语义）
    - URI 编码：encodeURI（UTF-8 默认 + 指定编码）
    - 编码转换：utf8ToGbk
    - HTML 格式化：htmlFormat
    - 时间格式化：timeFormat
    - AES 全套（以教程列举的方法为准）：
      - aesDecodeToByteArray / aesDecodeToString
      - aesBase64DecodeToByteArray / aesBase64DecodeToString
      - aesEncodeToByteArray / aesEncodeToString
      - aesEncodeToBase64ByteArray / aesEncodeToBase64String
      - 参数：`key`、`transformation`、`iv`
  - 能力门控（必须）：
    - `capabilities.codec=true` 才允许编解码节点
    - `capabilities.crypto.aes=true` 才允许 AES 节点
    - key/iv 通过 `KeyRef` 提供（vars/secure store/inline），默认禁止 inline secret，除非规则显式 `allowInlineSecrets=true`
  - web-editor 参数 UI：transformation 提供下拉（支持列表=引擎实际实现列表），iv/key 校验提示。

  **Must NOT do**:
  - 不在默认能力集中开放“任意加密解密 + 任意网络”组合（降低滥用面）。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 6 | Blocks: F* | Blocked By: 6-8

  **References**:
  - Legado 工具能力：以教程为准 https://mgz0227.github.io/The-tutorial-of-Legado/Rule/source.html

  **Acceptance Criteria**:
  - [ ] Base64/MD5/URI/GBK/HTML/timeFormat 节点单测覆盖。
  - [ ] AES 节点至少覆盖 2 个 transformation，并与已知用例对齐（提供 fixtures）。

  **QA Scenarios**:
  ```
  Scenario: codec nodes
    Tool: Bash
    Steps: cargo test -p rules_engine
    Expected: 通过
    Evidence: .sisyphus/evidence/task-33-codec-crypto.md
  ```

  **Commit**: YES | Message: `feat(rules-engine): add codec and crypto nodes` | Files: `rust/`（rules_engine）, `fixtures/`

- [ ] 34. Preview/选元素实现落地：Playwright/Chromium 运行时 + 注入脚本 + WS 回传

  **What to do**:
  - 实现一个“仅编辑器用途”的 preview runner（推荐 Node.js/Bun + Playwright）：
    - Flutter server 调用本地 runner（子进程或内嵌）创建 session
    - runner 打开 Chromium（headed）并注入脚本：
      - selection mode on/off
      - click 捕获并计算 selector（CSS 优先；XPath 可选）
      - 返回 outerHtml/text/rect
    - runner 通过 Flutter server `/ws` 广播 element_selected（或 server 代理 runner WS）
  - 资源与体验：
    - 限制并发 session 数
    - session 超时自动关闭
    - 截图按需刷新（与 web-editor UI 对齐）

  **Must NOT do**:
  - 不把 Chromium 预览当作主 App 的 webview 解决方案（仅规则编辑器调试）。

  **Recommended Agent Profile**:
  - Category: `unspecified-high`
  - Skills: [`playwright`] — Reason: 需要稳定的浏览器控制与脚本注入。

  **Parallelization**: Can Parallel: NO | Wave 3-4 | Blocks: 16-18 | Blocked By: 14

  **References**:
  - Existing preview UI: `web-editor/src/components/preview/PreviewPanel.tsx`
  - Existing WS: `lib/core/server/server_provider.dart`

  **Acceptance Criteria**:
  - [ ] 点击网页元素能回传 selector 并回填到节点配置。
  - [ ] 同一 session 结束后 Chromium 自动退出。

  **QA Scenarios**:
  ```
  Scenario: selector picking end-to-end
    Tool: Playwright
    Steps: 启动 server+editor；open preview；进入选择模式；点击元素
    Expected: web-editor 收到 element_selected 并应用到当前字段
    Evidence: .sisyphus/evidence/task-34-preview-runner.md
  ```

  **Commit**: YES | Message: `feat(preview): add chromium runner for selector picking` | Files: `lib/`（server/桥接）, `web-editor/`（协议对接）, `tools/`（runner）

- [ ] 35. 定义 SessionCookies v1（交互式会话 cookie 包）与 commit 契约（不做文件导出）

  **What to do**:
  - 定义“交互式会话 cookie 包”标准 JSON（SessionCookies v1），作为所有平台（Playwright / WebView / Tauri）统一输出与内部传递格式（不落文件、不提供下载）：
    - `v: 1`
    - `createdAt`（ISO8601）
    - `platform`（windows|macos|linux|android|ios）
    - `sourceUrl`（用于域名校验/诊断）
    - `allowlistDomains[]`（强制存在）
    - `cookies[]`（必须包含 `domain/path/name/value/expiresDateMs?/httpOnly?/secure?/sameSite?`；必须支持 HttpOnly）
  - 定义 commit 规则（已决策，执行时不再讨论）：
    - 服务端提供 `POST /api/sessions/{sessionId}/commit-cookies`：从 runner/WebView 获取 SessionCookies v1 并写入“规则级 CookieJar”（任务 4 + 32），后续 `wreq` 请求自动携带。
    - API 默认不返回 cookie 明文到 web-editor；仅返回 summary（cookieCount/domains）。
  - 定义安全护栏（写入 capability/validator 约束与 API 校验规则）：
    - 仅允许 allowlistDomains 内的 cookie 写入；禁止跨域注入。
    - 默认只接受 `http/https` scheme 的 `sourceUrl`。
    - 日志与 NodeEvent/WS 事件必须脱敏（不得输出 cookie 值）。
  - fixtures：新增 `fixtures/session_cookies_v1_min.json` + `fixtures/session_cookies_v1_invalid.json`（越权域名/缺字段/过期）。

  **Must NOT do**:
  - 不引入“绕过验证”的自动化脚本；交互式会话只负责承载用户操作并提交会话 cookies 以继续后续请求。

  **Recommended Agent Profile**:
  - Category: `deep` — Reason: 需要一次性定清跨端契约与安全边界。
  - Skills: `[]`

  **Parallelization**: Can Parallel: YES | Wave 1 | Blocks: 36-38 | Blocked By: 2-3

  **References**:
  - Rust HTTP cookies：`rust/Cargo.toml`（wreq cookies feature）
  - HTTP client（新代码）：`rust/crates/io_http/src/client.rs`
  - CookieJar 持久化：任务 4、任务 32
  - Desktop 会话 runner：任务 24、任务 34

  **Acceptance Criteria**:
  - [ ] SessionCookies v1 schema 与示例 JSON 写入文档（字段含义 + 安全约束）。
  - [ ] API 契约（任务 3）中明确 `commit-cookies` 的入参/出参（仅 summary，不返回明文）。

  **QA Scenarios**:
  ```
  Scenario: schema fixtures are valid JSON
    Tool: Bash
    Steps: 运行最小校验脚本/单测对 fixtures/session_cookies_v1_*.json 做 JSON 解析
    Expected: min.json 可解析；invalid.json 可解析但在后续 commit 校验中会被拒绝（见任务 36/37）
    Evidence: .sisyphus/evidence/task-35-session-cookies-fixtures.md
  ```

  **Commit**: YES | Message: `docs(session): define v1 session cookies commit contract` | Files: `docs/`, `fixtures/`

- [ ] 36. 桌面交互式会话（默认路径）：Playwright/Chromium 登录→获取 HttpOnly cookies→commit 到规则 CookieJar

  **What to do**:
  - 在 Flutter server 增加“交互式会话”API（与任务 3 契约一致）：
    - `POST /api/sessions`：入参 `ruleId + url + allowlistDomains + purpose=login`，返回 `sessionId`。
    - `POST /api/sessions/{sessionId}/commit-cookies`：从 runner 拉取 SessionCookies v1 并写入规则 CookieJar（任务 4 + 32），仅返回 summary。
    - `DELETE /api/sessions/{sessionId}`：关闭会话并清理临时目录。
  - 复用/扩展任务 34 的 Chromium runner（Node/Bun + Playwright）：
    - `purpose=login`：打开 URL（headed），允许用户手动完成登录/挑战。
    - 获取 cookies 使用 Playwright `context.cookies()`（或 `storageState`）确保包含 HttpOnly；将结果上送服务端供 commit（不写文件）。
    - 目录策略：每个 session 独立 userDataDir；session 结束默认删除。
  - WS 事件：复用 NodeEvent/diagnostics 思路，新增 session 相关事件（不包含敏感信息）：SessionOpened/SessionCommitted/SessionClosed。

  **Must NOT do**:
  - 不实现自动登录脚本；不做验证码/挑战的自动化处理。

  **Recommended Agent Profile**:
  - Category: `unspecified-high` — Reason: 需要跨 Flutter server + runner + Rust cookie jar 串联。
  - Skills: [`playwright`] — Reason: 需要稳定获取 cookies 与窗口会话控制。

  **Parallelization**: Can Parallel: NO | Wave 6 | Blocks: F* | Blocked By: 24,34,35

  **References**:
  - Existing WS：`lib/core/server/server_provider.dart`
  - Preview API UI：`web-editor/src/components/preview/PreviewPanel.tsx`
  - SessionCookies v1：任务 35
  - ChallengeRequired：任务 24

  **Acceptance Criteria**:
  - [ ] Desktop 上可打开交互式会话并成功 commit cookies（服务端仅返回 summary，不返回明文）。
  - [ ] commit 后 Rust `wreq` 请求能访问“需要登录”的验证接口（用本地 mock server/fixture 代替真实站点）。
  - [ ] allowlistDomains 生效：commit 时仅保留允许域名 cookies；越权 cookie 会被拒绝并返回结构化错误。

  **QA Scenarios**:
  ```
  Scenario: desktop login session produces cookies
    Tool: Playwright
    Steps: 启动 mock server（GET /set-cookie-on-load 立即设置 HttpOnly cookie）；POST /api/sessions（url=/set-cookie-on-load）；POST /api/sessions/{id}/commit-cookies；随后触发一次需要登录的 HTTP 请求
    Expected: commit summary 正确；后续请求命中已登录接口
    Evidence: .sisyphus/evidence/task-36-desktop-login-session.md
  ```

  **Commit**: YES | Message: `feat(session): add desktop interactive login via playwright runner` | Files: `lib/core/server/**`, `tools/**`, `rust/`（cookie jar 导入）

- [ ] 37. 移动端交互式会话（必备能力）：`flutter_inappwebview` 登录→commit cookies（Android/iOS）

  **What to do**:
  - 作为必备能力实现（与桌面一致的 commit-cookies 契约）：
    - 新增 Flutter 页面 `InteractiveSessionPage`（或等价命名），用 `flutter_inappwebview` 打开指定 URL。
    - “完成/提交”按钮触发：通过插件 CookieManager 拉取 cookies，组装 SessionCookies v1（任务 35）并调用 `commit-cookies` 写入规则 CookieJar。
  - 约束与护栏：
    - 强制 allowlistDomains；禁止跨域跳转（或跳转到非 allowlist 时直接提示并中止）。
    - 只提交目标域 cookies；不记录输入；提交前提示用户确认。
  - 失败策略（已决策，执行时不再讨论）：若移动端无法获取/提交认证所需 cookies（例如关键 HttpOnly/secure 无法获取），明确标记该站点“移动端交互会话不支持”，引导用户在桌面端完成。

  **Must NOT do**:
  - 不尝试“注入/破解”挑战；不做静默后台登录。

  **Recommended Agent Profile**:
  - Category: `unspecified-high`
  - Skills: [`flutter-dart-guide`]

  **Parallelization**: Can Parallel: YES | Wave 6 | Blocks: F* | Blocked By: 35,32

  **References**:
  - SessionCookies v1：任务 35
  - CookieJar：任务 32
  - Flutter i18n：`lib/l10n/intl_zh.arb`

  **Acceptance Criteria**:
  - [ ] Android/iOS 至少在 mock server 场景下可 commit cookies 并回填到规则 CookieJar。
  - [ ] 不支持时返回结构化错误（CapabilityUnsupported），UI 提示“请在桌面端完成交互会话”。

  **QA Scenarios**:
  ```
  Scenario: mobile inappwebview commit cookies (mock)
    Tool: Playwright (or flutter driver)
    Steps: 启动 mock server；打开 InteractiveSessionPage；访问 /set-cookie-on-load；点击提交
    Expected: commit 成功；后续请求带 cookie
    Evidence: .sisyphus/evidence/task-37-mobile-session.md
  ```

  **Commit**: YES | Message: `feat(session): add mobile interactive session via inappwebview` | Files: `lib/**`, `pubspec.yaml`

- [ ] 38. Gated spike：评估 `flutter_inappwebview` Linux（6.2.0-beta.3）与 Tauri/wry cookie API 是否值得替代 Playwright 主路径

  **What to do**:
  - 输出一份对比报告（必须包含证据与结论，不进主线代码）：
    - 目标：验证“系统 WebView 路线”在 Linux 桌面是否能稳定完成交互式登录并获取/commit 认证所需 cookies。
    - 对比对象：
      1) Playwright/Chromium（当前默认）
      2) Flutter `flutter_inappwebview` Linux（6.2.0-beta.3 起）
      3) Rust Tauri/wry（v2.4.0+ `Webview::cookies*`）作为“会话助手模块”（不做 UI 迁移）
    - 维度：cookies 获取覆盖（HttpOnly/secure）、挑战显示成功率、系统依赖/体积、维护成本、API 稳定性、安全护栏落地成本。
  - spike 结论规则（已决策）：
    - 只有当 2) 或 3) 在 Linux 上能“稳定获取并 commit 认证所需 cookies（含 HttpOnly/secure）”且显著降低体积/依赖/运维成本时，才允许替代 Playwright（且需保留 Playwright 作为 fallback）。

  **Must NOT do**:
  - 不在 spike 中实现站点针对性绕过。
  - 不把 spike 结果直接并入主路径（必须先通过验收与代码审查）。

  **Recommended Agent Profile**:
  - Category: `deep`
  - Skills: [`playwright`] — Reason: 需要与默认路径做可复现对比。

  **Parallelization**: Can Parallel: YES | Wave 6 | Blocks: - | Blocked By: 35

  **References**:
  - flutter_inappwebview Linux beta：https://pub.dev/packages/flutter_inappwebview/versions/6.2.0-beta.3
  - Tauri cookie API：https://v2.tauri.app/release/tauri/v2.4.0/
  - Tauri known issues（示例）：https://github.com/tauri-apps/tauri/blob/dev/crates/tauri/src/webview/mod.rs
  - wry secure cookie issue（示例）：https://github.com/tauri-apps/wry/issues/785

  **Acceptance Criteria**:
  - [ ] 报告包含：环境前置、测试步骤、截图/日志、结论（PASS/FAIL）与推荐路线。
  - [ ] 若推荐替代 Playwright，必须提供迁移策略与 fallback 条件。

  **QA Scenarios**:
  ```
  Scenario: linux webview spike matrix
    Tool: Bash
    Steps: 在 CI/本地 Linux 环境跑三条路径的 mock login 测试（xvfb 或 headed）并获取/commit cookies
    Expected: 输出对比表 + evidence；结论可复现
    Evidence: .sisyphus/evidence/task-38-linux-webview-spike.md
  ```

  **Commit**: NO | Message: - | Files: -

## Final Verification Wave (4 parallel agents, ALL must APPROVE)
- [ ] F1. Plan Compliance Audit — oracle
- [ ] F2. Code Quality Review — unspecified-high
- [ ] F3. Real Manual QA — unspecified-high (+ playwright if UI)
- [ ] F4. Scope Fidelity Check — deep

## Commit Strategy
- 以“协议/IR → 引擎 → Flutter API → Web-editor UI → Flutter 渲染 → 加固”分层做小步提交。
- 提交格式：`<type>(<scope>): <description>`（例如 `feat(rules-ir): add v1 envelope and diagnostics`）。

## Success Criteria
- 新 IR + 节点事件流 + 全栈闭环可用；旧 schema 不再出现在 Web-editor 编辑链路。
