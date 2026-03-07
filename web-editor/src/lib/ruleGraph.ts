import type {
  Connection,
  Edge as FlowEdge,
  Node as FlowNode,
} from '@xyflow/react';

import type { DataType } from '@/types/DataType';
import type { Graph } from '@/types/Graph';
import type { LifecyclePhase } from '@/types/LifecyclePhase';
import type { Node as RuleNode } from '@/types/Node';
import type { NodeKind } from '@/types/NodeKind';
import type { Port } from '@/types/Port';
import type { RuleEnvelope } from '@/types/rule';

type NodeKindType = NodeKind['type'];

const DEFAULT_PHASE: LifecyclePhase = 'search';
const DEFAULT_INPUT_ID = 'search_input';
const DEFAULT_OUTPUT_ID = 'search_output';
const DEFAULT_X_GAP = 240;
const DEFAULT_Y = 120;
const DEFAULT_TEXT_TYPE: DataType = { type: 'text' };
const DEFAULT_NORMALIZED_LIST: DataType = {
  type: 'list',
  item: { type: 'normalizedModel' },
};

export interface RuleGraphNodeData extends Record<string, unknown> {
  label: string;
  kindType: NodeKindType;
  phase: LifecyclePhase;
  inputs: Port[];
  outputs: Port[];
}

export type RuleGraphNode = FlowNode<RuleGraphNodeData, 'ruleNode'>;
export type RuleGraphEdge = FlowEdge;

const capitalize = (value: string) =>
  value.length > 0 ? `${value[0].toUpperCase()}${value.slice(1)}` : value;

const getNodeLabel = (node: RuleNode) =>
  node.id.split(/[_-]/).filter(Boolean).map(capitalize).join(' ');

const createFlowEdgeId = (
  source: string,
  sourceHandle: string,
  target: string,
  targetHandle: string,
) => `${source}:${sourceHandle}->${target}:${targetHandle}`;

const createPortsForKind = (
  kindType: NodeKindType,
): {
  inputs: Port[];
  outputs: Port[];
} => {
  switch (kindType) {
    case 'input':
      return {
        inputs: [],
        outputs: [
          {
            name: 'query',
            dataType: DEFAULT_TEXT_TYPE,
            optional: false,
          },
        ],
      };
    case 'output':
      return {
        inputs: [
          {
            name: 'items',
            dataType: DEFAULT_TEXT_TYPE,
            optional: false,
          },
        ],
        outputs: [
          {
            name: 'normalized',
            dataType: DEFAULT_NORMALIZED_LIST,
            optional: false,
          },
        ],
      };
    default:
      return {
        inputs: [
          {
            name: 'in',
            dataType: DEFAULT_TEXT_TYPE,
            optional: false,
          },
        ],
        outputs: [
          {
            name: 'out',
            dataType: DEFAULT_TEXT_TYPE,
            optional: false,
          },
        ],
      };
  }
};
const createRuleNode = (
  id: string,
  kindType: NodeKindType,
  phase: LifecyclePhase,
): RuleNode => {
  const { inputs, outputs } = createPortsForKind(kindType);

  return {
    id,
    kind: { type: kindType },
    phase,
    inputs,
    outputs,
  };
};

export const createMinimalRuleGraph = (): Graph => {
  const inputNode = createRuleNode(DEFAULT_INPUT_ID, 'input', DEFAULT_PHASE);
  const outputNode = createRuleNode(DEFAULT_OUTPUT_ID, 'output', DEFAULT_PHASE);

  return {
    nodes: [inputNode, outputNode],
    edges: [
      {
        from: {
          nodeId: DEFAULT_INPUT_ID,
          portName: 'query',
        },
        to: {
          nodeId: DEFAULT_OUTPUT_ID,
          portName: 'items',
        },
      },
    ],
    phaseEntrypoints: {
      [DEFAULT_PHASE]: {
        nodeId: DEFAULT_INPUT_ID,
        portName: 'query',
      },
    },
    layout: {
      nodes: {
        [DEFAULT_INPUT_ID]: { x: 80, y: DEFAULT_Y },
        [DEFAULT_OUTPUT_ID]: { x: 80 + DEFAULT_X_GAP, y: DEFAULT_Y },
      },
    },
  };
};

export const deriveNormalizedOutputs = (graph: Graph) => {
  const outputEntries = graph.nodes
    .filter((node) => node.kind.type === 'output' && node.outputs.length > 0)
    .map(
      (node) =>
        [
          node.phase,
          {
            nodeId: node.id,
            portName: node.outputs[0].name,
          },
        ] as const,
    );

  return Object.fromEntries(outputEntries) as RuleEnvelope['normalizedOutputs'];
};

