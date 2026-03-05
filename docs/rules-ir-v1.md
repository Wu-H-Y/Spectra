# Rules IR v1 规范说明

本文定义 `rules_ir` crate 的 IR v1 数据结构、版本策略与序列化约束。

## 1. 设计目标

- 以 `RuleEnvelope` 作为规则交换与持久化的唯一顶层封套。
- 保证 JSON 结构稳定，字段统一使用 `camelCase`。
- 使用显式 tag 表达 enum/variant，避免歧义反序列化。
- 将“结构可解析”与“语义合法性校验”拆分：IR v1 负责可解析，validator 负责规则完整性。

## 2. 顶层结构

`RuleEnvelope` 顶层必须包含以下字段：

- `irVersion`: IR 版本号字符串，例如 `1.0.0`。
- `metadata`: 规则元信息，包含 `ruleId`、`name`、`description`。
- `graph`: 图结构定义，包含 `nodes`、`edges`、`phaseEntrypoints`。
- `normalizedOutputs`: 生命周期阶段到最终输出端口 `PortRef` 的映射。
- `capabilities`: 规则能力声明。

## 3. 版本策略（schemaVersion / irVersion）

IR v1 将 `schemaVersion` 语义收敛到 `RuleEnvelope.irVersion` 字段，作为单一版本来源：

- **破坏性变更**（删除字段、修改字段含义、修改 enum tag/值）：主版本递增，例如 `1.x.x -> 2.0.0`。
- **向后兼容新增**（新增可选字段、新增不影响旧解析的 variant）：次版本递增，例如 `1.0.x -> 1.1.0`。
- **仅文档或实现修复**（不改变 JSON 可观察结构）：补丁版本递增，例如 `1.0.0 -> 1.0.1`。

在读取端，建议先判断 `irVersion` 主版本是否受支持，再进入反序列化与语义校验流程。

## 4. 生命周期阶段表达

`LifecyclePhase` 在 v1 中包含以下阶段：

- `explore`
- `search`
- `detail`
- `toc`
- `content`

阶段在 IR 中出现于三个位置：

- `Node.phase`: 节点所属阶段。
- `Graph.phaseEntrypoints`: 阶段入口端口映射（最小阶段入口表达）。
- `RuleEnvelope.normalizedOutputs`: 阶段最终标准化输出端口映射。

## 5. 端口类型系统

`Port` 使用 `dataType` 描述端口类型，`DataType` 采用 tag 结构（`type` 字段）并支持：

- `text`
- `html`
- `json`
- `url`
- `list`（包含 `item` 子类型）
- `record`（包含 `fields` 字段列表）
- `normalizedModel`

其中：

- `record.fields[].dataType` 允许递归使用 `DataType`。
- `Port.optional` 与 `RecordField.optional` 用于表达可选输入/字段。

## 6. 图结构与连接

- `Node`：定义节点 ID、类别（`kind`）、阶段、输入输出端口。
- `Edge`：由 `from: PortRef` 与 `to: PortRef` 构成。
- `PortRef`：由 `nodeId` + `portName` 唯一定位端口。

IR v1 仅保证结构可解析，不保证边引用目标必然存在。类似“悬挂边”“类型不匹配”等问题由后续 validator 负责。

## 7. 示例 JSON（最小可解析）

```json
{
  "irVersion": "1.0.0",
  "metadata": {
    "ruleId": "demo.min",
    "name": "最小规则",
    "description": "用于验证 IR v1 最小可解析结构"
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
            "name": "query",
            "dataType": { "type": "text" },
            "optional": false
          }
        ]
      },
      {
        "id": "search_output",
        "kind": { "type": "output" },
        "phase": "search",
        "inputs": [
          {
            "name": "items",
            "dataType": {
              "type": "list",
              "item": { "type": "normalizedModel" }
            },
            "optional": false
          }
        ],
        "outputs": [
          {
            "name": "normalized",
            "dataType": {
              "type": "list",
              "item": { "type": "normalizedModel" }
            },
            "optional": false
          }
        ]
      }
    ],
    "edges": [
      {
        "from": { "nodeId": "search_input", "portName": "query" },
        "to": { "nodeId": "search_output", "portName": "items" }
      }
    ],
    "phaseEntrypoints": {
      "search": { "nodeId": "search_input", "portName": "query" }
    }
  },
  "normalizedOutputs": {
    "search": { "nodeId": "search_output", "portName": "normalized" }
  },
  "capabilities": {
    "supportsPagination": true,
    "supportsConcurrency": false,
    "requiresAuth": false
  }
}
```

## 8. 示例 JSON（可解析但含无效边）

```json
{
  "irVersion": "1.0.0",
  "metadata": {
    "ruleId": "demo.invalid-edge",
    "name": "无效边规则",
    "description": "该示例可解析，但包含指向不存在节点的边"
  },
  "graph": {
    "nodes": [
      {
        "id": "detail_extract",
        "kind": { "type": "extract" },
        "phase": "detail",
        "inputs": [
          {
            "name": "url",
            "dataType": { "type": "url" },
            "optional": false
          }
        ],
        "outputs": [
          {
            "name": "content",
            "dataType": { "type": "html" },
            "optional": false
          }
        ]
      },
      {
        "id": "content_normalize",
        "kind": { "type": "normalize" },
        "phase": "content",
        "inputs": [
          {
            "name": "raw",
            "dataType": {
              "type": "record",
              "fields": [
                {
                  "name": "title",
                  "dataType": { "type": "text" },
                  "optional": false
                },
                {
                  "name": "payload",
                  "dataType": { "type": "json" },
                  "optional": true
                }
              ]
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
        ]
      }
    ],
    "edges": [
      {
        "from": { "nodeId": "detail_extract", "portName": "content" },
        "to": { "nodeId": "content_normalize", "portName": "raw" }
      },
      {
        "from": { "nodeId": "ghost_node", "portName": "missing" },
        "to": { "nodeId": "content_normalize", "portName": "raw" }
      }
    ],
    "phaseEntrypoints": {
      "detail": { "nodeId": "detail_extract", "portName": "url" },
      "content": { "nodeId": "content_normalize", "portName": "raw" }
    }
  },
  "normalizedOutputs": {
    "content": { "nodeId": "content_normalize", "portName": "normalized" }
  },
  "capabilities": {
    "supportsPagination": false,
    "supportsConcurrency": true,
    "requiresAuth": true
  }
}
```
