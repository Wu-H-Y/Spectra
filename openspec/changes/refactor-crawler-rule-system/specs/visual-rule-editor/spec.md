# Visual Rule Editor

## Overview

基于 React Flow 的节点流可视化编辑器，支持拖拽创建 Pipeline、WebView 元素拾取、实时预览。

## Architecture

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                           Rule Editor Layout                                  │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                               │
│  ┌─────────────────────────────────────────────────────────────────────────┐ │
│  │  Toolbar                                                                 │ │
│  │  [Rule Name] [Media Type ▼] | [💾 Save] [✓ Validate] [📤 Export]       │ │
│  └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                               │
│  ┌─────────────────────────────────────────────────────────────────────────┐ │
│  │  Tabs                                                                    │ │
│  │  [Metadata] [Network] [Explore] [Search] [Detail] [TOC] [Content]       │ │
│  └─────────────────────────────────────────────────────────────────────────┘ │
│                                                                               │
│  ┌────────────────┐  ┌──────────────────────────────┐  ┌─────────────────┐  │
│  │                │  │                              │  │                 │  │
│  │   📱 Preview   │  │   🔗 Pipeline Editor         │  │   📊 Output     │  │
│  │   (WebView)    │  │   (React Flow)               │  │   Panel         │  │
│  │                │  │                              │  │                 │  │
│  │ ┌────────────┐ │  │  Node Palette:              │  │ Results:        │  │
│  │ │ URL Input  │ │  │  ┌─────┐ ┌─────┐ ┌─────┐  │  │                 │  │
│  │ │ [____] [→] │ │  │  │@css │ │@text│ │@trim│  │  │ title: "..."    │  │
│  │ └────────────┘ │  │  └─────┘ └─────┘ └─────┘  │  │ author: "..."   │  │
│  │                │  │                              │  │ cover: "..."    │  │
│  │ ┌────────────┐ │  │  Canvas:                    │  │                 │  │
│  │ │ Target     │ │  │                              │  │ Status:         │  │
│  │ │ Page       │ │  │  ┌───┐    ┌───┐    ┌───┐   │  │ ✓ 15 items     │  │
│  │ │            │ │  │  │@css│───▶│@txt│───▶│Out│   │  │ ⚠ 2 warnings  │  │
│  │ │ [Element]  │ │  │  └───┘    └───┘    └───┘   │  │                 │  │
│  │ │  Click to  │ │  │                              │  │ [📋 Copy JSON] │  │
│  │ │  pick      │ │  │  ┌───┐    ┌───┐    ┌───┐   │  │ [🔄 Refresh]   │  │
│  │ └────────────┘ │  │  │@css│───▶│@url│───▶│Out│   │  │                 │  │
│  │                │  │  └───┘    └───┘    └───┘   │  │                 │  │
│  │ ┌────────────┐ │  │                              │  │                 │  │
│  │ │ [🎯 Pick]  │ │  └──────────────────────────────┘  │                 │  │
│  │ │ [📷 Shot]  │ │                                    │                 │  │
│  │ └────────────┘ │                                    │                 │  │
│  │                │                                    │                 │  │
│  └────────────────┘                                    └─────────────────┘  │
│                                                                               │
└──────────────────────────────────────────────────────────────────────────────┘
```

## Components

### 1. Pipeline Editor (React Flow)

```typescript
// src/components/flow/FlowEditor.tsx

import ReactFlow, {
  Node,
  Edge,
  Controls,
  Background,
  useNodesState,
  useEdgesState,
  addEdge,
  Connection,
} from '@xyflow/react';

interface FlowEditorProps {
  fields: FieldConfig[];
  onPipelineChange: (field: string, pipeline: string[]) => void;
}

export function FlowEditor({ fields, onPipelineChange }: FlowEditorProps) {
  const [nodes, setNodes, onNodesChange] = useNodesState([]);
  const [edges, setEdges, onEdgesChange] = useEdgesState([]);
  
  const onConnect = useCallback(
    (params: Connection) => setEdges((eds) => addEdge(params, eds)),
    [setEdges]
  );
  
  // 序列化为 Pipeline
  const serializeField = (fieldId: string): string[] => {
    const fieldNodes = nodes.filter(n => n.data.fieldId === fieldId);
    const fieldEdges = edges.filter(e => 
      fieldNodes.some(n => n.id === e.source || n.id === e.target)
    );
    
    return serializeToPipeline(fieldNodes, fieldEdges, fieldId);
  };
  
  return (
    <div className="h-full">
      <ReactFlow
        nodes={nodes}
        edges={edges}
        onNodesChange={onNodesChange}
        onEdgesChange={onEdgesChange}
        onConnect={onConnect}
        nodeTypes={customNodeTypes}
        fitView
      >
        <Background />
        <Controls />
        <NodePalette />
      </ReactFlow>
    </div>
  );
}
```

### 2. Custom Node Types

```typescript
// src/components/flow/nodes/SelectorNode.tsx

