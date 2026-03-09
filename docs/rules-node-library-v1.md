# 规则节点库参考 v1

本文列出当前代码库中全部 `NodeKind`，并区分“IR 允许出现”与“运行时已有专门语义实现”。目标是帮助开发者快速写规则、查节点参数、对照 `nodeId` 和端口定位问题。

## 1. 阅读方式

- 节点种类名以 IR 中的 `kind.type` 为准。
- 输入输出仅描述当前实现的常见约定，不替代端口类型校验。
- 若节点未实现专门语义，本文会明确标记“当前走透传语义”。

## 2. 已有专门语义实现的节点

### 2.1 `input`

- 作用：从运行上下文注入初始值。
- 常见输入：无。
- 常见输出：任意，取决于节点声明的 `outputs`。
- 关键点：运行时优先按 `PortRef(nodeId, portName)` 从 `port_inputs` 找值，找不到时再按 `phase` 从 `phase_inputs` 找默认输入。

最小用法：

```json
{
  "id": "search_input",
  "kind": { "type": "input" },
  "phase": "search",
  "inputs": [],
  "outputs": [
    { "name": "query", "dataType": { "type": "text" }, "optional": false }
  ],
  "params": {}
}
```

### 2.2 `fetch`

- 作用：发起 HTTP GET 请求。
- 常见输入：`url` 或 `text`。
- 常见输出：`text`、`html`、`json`。
- 允许参数：`method`、`response`、`url`。

参数说明：

- `method`，当前仅支持 `get`。
- `response`，允许 `text`、`html`、`json`。
- `url`，可选。提供时直接使用该参数，不再从输入端口读取 URL。

调试要点：

- 规则配置了 `rateLimit` 时，节点可能发出 `node_log`。
- 触发透明缓存命中时，对应 `port_emit.cacheHit=true`。
- 若检测到挑战页，可能返回 `node_error.code="CHALLENGE_REQUIRED"`。

最小示例：

```json
{
  "id": "fetch_search",
  "kind": { "type": "fetch" },
  "phase": "search",
  "inputs": [
    { "name": "url", "dataType": { "type": "url" }, "optional": false }
  ],
  "outputs": [
    { "name": "body", "dataType": { "type": "html" }, "optional": false }
  ],
  "params": {
    "method": "get",
    "response": "html"
  }
}
```

### 2.3 `parse`

- 作用：把原始文本收敛为 HTML 或 JSON 运行值。
- 常见输入：`text`、`html`、`url`、`json`。
- 常见输出：`html`、`json`。
- 允许参数：`format`。

参数说明：

- `format=html`，允许输入 `text/html/url`，输出 `html`。
- `format=json`，允许输入 `text/json`，输出 `json`。

最小示例：

```json
{
  "id": "parse_body",
  "kind": { "type": "parse" },
  "phase": "detail",
  "inputs": [
    { "name": "in", "dataType": { "type": "text" }, "optional": false }
  ],
  "outputs": [
    { "name": "doc", "dataType": { "type": "html" }, "optional": false }
  ],
  "params": {
    "format": "html"
  }
}
```

### 2.4 `select`

- 作用：从 HTML、JSON 或文本中选择值。
- 常见输入：`html`、`text`、`json`、`url`。
- 常见输出：`text`、`html`、`json`、`list<...>`。
- 允许参数：`attr`、`engine`、`extract`、`group`、`query`。

`engine` 当前支持：

- `css`
- `xpath`
- `jsonpath`
- `regex`

提取语义：

- `css` 支持 `extract=text/html/attr`。
- `xpath` 支持 `extract=text/html/outerHtml/innerHtml/attr`。
- `jsonpath` 直接把命中节点映射为运行值。
- `regex` 用 `group` 指定捕获组，默认 `0`。

说明：若输出端口声明为 `list<T>`，当前实现会把全部命中结果聚成单个列表输出。若输出端口不是列表，仅取第一条命中结果。

最小示例：

```json
{
  "id": "select_links",
  "kind": { "type": "select" },
  "phase": "search",
  "inputs": [
    { "name": "in", "dataType": { "type": "html" }, "optional": false }
  ],
  "outputs": [
    {
      "name": "links",
      "dataType": { "type": "list", "item": { "type": "text" } },
      "optional": false
    }
  ],
  "params": {
    "engine": "css",
    "query": "a.item",
    "extract": "attr",
    "attr": "href"
  }
}
```

