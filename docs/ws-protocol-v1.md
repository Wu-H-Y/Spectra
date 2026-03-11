# WebSocket NodeEvent 流协议 v1

本文对应当前代码中的 `rust/src/rules_ir/ws_protocol.rs`。重点覆盖规则执行期的事件流、字段语义与调试时应关注的关键字段。

## 0. 运行时归属（Flutter-owned runtime）

本协议只定义事件词汇与消息封套，不改变现有 `type`、`NodeEvent` 事件值与 `SubscriptionFilter` 字段。

- Flutter 是唯一的 `runtime operator`，负责发起会改变运行时状态的动作。
- Web Editor 仅允许作为 `attach/read-only diagnostics`，用于附着式诊断与只读观察。它可以订阅事件流用于展示与定位问题，但不得被描述为运行时控制面。

## 1. 外层封套

所有服务端消息统一使用 `WsMessageV1<T>`：

```json
{
  "v": 1,
  "type": "string",
  "data": {}
}
```

- `v`，协议版本，当前固定为 `1`。
- `type`，消息类型。
- `data`，可选负载。

服务端消息必须显式携带 `v=1`。客户端消息允许省略 `v`，省略时按 `v=1` 处理。

## 2. 客户端消息

客户端使用 `ClientMessageEnvelopeV1`，结构为：

```json
{
  "v": 1,
  "type": "auth",
  "data": {}
}
```

或在允许缺省版本时：

```json
{
  "type": "subscribe",
  "data": {}
}
```

### 2.1 当前消息类型

- `auth`
- `subscribe`
- `unsubscribe`
- `ping`
- `pong`

### 2.2 `auth`

```json
{
  "type": "auth",
  "data": {
    "token": "jwt-or-session-token"
  }
}
```

### 2.3 `subscribe` / `unsubscribe`

`data` 为 `SubscriptionFilter`：

- `runId?: string`
- `sessionId?: string`
- `previewSessionId?: string`

服务端按“全部匹配”语义处理过滤条件。

## 3. 服务端消息类型

服务端当前会下发：

- `node_event`
- `element_selected`
- `selection_started`
- `selection_cancelled`

其中规则执行主事件流统一走 `type="node_event"`，其 `data` 为 `NodeEvent`。

## 4. `NodeEvent` 当前事件集合

当前 `NodeEvent` 事件值如下：

- `run_started`
- `node_started`
- `port_emit`
- `node_log`
- `node_error`
- `node_finished`
- `run_finished`

## 5. 公共字段语义

所有 `NodeEvent` 都包含：

- `runId`，一次规则运行实例 ID。
- `seq`，同一 `runId` 内严格单调递增的事件序号。

可选链路字段：

- `traceId?`
- `spanId?`

按事件类型补充：

- `nodeId`，节点相关事件必带。
- `port`，端口相关事件使用。

调试时推荐首先按 `runId` 聚合同一次运行，再按 `seq` 排序重建事件时间线。`seq` 不是节点内局部序号，而是该次运行下的全局递增序号。

## 6. 各事件字段说明

### 6.1 `run_started`

字段：

- `runId`
- `seq`
- `traceId?`
- `spanId?`

语义：运行开始，但尚未指向具体 `nodeId`。

### 6.2 `node_started`

字段：

- `runId`
- `seq`
- `traceId?`
- `spanId?`
- `nodeId`

语义：节点开始执行。

### 6.3 `port_emit`

字段：

- `runId`
- `seq`
- `traceId?`
- `spanId?`
- `nodeId`
- `port`
- `payloadPreview?`
- `payloadTruncated: bool`
- `cacheHit: bool`，缺省时不序列化，表示 `false`

字段语义：

- `payloadPreview` 是输出值的字符串化快照，面向 UI 调试，不保证完整。
- `payloadTruncated=true` 表示快照已按字节上限截断。
- `cacheHit=true` 表示这次输出来自节点执行缓存，而不是本次重新执行节点语义。

