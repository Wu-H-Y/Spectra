# HTTP API 契约 v1

本文定义 Spectra 内置 server 的 HTTP API 契约 v1，覆盖规则管理与执行相关接口。

## 0. 运行时归属（Flutter-owned runtime）

本契约默认遵循 `docs/runtime-ownership-v1.md`：

- Flutter 是唯一的 `runtime operator`，负责发起会改变运行时状态的动作。
- Web Editor 仅允许作为 `attach/read-only diagnostics`，用于附着式诊断与只读观察，不得作为运行时控制面。

## 1. 范围与挂载关系

- 当前已存在状态接口：`GET /api/server/status`。
- 新增接口全部挂载在同一 server 实例下，统一使用 `/api/*` 前缀。
- 本文仅定义契约，不包含实现细节。

## 2. 鉴权约定

### 2.1 `GET /api/server/status`

- 该接口用于发现服务状态与鉴权令牌。
- 响应在现有字段 `isRunning`、`port`、`url` 基础上新增 `serverToken`。
- `serverToken` 为 Flutter host 完整权限鉴权凭据，用于发起 preview/execute 等运行时操作。
- 新增 `attachToken` 为 Web editor 只读附着鉴权凭据，仅用于 WebSocket 连接的只读诊断附着。
- 本条为契约扩展描述，本任务不实现。

示例响应：

```json
{
  "isRunning": true,
  "port": 15421,
  "url": "http://localhost:15421",
  "serverToken": "st_8f2a0f6f...",
  "attachToken": "attach_st_8f2a0f6f..."
}
```

**权限说明：**
- `serverToken`：Flutter host 专用，可调用所有 API（包括 preview/open、execute 等）
- `attachToken`：Web editor 专用，仅用于 WebSocket 连接的只读诊断附着，不能发起任何运行时操作

### 2.2 `/api/*` 访问控制

- 除 `GET /api/server/status` 外，所有 `/api/*` 接口必须携带：

```http
Authorization: Bearer <serverToken>
```

- 缺失、格式错误或令牌无效时，服务端返回 `401 unauthorized`。

### 2.3 `/ws` 首条消息鉴权

- 客户端连接 `/ws` 后，第一条消息必须为 `auth`。
- 消息结构与流程遵循 `docs/ws-protocol-v1.md`（Task 2 产物）。
- 在鉴权通过前，服务端不得下发业务事件。

## 3. 通用约定

### 3.1 数据格式

- 请求与响应默认 `Content-Type: application/json`。
- JSON 字段统一使用 `camelCase`。
- 时间字段使用 ISO 8601 字符串（UTC）。

### 3.2 通用错误响应结构

```json
{
  "error": {
    "type": "bad_request",
    "message": "请求参数不合法",
    "requestId": "req_01HZY...",
    "details": [
      {
        "path": "graph.nodes[2].inputs[0].dataType",
        "code": "TYPE_MISMATCH",
        "message": "输入端口类型与上游输出不匹配",
        "nodeId": "content_normalize"
      }
    ]
  }
}
```

字段说明：

- `error.type`：错误类型，枚举值见下文。
- `error.message`：错误摘要。
- `error.requestId`：请求追踪 ID。
- `error.details`：诊断列表，可为空数组。
- `error.details[].path`：定位路径。
- `error.details[].code`：机器可读错误码。
- `error.details[].message`：诊断描述。
- `error.details[].nodeId`：关联节点 ID，无节点上下文时可省略。

### 3.3 通用错误类型与状态码

- `400 bad_request`：参数缺失、格式错误、语义校验失败。
- `401 unauthorized`：未携带或携带了无效 `Authorization`。
- `500 internal_error`：服务端内部错误。

示例：

`400 bad_request`

```json
{
  "error": {
    "type": "bad_request",
    "message": "rule.name 不能为空",
    "requestId": "req_01HZY...",
    "details": [
      {
        "path": "rule.metadata.name",
        "code": "REQUIRED_FIELD",
        "message": "字段不能为空",
        "nodeId": "metadata"
      }
    ]
  }
}
```

`401 unauthorized`

```json
{
  "error": {
    "type": "unauthorized",
    "message": "缺少或无效的 serverToken",
    "requestId": "req_01HZY...",
    "details": []
  }
}
```

`500 internal_error`

```json
{
  "error": {
    "type": "internal_error",
    "message": "服务端内部错误",
    "requestId": "req_01HZY...",
    "details": []
  }
}
```

