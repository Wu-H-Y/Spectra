# 爬虫规则编辑器 API 文档

## 概述

Spectra 内置 HTTP 服务器，提供 REST API 用于规则管理和 WebSocket 用于实时通信。

## 基础信息

- **协议**: HTTP/1.1
- **数据格式**: JSON
- **字符编码**: UTF-8
- **默认端口**: 随机分配（可配置）

## 认证

当前版本无需认证，但建议在受信任的网络环境中使用。

## 通用响应格式

### 成功响应

```json
{
  "success": true,
  "data": { ... }
}
```

### 错误响应

```json
{
  "success": false,
  "error": "错误信息",
  "code": "ERROR_CODE"
}
```

---

## 规则管理 API

### 获取规则列表

```
GET /api/rules
```

**响应**

```json
[
  {
    "id": "rule-id",
    "name": "规则名称",
    "mediaType": "video",
    "enabled": true,
    ...
  }
]
```

### 获取单个规则

```
GET /api/rules/{id}
```

**参数**

- `id` (path) - 规则 ID

**响应**

```json
{
  "id": "rule-id",
  "name": "规则名称",
  ...
}
```

### 创建规则

```
POST /api/rules
```

**请求体**

```json
{
  "name": "新规则",
  "mediaType": "video",
  "match": {
    "pattern": "example.com/video",
    "type": "regex"
  },
  "extract": { ... }
}
```

**响应**

返回创建的规则，包含生成的 `id` 和时间戳。

### 更新规则

```
PUT /api/rules/{id}
```

**参数**

- `id` (path) - 规则 ID

**请求体**

```json
{
  "name": "更新后的名称",
  ...
}
```

### 删除规则

```
DELETE /api/rules/{id}
```

**参数**

- `id` (path) - 规则 ID

**响应**

```json
{
  "success": true
}
```

---

## 验证 API

### 验证规则

```
POST /api/validate
```

**请求体**

完整的规则 JSON 对象

**响应**

```json
{
  "valid": true,
  "errors": []
}
```

**验证失败响应**

```json
{
  "valid": false,
  "errors": [
    {
      "path": "match.pattern",
      "message": "Pattern cannot be empty"
    }
  ]
}
```

---

## 执行 API

### 执行规则

```
POST /api/execute
```

**请求体**

```json
{
  "ruleId": "rule-id",
  "url": "https://example.com/video/123"
}
```

**响应**

```json
{
  "success": true,
  "data": {
    "title": "视频标题",
    "cover": "https://...",
    ...
  },
  "extractedCount": 1
}
```

---

## 服务器状态 API

### 获取服务器状态

```
GET /api/server/status
```

**响应**

```json
{
  "isRunning": true,
  "port": 8080,
  "url": "http://192.168.1.100:8080"
}
```

### 启动服务器

```
POST /api/server/start
```

### 停止服务器

```
POST /api/server/stop
```

---

## 预览 API

### 打开预览页面

```
POST /api/preview/open
```

**请求体**

```json
{
  "url": "https://example.com"
}
```

**响应**

```json
{
  "success": true
}
```

### 测试选择器

```
POST /api/preview/test-selector
```

**请求体**

```json
{
  "url": "https://example.com",
  "selector": {
    "type": "css",
    "expression": ".title"
  }
}
```

**响应**

```json
{
  "success": true,
  "count": 5,
  "elements": [
    {
      "text": "标题文本",
      "html": "<h1 class=\"title\">标题文本</h1>"
    },
    ...
  ]
}
```

### 获取截图

```
GET /api/preview/screenshot
```

**响应**

Base64 编码的 PNG 图片数据

---

## WebSocket API

### 连接

```
ws://localhost:{port}/api/ws
```

### 消息格式

所有消息使用 JSON 格式：

```json
{
  "type": "message_type",
  "data": { ... }
}
```

### 客户端消息

#### 连接

```json
{ "type": "connect" }
```

#### 开始元素选择

```json
{ "type": "start_selection" }
```

#### 取消元素选择

```json
{ "type": "cancel_selection" }
```

#### 请求截图

```json
{ "type": "request_screenshot" }
```

### 服务端消息

#### 元素已选择

```json
{
  "type": "element_selected",
  "data": {
    "selector": ".video-title",
    "selectorType": "css",
    "outerHtml": "<h1 class=\"video-title\">...</h1>",
    "textContent": "视频标题",
    "rect": {
      "x": 100,
      "y": 200,
      "width": 300,
      "height": 50
    }
  }
}
```

#### 选择已开始

```json
{ "type": "selection_started" }
```

#### 选择已取消

```json
{ "type": "selection_cancelled" }
```

#### 截图已准备

```json
{
  "type": "screenshot_ready",
  "data": {
    "image": "base64-encoded-image-data"
  }
}
```

#### 错误

```json
{
  "type": "error",
  "data": {
    "message": "错误信息",
    "code": "ERROR_CODE"
  }
}
```

---

## 错误代码

| 代码 | 说明 |
|------|------|
| `RULE_NOT_FOUND` | 规则不存在 |
| `VALIDATION_ERROR` | 规则验证失败 |
| `EXECUTION_ERROR` | 规则执行失败 |
| `NETWORK_ERROR` | 网络请求失败 |
| `PARSE_ERROR` | 数据解析失败 |
| `SERVER_ERROR` | 服务器内部错误 |

---

## CORS 配置

服务器默认启用 CORS，允许来自任何源的请求：

```
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS
Access-Control-Allow-Headers: Content-Type
```

---

## 示例

### cURL 示例

```bash
# 获取规则列表
curl http://localhost:8080/api/rules

# 创建规则
curl -X POST http://localhost:8080/api/rules \
  -H "Content-Type: application/json" \
  -d '{"name":"新规则","mediaType":"video","match":{"pattern":"example.com","type":"regex"},"extract":{}}'

# 执行规则
curl -X POST http://localhost:8080/api/execute \
  -H "Content-Type: application/json" \
  -d '{"ruleId":"rule-id","url":"https://example.com/video/123"}'
```

### JavaScript 示例

```javascript
// 获取规则列表
const rules = await fetch('/api/rules').then(r => r.json());

// 创建规则
const newRule = await fetch('/api/rules', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    name: '新规则',
    mediaType: 'video',
    match: { pattern: 'example.com', type: 'regex' },
    extract: {}
  })
}).then(r => r.json());

// WebSocket 连接
const ws = new WebSocket('ws://localhost:8080/api/ws');
ws.onmessage = (event) => {
  const message = JSON.parse(event.data);
  console.log('Received:', message);
};
ws.send(JSON.stringify({ type: 'start_selection' }));
```
