# Rules IR v1 规范说明

本文定义当前代码库中 `rust/src/rules_ir/mod.rs` 对应的 IR v1 结构。本文只描述可序列化结构与字段语义，不替代 validator 对图合法性的检查。

## 1. 设计边界

- 顶层封套统一为 `RuleEnvelope`。
- JSON 字段统一使用 `camelCase`。
- enum 统一使用显式 tag 结构。
- IR 负责“可解析”，validator 负责“是否可执行”。

## 2. `RuleEnvelope` 顶层字段

顶层字段如下：

- `irVersion: string`，IR 版本号，当前示例为 `1.0.0`。
- `metadata: Metadata`，规则元信息。
- `graph: Graph`，图结构本体。
- `normalizedOutputs: Record<LifecyclePhase, PortRef>`，阶段到标准化输出端口的映射。
- `capabilities: Capabilities`，规则能力声明。
- `rateLimit?: RuleRateLimit`，可选规则级限速配置。

其中 `rateLimit` 为当前实现已支持字段，缺省表示本次运行不启用规则级限速。

### 2.1 `Metadata`

- `ruleId: string`
- `name: string`
- `description?: string`

### 2.2 `RuleRateLimit`

- `count: number`，时间窗口内允许的请求数。
- `periodMs: number`，时间窗口大小，单位毫秒。

运行时会把该配置共享给当前规则执行中的所有 `fetch` 节点。若 `count=0` 或 `periodMs=0`，当前实现会视为无效配置并忽略。

## 3. 版本策略

IR v1 仅以 `RuleEnvelope.irVersion` 作为版本入口。

- 破坏性变更，主版本递增。
- 向后兼容新增，次版本递增。
- 仅实现或文档修正，补丁版本递增。

读取端应先判断 `irVersion` 主版本是否受支持，再进入反序列化与校验流程。

## 4. 生命周期阶段

`LifecyclePhase` 当前集合为：

- `explore`
- `search`
- `detail`
- `toc`
- `content`

阶段出现在以下位置：

- `Node.phase`
- `Graph.phaseEntrypoints`
- `RuleEnvelope.normalizedOutputs`

## 5. `Graph` 结构

`Graph` 当前字段如下：

- `nodes: Node[]`
- `edges: Edge[]`
- `phaseEntrypoints: Record<LifecyclePhase, PortRef>`
- `metadata?: GraphMetadata`
- `layout?: GraphLayout`

### 5.1 `GraphMetadata`

- `name?: string`
- `description?: string`
- `tags: string[]`

### 5.2 `GraphLayout`

- `nodes: Record<string, NodeLayout>`

### 5.3 `NodeLayout`

- `x: number`
- `y: number`

## 6. 节点、边与端口引用

### 6.1 `Node`

- `id: string`
- `kind: NodeKind`
- `phase: LifecyclePhase`
- `inputs: Port[]`
- `outputs: Port[]`
- `params: Record<string, string>`

`params` 是当前运行时读取节点语义的主要入口。未知参数是否允许，由具体节点实现决定。

### 6.2 `Edge`

- `from: PortRef`
- `to: PortRef`

### 6.3 `PortRef`

- `nodeId: string`
- `portName: string`

`nodeId` 与 `portName` 是文档、调试协议、运行日志三处共享的核心定位字段。

## 7. 当前 `NodeKind` 集合

当前代码中的 `NodeKind` 全量集合如下：

- `fetch`
- `parse`
- `select`
- `transform`
- `join`
- `branch`
- `mapToModel`
- `loop`
- `filter`
- `assert`
- `input`
- `extract`
- `normalize`
- `output`

说明：

- 上述列表是 IR 允许出现的当前完整节点种类。
- 其中运行时有专门语义实现的节点主要是 `fetch`、`parse`、`select`、`transform`、`join`、`mapToModel`、`input`。
- 其余节点当前仍会进入通用透传逻辑，适合作为占位或后续扩展，不应误认为都已有独立执行语义。

详细节点说明见 `docs/rules-node-library-v1.md`。

## 8. 当前 `DataType` 集合