import { Handle, Position, NodeProps } from '@xyflow/react';

interface SelectorNodeData {
  operator: 'css' | 'xpath' | 'jsonpath' | 'regex' | 'js';
  expression: string;
  fieldId: string;
}

export function SelectorNode({ data, selected }: NodeProps) {
  return (
    <div className={`
      px-4 py-2 rounded-lg border-2 min-w-[150px]
      ${selected ? 'border-blue-500' : 'border-gray-300'}
      bg-white shadow-md
    `}>
      <Handle type="target" position={Position.Left} />
      
      <div className="flex items-center gap-2">
        <span className="text-sm font-medium text-gray-600">
          @{data.operator}
        </span>
      </div>
      
      <input
        type="text"
        value={data.expression}
        onChange={(e) => data.onExpressionChange(e.target.value)}
        className="mt-1 w-full text-xs p-1 border rounded"
        placeholder="Expression..."
      />
      
      <Handle type="source" position={Position.Right} />
    </div>
  );
}

// src/components/flow/nodes/TransformNode.tsx

interface TransformNodeData {
  operator: 'trim' | 'text' | 'attr' | 'url' | 'replace' | 'js';
  argument?: string;
}

export function TransformNode({ data, selected }: NodeProps) {
  return (
    <div className={`
      px-4 py-2 rounded-lg border-2 min-w-[120px]
      ${selected ? 'border-green-500' : 'border-gray-300'}
      bg-green-50
    `}>
      <Handle type="target" position={Position.Left} />
      
      <div className="text-sm font-medium">
        @{data.operator}
        {data.argument && <span className="text-gray-500">:{data.argument}</span>}
      </div>
      
      <Handle type="source" position={Position.Right} />
    </div>
  );
}

// src/components/flow/nodes/OutputNode.tsx

interface OutputNodeData {
  fieldName: string;
}

export function OutputNode({ data }: NodeProps) {
  return (
    <div className="px-4 py-2 rounded-lg border-2 border-purple-500 bg-purple-50">
      <Handle type="target" position={Position.Left} />
      
      <div className="text-sm font-bold text-purple-700">
        📤 {data.fieldName}
      </div>
    </div>
  );
}

const customNodeTypes = {
  selector: SelectorNode,
  transform: TransformNode,
  output: OutputNode,
};
```

### 3. Node Palette

```typescript
// src/components/flow/NodePalette.tsx

const nodeTemplates = [
  // Selectors
  { type: 'selector', operator: 'css', label: 'CSS Selector', icon: '🔍' },
  { type: 'selector', operator: 'xpath', label: 'XPath', icon: '🛤️' },
  { type: 'selector', operator: 'jsonpath', label: 'JSONPath', icon: '📦' },
  { type: 'selector', operator: 'regex', label: 'Regex', icon: '🎯' },
  { type: 'selector', operator: 'js', label: 'JavaScript', icon: '⚡' },
  
  // Extractors
  { type: 'transform', operator: 'text', label: 'Get Text', icon: '📝' },
  { type: 'transform', operator: 'attr', label: 'Get Attribute', icon: '🏷️' },
  { type: 'transform', operator: 'html', label: 'Get HTML', icon: '📄' },
  { type: 'transform', operator: 'href', label: 'Get Link', icon: '🔗' },
  { type: 'transform', operator: 'src', label: 'Get Image', icon: '🖼️' },
  
  // Transforms
  { type: 'transform', operator: 'trim', label: 'Trim', icon: '✂️' },
  { type: 'transform', operator: 'replace', label: 'Replace', icon: '🔀' },
  { type: 'transform', operator: 'url', label: 'Normalize URL', icon: '🌐' },
  { type: 'transform', operator: 'lower', label: 'Lowercase', icon: '🔤' },
  { type: 'transform', operator: 'upper', label: 'Uppercase', icon: '🔠' },
  { type: 'transform', operator: 'number', label: 'Extract Number', icon: '🔢' },
  
  // Aggregation
  { type: 'transform', operator: 'first', label: 'First', icon: '1️⃣' },
  { type: 'transform', operator: 'join', label: 'Join Array', icon: '🔗' },
];

