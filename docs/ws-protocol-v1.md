# WebSocket NodeEvent 流协议 v1

本文定义规则执行运行时的 WebSocket 协议 v1，仅覆盖协议层消息结构、事件字段语义、重连与补拉策略。

## 1. 外层封套规范

所有消息均使用如下 JSON 外层封套：

```json
{
  "v": 1,
  "type": "string",
  "data": {}
}
```

- `v`：协议版本号。服务端发送消息时必须携带且固定为 `1`。
- `type`：消息类型字符串。
- `data`：可选消息负载。

约束：

- 服务端消息必须满足 `v=1`。
- 客户端消息允许缺省 `v`，缺省时按 `v=1` 处理。
- 当客户端显式传入 `v` 且不为 `1` 时，服务端应拒绝该消息并终止会话。

## 2. 客户端消息

### 2.1 鉴权握手

客户端必须先发送 `auth`，在鉴权通过前，服务端不得下发业务事件。

`auth` 消息结构：

```json
{
  "v": 1,
  "type": "auth",
  "data": {
    "token": "jwt-or-session-token"
  }
}
```

### 2.2 订阅与取消订阅

`subscribe` / `unsubscribe` 的 `data` 结构一致，支持按以下维度过滤：

- `runId`：运行实例过滤。
- `sessionId`：会话过滤。
- `previewSessionId`：预览会话过滤。

可同时传多个字段；服务端按“全部匹配”语义处理过滤条件。

示例：

```json
{
  "type": "subscribe",
  "data": {
    "runId": "run-20260305-001",
    "sessionId": "session-a",
    "previewSessionId": "preview-x"
  }
}
```

## 3. 服务端事件消息

服务端通过 `type="node_event"` 下发节点事件流。

对于预览选择器相关的轻量消息，服务端也可直接下发：

- `element_selected`
- `selection_started`
- `selection_cancelled`

这类消息的 `data.previewSessionId` 应与订阅过滤维度保持一致，便于当前 web-editor 预览流按 `previewSessionId` 关联具体预览会话。

### 3.1 `NodeEvent` 事件类型

`NodeEvent` 枚举值：

- `run_started`
- `node_started`
- `port_emit`
- `node_log`
- `node_error`
- `node_finished`
- `run_finished`

### 3.2 公共字段约束

所有 `NodeEvent` 必须包含：

- `runId`: 运行实例 ID。
- `seq`: 运行内严格单调递增序号（同一 `runId` 下后到达事件的 `seq` 必须大于前一条）。

可选链路追踪字段：

- `traceId`
- `spanId`

按事件需要携带：

- `nodeId`：节点相关事件必填。
- `port`：端口相关事件填充，尤其是 `port_emit`，`node_error` 可选。

### 3.3 `payloadPreview` 截断规则

`port_emit` 事件可携带 `payloadPreview` 用于 UI 预览。

- `payloadPreview` 为序列化后的字符串快照，不保证完整。
- 默认最大长度为 1024 字节，超过时按 UTF-8 安全边界截断。
- 截断后必须设置 `payloadTruncated=true`；未截断时为 `false`。
- 完整负载不通过该字段保证传输。

## 4. 心跳与断线重连

### 4.1 心跳

- 客户端可发送 `ping`。
- 服务端应回复 `pong`。
- 双方可在空闲期使用心跳检测链路存活。

### 4.2 断线重连

重连流程：

1. 客户端重连建立 WebSocket。
2. 客户端优先发送 `auth`。
3. 鉴权成功后重新发送 `subscribe`。
4. 服务端按订阅过滤返回事件流。

补拉策略（协议层）：

- 服务端维护每个订阅维度的 ring buffer。
- 重连后可补拉“最近 N 条”事件。
- `N` 为服务端可配置窗口大小，协议不约束具体值。
- 该策略仅定义传输语义，不要求持久化存储。

## 5. JSON 示例

### 5.1 `auth`

```json
{
  "type": "auth",
  "data": {
    "token": "token-abc"
  }
}
```

### 5.2 `subscribe`

```json
{
  "v": 1,
  "type": "subscribe",
  "data": {
    "runId": "run-1",
    "sessionId": "session-1"
  }
}
```

### 5.3 `node_event`（`port_emit`）

```json
{
  "v": 1,
  "type": "node_event",
  "data": {
    "event": "port_emit",
    "runId": "run-1",
    "seq": 12,
    "traceId": "trace-1",
    "spanId": "span-2",
    "nodeId": "extract-detail",
    "port": "content",
    "payloadPreview": "{\"title\":\"示例\"}",
    "payloadTruncated": false
  }
}
```

### 5.4 `node_event`（`node_error`）

```json
{
  "v": 1,
  "type": "node_event",
  "data": {
    "event": "node_error",
    "runId": "run-1",
    "seq": 13,
    "traceId": "trace-1",
    "spanId": "span-3",
    "nodeId": "normalize-content",
    "port": "input",
    "message": "下游接口响应超时",
    "code": "UPSTREAM_TIMEOUT"
  }
}
```
