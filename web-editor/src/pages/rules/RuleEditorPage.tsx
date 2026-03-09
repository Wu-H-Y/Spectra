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
import { useCallback, useEffect, useMemo, useState } from 'react';
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
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
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

const AES_TRANSFORMATION_OPTIONS = [
  'AES/CBC/PKCS7Padding',
  'AES/ECB/PKCS7Padding',
] as const;

const TRANSFORM_FAMILY_OPTIONS = [
  'text',
  'list',
  'json',
  'convert',
  'url',
  'js',
  'codec',
  'crypto',
] as const;

const TRANSFORM_OP_OPTIONS: Partial<Record<string, readonly string[]>> = {
  codec: [
    'base64Encode',
    'base64Decode',
    'md532',
    'md516',
    'encodeURI',
    'utf8ToGbk',
    'htmlFormat',
    'timeFormat',
  ],
  crypto: [
    'aesEncode',
    'aesDecode',
    'aesCbcEncode',
    'aesCbcDecode',
    'aesEcbEncode',
    'aesEcbDecode',
  ],
};

type SecretSource = 'inline' | 'variableRef' | 'secureStoreRef';

interface ParsedKeyRef {
  provider: 'inline' | 'variable' | 'secureStore';
  name?: string;
  value?: string;
}

const parseKeyRef = (value?: string): ParsedKeyRef | null => {
  if (!value) {
    return null;
  }

  try {
    const parsed = JSON.parse(value) as ParsedKeyRef;
    if (
      parsed.provider === 'inline' ||
      parsed.provider === 'variable' ||
      parsed.provider === 'secureStore'
    ) {
      return parsed;
    }
  } catch {
    // ignore
  }

  return null;
};

