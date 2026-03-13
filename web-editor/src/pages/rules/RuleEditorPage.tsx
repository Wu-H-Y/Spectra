import { useCallback, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate, useParams } from 'react-router-dom';

import { PreviewPanel } from '@/components/preview/PreviewPanel';
import { RuleEditorHeader } from '@/components/rules/RuleEditorHeader';
import { RuleGraphEditorCard } from '@/components/rules/RuleGraphEditorCard';
import { RuleJsonEditorCard } from '@/components/rules/RuleJsonEditorCard';
import { RuleValidationResultCard } from '@/components/rules/RuleValidationResultCard';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { useRuleEditorGraph } from '@/hooks/useRuleEditorGraph';
import { useRuleEditorResource } from '@/hooks/useRuleEditorResource';
import { useRuleEditorRuntime } from '@/hooks/useRuleEditorRuntime';
import { useRuleEditorTransformFields } from '@/hooks/useRuleEditorTransformFields';
import { useRuleEditorTransformNode } from '@/hooks/useRuleEditorTransformNode';
import { parseRuleEnvelope } from '@/lib/ruleEditorEnvelope';
import { useEditorStore } from '@/stores';

/**
 * 规则编辑器页面。
 */
export const RuleEditorPage = () => {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const { id } = useParams<{ id: string }>();
  const isNew = !id;

  const jsonValue = useEditorStore((state) => state.jsonValue);
  const setJsonValue = useEditorStore((state) => state.setJsonValue);
  const graphNodes = useEditorStore((state) => state.graphNodes);
  const graphEdges = useEditorStore((state) => state.graphEdges);
  const setGraphState = useEditorStore((state) => state.setGraphState);

  const parsedRule = useMemo(() => {
    try {
      return parseRuleEnvelope(jsonValue);
    } catch {
      return null;
    }
  }, [jsonValue]);

  const { serverStatus, runtimeDiagnostics } = useRuleEditorRuntime();
  const {
    isLoading,
    saveMutation,
    validateMutation,
    handleSave,
    handleValidate,
  } = useRuleEditorResource({
    id,
    isNew,
    jsonValue,
    navigate,
    setJsonValue,
    t,
  });

  const {
    handleAddNode,
    handleConnect,
    handleEdgesChange,
    handleNodesChange,
    syncGraphToJson,
  } = useRuleEditorGraph({
    graphEdges,
    graphNodes,
    parsedRule,
    setGraphState,
    setJsonValue,
    t,
  });

  const {
    setSelectedGraphNodeId,
    selectedTransformNode,
    handleTransformParamChange,
  } = useRuleEditorTransformNode({
    graphEdges,
    graphNodes,
    syncGraphToJson,
  });

  const {
    isCryptoTransform,
    keySource,
    ivSource,
    selectedKeyRef,
    selectedIvRef,
    selectedTransformOpOptions,
    showIvEditor,
    handleSecretSourceChange,
    handleSecretRefNameChange,
  } = useRuleEditorTransformFields({
    onChange: handleTransformParamChange,
    selectedTransformNode,
  });

  const handleJsonChange = useCallback(
    (value: string | undefined) => {
      if (value !== undefined) {
        setJsonValue(value);
      }
    },
    [setJsonValue],
  );

  if (isLoading) {
    return (
      <div className="flex min-h-100 items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-b-2 border-primary" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <RuleEditorHeader
        isNew={isNew}
        isSaving={saveMutation.isPending}
        onCancel={() => navigate('/rules')}
        onSave={handleSave}
        onValidate={handleValidate}
      />

      <Tabs defaultValue="graph" className="space-y-4">
        <TabsList>
          <TabsTrigger value="graph">{t('rules.graph')}</TabsTrigger>
          <TabsTrigger value="json">{t('rules.json')}</TabsTrigger>
        </TabsList>

        <TabsContent value="graph">
          <RuleGraphEditorCard
            graphEdges={graphEdges}
            graphNodes={graphNodes}
            isGraphReady={parsedRule !== null}
            isCryptoTransform={isCryptoTransform}
            ivSource={ivSource}
            keySource={keySource}
            selectedIvName={selectedIvRef?.name || ''}
            selectedKeyName={selectedKeyRef?.name || ''}
            selectedTransformNode={selectedTransformNode}
            selectedTransformOpOptions={selectedTransformOpOptions}
            showIvEditor={showIvEditor}
            onAddNode={handleAddNode}
            onConnect={handleConnect}
            onEdgesChange={handleEdgesChange}
            onNodesChange={handleNodesChange}
            onPaneClick={() => setSelectedGraphNodeId(null)}
            onSecretRefNameChange={handleSecretRefNameChange}
            onSecretSourceChange={handleSecretSourceChange}
            onSelectNode={setSelectedGraphNodeId}
            onTransformParamChange={handleTransformParamChange}
          />
        </TabsContent>

        <TabsContent value="json">
          <RuleJsonEditorCard
            jsonValue={jsonValue}
            onChange={handleJsonChange}
          />
        </TabsContent>
      </Tabs>

      <PreviewPanel
        serverUrl={serverStatus?.url || null}
        isConnected={runtimeDiagnostics.isConnected}
        attachment={runtimeDiagnostics.attachment}
        isSelecting={runtimeDiagnostics.isSelecting}
        selectedElement={runtimeDiagnostics.selectedElement}
        events={runtimeDiagnostics.events}
        onAttach={runtimeDiagnostics.attach}
        onDetach={runtimeDiagnostics.detach}
        onClearEvents={runtimeDiagnostics.clearEvents}
      />

      <RuleValidationResultCard result={validateMutation.data} />
    </div>
  );
};

export default RuleEditorPage;
