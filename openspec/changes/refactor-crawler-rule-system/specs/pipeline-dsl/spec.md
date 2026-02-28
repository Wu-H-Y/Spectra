# Pipeline DSL

## Overview

Pipeline DSL 是一套用于描述数据提取和变换的声明式语言，采用字符串数组格式，每个元素代表一个原子操作节点。

**架构决策**: 所有 Pipeline 执行在 Rust 层完成，支持 HTML/XML/JSON 三种内容类型。

## Syntax

### 基本格式

```json
{
  "fieldName": ["@operator:arg1", "@operator2:arg2", "..."]
}
```

- 每个字段映射到一个 Pipeline 数组
- 数组中的字符串按顺序执行
- 前一个节点的输出是后一个节点的输入

### 内容类型支持

Pipeline 自动检测输入内容类型:

| 类型 | 检测规则 | 支持的选择器 |
|------|----------|-------------|
| HTML | `<!DOCTYPE html` 或 `<html` | XPath, Regex |
| XML | `<?xml` 或 `<tag>` | XPath, Regex |
| JSON | `{...}` 或 `[...]` | JSONPath, Regex |
| Text | 其他 | Regex |

### 支持的操作符

#### 选择器节点 (Selector Nodes)

| 操作符 | 语法 | 用途 | 内容类型 | 示例 |
|--------|------|------|----------|------|
| XPath | `@xpath:expr` | XPath 表达式 | HTML/XML | `@xpath://div[@class="title"]` |
| JSONPath | `@jsonpath:expr` | JSONPath 表达式 | JSON | `@jsonpath:$.data.items[*]` |
| Regex | `@regex:pattern` | 正则提取 | All | `@regex:video_id=(\d+)` |

> **注意**: CSS 选择器暂不支持，推荐使用 XPath (rlibxml2 提供完整的 XPath 1.0 支持)。

#### 提取节点 (Extractor Nodes)

| 操作符 | 语法 | 用途 | 示例 |
|--------|------|------|------|
| Text | `@text` | 获取文本内容 | `@text` |
| HTML | `@html` | 获取内部 HTML | `@html` |
| Attr | `@attr:name` | 获取属性值 | `@attr:href` |

#### 变换节点 (Transform Nodes)

| 操作符 | 语法 | 用途 | 示例 |
|--------|------|------|------|
| Trim | `@trim` | 去除首尾空白 | `@trim` |
| Replace | `@replace:from→to` | 字符串替换 | `@replace:作者：→` |
| URL | `@url` | URL 规范化 (相对->绝对) | `@url` |
| Lower | `@lower` | 转小写 | `@lower` |
| Upper | `@upper` | 转大写 | `@upper` |
| Number | `@number` | 提取数字 | `@number` |
| JS | `@js:expression` | JS 表达式 (rquickjs) | `@js:val.replace('作者：', '')` |

#### JS 表达式说明

JS 表达式使用 rquickjs (QuickJS 的 Rust 绑定) 执行，支持:

- **输入值**: `val` 变量包含当前处理的字符串
- **上下文变量**: `vars.host`, `vars.key`, `vars.page` 等
- **内置方法**: `replace()`, `toLowerCase()`, `toUpperCase()`, `trim()`, `parseInt()` 等

| JS 表达式 | 说明 |
|-----------|------|
| `val.replace('作者：', '')` | 去除前缀 |
| `val.replace(/^(作者\|author\|by)[：:]\s*/i, '')` | 正则替换 |
| `val.trim().toLowerCase()` | 去空白并转小写 |
| `vars.host + val` | 拼接变量 |
| `parseInt(val) * 2` | 数字运算 |

#### 聚合节点 (Aggregation Nodes)

| 操作符 | 语法 | 用途 | 示例 |
|--------|------|------|------|
| First | `@first` | 取第一个值 | `@first` |
| Last | `@last` | 取最后一个值 | `@last` |
| Join | `@join:sep` | 连接数组 | `@join:, ` |
| Array | `@array` | 标记为数组输出 | `@array` |

## Examples

### 视频标题提取 (HTML + XPath)

```json
{
  "title": [
    "@xpath://h1[@class='video-title']",
    "@text",
    "@trim"
  ]
}
```

### 封面 URL (补全相对路径)

```json
{
  "cover": [
    "@xpath://img[@class='cover']/@src",
    "@url"
  ]
}
```

### JSON API 响应提取

```json
{
  "videoList": [
    "@jsonpath:$.data.items[*].title"
  ]
}
```

### 播放量数字提取

```json
{
  "playCount": [
    "@xpath://span[@class='play-count']",
    "@text",
    "@number"
  ]
}
```

### 标签数组

```json
{
  "tags": [
    "@xpath://div[@class='tag-list']/a",
    "@text",
    "@array"
  ]
}
```

## Implementation

### Rust Pipeline Executor (核心实现)

