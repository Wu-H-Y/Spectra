import Editor from '@monaco-editor/react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import {
  Background,
  Controls,
  ReactFlow,
  applyEdgeChanges,
  applyNodeChanges,
  type Connection,
  type EdgeChange,
  type NodeChange,
} from '@xyflow/react';
import { useCallback, useEffect, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate, useParams } from 'react-router-dom';
import { toast } from 'sonner';

import '@xyflow/react/dist/style.css';
import { rulesApi, serverApi } from '@/api/client';
import type { Selector } from '@/api/types';
import { PreviewPanel } from '@/components/preview/PreviewPanel';
import RuleGraphNode from '@/components/rules/RuleGraphNode';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { useElementSelection } from '@/hooks/useWebSocket';
import {
  appendGraphNode,
  createConnectedGraphEdge,
  createMinimalRuleGraph,
  deriveNormalizedOutputs,
  graphToFlow,
  syncRuleGraph,
} from '@/lib/ruleGraph';
import { useEditorStore, useSelectorApplyStore } from '@/stores';
import type { RuleEnvelope } from '@/types/rule';

const nodeTypes = {
  ruleNode: RuleGraphNode,
};

const createEmptyRuleEnvelope = (): RuleEnvelope => ({
  irVersion: '1.0.0',
  metadata: {
    ruleId: crypto.randomUUID(),
    name: '',
    description: null,
  },
  graph: createMinimalRuleGraph(),
  normalizedOutputs: deriveNormalizedOutputs(createMinimalRuleGraph()),
  capabilities: {
    supportsPagination: false,
    supportsConcurrency: false,
    requiresAuth: false,
  },
});

const formatRuleEnvelope = (rule: RuleEnvelope) =>
  JSON.stringify(rule, null, 2);

const parseRuleEnvelope = (jsonValue: string): RuleEnvelope =>
  JSON.parse(jsonValue) as RuleEnvelope;

/**
 * 规则编辑器页面。
 */