export function NodePalette() {
  const onDragStart = (event: DragEvent, nodeType: string, operator: string) => {
    event.dataTransfer.setData('application/reactflow', JSON.stringify({
      type: nodeType,
      operator,
    }));
    event.dataTransfer.effectAllowed = 'move';
  };
  
  return (
    <div className="absolute left-4 top-4 bg-white rounded-lg shadow-lg p-4 max-h-[80vh] overflow-y-auto z-10">
      <h3 className="font-bold text-sm mb-2">Nodes</h3>
      
      <div className="space-y-1">
        {nodeTemplates.map((node) => (
          <div
            key={`${node.type}-${node.operator}`}
            draggable
            onDragStart={(e) => onDragStart(e, node.type, node.operator)}
            className="flex items-center gap-2 p-2 rounded hover:bg-gray-100 cursor-grab"
          >
            <span>{node.icon}</span>
            <span className="text-sm">{node.label}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
```

### 4. WebView Preview

```typescript
// src/components/preview/WebViewPanel.tsx

interface WebViewPanelProps {
  serverUrl: string;
  onElementSelected: (selector: ElementSelector) => void;
}

export function WebViewPanel({ serverUrl, onElementSelected }: WebViewPanelProps) {
  const [url, setUrl] = useState('');
  const [isPickerMode, setIsPickerMode] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const { sendJsonMessage, lastJsonMessage } = useWebSocket(
    `${serverUrl}/api/ws`
  );
  
  // 监听 WebSocket 消息
  useEffect(() => {
    if (lastJsonMessage?.type === 'element_selected') {
      onElementSelected({
        css: lastJsonMessage.selector,
        xpath: lastJsonMessage.xpath,
        text: lastJsonMessage.text,
      });
      setIsPickerMode(false);
    }
  }, [lastJsonMessage, onElementSelected]);
  
  const loadPage = async () => {
    setIsLoading(true);
    await fetch(`${serverUrl}/api/preview/open`, {
      method: 'POST',
      body: JSON.stringify({ url }),
    });
  };
  
  const startPicker = async () => {
    setIsPickerMode(true);
    sendJsonMessage({ type: 'start_selection' });
  };
  
  const cancelPicker = () => {
    setIsPickerMode(false);
    sendJsonMessage({ type: 'cancel_selection' });
  };
  
  return (
    <div className="h-full flex flex-col">
      {/* URL Bar */}
      <div className="flex items-center gap-2 p-2 border-b">
        <input
          type="text"
          value={url}
          onChange={(e) => setUrl(e.target.value)}
          placeholder="Enter URL..."
          className="flex-1 px-2 py-1 border rounded text-sm"
        />
        <Button onClick={loadPage} disabled={isLoading}>
          {isLoading ? 'Loading...' : 'Load'}
        </Button>
      </div>
      
      {/* Actions */}
      <div className="flex items-center gap-2 p-2 border-b">
        <Button
          variant={isPickerMode ? 'destructive' : 'outline'}
          onClick={isPickerMode ? cancelPicker : startPicker}
        >
          {isPickerMode ? '❌ Cancel Pick' : '🎯 Pick Element'}
        </Button>
        <Button variant="outline" onClick={takeScreenshot}>
          📷 Screenshot
        </Button>
      </div>
      
      {/* Preview Frame */}
      <div className="flex-1 bg-gray-100 flex items-center justify-center">
        {isLoading ? (
          <div className="text-gray-500">Loading preview in app...</div>
        ) : (
          <div className="text-gray-400 text-center p-4">
            <p>📱 Preview opens in Spectra app</p>
            <p className="text-sm mt-2">
              Click "Load" to open page, then "Pick Element" to select
            </p>
          </div>
        )}
      </div>
      
      {/* Picker Status */}
      {isPickerMode && (
        <div className="p-2 bg-yellow-50 border-t border-yellow-200">
          <p className="text-sm text-yellow-700">
            🎯 Picker mode active - Click an element in the app
          </p>
        </div>
      )}
    </div>
  );
}
```

### 5. Output Panel

```typescript
// src/components/preview/ResultPreview.tsx

interface ResultPreviewProps {
  results: Record<string, unknown> | null;
  error: string | null;
  itemCount: number;
  onRefresh: () => void;
}

export function ResultPreview({ results, error, itemCount, onRefresh }: ResultPreviewProps) {
  const [viewMode, setViewMode] = useState<'json' | 'tree'>('tree');
  
  return (
    <div className="h-full flex flex-col">
      {/* Header */}
      <div className="flex items-center justify-between p-2 border-b">
        <div className="flex items-center gap-2">
          <span className="font-medium text-sm">Output</span>
          {itemCount > 0 && (
            <Badge variant="success">✓ {itemCount} items</Badge>
          )}
          {error && (
            <Badge variant="destructive">⚠ Error</Badge>
          )}
        </div>
        
        <div className="flex items-center gap-1">
          <Button size="sm" variant="ghost" onClick={() => setViewMode('tree')}>
            🌳 Tree
          </Button>
          <Button size="sm" variant="ghost" onClick={() => setViewMode('json')}>
            { } JSON
          </Button>
          <Button size="sm" variant="outline" onClick={onRefresh}>
            🔄
          </Button>
        </div>
      </div>
      
      {/* Content */}
      <div className="flex-1 overflow-auto p-2">
        {error ? (
          <div className="p-4 bg-red-50 rounded text-red-700 text-sm">
            {error}
          </div>
        ) : results ? (
          viewMode === 'json' ? (
            <pre className="text-xs bg-gray-50 p-2 rounded overflow-auto">
              {JSON.stringify(results, null, 2)}
            </pre>
          ) : (
            <TreeView data={results} />
          )
        ) : (
          <div className="text-gray-400 text-center p-4">
            <p>No results yet</p>
            <p className="text-sm mt-1">
              Build a pipeline and click Refresh
            </p>
          </div>
        )}
      </div>
      
      {/* Actions */}
      <div className="p-2 border-t">
        <Button size="sm" variant="outline" className="w-full" onClick={copyToClipboard}>
          📋 Copy JSON
        </Button>
      </div>
    </div>
  );
}
```

### 6. Pipeline Serializer

```typescript
// src/utils/pipelineSerializer.ts

interface FlowNode {
  id: string;
  type: string;
  data: {
    operator: string;
    expression?: string;
    argument?: string;
    fieldId?: string;
  };
}

interface FlowEdge {
  id: string;
  source: string;
  target: string;
}

/**
 * Serialize React Flow nodes/edges to Pipeline string array
 */
export function serializeToPipeline(
  nodes: FlowNode[],
  edges: FlowEdge[],
  fieldId: string,
): string[] {
  // 找到该字段的输出节点
  const outputNode = nodes.find(
    n => n.type === 'output' && n.data.fieldId === fieldId
  );
  
  if (!outputNode) return [];
  
  const pipeline: string[] = [];
  let currentId: string | null = outputNode.id;
  
  // 逆向遍历
  while (currentId) {
    const node = nodes.find(n => n.id === currentId);
    if (!node || node.type === 'output') {
      currentId = findIncomingNode(edges, currentId);
      continue;
    }
    
    // 格式化节点
    const pipelineStr = formatNode(node);
    pipeline.unshift(pipelineStr);
    
    currentId = findIncomingNode(edges, currentId);
  }
  
  return pipeline;
}

function findIncomingNode(edges: FlowEdge[], nodeId: string): string | null {
  const edge = edges.find(e => e.target === nodeId);
  return edge?.source ?? null;
}

function formatNode(node: FlowNode): string {
  const { operator, expression, argument } = node.data;
  
  if (expression) {
    return `@${operator}:${expression}`;
  }
  if (argument) {
    return `@${operator}:${argument}`;
  }
  return `@${operator}`;
}

/**
 * Parse Pipeline string array to React Flow nodes/edges
 */
export function parseFromPipeline(
  pipeline: string[],
  fieldId: string,
  startX: number = 0,
  startY: number = 0,
): { nodes: FlowNode[]; edges: FlowEdge[] } {
  const nodes: FlowNode[] = [];
  const edges: FlowEdge[] = [];
  
  let x = startX;
  const spacing = 150;
  
  // 创建节点
  pipeline.forEach((nodeStr, index) => {
    const { operator, argument } = parseNodeString(nodeStr);
    const nodeType = getNodeType(operator);
    
    nodes.push({
      id: `${fieldId}-${index}`,
      type: nodeType,
      position: { x, y: startY },
      data: {
        operator,
        expression: argument,
        fieldId,
      },
    });
    
    x += spacing;
  });
  
  // 添加输出节点
  nodes.push({
    id: `${fieldId}-output`,
    type: 'output',
    position: { x, y: startY },
    data: {
      fieldName: fieldId,
    },
  });
  
  // 创建边
  for (let i = 0; i < nodes.length - 1; i++) {
    edges.push({
      id: `e-${nodes[i].id}-${nodes[i + 1].id}`,
      source: nodes[i].id,
      target: nodes[i + 1].id,
    });
  }
  
  return { nodes, edges };
}

function parseNodeString(str: string): { operator: string; argument?: string } {
  const match = str.match(/^@(\w+)(?::(.+))?$/);
  if (!match) {
    throw new Error(`Invalid pipeline node: ${str}`);
  }
  
  return {
    operator: match[1],
    argument: match[2],
  };
}
```

## WebSocket Protocol

### Client → Server

```typescript
// 开始元素选择
{
  type: 'start_selection'
}

// 取消选择
{
  type: 'cancel_selection'
}

// 测试 Pipeline
{
  type: 'test_pipeline',
  fieldId: string,
  pipeline: string[]
}
```

### Server → Client

```typescript
// 元素被选中
{
  type: 'element_selected',
  selector: string,      // CSS selector
  xpath: string,         // XPath
  text: string,          // Element text
  html: string,          // Element HTML
  tagName: string,       // Tag name
  attributes: Record<string, string>
}

// Pipeline 测试结果
{
  type: 'pipeline_result',
  fieldId: string,
  success: boolean,
  result?: unknown,
  error?: string
}
```

## State Management

```typescript
// src/stores/ruleStore.ts

import { create } from 'zustand';

interface RuleState {
  // 当前规则
  rule: Partial<CrawlerRule>;
  
  // Pipeline 编辑器状态
  pipelines: Record<string, string[]>;
  
  // 预览状态
  previewUrl: string;
  previewResults: Record<string, unknown> | null;
  previewError: string | null;
  
  // Actions
  updateRule: (updates: Partial<CrawlerRule>) => void;
  setPipeline: (field: string, pipeline: string[]) => void;
  setPreviewResults: (results: Record<string, unknown> | null, error: string | null) => void;
  resetState: () => void;
}

export const useRuleStore = create<RuleState>((set) => ({
  rule: {
    name: '',
    mediaType: 'generic',
    network: {},
    explore: {},
    search: {},
    detail: {},
    toc: {},
    content: {},
  },
  pipelines: {},
  previewUrl: '',
  previewResults: null,
  previewError: null,
  
  updateRule: (updates) => set((state) => ({
    rule: { ...state.rule, ...updates },
  })),
  
  setPipeline: (field, pipeline) => set((state) => ({
    pipelines: { ...state.pipelines, [field]: pipeline },
  })),
  
  setPreviewResults: (results, error) => set({
    previewResults: results,
    previewError: error,
  }),
  
  resetState: () => set({
    rule: {},
    pipelines: {},
    previewResults: null,
    previewError: null,
  }),
}));
```

## Tech Stack

| 技术 | 版本 | 用途 |
|------|------|------|
| React | 19.x | UI 框架 |
| TypeScript | 5.x | 类型安全 |
| @xyflow/react | 12.x | 节点流编辑器 |
| Zustand | 5.x | 状态管理 |
| TanStack Query | 5.x | 数据请求 |
| Tailwind CSS | 4.x | 样式 |
| shadcn/ui | latest | UI 组件 |
| Monaco Editor | latest | JSON 编辑 |
| Lucide React | latest | 图标 |

## Responsive Design

```
┌─────────────────────────────────────────────────────────────────────┐
│  Desktop (width > 1024px)                                           │
│  ┌──────────┐ ┌──────────────────────────────┐ ┌────────────────┐  │
│  │ Preview  │ │     Pipeline Editor          │ │ Output Panel   │  │
│  │ (20%)    │ │         (50%)                │ │    (30%)       │  │
│  └──────────┘ └──────────────────────────────┘ └────────────────┘  │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│  Tablet (600px - 1024px)                                            │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                    Pipeline Editor (100%)                    │   │
│  └─────────────────────────────────────────────────────────────┘   │
│  ┌───────────────────────┐ ┌─────────────────────────────────────┐ │
│  │    Preview (50%)      │ │       Output Panel (50%)            │ │
│  └───────────────────────┘ └─────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│  Mobile (width < 600px)                                             │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                    Pipeline Editor                           │   │
│  └─────────────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                      Preview                                 │   │
│  └─────────────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                     Output Panel                             │   │
│  └─────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```