## 4. Rules API

规则对象建议复用 IR v1 封套结构（见 `docs/rules-ir-v1.md`）。

### 4.1 `GET /api/rules`

用途：查询规则列表。

响应 `200`：

```json
{
  "items": [
    {
      "id": "rule_demo_001",
      "name": "演示规则",
      "irVersion": "1.0.0",
      "updatedAt": "2026-03-05T10:00:00Z"
    }
  ],
  "total": 1
}
```

curl：

```bash
curl -X GET "http://localhost:15421/api/rules" \
  -H "Authorization: Bearer <serverToken>"
```

### 4.2 `POST /api/rules`

用途：创建规则。

请求体：

```json
{
  "rule": {
    "irVersion": "1.0.0",
    "metadata": {
      "ruleId": "demo.min",
      "name": "最小规则",
      "description": "用于演示"
    },
    "graph": {
      "nodes": [],
      "edges": [],
      "phaseEntrypoints": {}
    },
    "normalizedOutputs": {},
    "capabilities": {
      "supportsPagination": false,
      "supportsConcurrency": false,
      "requiresAuth": false
    }
  }
}
```

响应 `201`：

```json
{
  "id": "rule_demo_001",
  "createdAt": "2026-03-05T10:00:00Z"
}
```

curl：

```bash
curl -X POST "http://localhost:15421/api/rules" \
  -H "Authorization: Bearer <serverToken>" \
  -H "Content-Type: application/json" \
  -d '{"rule":{"irVersion":"1.0.0","metadata":{"ruleId":"demo.min","name":"最小规则","description":"用于演示"},"graph":{"nodes":[],"edges":[],"phaseEntrypoints":{}},"normalizedOutputs":{},"capabilities":{"supportsPagination":false,"supportsConcurrency":false,"requiresAuth":false}}}'
```

### 4.3 `PUT /api/rules/:id`

用途：更新指定规则。

路径参数：

- `id`：规则 ID。

请求体：同 `POST /api/rules`。

响应 `200`：

```json
{
  "id": "rule_demo_001",
  "updatedAt": "2026-03-05T10:30:00Z"
}
```

curl：

```bash
curl -X PUT "http://localhost:15421/api/rules/rule_demo_001" \
  -H "Authorization: Bearer <serverToken>" \
  -H "Content-Type: application/json" \
  -d '{"rule":{"irVersion":"1.0.0","metadata":{"ruleId":"demo.min","name":"最小规则-更新","description":"用于演示"},"graph":{"nodes":[],"edges":[],"phaseEntrypoints":{}},"normalizedOutputs":{},"capabilities":{"supportsPagination":false,"supportsConcurrency":false,"requiresAuth":false}}}'
```

### 4.4 `DELETE /api/rules/:id`

用途：删除指定规则。

路径参数：

- `id`：规则 ID。

响应 `200`：

```json
{
  "id": "rule_demo_001",
  "deleted": true
}
```

curl：

```bash
curl -X DELETE "http://localhost:15421/api/rules/rule_demo_001" \
  -H "Authorization: Bearer <serverToken>"
```

### 4.5 `POST /api/rules/validate`

用途：对规则进行结构与语义校验，不落库。

请求体：

```json
{
  "rule": {
    "irVersion": "1.0.0",
    "metadata": {
      "ruleId": "demo.min",
      "name": "最小规则",
      "description": "用于校验"
    },
    "graph": {
      "nodes": [],
      "edges": [],
      "phaseEntrypoints": {}
    },
    "normalizedOutputs": {},
    "capabilities": {
      "supportsPagination": false,
      "supportsConcurrency": false,
      "requiresAuth": false
    }
  }
}
```

响应 `200`：

```json
{
  "valid": true,
  "diagnostics": []
}
```

响应 `400`（校验失败）：

```json
{
  "error": {
    "type": "bad_request",
    "message": "规则校验失败",
    "requestId": "req_01HZY...",
    "details": [
      {
        "path": "graph.edges[1].from.nodeId",
        "code": "UNKNOWN_NODE",
        "message": "引用了不存在的节点",
        "nodeId": "ghost_node"
      }
    ]
  }
}
```

curl：

