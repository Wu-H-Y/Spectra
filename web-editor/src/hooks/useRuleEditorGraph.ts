import {
  addEdge,
  applyEdgeChanges,
  applyNodeChanges,
  type Connection,
  type EdgeChange,
  type NodeChange,
} from '@xyflow/react';
import type { TFunction } from 'i18next';
import { useCallback } from 'react';
import { toast } from 'sonner';

import {
  appendGraphNode,
  createConnectedGraphEdge,
  syncRuleGraph,
} from '@/lib/ruleGraph';
import type { RuleGraphEdge, RuleGraphNode } from '@/lib/ruleGraph';
import type { NodeKind } from '@/types/NodeKind';
import type { RuleEnvelope } from '@/types/rule';

interface UseRuleEditorGraphOptions {
  graphNodes: RuleGraphNode[];
  graphEdges: RuleGraphEdge[];
  parsedRule: RuleEnvelope | null;
  setGraphState: (nodes: RuleGraphNode[], edges: RuleGraphEdge[]) => void;
  setJsonValue: (value: string) => void;
  t: TFunction;
}

interface UseRuleEditorGraphResult {
  handleAddNode: (kindType: NodeKind['type']) => void;
  handleConnect: (connection: Connection) => void;
  handleEdgesChange: (changes: EdgeChange[]) => void;
  handleNodesChange: (changes: NodeChange<RuleGraphNode>[]) => void;
  syncGraphToJson: () => void;
}

/**
 * 规则编辑器图操作 Hook。
 *
 * 负责 React Flow 画布交互与 graph 同步。
 */
export const useRuleEditorGraph = (
  options: UseRuleEditorGraphOptions,
): UseRuleEditorGraphResult => {
  const { graphNodes, graphEdges, parsedRule, setGraphState, setJsonValue, t } =
    options;

  // 同步图到 JSON
  const syncGraphToJson = useCallback(() => {
    if (!parsedRule) {
      toast.warning(t('rules.graphJsonSyncError'));
      return;
    }

    const updatedRule = syncRuleGraph(parsedRule, graphNodes, graphEdges);
    setJsonValue(JSON.stringify(updatedRule, null, 2));
  }, [parsedRule, graphNodes, graphEdges, setJsonValue, t]);

  // 添加节点
  const handleAddNode = useCallback(
    (kindType: NodeKind['type']) => {
      if (!parsedRule) {
        toast.warning(t('rules.graphJsonInvalid'));
        return;
      }

      const newNodes = appendGraphNode(graphNodes, kindType);
      setGraphState(newNodes, graphEdges);

      // 同步到 JSON
      const updatedRule = syncRuleGraph(parsedRule, newNodes, graphEdges);
      setJsonValue(JSON.stringify(updatedRule, null, 2));
    },
    [parsedRule, graphNodes, graphEdges, setGraphState, setJsonValue, t],
  );

  // 连接节点
  const handleConnect = useCallback(
    (connection: Connection) => {
      if (!parsedRule) {
        return;
      }

      const newEdge = createConnectedGraphEdge(connection);

      if (!newEdge) {
        return;
      }

      const newEdges = addEdge(newEdge, graphEdges);
      setGraphState(graphNodes, newEdges);

      // 同步到 JSON
      const updatedRule = syncRuleGraph(parsedRule, graphNodes, newEdges);
      setJsonValue(JSON.stringify(updatedRule, null, 2));
    },
    [parsedRule, graphNodes, graphEdges, setGraphState, setJsonValue],
  );

  // 处理边变化
  const handleEdgesChange = useCallback(
    (changes: EdgeChange[]) => {
      const newEdges = applyEdgeChanges(changes, graphEdges);
      setGraphState(graphNodes, newEdges);
    },
    [graphNodes, graphEdges, setGraphState],
  );

  // 处理节点变化
  const handleNodesChange = useCallback(
    (changes: NodeChange<RuleGraphNode>[]) => {
      const newNodes = applyNodeChanges(changes, graphNodes) as RuleGraphNode[];
      setGraphState(newNodes, graphEdges);
    },
    [graphNodes, graphEdges, setGraphState],
  );

  return {
    handleAddNode,
    handleConnect,
    handleEdgesChange,
    handleNodesChange,
    syncGraphToJson,
  };
};