`Port.dataType` 使用 `DataType`，当前完整集合如下：

- `text`
- `html`
- `json`
- `url`
- `list`
- `record`
- `normalizedModel`

### 8.1 `list`

结构：

```json
{ "type": "list", "item": { "type": "text" } }
```

### 8.2 `record`

结构：

```json
{
  "type": "record",
  "fields": [
    {
      "name": "title",
      "dataType": { "type": "text" },
      "optional": false
    }
  ]
}
```

### 8.3 `normalizedModel`

表示 `NormalizedModel` 顶层对象。其字段参考见 `docs/normalized-model-fields-v1.md`。

## 9. `Port` 与 `RecordField`

### 9.1 `Port`

- `name: string`
- `dataType: DataType`
- `optional: bool`

### 9.2 `RecordField`

- `name: string`
- `dataType: DataType`
- `optional: bool`

## 10. `Capabilities`

当前 `Capabilities` 字段如下：

- `supportsPagination: bool`
- `supportsConcurrency: bool`
- `requiresAuth: bool`
- `supportsJs: bool`

其中 `supportsJs` 为当前实现已接入的能力声明字段，用于约束是否允许规则使用 JS transform。规则作者若使用 `transform` 节点且 `family=js`，应显式把 `supportsJs` 设为 `true`。

## 11. 当前实现相关约束

- IR 可解析不代表图一定可执行。
- `phaseEntrypoints` 与 `normalizedOutputs` 是否完整，由 validator 进一步校验。
- `rateLimit` 只描述规则级限速，不改变节点 JSON 结构。
- 运行态缓存键会包含 `irVersion`、`nodeId` 与输入哈希，因此文档或调试时应保留这些字段的稳定性认知。

## 12. 最小示例

```json
{
  "irVersion": "1.0.0",
  "metadata": {
    "ruleId": "demo.search",
    "name": "最小搜索规则",
    "description": "演示 input 到 mapToModel 的最小链路"
  },
  "graph": {
    "nodes": [
      {
        "id": "search_input",
        "kind": { "type": "input" },
        "phase": "search",
        "inputs": [],
        "outputs": [
          {
            "name": "items",
            "dataType": {
              "type": "list",
              "item": {
                "type": "record",
                "fields": [
                  {
                    "name": "title",
                    "dataType": { "type": "text" },
                    "optional": false
                  },
                  {
                    "name": "url",
                    "dataType": { "type": "url" },
                    "optional": false
                  }
                ]
              }
            },
            "optional": false
          }
        ],
        "params": {}
      },
      {
        "id": "search_model",
        "kind": { "type": "mapToModel" },
        "phase": "search",
        "inputs": [
          {
            "name": "items",
            "dataType": {
              "type": "list",
              "item": {
                "type": "record",
                "fields": [
                  {
                    "name": "title",
                    "dataType": { "type": "text" },
                    "optional": false
                  },
                  {
                    "name": "url",
                    "dataType": { "type": "url" },
                    "optional": false
                  }
                ]
              }
            },
            "optional": false
          }
        ],
        "outputs": [
          {
            "name": "normalized",
            "dataType": { "type": "normalizedModel" },
            "optional": false
          }
        ],
        "params": {
          "target": "search"
        }
      }
    ],
    "edges": [
      {
        "from": { "nodeId": "search_input", "portName": "items" },
        "to": { "nodeId": "search_model", "portName": "items" }
      }
    ],
    "phaseEntrypoints": {
      "search": { "nodeId": "search_input", "portName": "items" }
    }
  },
  "normalizedOutputs": {
    "search": { "nodeId": "search_model", "portName": "normalized" }
  },
  "capabilities": {
    "supportsPagination": true,
    "supportsConcurrency": false,
    "requiresAuth": false,
    "supportsJs": false
  },
  "rateLimit": {
    "count": 2,
    "periodMs": 300
  }
}
```

## 13. 关联文档

- `docs/ws-protocol-v1.md`
- `docs/rules-node-library-v1.md`
- `docs/normalized-model-fields-v1.md`