当前实现中，节点缓存键会结合规则 `irVersion`、`nodeId` 与输入哈希计算，因此 `cacheHit` 很适合用来判断一次输出是否命中既有输入结果。

### 6.4 `node_log`

字段：

- `runId`
- `seq`
- `traceId?`
- `spanId?`
- `nodeId`
- `level`
- `message`

语义：节点运行期间的日志事件。当前代码中，`fetch` 节点在触发 `rateLimit` 延迟时会发出 `node_log`，`level` 为 `info`，`message` 中会包含本次等待毫秒数、`count` 与 `periodMs`。

这类事件适合在调试面板中作为“非错误但影响执行节奏”的说明信息展示。

### 6.5 `node_error`

字段：

- `runId`
- `seq`
- `traceId?`
- `spanId?`
- `nodeId`
- `port?`
- `message`
- `code?`

语义：节点执行失败。当前实现里的 `code` 可能包括：

- `MISSING_INPUT`
- `TYPE_MISMATCH`
- `JOIN_WITHOUT_INPUTS`
- `MISSING_FINAL_RESULT`
- `NODE_FAILED`
- `JS_TIMEOUT`
- `TASK_JOIN`
- 节点自定义错误码，例如 `CHALLENGE_REQUIRED`

### 6.6 `node_finished`

字段：

- `runId`
- `seq`
- `traceId?`
- `spanId?`
- `nodeId`
- `success: bool`

语义：节点完成，`success=false` 通常意味着此前同一 `nodeId` 已出现 `node_error`。

### 6.7 `run_finished`

字段：

- `runId`
- `seq`
- `traceId?`
- `spanId?`
- `success: bool`

语义：整次运行完成。若任一节点失败，当前实现会令 `success=false`。

## 7. `payloadPreview` 截断规则

当前运行时会把输出值序列化为字符串，再按 UTF-8 安全边界截断。

- 默认最大长度为 1024 字节。
- 未超限时，`payloadTruncated=false`。
- 超限时，`payloadTruncated=true`。
- 该字段只用于预览，不承诺是完整输出。

## 8. 事件流调试建议

调试新规则时，建议按以下顺序观察：

1. 看 `run_started` 是否到达。
2. 按 `seq` 检查每个 `node_started`、`port_emit`、`node_error`。
3. 若 `port_emit.cacheHit=true`，优先确认是不是输入未变化导致命中缓存。
4. 若出现 `node_log`，把它视为执行说明，而不是失败信号。
5. 用 `nodeId` + `port` 回到 IR 文档和节点库文档比对端口语义。

## 9. JSON 示例

### 9.1 `node_event`，`port_emit`

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
    "nodeId": "search_model",
    "port": "normalized",
    "payloadPreview": "{\"search\":{\"items\":[{\"title\":\"示例\",\"url\":\"https://example.com\"}]}}",
    "payloadTruncated": false,
    "cacheHit": true
  }
}
```

### 9.2 `node_event`，`node_log`

```json
{
  "v": 1,
  "type": "node_event",
  "data": {
    "event": "node_log",
    "runId": "run-1",
    "seq": 8,
    "nodeId": "fetch_search",
    "level": "info",
    "message": "触发规则限速，延迟请求 300 ms（count=2, periodMs=300）"
  }
}
```

### 9.3 `node_event`，`node_error`

```json
{
  "v": 1,
  "type": "node_event",
  "data": {
    "event": "node_error",
    "runId": "run-1",
    "seq": 13,
    "nodeId": "fetch_detail",
    "message": "检测到目标站点返回验证/挑战页面（HTTP 403 Forbidden），已中止当前请求。当前版本暂不支持交互式会话处理，请先在浏览器确认站点可访问后再重试。",
    "code": "CHALLENGE_REQUIRED"
  }
}
```

## 10. 关联文档

- `docs/rules-ir-v1.md`
- `docs/rules-node-library-v1.md`
- `docs/normalized-model-fields-v1.md`