```rust
// rust/src/api/pipeline_executor.rs
use rlibxml::Document;
use jsonpath_rust::JsonPath;
use serde::{Deserialize, Serialize};

/// 内容类型
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ContentType {
    Html,
    Xml,
    Json,
    Text,
}

/// 解析后的文档
pub enum ParsedDocument {
    Html(HtmlDocument),
    Json(serde_json::Value),
    Text(String),
}

/// Pipeline 节点定义
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PipelineNode {
    pub node_type: String,    // selector, extractor, transform, aggregation
    pub operator: String,     // xpath, jsonpath, regex, text, attr, trim, etc.
    pub argument: Option<String>,
}

/// 执行 Pipeline
#[frb]
pub fn execute_pipeline(
    content: String,
    content_type: Option<ContentType>,
    nodes: Vec<PipelineNode>,
    variables: HashMap<String, String>,
) -> Result<PipelineExecuteResult, String> {
    // 1. 检测内容类型
    let ct = content_type.unwrap_or_else(|| detect_content_type(&content));

    // 2. 解析内容
    let doc = parse_content(&content, ct)?;

    // 3. 执行节点链
    let mut current_values: Vec<String> = vec![];
    let mut errors: Vec<String> = vec![];

    for node in nodes {
        match execute_node(&doc, &current_values, &node, &variables) {
            Ok(values) => current_values = values,
            Err(e) => {
                errors.push(format!("[{}] {}", node.operator, e));
                if current_values.is_empty() {
                    break;
                }
            }
        }
    }

    Ok(PipelineExecuteResult { values: current_values, errors })
}

/// 执行选择器
fn execute_selector(doc: &ParsedDocument, node: &PipelineNode) -> Result<Vec<String>, String> {
    let expr = node.argument.as_ref().ok_or("表达式不能为空")?;

    match node.operator.as_str() {
        "xpath" => {
            match doc {
                ParsedDocument::Html(html_doc) => html_doc.xpath_extract_texts(expr.clone()),
                _ => Err("XPath 仅支持 HTML/XML 内容".to_string()),
            }
        }
        "jsonpath" => {
            match doc {
                ParsedDocument::Json(json) => {
                    let path = JsonPath::from_str(expr)?;
                    let result = path.find(json);
                    Ok(json_values_to_strings(result))
                }
                _ => Err("JSONPath 仅支持 JSON 内容".to_string()),
            }
        }
        "regex" => {
            let content = doc.to_string();
            let re = regex::Regex::new(expr)?;
            Ok(re.find_iter(&content).map(|m| m.as_str().to_string()).collect())
        }
        _ => Err(format!("未知选择器: {}", node.operator)),
    }
}
```

### Dart Model (配置层)

```dart
/// Pipeline 节点类型
enum PipelineNodeType {
  selector,
  extractor,
  transform,
  aggregation,
}

/// 解析单个节点字符串
PipelineNode parseNode(String nodeStr) {
  final match = RegExp(r'^@(\w+)(?::(.+))?$').firstMatch(nodeStr);
  if (match == null) {
    throw PipelineParseException('Invalid node: $nodeStr');
  }
  
  final operator = match.group(1)!;
  final argument = match.group(2);
  
  return PipelineNode(
    operator: operator,
    argument: argument,
    type: _getNodeType(operator),
  );
}

/// 执行 Pipeline
Future<dynamic> executePipeline(
  String input,
  List<String> pipeline,
  PipelineContext context,
) async {
  var value = input;
  
  for (final nodeStr in pipeline) {
    final node = parseNode(nodeStr);
    value = await executeNode(node, value, context);
  }
  
  return value;
}
```

### React Flow 序列化

```typescript
interface FlowNode {
  id: string;
  type: 'selector' | 'extractor' | 'transform' | 'aggregation';
  position: { x: number; y: number };
  data: {
    operator: string;
    argument?: string;
  };
}

interface FlowEdge {
  id: string;
  source: string;
  target: string;
}

// 从 React Flow 序列化为 Pipeline
function serializeToPipeline(
  nodes: FlowNode[],
  edges: FlowEdge[],
  fieldId: string,
): string[] {
  const outputNode = nodes.find(n => n.id === fieldId);
  if (!outputNode) return [];
  
  const pipeline: string[] = [];
  let currentId = outputNode.id;
  
  // 按边逆向遍历
  while (true) {
    const incomingEdge = edges.find(e => e.target === currentId);
    if (!incomingEdge) break;
    
    const sourceNode = nodes.find(n => n.id === incomingEdge.source);
    if (!sourceNode) break;
    
    pipeline.unshift(formatNode(sourceNode));
    currentId = sourceNode.id;
  }
  
  return pipeline;
}

function formatNode(node: FlowNode): string {
  return node.data.argument 
    ? `@${node.data.operator}:${node.data.argument}`
    : `@${node.data.operator}`;
}
```

## Validation Rules

1. **节点语法**: 必须符合 `@operator[:argument]` 格式
2. **操作符有效性**: 操作符必须在支持列表中
3. **参数要求**: 部分操作符必须提供参数 (如 @attr, @css)
4. **类型兼容**: 节点间输入输出类型必须兼容
5. **长度限制**: 单个 Pipeline 不超过 20 个节点

## Error Handling

```dart
class PipelineException implements Exception {
  final String message;
  final int nodeIndex;
  final String nodeStr;
  
  PipelineException(this.message, this.nodeIndex, this.nodeStr);
  
  @override
  String toString() => 'Pipeline error at node $nodeIndex ($nodeStr): $message';
}
```

## Versioning

- 当前版本: 1.0
- 版本号存储在规则元数据中
- 未来新增操作符保持向后兼容
