import { useCallback, useState } from 'react';

import type { RuleGraphEdge, RuleGraphNode } from '@/lib/ruleGraph';

interface UseRuleEditorTransformNodeOptions {
  graphNodes: RuleGraphNode[];
  graphEdges: RuleGraphEdge[];
  syncGraphToJson: () => void;
}

interface TransformNode {
  id: string;
  params: Record<string, string>;
}

interface UseRuleEditorTransformNodeResult {
  setSelectedGraphNodeId: (id: string | null) => void;
  selectedTransformNode: TransformNode | null;
  handleTransformParamChange: (key: string, value: string) => void;
}

/**
 * 规则编辑器 Transform 节点选择 Hook。
 *
 * 负责选中节点状态管理与参数变更回调。
 */
export const useRuleEditorTransformNode = (
  options: UseRuleEditorTransformNodeOptions,
): UseRuleEditorTransformNodeResult => {
  const { graphNodes, syncGraphToJson } = options;
  const [selectedGraphNodeId, setSelectedGraphNodeId] = useState<string | null>(
    null,
  );

  // 获取选中的 transform 节点
  const selectedTransformNode = (() => {
    if (!selectedGraphNodeId) {
      return null;
    }

    const node = graphNodes.find((n) => n.id === selectedGraphNodeId);

    if (!node || node.data.kindType !== 'transform') {
      return null;
    }

    return {
      id: node.id,
      params: node.data.params,
    };
  })();

  // 处理参数变更
  const handleTransformParamChange = useCallback(
    (key: string, value: string) => {
      if (!selectedGraphNodeId) {
        return;
      }

      const node = graphNodes.find((n) => n.id === selectedGraphNodeId);

      if (!node) {
        return;
      }

      // 更新节点参数
      node.data.params = {
        ...node.data.params,
        [key]: value,
      };

      // 同步到 JSON
      syncGraphToJson();
    },
    [selectedGraphNodeId, graphNodes, syncGraphToJson],
  );

  return {
    setSelectedGraphNodeId,
    selectedTransformNode,
    handleTransformParamChange,
  };
};