```bash
curl -X POST "http://localhost:15421/api/rules/validate" \
  -H "Authorization: Bearer <serverToken>" \
  -H "Content-Type: application/json" \
  -d '{"rule":{"irVersion":"1.0.0","metadata":{"ruleId":"demo.min","name":"最小规则","description":"用于校验"},"graph":{"nodes":[],"edges":[],"phaseEntrypoints":{}},"normalizedOutputs":{},"capabilities":{"supportsPagination":false,"supportsConcurrency":false,"requiresAuth":false}}}'
```

### 4.6 `POST /api/rules/execute`

用途：提交规则执行任务，返回 `runId`。

请求体：

```json
{
  "ruleId": "rule_demo_001",
  "input": {
    "query": "示例关键字"
  },
  "sessionId": "sess_01HZY..."
}
```

响应 `202`：

```json
{
  "runId": "run_01HZZ...",
  "status": "accepted"
}
```

curl：

```bash
curl -X POST "http://localhost:15421/api/rules/execute" \
  -H "Authorization: Bearer <serverToken>" \
  -H "Content-Type: application/json" \
  -d '{"ruleId":"rule_demo_001","input":{"query":"示例关键字"},"sessionId":"sess_01HZY"}'
```

## 5. Sessions API

### 5.0 SessionCookies v1（交互式会话 cookie 包）

`SessionCookies` 用于承载交互式会话（agent-browser / WebView / Tauri）的 cookie 提交载荷，仅用于 API 内部传递，不提供文件导出能力。

字段定义：

- `v`：协议版本，当前固定为 `1`。
- `createdAt`：载荷创建时间，ISO 8601（UTC）。
- `platform`：来源平台，枚举：`windows | macos | linux | android | ios`。
- `sourceUrl`：会话来源 URL，用于校验与诊断；仅允许 `http` 或 `https` scheme。
- `allowlistDomains`：允许导入的域名白名单（必填，至少 1 项）。
- `cookies`：cookie 列表（可为空数组）。

`cookies[]` 子项定义：

- 必填：`domain`、`path`、`name`、`value`。
- 可选：`expiresDateMs`、`httpOnly`、`secure`、`sameSite`。

示例（最小可用）：

```json
{
  "v": 1,
  "createdAt": "2026-03-09T10:30:00Z",
  "platform": "windows",
  "sourceUrl": "https://accounts.example.com/login",
  "allowlistDomains": [
    ".example.com"
  ],
  "cookies": [
    {
      "domain": ".example.com",
      "path": "/",
      "name": "session_id",
      "value": "masked-example-value",
      "httpOnly": true,
      "secure": true,
      "sameSite": "Lax"
    }
  ]
}
```

配套 fixtures：

- `fixtures/session_cookies_v1_min.json`
- `fixtures/session_cookies_v1_invalid.json`

安全约束（强制）：

- 仅允许导入 `allowlistDomains` 内的 cookies，禁止跨域注入。
- `sourceUrl` 仅允许 `http/https`；其他 scheme 一律拒绝。
- 日志、NodeEvent、WS 消息与 HTTP API 响应均不得输出 cookie 明文（`value`）。
- `POST /api/sessions/{sessionId}/commit-cookies` 仅返回 summary，不返回 cookie 明文。

### 5.1 `POST /api/sessions`

用途：创建“交互式登录会话”，用于后续提交 `SessionCookies v1` 到规则级 CookieJar。

请求体：

```json
{
  "ruleId": "rule_demo_001",
  "url": "https://accounts.example.com/login",
  "allowlistDomains": [
    ".example.com"
  ],
  "purpose": "login"
}
```

字段说明：

- `ruleId`：目标规则 ID。
- `url`：交互式会话入口 URL。
- `allowlistDomains`：本会话允许写入 CookieJar 的域名白名单。
- `purpose`：会话用途；v1 仅允许 `login`。

响应 `201`：

```json
{
  "sessionId": "sess_01HZY...",
  "ruleId": "rule_demo_001",
  "purpose": "login",
  "createdAt": "2026-03-05T10:00:00Z"
}
```

curl：

```bash
curl -X POST "http://localhost:15421/api/sessions" \
  -H "Authorization: Bearer <serverToken>" \
  -H "Content-Type: application/json" \
  -d '{"ruleId":"rule_demo_001","url":"https://accounts.example.com/login","allowlistDomains":[".example.com"],"purpose":"login"}'
```

### 5.2 `POST /api/sessions/{sessionId}/commit-cookies`

用途：提交 `SessionCookies v1` 到规则级 CookieJar，并返回导入摘要（不含明文）。

路径参数：