const derivePhaseEntrypoints = (
  nodes: RuleNode[],
): Graph['phaseEntrypoints'] => {
  const entries = new Map<
    LifecyclePhase,
    { nodeId: string; portName: string }
  >();

  for (const node of nodes) {
    const firstPort = node.outputs[0];

    if (!firstPort || entries.has(node.phase)) {
      continue;
    }

    if (node.kind.type === 'input' || nodes.length === 1) {
      entries.set(node.phase, {
        nodeId: node.id,
        portName: firstPort.name,
      });
    }
  }

  if (entries.size === 0) {
    for (const node of nodes) {
      const firstPort = node.outputs[0];

      if (!firstPort || entries.has(node.phase)) {
        continue;
      }

      entries.set(node.phase, {
        nodeId: node.id,
        portName: firstPort.name,
      });
    }
  }

  return Object.fromEntries(entries) as Graph['phaseEntrypoints'];
};

export const graphToFlow = (
  graph: Graph,
): {
  nodes: RuleGraphNode[];
  edges: RuleGraphEdge[];
} => {
  const nodes = graph.nodes.map((node, index) => {
    const savedPosition = graph.layout?.nodes[node.id];
    const position = savedPosition ?? {
      x: 80 + index * DEFAULT_X_GAP,
      y: DEFAULT_Y,
    };

    return {
      id: node.id,
      type: 'ruleNode',
      position,
      data: {
        label: getNodeLabel(node),
        kindType: node.kind.type,
        phase: node.phase,
        inputs: node.inputs,
        outputs: node.outputs,
      },
    } satisfies RuleGraphNode;
  });

  const edges = graph.edges.map(
    (edge) =>
      ({
        id: createFlowEdgeId(
          edge.from.nodeId,
          edge.from.portName,
          edge.to.nodeId,
          edge.to.portName,
        ),
        source: edge.from.nodeId,
        sourceHandle: edge.from.portName,
        target: edge.to.nodeId,
        targetHandle: edge.to.portName,
      }) satisfies RuleGraphEdge,
  );

  return { nodes, edges };
};

export const syncRuleGraph = (
  rule: RuleEnvelope,
  flowNodes: RuleGraphNode[],
  flowEdges: RuleGraphEdge[],
): RuleEnvelope => {
  const nodeIdSet = new Set(flowNodes.map((node) => node.id));
  const nodes: RuleNode[] = flowNodes.map((node) => ({
    id: node.id,
    kind: { type: node.data.kindType },
    phase: node.data.phase,
    inputs: node.data.inputs,
    outputs: node.data.outputs,
  }));
  const edges = flowEdges
    .filter(
      (edge) =>
        edge.source &&
        edge.target &&
        edge.sourceHandle &&
        edge.targetHandle &&
        nodeIdSet.has(edge.source) &&
        nodeIdSet.has(edge.target),
    )
    .map((edge) => ({
      from: {
        nodeId: edge.source,
        portName: edge.sourceHandle!,
      },
      to: {
        nodeId: edge.target,
        portName: edge.targetHandle!,
      },
    }));
  const graph: Graph = {
    ...rule.graph,
    nodes,
    edges,
    phaseEntrypoints: derivePhaseEntrypoints(nodes),
    layout: {
      nodes: Object.fromEntries(
        flowNodes.map((node) => [
          node.id,
          {
            x: node.position.x,
            y: node.position.y,
          },
        ]),
      ),
    },
  };

  return {
    ...rule,
    graph,
    normalizedOutputs: deriveNormalizedOutputs(graph),
  };
};

export const appendGraphNode = (
  nodes: RuleGraphNode[],
  kindType: NodeKindType,
): RuleGraphNode[] => {
  const nextIndex =
    nodes.filter((node) => node.data.kindType === kindType).length + 1;
  const id = `${kindType}_${nextIndex}`;
  const maxX = nodes.reduce(
    (currentMax, node) => Math.max(currentMax, node.position.x),
    80,
  );
  const maxY = nodes.reduce(
    (currentMax, node) => Math.max(currentMax, node.position.y),
    DEFAULT_Y,
  );
  const ruleNode = createRuleNode(id, kindType, DEFAULT_PHASE);

  return [
    ...nodes,
    {
      id,
      type: 'ruleNode',
      position: {
        x: maxX + DEFAULT_X_GAP,
        y: maxY,
      },
      data: {
        label: getNodeLabel(ruleNode),
        kindType,
        phase: DEFAULT_PHASE,
        inputs: ruleNode.inputs,
        outputs: ruleNode.outputs,
      },
    },
  ];
};

export const createConnectedGraphEdge = (
  connection: Connection,
): RuleGraphEdge | null => {
  if (
    !connection.source ||
    !connection.target ||
    !connection.sourceHandle ||
    !connection.targetHandle
  ) {
    return null;
  }

  return {
    id: createFlowEdgeId(
      connection.source,
      connection.sourceHandle,
      connection.target,
      connection.targetHandle,
    ),
    source: connection.source,
    sourceHandle: connection.sourceHandle,
    target: connection.target,
    targetHandle: connection.targetHandle,
  } satisfies RuleGraphEdge;
};
