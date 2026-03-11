# Runtime Ownership（运行时归属）v1

本文定义 Spectra 规则运行时（runtime）的“归属关系”和“职责边界”。它是后续实现与契约文档的基线。

## 0. 结论（强制）

1. **Flutter 是 runtime operator**。所有会改变运行时状态的动作，都必须由 Flutter 端发起并承载执行结果。
2. **Web Editor 不是 runtime operator**。Web Editor 只能作为 **attach/read-only diagnostics**（附着式、只读诊断面板），不得成为运行时控制面。
3. 旧方向 `rust-rules-architecture-refactor` 及其“由编辑器主导预览与执行”的工作流在本基线下被明确判定为 **deprecated** 且 **superseded**，不再是可执行路线。
4. 旧方向未完成的任务不自动继承到本方向。是否需要做，必须在新方向下重新建模、重新立项、重新验收。

为便于检索，本基线会在关键位置保留以下术语字面量：`Flutter-owned runtime`、`runtime operator`、`attach/read-only diagnostics`、`deprecated`、`superseded`。

## 1. 背景与证据

当前仓库里仍存在“编辑器拥有预览入口”的实现证据：

- `web-editor/src/components/preview/PreviewPanel.tsx` 直接调用 `POST /api/preview/open`，并在 UI 上提供“触发预览”和“元素选择”的交互入口。
- `docs/api-contract-v1.md` 在 `Preview API` 节明确写到 `wsChannel.previewSessionId` 被“当前编辑器预览流”用于订阅并关联选择器回调。

这些证据说明旧方向仍以“编辑器驱动预览”为中心。本文的目标是终止该方向，把 repo 的对外叙事与后续实现基线统一到 Flutter-owned runtime。

## 2. 术语定义

- **Flutter-owned runtime**：运行时状态归属 Flutter。包括但不限于规则执行生命周期、预览会话生命周期、鉴权 token 生命周期，以及任何会改变 server 侧资源占用的动作。
- **runtime operator**：能够发起并控制运行时状态变更的一方。v1 规定唯一的 runtime operator 是 Flutter。
- **attach/read-only diagnostics**：只能附着连接到运行时，订阅事件流，读取诊断信息，不能触发状态变更。
- **serverToken**：Flutter host 完整权限鉴权凭据，用于发起 preview/execute 等运行时操作。
- **attachToken**：Web editor 只读附着鉴权凭据，仅用于 WebSocket 连接的只读诊断附着，不能发起任何运行时操作。

## 3. 角色与职责边界

### 3.1 Flutter（唯一 runtime operator）

Flutter 端负责：

- 启动与管理内置 server（HTTP/WS）。
- 生成并保管 `serverToken`，决定对外暴露哪些能力。
- 发起规则执行、创建与释放会话资源（包括 previewSession）。
- 作为唯一入口去触发任何可能引起副作用的动作。

### 3.2 Web Editor（attach/read-only diagnostics）

Web Editor 端仅允许：

- 连接 `/ws`，完成 `auth`，进行 `subscribe/unsubscribe`，并显示事件流。
- 以诊断为目的展示 `node_event`、选择器结果、截图等信息。

Web Editor 端明确禁止：

- 作为“正式预览入口”或“执行入口”。
- 在契约层被描述为控制运行时的操作者。

### 3.3 内置 Server（被 Flutter 拥有）

Server 的生命周期由 Flutter 承载，server 不对“谁是操作者”做歧义兼容。契约与实现应以“Flutter-owned runtime”为唯一解释。

## 4. 契约文档对齐要求

为避免读者继续沿旧方向理解系统，以下文档必须在叙事层面与本基线一致：

- `docs/api-contract-v1.md`：不得把 Web Editor 描述为正式预览或运行时操作者。
- `docs/ws-protocol-v1.md`：保持现有事件词汇与过滤字段不变，但必须明确 Flutter 是 runtime operator，Web Editor 仅 attach/read-only diagnostics。

## 5. 迁移与继承规则（强制）

1. 旧方向的任何未完成事项，不视为本方向的 backlog。
2. 任何后续实现工作都必须以本基线重新描述目标、边界、验收点。
3. 若存在与旧方向同名但语义不同的接口或 UI，需要在文档中明确以本基线解释其归属，禁止保留“两条都对”的表述。
