import { describe, expect, test } from 'vitest';

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

describe('ruleGraph round trip', () => {
  test('keeps graph structure stable after edit and reload', () => {
    const rule = createEnvelope();
    const flow = graphToFlow(rule.graph);
    const nodesWithTransform = appendGraphNode(flow.nodes, 'transform').map(
      (node) => {
        if (node.id !== 'transform_1') {
          return node;
        }

        return {
          ...node,
          position: {
            x: 320,
            y: 220,
          },
        };
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

    expect(firstEdge).not.toBeNull();
    expect(secondEdge).not.toBeNull();

    const updatedRule = syncRuleGraph(rule, nodesWithTransform, [
      firstEdge!,
      secondEdge!,
    ]);
    const reloadedRule = JSON.parse(
      JSON.stringify(updatedRule),
    ) as RuleEnvelope;
    const reloadedFlow = graphToFlow(reloadedRule.graph);

    expect(reloadedRule.graph.nodes).toHaveLength(3);
    expect(reloadedRule.graph.edges).toHaveLength(2);
    expect(reloadedRule.graph.layout?.nodes.transform_1).toEqual({
      x: 320,
      y: 220,
    });
    expect(reloadedRule.graph.phaseEntrypoints.search).toEqual({
      nodeId: 'search_input',
      portName: 'query',
    });
    expect(reloadedRule.normalizedOutputs.search).toEqual({
      nodeId: 'search_output',
      portName: 'normalized',
    });
    expect(reloadedFlow.nodes.map((node) => node.id)).toEqual([
      'search_input',
      'search_output',
      'transform_1',
    ]);
  });
});