### 2.5 `transform`

- 作用：对文本、列表、JSON、URL 或 JS 结果做变换。
- 常见输入：`text`、`html`、`url`、`list`、`json`。
- 常见输出：取决于 `family` 和 `op`。
- 允许参数：`base`、`family`、`op`、`pattern`、`replacement`、`script`、`separator`。

当前 `family` 与 `op`：

- `text`: `trim`、`lower`、`upper`、`replace`、`normalizespace`
- `list`: `join`、`first`
- `json`: `stringify`
- `convert`: `text`、`url`
- `url`: `normalize`、`join`
- `js`: 通过 `script` 执行 JS，返回文本

说明：

- 使用 `family=js` 时，能力声明应同步开启 `supportsJs=true`。
- 当前 JS 执行有超时、内存、栈限制。

最小示例：

```json
{
  "id": "trim_title",
  "kind": { "type": "transform" },
  "phase": "detail",
  "inputs": [
    { "name": "in", "dataType": { "type": "text" }, "optional": false }
  ],
  "outputs": [
    { "name": "out", "dataType": { "type": "text" }, "optional": false }
  ],
  "params": {
    "family": "text",
    "op": "trim"
  }
}
```

### 2.6 `join`

- 作用：汇聚多个输入端口的值。
- 常见输入：多个任意类型端口。
- 常见输出：单值或 `list<T>`。
- 关键语义：按输入端口声明顺序收集全部消息。

当前行为：

- 若输出端口类型为 `list<T>`，输出聚合后的列表。
- 否则输出最后一条消息。
- 没有任何输入时会报 `JOIN_WITHOUT_INPUTS`。

最小示例：

```json
{
  "id": "join_titles",
  "kind": { "type": "join" },
  "phase": "search",
  "inputs": [
    { "name": "left", "dataType": { "type": "text" }, "optional": false },
    { "name": "right", "dataType": { "type": "text" }, "optional": false }
  ],
  "outputs": [
    {
      "name": "joined",
      "dataType": { "type": "list", "item": { "type": "text" } },
      "optional": false
    }
  ],
  "params": {}
}
```

### 2.7 `mapToModel`

- 作用：把中间 record/list 数据映射成 `NormalizedModel`。
- 常见输入：`record` 或 `list<record>`。
- 常见输出：`normalizedModel`。
- 允许参数：`target`。

`target` 当前支持：

- `search`
- `detail`
- `toc`
- `content`

规则：

- `search` 支持 `list<Record>` 或含 `items` 字段的 `record`。
- `detail` 需要单个 `record`。
- `toc` 支持 `list<Record>` 或含 `chapters` 字段的 `record`。
- `content` 需要单个 `record`，会读取 `contentTextHtml` / `content_text_html`、`contentTextPlain` / `content_text_plain`、`mediaAssets` / `media_assets`。
- 当节点处于 `explore` 阶段时，必须显式提供 `target`。

最小示例：

```json
{
  "id": "detail_model",
  "kind": { "type": "mapToModel" },
  "phase": "detail",
  "inputs": [
    {
      "name": "detail",
      "dataType": {
        "type": "record",
        "fields": [
          { "name": "title", "dataType": { "type": "text" }, "optional": false }
        ]
      },
      "optional": false
    }
  ],
  "outputs": [
    { "name": "normalized", "dataType": { "type": "normalizedModel" }, "optional": false }
  ],
  "params": {
    "target": "detail"
  }
}
```

## 3. 当前仅定义于 IR，但运行时仍走透传语义的节点

以下节点已在 `NodeKind` 中存在，但当前没有独立语义实现，仍使用“取主输入并复制到所有输出”的通用透传逻辑：

- `branch`
- `loop`
- `filter`
- `assert`
- `extract`
- `normalize`
- `output`

使用建议：

- 可以用于图编辑、结构占位或后续扩展。
- 若需要真实语义，请先确认运行时是否已实现，不要只凭节点名推断行为。

## 4. 与调试协议的对应关系

- `nodeId` 对应 `Node.id`
- `port` 对应端口 `name`
- `port_emit.cacheHit` 可判断节点输出是否来自缓存
- `node_log` 适合显示限速、说明性日志
- `node_error.code` 适合显示结构化错误码

## 5. 关联文档

- `docs/rules-ir-v1.md`
- `docs/ws-protocol-v1.md`
- `docs/normalized-model-fields-v1.md`
