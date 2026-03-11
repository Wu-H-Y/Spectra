# Runtime Session Ownership Model v1

## 1. 文档目标与适用范围

本文定义 `sessionId`、`previewSessionId`、`runId` 的统一 runtime ownership 模型，作为 Flutter 本地服务端与 web-editor 协作的单一基线。

本模型仅定义所有权、生命周期、过滤语义与状态映射，不在此阶段修改 API/WS 代码实现。

## 2. 单一所有权原则

1. Flutter app 是 runtime 状态的 **authoritative owner**。
2. web-editor 仅允许 attach/read：
   - 可读取并缓存 Flutter 下发的 ID；
   - 可基于这些 ID 发起订阅、取消订阅、选择器操作；
   - 不得创建、重写、推断新的 runtime 主 ID。
3. 统一层级：`sessionId -> previewSessionId -> runId`。
4. 单会话模型：一个 `sessionId` 在同一时刻只允许一个 **active preview**，但允许 **multiple runs**。

## 3. 运行时实体关系

### 3.1 关系约束

- `sessionId`：runtime 工作区根上下文。
- `previewSessionId`：从属于 `sessionId` 的当前预览实例。
- `runId`：一次规则执行实例，从属于 `sessionId`；可选关联当前 `previewSessionId`。

约束：

- 一个 `sessionId` 可包含 0..1 个 active `previewSessionId`。
- 一个 `sessionId` 可包含 0..N 个 `runId`（串行或并行）。
- `runId` 全局唯一，且在模型层只归属一个 `sessionId`。
- 当 run 绑定预览上下文时，`run.previewSessionId` 必须等于该 `sessionId` 的当前 active preview。

### 3.2 当前仓库事实对齐

- `rules_routes.dart` 已接收 `context.runId/sessionId/previewSessionId`。
- `preview_routes.dart` 打开预览时返回 `previewSessionId`，并接受可选 `sessionId`。
- `ws-protocol-v1.md` 已定义 `runId/sessionId/previewSessionId` 订阅过滤字段。
- `useWebSocket.ts` 当前围绕 `previewSessionId` 本地订阅，这属于 attach/read 行为，不拥有创建权。

## 4. ID 语义定义（创建、生命周期、失效、持久化）

| ID | 创建者 | 生命周期起点 | 生命周期终点/失效 | 持久化边界 |
|---|---|---|---|---|
| `sessionId` | Flutter runtime（页面/工作区初始化流程） | Flutter 建立 runtime 工作区并分配会话上下文 | 工作区关闭、会话显式销毁、或 Flutter 进程重启后未恢复该会话 | 作为 runtime owning key；可映射到 Flutter 侧会话记录。web-editor 仅缓存，不持久化为权威源 |
| `previewSessionId` | Flutter runtime（`/api/preview/open`） | 预览成功打开后返回 | 预览关闭、空闲超时、同 `sessionId` 下新预览替换旧预览时立即失效 | 仅 Flutter 内存态预览会话集合（`_previewSessions`）与 WS 通道元数据；不作为跨重启稳定 ID |
| `runId` | Flutter runtime（`/api/rules/execute`，未传入时生成） | run 被 accepted 并开始发布事件 | `run_finished` 后进入只读历史态；超出 WS 缓冲窗口后不再可回放 | 执行期/消息期 ID；用于事件关联与过滤。web-editor 可保存引用用于 UI 展示，但不拥有其生命周期 |

补充规则：

- web-editor 不得生成 `sessionId/previewSessionId/runId` 作为 runtime 真值。
- web-editor 允许在 UI 层保存“最近一次收到的 ID”，该保存仅是客户端视图状态，不改变 ownership。

## 5. 生命周期编排（单会话、单活跃预览、多运行）

1. Flutter 创建/恢复页面工作区，生成 `sessionId`。
2. web-editor attach 到该 `sessionId`，仅用于请求与过滤上下文。
3. 打开预览：Flutter 创建 `previewSessionId`，并将其设为该 `sessionId` 的 active preview。
4. 若同一 `sessionId` 再次打开预览：
   - 旧 `previewSessionId` 立即失效；
   - 新 `previewSessionId` 成为唯一 active preview。
5. 执行规则：Flutter 为每次执行分配或确认 `runId`。
6. 同一 `sessionId` 可同时存在多个 `runId`（multiple runs），互不覆盖。
7. 会话结束：`sessionId` 失效并级联终止其 active preview；run 保留为历史引用（直到缓冲淘汰）。

## 6. WebSocket 过滤语义

### 6.1 过滤字段

`subscribe/unsubscribe.data` 支持：

- `sessionId?: string`
- `previewSessionId?: string`
- `runId?: string`

### 6.2 匹配规则

采用 AND（全部匹配）语义：

- 仅传 `sessionId`：接收该会话下全部匹配消息（含预览事件与 run 事件）。
- 仅传 `previewSessionId`：接收该预览范围内消息（如 `selection_started/element_selected`，以及绑定该预览的 run 消息）。
- 仅传 `runId`：仅接收该运行实例消息。
- 同时传多个字段：消息需同时满足全部字段。

边界条件：

- 若订阅指定了某字段，而消息未携带对应字段，则该消息不匹配。
- 取消订阅使用同一过滤结构；移除后不再接收该过滤集合对应消息。

## 7. Flutter 页面状态映射（非 editor-owned）

`sessionId/previewSessionId/runId` 必须映射到 Flutter runtime 页面状态，而非编辑器私有状态：

- 页面级 RuntimeWorkspaceState（Flutter owned）
  - `sessionId`：页面工作区主键。
  - `activePreviewSessionId`：当前活跃预览句柄（0..1）。
  - `runsById`：该会话内运行注册表（0..N）。

- web-editor 视图状态（attach/read）
  - 可保存当前展示用 `previewSessionId` 与聚焦 `runId`；
  - 必须由 Flutter 返回值驱动更新；
  - 不可作为 runtime 真值来源。

## 8. 具体示例（规范命名空间）

以下示例展示单会话、单 active preview、multiple runs：

1. Flutter 创建会话：`sessionId = "session_runtime_001"`。
2. Flutter 打开预览：`previewSessionId = "preview_runtime_001"`，并设为 active preview。
3. Flutter 发起执行：`runId = "run_runtime_001"`，上下文为：

```json
{
  "context": {
    "sessionId": "session_runtime_001",
    "previewSessionId": "preview_runtime_001",
    "runId": "run_runtime_001"
  }
}
```

4. 同一 `session_runtime_001` 可继续发起 `run_runtime_002`、`run_runtime_003`（multiple runs）。
5. 若再次打开预览得到 `preview_runtime_002`，则 `preview_runtime_001` 立即失效，不再是 active preview。

## 9. 持久化边界与一致性要求

1. `sessionId` 是 runtime 级 owning key；跨端通信必须携带该上下文时，以 Flutter 当前会话状态为准。
2. `previewSessionId` 属于短生命周期运行时句柄，仅在 Flutter 进程内存预览集合中有效。
3. `runId` 用于执行链路关联与 WS 过滤；其“可回放性”受服务端缓冲窗口限制，而非长期存储保证。
4. 任何一侧若检测到 `previewSessionId` 已失效，必须回退到“无 active preview”状态并等待 Flutter 下发新值。

## 10. 兼容与后续任务边界

- 本文是 runtime ownership 基线文档；后续 API/WS 行为调整必须满足本文约束。
- 若后续实现与本文冲突，以“Flutter authoritative owner + 单会话单 active preview + 多 run 并存”为优先修正方向。