const buildKeyRef = (ref: ParsedKeyRef) =>
  JSON.stringify({
    provider: ref.provider,
    ...(ref.name ? { name: ref.name } : {}),
    ...(ref.value ? { value: ref.value } : {}),
  });

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
    supportsJs: false,
    codec: false,
    crypto: {
      aes: false,
    },
    allowInlineSecrets: false,
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
  const isNew = !id;

  const initialRule = useMemo(() => createEmptyRuleEnvelope(), []);
  const [selectedGraphNodeId, setSelectedGraphNodeId] = useState<string | null>(
    null,
  );

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

  useEffect(() => {
    if (
      selectedGraphNodeId &&
      !graphNodes.some((node) => node.id === selectedGraphNodeId)
    ) {
      setSelectedGraphNodeId(null);
    }
  }, [graphNodes, selectedGraphNodeId]);

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

  const selectedTransformNode = useMemo(() => {
    if (!selectedGraphNodeId) {
      return null;
    }

    const targetNode = graphNodes.find((node) => node.id === selectedGraphNodeId);
    if (!targetNode || targetNode.data.kindType !== 'transform') {
      return null;
    }

    return targetNode;
  }, [graphNodes, selectedGraphNodeId]);

  const handleTransformParamChange = useCallback(
    (key: string, value: string) => {
      if (!selectedTransformNode) {
        return;
      }

      const nextNodes = graphNodes.map((node) => {
        if (node.id !== selectedTransformNode.id) {
          return node;
        }

        return {
          ...node,
          data: {
            ...node.data,
            params: {
              ...node.data.params,
              [key]: value,
            },
          },
        };
      });

      syncGraphToJson(nextNodes, graphEdges);
    },
    [graphEdges, graphNodes, selectedTransformNode, syncGraphToJson],
  );

  const selectedTransformFamily =
    selectedTransformNode?.data.params.family?.trim().toLowerCase() ?? '';
  const selectedTransformOpOptions =
    TRANSFORM_OP_OPTIONS[selectedTransformFamily] || null;
  const selectedTransformOp =
    selectedTransformNode?.data.params.op?.trim().toLowerCase() ?? '';
  const selectedKeyRef = parseKeyRef(selectedTransformNode?.data.params.keyRef);
  const selectedIvRef = parseKeyRef(selectedTransformNode?.data.params.ivRef);

  const keySource: SecretSource = selectedKeyRef
    ? selectedKeyRef.provider === 'secureStore'
      ? 'secureStoreRef'
      : selectedKeyRef.provider === 'variable'
        ? 'variableRef'
        : 'inline'
    : 'inline';
  const ivSource: SecretSource = selectedIvRef
    ? selectedIvRef.provider === 'secureStore'
      ? 'secureStoreRef'
      : selectedIvRef.provider === 'variable'
        ? 'variableRef'
        : 'inline'
    : 'inline';

  const handleSecretSourceChange = useCallback(
    (target: 'key' | 'iv', source: SecretSource) => {
      if (source === 'inline') {
        handleTransformParamChange(`${target}Ref`, '');
        return;
      }

      handleTransformParamChange(target, '');

      const provider = source === 'variableRef' ? 'variable' : 'secureStore';
      handleTransformParamChange(
        `${target}Ref`,
        buildKeyRef({
          provider,
          name: '',
        }),
      );
    },
    [handleTransformParamChange],
  );

  const handleSecretRefNameChange = useCallback(
    (target: 'key' | 'iv', name: string) => {
      const parsed = parseKeyRef(
        target === 'key'
          ? selectedTransformNode?.data.params.keyRef
          : selectedTransformNode?.data.params.ivRef,
      );
      const provider = parsed?.provider === 'secureStore' ? 'secureStore' : 'variable';
      handleTransformParamChange(
        `${target}Ref`,
        buildKeyRef({
          provider,
          name,
        }),
      );
    },
    [handleTransformParamChange, selectedTransformNode?.data.params.ivRef, selectedTransformNode?.data.params.keyRef],
  );

  const showIvEditor =
    selectedTransformOp !== 'aesecbencode' && selectedTransformOp !== 'aesecbdecode';

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
                  onNodeClick={(_, node) => {
                    setSelectedGraphNodeId(node.id);
                  }}
                  onPaneClick={() => {
                    setSelectedGraphNodeId(null);
                  }}
                >
                  <Background />
                  <Controls />
                </ReactFlow>
              </div>

              {selectedTransformNode && (
                <div className="mt-4 rounded-lg border bg-muted/20 p-4">
                  <div className="mb-3 text-sm font-medium">
                    {t('rules.transformParamEditorTitle', {
                      nodeId: selectedTransformNode.id,
                    })}
                  </div>

                  <div className="grid gap-3 md:grid-cols-2">
                    <div className="space-y-2">
                      <Label>{t('rules.transformParamFamily')}</Label>
                      <Select
                        value={selectedTransformNode.data.params.family || ''}
                        onValueChange={(value) => {
                          handleTransformParamChange('family', value);
                        }}
                      >
                        <SelectTrigger>
                          <SelectValue
                            placeholder={t('rules.transformParamFamilyPlaceholder')}
                          />
                        </SelectTrigger>
                        <SelectContent>
                          {TRANSFORM_FAMILY_OPTIONS.map((option) => (
                            <SelectItem key={option} value={option}>
                              {option}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                    </div>

                    <div className="space-y-2">
                      <Label>{t('rules.transformParamOp')}</Label>
                      {selectedTransformOpOptions ? (
                        <Select
                          value={selectedTransformNode.data.params.op || ''}
                          onValueChange={(value) => {
                            handleTransformParamChange('op', value);
                          }}
                        >
                          <SelectTrigger>
                            <SelectValue
                              placeholder={t('rules.transformParamOpPlaceholder')}
                            />
                          </SelectTrigger>
                          <SelectContent>
                            {selectedTransformOpOptions.map((option) => (
                              <SelectItem key={option} value={option}>
                                {option}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>
                      ) : (
                        <Input
                          value={selectedTransformNode.data.params.op || ''}
                          onChange={(event) => {
                            handleTransformParamChange('op', event.target.value);
                          }}
                          placeholder={t('rules.transformParamOpPlaceholder')}
                        />
                      )}
                    </div>
                  </div>

                  {selectedTransformFamily === 'crypto' && (
                    <div className="mt-3 grid gap-3 md:grid-cols-2">
                      <div className="space-y-2 md:col-span-2">
                        <Label>{t('rules.transformParamTransformation')}</Label>
                        <Select
                          value={
                            selectedTransformNode.data.params.transformation ||
                            AES_TRANSFORMATION_OPTIONS[0]
                          }
                          onValueChange={(value) => {
                            handleTransformParamChange('transformation', value);
                          }}
                        >
                          <SelectTrigger>
                            <SelectValue />
                          </SelectTrigger>
                          <SelectContent>
                            {AES_TRANSFORMATION_OPTIONS.map((option) => (
                              <SelectItem key={option} value={option}>
                                {option}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>
                      </div>

                      <div className="space-y-2">
                        <Label>{t('rules.transformParamKey')}</Label>
                        <Select
                          value={keySource}
                          onValueChange={(value) => {
                            handleSecretSourceChange('key', value as SecretSource);
                          }}
                        >
                          <SelectTrigger>
                            <SelectValue />
                          </SelectTrigger>
                          <SelectContent>
                            <SelectItem value="inline">
                              {t('rules.transformSecretSourceInline')}
                            </SelectItem>
                            <SelectItem value="variableRef">
                              {t('rules.transformSecretSourceVariable')}
                            </SelectItem>
                            <SelectItem value="secureStoreRef">
                              {t('rules.transformSecretSourceSecureStore')}
                            </SelectItem>
                          </SelectContent>
                        </Select>

                        {keySource === 'inline' ? (
                          <Input
                            value={selectedTransformNode.data.params.key || ''}
                            onChange={(event) => {
                              handleTransformParamChange('key', event.target.value);
                            }}
                            placeholder={t('rules.transformParamKeyPlaceholder')}
                          />
                        ) : (
                          <Input
                            value={selectedKeyRef?.name || ''}
                            onChange={(event) => {
                              handleSecretRefNameChange('key', event.target.value);
                            }}
                            placeholder={t('rules.transformParamKeyRefNamePlaceholder')}
                          />
                        )}

                        <p className="text-xs text-muted-foreground">
                          {t('rules.transformParamKeyHint')}
                        </p>
                      </div>

                      {showIvEditor && (
                        <div className="space-y-2">
                          <Label>{t('rules.transformParamIv')}</Label>
                          <Select
                            value={ivSource}
                            onValueChange={(value) => {
                              handleSecretSourceChange('iv', value as SecretSource);
                            }}
                          >
                            <SelectTrigger>
                              <SelectValue />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="inline">
                                {t('rules.transformSecretSourceInline')}
                              </SelectItem>
                              <SelectItem value="variableRef">
                                {t('rules.transformSecretSourceVariable')}
                              </SelectItem>
                              <SelectItem value="secureStoreRef">
                                {t('rules.transformSecretSourceSecureStore')}
                              </SelectItem>
                            </SelectContent>
                          </Select>

                          {ivSource === 'inline' ? (
                            <Input
                              value={selectedTransformNode.data.params.iv || ''}
                              onChange={(event) => {
                                handleTransformParamChange('iv', event.target.value);
                              }}
                              placeholder={t('rules.transformParamIvPlaceholder')}
                            />
                          ) : (
                            <Input
                              value={selectedIvRef?.name || ''}
                              onChange={(event) => {
                                handleSecretRefNameChange('iv', event.target.value);
                              }}
                              placeholder={t('rules.transformParamIvRefNamePlaceholder')}
                            />
                          )}

                          <p className="text-xs text-muted-foreground">
                            {t('rules.transformParamIvHint')}
                          </p>
                        </div>
                      )}
                    </div>
                  )}
                </div>
              )}
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