export function RuleEditorPage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const { id } = useParams<{ id: string }>();
  const queryClient = useQueryClient();
  const isNew = id === 'new';

  const initialRule = useMemo(() => createEmptyRuleEnvelope(), []);

  const { jsonValue, setJsonValue, graphNodes, graphEdges, setGraphState } =
    useEditorStore();
  const parsedRule = useMemo(() => {
    try {
      return parseRuleEnvelope(jsonValue);
    } catch {
      return null;
    }
  }, [jsonValue]);

  const { data: serverStatus } = useQuery({
    queryKey: ['server', 'status'],
    queryFn: serverApi.status,
    refetchInterval: 5000,
  });

  const {
    isConnected: isWsConnected,
    previewSessionId,
    isSelecting,
    selectedElement,
    openPreviewSession,
    startSelection,
    cancelSelection,
    clearSelection,
    connect,
  } = useElementSelection(
    serverStatus
      ? {
          url: serverStatus.url,
          serverToken: serverStatus.serverToken,
        }
      : null,
  );

  useEffect(() => {
    if (serverStatus?.isRunning) {
      connect();
    }
  }, [serverStatus?.isRunning, connect]);

  const { setApplyCallback } = useSelectorApplyStore();

  const { data: existingRule, isLoading } = useQuery({
    queryKey: ['rules', id],
    queryFn: () => rulesApi.getEnvelope(id!),
    enabled: !isNew && !!id,
  });

  useEffect(() => {
    if (isNew) {
      setJsonValue(formatRuleEnvelope(initialRule));
      return;
    }

    if (existingRule?.rule) {
      setJsonValue(formatRuleEnvelope(existingRule.rule));
    }
  }, [existingRule, initialRule, isNew, setJsonValue]);

  useEffect(() => {
    if (!parsedRule) {
      return;
    }

    const flowGraph = graphToFlow(parsedRule.graph);
    setGraphState(flowGraph.nodes, flowGraph.edges);
  }, [parsedRule, setGraphState]);

  const saveMutation = useMutation({
    mutationFn: async (ruleData: RuleEnvelope) => {
      if (isNew) {
        return rulesApi.createEnvelope(ruleData);
      }
      return rulesApi.updateEnvelope(id!, ruleData);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['rules'] });
      navigate('/rules');
    },
  });

  const validateMutation = useMutation({
    mutationFn: (ruleData: RuleEnvelope) => rulesApi.validateEnvelope(ruleData),
  });

  const withParsedRuleEnvelope = (
    callback: (ruleEnvelope: RuleEnvelope) => void,
  ) => {
    try {
      const ruleEnvelope = parseRuleEnvelope(jsonValue);
      callback(ruleEnvelope);
    } catch {
      toast.error(t('errors.error'));
    }
  };

  const handleSave = () => {
    withParsedRuleEnvelope((ruleEnvelope) => {
      saveMutation.mutate(ruleEnvelope);
    });
  };

  const handleValidate = () => {
    withParsedRuleEnvelope((ruleEnvelope) => {
      validateMutation.mutate(ruleEnvelope);
    });
  };

  const handleJsonChange = (value: string | undefined) => {
    if (value === undefined) {
      return;
    }

    setJsonValue(value);

    try {
      parseRuleEnvelope(value);
    } catch {
      // Ignore invalid JSON while editing.
    }
  };

  const syncGraphToJson = useCallback(
    (nextNodes = graphNodes, nextEdges = graphEdges) => {
      if (!parsedRule) {
        toast.error(t('rules.graphJsonSyncError'));
        return;
      }

      setGraphState(nextNodes, nextEdges);
      setJsonValue(
        formatRuleEnvelope(syncRuleGraph(parsedRule, nextNodes, nextEdges)),
      );
    },
    [graphEdges, graphNodes, parsedRule, setGraphState, setJsonValue, t],
  );

  const handleAddNode = useCallback(
    (kindType: 'input' | 'transform' | 'output') => {
      syncGraphToJson(appendGraphNode(graphNodes, kindType), graphEdges);
    },
    [graphEdges, graphNodes, syncGraphToJson],
  );

  const handleNodesChange = useCallback(
    (changes: NodeChange[]) => {
      const nextNodes = applyNodeChanges(
        changes,
        graphNodes,
      ) as typeof graphNodes;
      const nodeIds = new Set(nextNodes.map((node) => node.id));
      const nextEdges = graphEdges.filter(
        (edge) => nodeIds.has(edge.source) && nodeIds.has(edge.target),
      );

      syncGraphToJson(nextNodes, nextEdges);
    },
    [graphEdges, graphNodes, syncGraphToJson],
  );

  const handleEdgesChange = useCallback(
    (changes: EdgeChange[]) => {
      syncGraphToJson(graphNodes, applyEdgeChanges(changes, graphEdges));
    },
    [graphEdges, graphNodes, syncGraphToJson],
  );

  const handleConnect = useCallback(
    (connection: Connection) => {
      const nextEdge = createConnectedGraphEdge(connection);

      if (!nextEdge) {
        return;
      }

      syncGraphToJson(graphNodes, [...graphEdges, nextEdge]);
    },
    [graphEdges, graphNodes, syncGraphToJson],
  );

  const handleApplySelector = (selector: string, type: 'css' | 'xpath') => {
    const newSelector: Selector = {
      type,
      expression: selector,
    };

    const { applyCallback } = useSelectorApplyStore.getState();
    if (applyCallback) {
      applyCallback(newSelector);
      setApplyCallback(null);
      toast.success(t('preview.selectorApplied'));
    } else {
      toast.success(t('preview.selectorCopied'));
    }
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-100">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-3xl font-bold tracking-tight">
            {isNew ? t('common.newRule') : t('rules.editRule')}
          </h2>
          <p className="text-muted-foreground">
            {isNew ? t('rules.createNewRule') : t('rules.editRuleDescription')}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" onClick={() => navigate('/rules')}>
            {t('common.cancel')}
          </Button>
          <Button variant="outline" onClick={handleValidate}>
            {t('rules.validate')}
          </Button>
          <Button onClick={handleSave} disabled={saveMutation.isPending}>
            {t('common.save')}
          </Button>
        </div>
      </div>

      <Tabs defaultValue="graph" className="space-y-4">
        <TabsList>
          <TabsTrigger value="graph">{t('rules.graph')}</TabsTrigger>
          <TabsTrigger value="json">{t('rules.json')}</TabsTrigger>
        </TabsList>

        <TabsContent value="graph">
          <Card>
            <CardHeader className="flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
              <div>
                <CardTitle>{t('rules.graph')}</CardTitle>
                <CardDescription>
                  {parsedRule
                    ? t('rules.graphReady')
                    : t('rules.graphJsonInvalid')}
                </CardDescription>
              </div>

              <div className="flex flex-wrap items-center gap-2">
                <Badge variant={parsedRule ? 'secondary' : 'destructive'}>
                  {t('rules.graphSummary', {
                    nodes: graphNodes.length,
                    edges: graphEdges.length,
                  })}
                </Badge>
                <Button
                  variant="outline"
                  onClick={() => handleAddNode('input')}
                  disabled={!parsedRule}
                >
                  {t('rules.addInputNode')}
                </Button>
                <Button
                  variant="outline"
                  onClick={() => handleAddNode('transform')}
                  disabled={!parsedRule}
                >
                  {t('rules.addTransformNode')}
                </Button>
                <Button
                  variant="outline"
                  onClick={() => handleAddNode('output')}
                  disabled={!parsedRule}
                >
                  {t('rules.addOutputNode')}
                </Button>
              </div>
            </CardHeader>
            <CardContent>
              <div className="h-[560px] overflow-hidden rounded-lg border bg-muted/20">
                <ReactFlow
                  nodes={graphNodes}
                  edges={graphEdges}
                  nodeTypes={nodeTypes}
                  onNodesChange={handleNodesChange}
                  onEdgesChange={handleEdgesChange}
                  onConnect={handleConnect}
                  fitView
                  deleteKeyCode={['Backspace', 'Delete']}
                  nodesDraggable={parsedRule !== null}
                  nodesConnectable={parsedRule !== null}
                  elementsSelectable={parsedRule !== null}
                >
                  <Background />
                  <Controls />
                </ReactFlow>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="json">
          <Card>
            <CardHeader>
              <CardTitle>{t('rules.json')}</CardTitle>
              <CardDescription>
                {t('rules.jsonEditorDescription')}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Editor
                height="600px"
                defaultLanguage="json"
                value={jsonValue}
                onChange={handleJsonChange}
                options={{
                  minimap: { enabled: false },
                  fontSize: 14,
                  lineNumbers: 'on',
                  scrollBeyondLastLine: false,
                  automaticLayout: true,
                }}
              />
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

      <PreviewPanel
        serverUrl={serverStatus?.url || null}
        serverToken={serverStatus?.serverToken || null}
        isConnected={isWsConnected}
        previewSessionId={previewSessionId}
        isSelecting={isSelecting}
        selectedElement={selectedElement}
        onStartSelection={startSelection}
        onCancelSelection={cancelSelection}
        onClearSelection={clearSelection}
        onPreviewOpened={openPreviewSession}
        onApplySelector={handleApplySelector}
      />

      {validateMutation.data && (
        <Card
          className={
            validateMutation.data.valid ? 'border-green-500' : 'border-red-500'
          }
        >
          <CardHeader>
            <CardTitle>
              {validateMutation.data.valid
                ? t('rules.validationPassed')
                : t('rules.validationFailed')}
            </CardTitle>
          </CardHeader>
          {validateMutation.data.errors.length > 0 && (
            <CardContent>
              <ul className="list-disc pl-5 space-y-1">
                {validateMutation.data.errors.map((error, index) => (
                  <li key={index} className="text-sm text-destructive">
                    <span className="font-mono">{error.path}:</span>{' '}
                    {error.message}
                  </li>
                ))}
              </ul>
            </CardContent>
          )}
        </Card>
      )}
    </div>
  );
}

export default RuleEditorPage;
