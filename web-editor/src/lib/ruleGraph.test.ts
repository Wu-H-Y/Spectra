import {
  appendGraphNode,
  createConnectedGraphEdge,
  createMinimalRuleGraph,
  graphToFlow,
  syncRuleGraph,
} from '@/lib/ruleGraph';
import type { RuleEnvelope } from '@/types/rule';

const createEnvelope = (): RuleEnvelope => ({
  irVersion: '1.0.0',
  metadata: {
    ruleId: 'task-16-test',
    name: 'Task 16 Test',
    description: null,
  },
  graph: createMinimalRuleGraph(),
  normalizedOutputs: {
    search: {
      nodeId: 'search_output',
      portName: 'normalized',
    },
  },
  capabilities: {
    supportsPagination: false,
    supportsConcurrency: false,
    requiresAuth: false,
    supportsJs: false,
    codec: false,
    crypto: {
      aes: false,
    },
    allowInlineSecrets: false,
  },
});

export const runRuleGraphRoundTripQa = () => {
  const rule = createEnvelope();
  const flow = graphToFlow(rule.graph);
  const nodesWithTransform = appendGraphNode(flow.nodes, 'transform').map(
    (node) => {
      if (node.id === 'transform_1') {
        return {
          ...node,
          position: {
            x: 320,
            y: 220,
          },
        };
      }

      return node;
    },
  );
  const firstEdge = createConnectedGraphEdge({
    source: 'search_input',
    sourceHandle: 'query',
    target: 'transform_1',
    targetHandle: 'in',
  });
  const secondEdge = createConnectedGraphEdge({
    source: 'transform_1',
    sourceHandle: 'out',
    target: 'search_output',
    targetHandle: 'items',
  });

  if (!firstEdge || !secondEdge) {
    throw new Error('Expected graph connections to produce two edges.');
  }

  const updatedRule = syncRuleGraph(rule, nodesWithTransform, [
    firstEdge,
    secondEdge,
  ]);
  const serializedRule = JSON.stringify(updatedRule);
  const reloadedRule = JSON.parse(serializedRule) as RuleEnvelope;
  const reloadedFlow = graphToFlow(reloadedRule.graph);

  if (reloadedRule.graph.nodes.length !== 3) {
    throw new Error(
      `Expected 3 nodes after reload, got ${reloadedRule.graph.nodes.length}.`,
    );
  }

  if (reloadedRule.graph.edges.length !== 2) {
    throw new Error(
      `Expected 2 edges after reload, got ${reloadedRule.graph.edges.length}.`,
    );
  }

  const transformLayout = reloadedRule.graph.layout?.nodes.transform_1;

  if (transformLayout?.x !== 320 || transformLayout.y !== 220) {
    throw new Error('Expected transform_1 layout to survive reload.');
  }

  const searchEntrypoint = reloadedRule.graph.phaseEntrypoints.search;

  if (
    searchEntrypoint?.nodeId !== 'search_input' ||
    searchEntrypoint.portName !== 'query'
  ) {
    throw new Error(
      'Expected search phase entrypoint to point at search_input.query.',
    );
  }

  const normalizedOutput = reloadedRule.normalizedOutputs.search;

  if (
    normalizedOutput?.nodeId !== 'search_output' ||
    normalizedOutput.portName !== 'normalized'
  ) {
    throw new Error(
      'Expected normalized output to point at search_output.normalized.',
    );
  }

  const nodeOrder = reloadedFlow.nodes.map((node) => node.id).join(',');

  if (nodeOrder !== 'search_input,search_output,transform_1') {
    throw new Error(`Unexpected node order after reload: ${nodeOrder}.`);
  }
};

runRuleGraphRoundTripQa();
