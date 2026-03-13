import type { Connection, EdgeChange, NodeChange } from '@xyflow/react';
import { useTranslation } from 'react-i18next';

import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import type { RuleGraphEdge, RuleGraphNode } from '@/lib/ruleGraph';
import type { NodeKind } from '@/types/NodeKind';

import { TransformParamEditor } from './TransformParamEditor';

type SecretSource = 'inline' | 'variable' | 'secureStore';

interface RuleGraphEditorCardProps {
  graphNodes: RuleGraphNode[];
  graphEdges: RuleGraphEdge[];
  isGraphReady: boolean;
  isCryptoTransform: boolean;
  ivSource: SecretSource;
  keySource: SecretSource;
  selectedIvName: string;
  selectedKeyName: string;
  selectedTransformNode: {
    id: string;
    params: Record<string, string>;
  } | null;
  selectedTransformOpOptions: string[];
  showIvEditor: boolean;
  onAddNode: (kindType: NodeKind['type']) => void;
  onConnect: (connection: Connection) => void;
  onEdgesChange: (changes: EdgeChange[]) => void;
  onNodesChange: (changes: NodeChange<RuleGraphNode>[]) => void;
  onPaneClick: () => void;
  onSecretRefNameChange: (param: 'key' | 'iv', name: string) => void;
  onSecretSourceChange: (param: 'key' | 'iv', source: SecretSource) => void;
  onSelectNode: (id: string | null) => void;
  onTransformParamChange: (key: string, value: string) => void;
}

/**
 * 规则图编辑器卡片组件。
 *
 * 包含 React Flow 画布、节点添加按钮和 Transform 参数编辑器。
 */
export const RuleGraphEditorCard = ({
  graphNodes,
  graphEdges,
  isGraphReady,
  isCryptoTransform,
  ivSource,
  keySource,
  selectedIvName,
  selectedKeyName,
  selectedTransformNode,
  showIvEditor,
  onAddNode,
  onTransformParamChange,
  onSecretSourceChange,
  onSecretRefNameChange,
}: RuleGraphEditorCardProps) => {
  const { t } = useTranslation();

  return (
    <Card>
      <CardHeader>
        <CardTitle>{t('rules.graph')}</CardTitle>
        <CardDescription>{t('rules.graphEditorDescription')}</CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        {/* 状态提示 */}
        {!isGraphReady && (
          <div className="rounded-lg border border-yellow-500 bg-yellow-50 p-4 text-sm text-yellow-800">
            {t('rules.graphJsonInvalid')}
          </div>
        )}
        {isGraphReady && (
          <div className="rounded-lg border border-green-500 bg-green-50 p-4 text-sm text-green-800">
            {t('rules.graphReady')}
          </div>
        )}

        {/* 节点统计 */}
        <div className="text-sm text-muted-foreground">
          {t('rules.graphSummary', {
            nodes: graphNodes.length,
            edges: graphEdges.length,
          })}
        </div>

        {/* 添加节点按钮 */}
        <div className="flex gap-2">
          <Button size="sm" onClick={() => onAddNode('input')}>
            {t('rules.addInputNode')}
          </Button>
          <Button size="sm" onClick={() => onAddNode('transform')}>
            {t('rules.addTransformNode')}
          </Button>
          <Button size="sm" onClick={() => onAddNode('output')}>
            {t('rules.addOutputNode')}
          </Button>
        </div>

        {/* Transform 参数编辑器 */}
        {selectedTransformNode && (
          <TransformParamEditor
            isCryptoTransform={isCryptoTransform}
            ivSource={ivSource}
            keySource={keySource}
            nodeId={selectedTransformNode.id}
            params={selectedTransformNode.params}
            selectedIvName={selectedIvName}
            selectedKeyName={selectedKeyName}
            showIvEditor={showIvEditor}
            onChange={onTransformParamChange}
            onSecretRefNameChange={onSecretRefNameChange}
            onSecretSourceChange={onSecretSourceChange}
          />
        )}
      </CardContent>
    </Card>
  );
};

export default RuleGraphEditorCard;