- `sessionId`：会话 ID。

请求体：

```json
{
  "sessionCookies": {
    "v": 1,
    "createdAt": "2026-03-09T10:30:00Z",
    "platform": "windows",
    "sourceUrl": "https://accounts.example.com/login",
    "allowlistDomains": [
      ".example.com"
    ],
    "cookies": [
      {
        "domain": ".example.com",
        "path": "/",
        "name": "session_id",
        "value": "masked-example-value",
        "httpOnly": true,
        "secure": true,
        "sameSite": "Lax"
      }
    ]
  }
}
```

说明：

- 请求体中的 `sessionCookies` 必须符合本节 `SessionCookies v1`。
- 即使请求体携带 cookie 明文，服务端日志与返回体也必须脱敏，不得回传明文。

响应 `200`：

```json
{
  "sessionId": "sess_01HZY...",
  "committed": true,
  "committedAt": "2026-03-05T10:20:00Z",
  "summary": {
    "cookieCount": 2,
    "domains": [
      ".example.com"
    ],
    "droppedCookieCount": 1
  }
}
```

`summary` 字段说明：

- `cookieCount`：实际写入 CookieJar 的 cookie 数。
- `domains`：实际写入涉及的域名列表。
- `droppedCookieCount`：被过滤/拒绝的 cookie 数（例如越权域名、过期等）。

curl：

```bash
curl -X POST "http://localhost:15421/api/sessions/sess_01HZY/commit-cookies" \
  -H "Authorization: Bearer <serverToken>" \
  -H "Content-Type: application/json" \
  -d '{"sessionCookies":{"v":1,"createdAt":"2026-03-09T10:30:00Z","platform":"windows","sourceUrl":"https://accounts.example.com/login","allowlistDomains":[".example.com"],"cookies":[{"domain":".example.com","path":"/","name":"session_id","value":"masked-example-value","httpOnly":true,"secure":true,"sameSite":"Lax"}]}}'
```

### 5.3 `DELETE /api/sessions/{sessionId}`

用途：删除会话并释放相关资源。

路径参数：

- `sessionId`：会话 ID。

响应 `200`：

```json
{
  "sessionId": "sess_01HZY...",
  "deleted": true
}
```

curl：

```bash
curl -X DELETE "http://localhost:15421/api/sessions/sess_01HZY" \
  -H "Authorization: Bearer <serverToken>"
```

## 6. Preview API

### 6.1 `POST /api/preview/open`

用途：创建并打开预览会话。

请求体：

```json
{
  "sessionId": "sess_01HZY...",
  "url": "https://example.com/list"
}
```

响应 `200`：

```json
{
  "opened": true,
  "previewSessionId": "preview_01HZY...",
  "debugUrl": "https://example.com/list",
  "wsChannel": {
    "previewSessionId": "preview_01HZY..."
  }
}
```

- `debugUrl`：当前最小实现下返回目标页面 URL，用于桌面调试场景。
- `wsChannel.previewSessionId`：WebSocket 订阅过滤器。附着式诊断客户端可以据此订阅并关联只读展示（例如在调试面板中展示选中元素信息），但不得把自身描述为运行时操作者。

curl：

```bash
curl -X POST "http://localhost:15421/api/preview/open" \
  -H "Authorization: Bearer <serverToken>" \
  -H "Content-Type: application/json" \
  -d '{"sessionId":"sess_01HZY","url":"https://example.com/list"}'
```

### 6.2 `POST /api/preview/test-selector`

用途：在预览上下文中测试选择器。

请求体：

```json
{
  "previewSessionId": "preview_01HZY...",
  "selector": ".item > a.title",
  "mode": "text"
}
```

响应 `200`：

```json
{
  "matched": 3,
  "samples": [
    "标题 A",
    "标题 B"
  ]
}
```

curl：

```bash
curl -X POST "http://localhost:15421/api/preview/test-selector" \
  -H "Authorization: Bearer <serverToken>" \
  -H "Content-Type: application/json" \
  -d '{"previewSessionId":"preview_01HZY","selector":".item > a.title","mode":"text"}'
```

## 7. 服务状态接口示例

`GET /api/server/status`（无需 `Authorization`）：

```bash
curl -X GET "http://localhost:15421/api/server/status"
```

响应 `200`：

```json
{
  "isRunning": true,
  "port": 15421,
  "url": "http://localhost:15421",
  "serverToken": "st_8f2a0f6f..."
}
```
