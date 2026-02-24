# Pipeline DSL

## Overview

Pipeline DSL 是一套用于描述数据提取和变换的声明式语言，采用字符串数组格式，每个元素代表一个原子操作节点。

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

### 支持的操作符

#### 选择器节点 (Selector Nodes)

| 操作符 | 语法 | 用途 | 示例 |
|--------|------|------|------|
| CSS | `@css:selector` | CSS 选择器 | `@css:.video-title` |
| XPath | `@xpath:expr` | XPath 表达式 | `@xpath://div[@class="title"]` |
| JSONPath | `@jsonpath:expr` | JSONPath 表达式 | `@jsonpath:$.data.items[*]` |
| Regex | `@regex:pattern` | 正则提取 | `@regex:video_id=(\d+)` |
| JavaScript | `@js:code` | JS 表达式 (val 为输入) | `@js: val.replace('作者：', '')` |

#### 提取节点 (Extractor Nodes)

| 操作符 | 语法 | 用途 | 示例 |
|--------|------|------|------|
| Text | `@text` | 获取文本内容 | `@text` |
| HTML | `@html` | 获取内部 HTML | `@html` |
| Attr | `@attr:name` | 获取属性值 | `@attr:href` |
| Href | `@href` | 获取 href (自动补全) | `@href` |
| Src | `@src` | 获取 src (自动补全) | `@src` |

#### 变换节点 (Transform Nodes)

| 操作符 | 语法 | 用途 | 示例 |
|--------|------|------|------|
| Trim | `@trim` | 去除首尾空白 | `@trim` |
| Replace | `@replace:from→to` | 字符串替换 | `@replace:作者：→` |
| RegexReplace | `@regex:/pattern/replacement/` | 正则替换 | `@regex:/\s+/ /` |
| URL | `@url` | URL 规范化 | `@url` |
| Lower | `@lower` | 转小写 | `@lower` |
| Upper | `@upper` | 转大写 | `@upper` |
| Number | `@number` | 提取数字 | `@number` |
| Date | `@date:format` | 解析日期 | `@date:yyyy-MM-dd` |

#### 聚合节点 (Aggregation Nodes)

| 操作符 | 语法 | 用途 | 示例 |
|--------|------|------|------|
| First | `@first` | 取第一个值 | `@first` |
| Last | `@last` | 取最后一个值 | `@last` |
| Join | `@join:sep` | 连接数组 | `@join:, ` |
| Array | `@array` | 标记为数组输出 | `@array` |
| Flat | `@flat` | 扁平化嵌套数组 | `@flat` |

## Examples

### 视频标题提取

```json
{
  "title": [
    "@css:h1.video-title",
    "@text",
    "@trim"
  ]
}
```

### 封面 URL (补全相对路径)

```json
{
  "cover": [
    "@css:img.cover",
    "@attr:src",
    "@url"
  ]
}
```

### 去除作者前缀

```json
{
  "author": [
    "@css:.author-name",
    "@text",
    "@js: val.replace(/^(作者|author|by)[：:]\s*/i, '')",
    "@trim"
  ]
}
```

### 播放量数字提取

```json
{
  "playCount": [
    "@css:.play-count",
    "@text",
    "@number"
  ]
}
```

### 标签数组

```json
{
  "tags": [
    "@css:.tag-list > a",
    "@text",
    "@array"
  ]
}
```

### JavaScript 提取加密数据

```json
{
  "playUrl": [
    "@js: const data = JSON.parse(window.__playinfo__); data.dash.video[0].baseUrl;"
  ]
}
```

## Implementation

### Dart Model

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
