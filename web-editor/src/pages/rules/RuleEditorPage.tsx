import Editor from '@monaco-editor/react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate, useParams } from 'react-router-dom';
import { toast } from 'sonner';

import { rulesApi, serverApi } from '@/api/client';
import type { CrawlerRule } from '@/api/types';
import type { Selector } from '@/api/types';
import { PreviewPanel } from '@/components/preview/PreviewPanel';
import { ActionSequenceEditor } from '@/components/rules/ActionSequenceEditor';
import { FieldMappingEditor } from '@/components/rules/FieldMappingEditor';
import { PaginationConfigForm } from '@/components/rules/PaginationConfigForm';
import { RequestConfigForm } from '@/components/rules/RequestConfigForm';
import { RuleMetadataForm } from '@/components/rules/RuleMetadataForm';
import { UrlMatchingForm } from '@/components/rules/UrlMatchingForm';
import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Label } from '@/components/ui/label';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { useElementSelection } from '@/hooks/useWebSocket';
import { useEditorStore, useSelectorApplyStore } from '@/stores';

/**
 * 规则编辑器页面。
 */
export function RuleEditorPage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const { id } = useParams<{ id: string }>();
  const queryClient = useQueryClient();
  const isNew = id === 'new';

  const { isJsonMode, jsonValue, toggleJsonMode, setJsonValue } =
    useEditorStore();

  const [rule, setRule] = useState<Partial<CrawlerRule>>({
    name: '',
    description: '',
    mediaType: 'generic',
    match: { pattern: '', type: 'regex' },
    request: {},
    extract: {},
    beforeActions: [],
    afterActions: [],
    tags: [],
    enabled: true,
  });

  // 获取服务器状态
  const { data: serverStatus } = useQuery({
    queryKey: ['server', 'status'],
    queryFn: serverApi.status,
    refetchInterval: 5000, // 每5秒刷新一次
  });

  // 元素选择 WebSocket 连接
  const {
    isConnected: isWsConnected,
    isSelecting,
    selectedElement,
    startSelection,
    cancelSelection,
    clearSelection,
    connect,
  } = useElementSelection(serverStatus?.url || null);

  // 连接 WebSocket
  useEffect(() => {
    if (serverStatus?.isRunning) {
      connect();
    }
  }, [serverStatus?.isRunning, connect]);

  // 选择器应用回调
  const { setApplyCallback } = useSelectorApplyStore();

  // Fetch existing rule if editing
  const { data: existingRule, isLoading } = useQuery({
    queryKey: ['rules', id],
    queryFn: () => rulesApi.get(id!),
    enabled: !isNew && !!id,
  });

  // Update rule state when existing rule is loaded
  if (existingRule && !rule.id) {
    setRule(existingRule);
    setJsonValue(JSON.stringify(existingRule, null, 2));
  }

  // Create/Update mutation
  const saveMutation = useMutation({
    mutationFn: (ruleData: CrawlerRule) => {
      if (isNew) {
        return rulesApi.create(ruleData);
      }
      return rulesApi.update(id!, ruleData);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['rules'] });
      navigate('/rules');
    },
  });

  // Validate mutation
  const validateMutation = useMutation({
    mutationFn: (ruleData: CrawlerRule) => rulesApi.validate(ruleData),
  });

  const handleSave = () => {
    const ruleToSave = isJsonMode ? JSON.parse(jsonValue) : rule;
    saveMutation.mutate(ruleToSave as CrawlerRule);
  };

  const handleValidate = () => {
    const ruleToValidate = isJsonMode ? JSON.parse(jsonValue) : rule;
    validateMutation.mutate(ruleToValidate as CrawlerRule);
  };

  const handleJsonChange = (value: string | undefined) => {
    if (value !== undefined) {
      setJsonValue(value);
      try {
        const parsed = JSON.parse(value);
        setRule(parsed);
      } catch {
        // Invalid JSON, ignore
      }
    }
  };

  const updateRule = (updates: Partial<CrawlerRule>) => {
    const newRule = { ...rule, ...updates };
    setRule(newRule);
    setJsonValue(JSON.stringify(newRule, null, 2));
  };

  // 应用选择器到当前规则
  const handleApplySelector = (selector: string, type: 'css' | 'xpath') => {
    const newSelector: Selector = {
      type,
      expression: selector,
    };

    // 使用回调来应用选择器
    const { applyCallback } = useSelectorApplyStore.getState();
    if (applyCallback) {
      applyCallback(newSelector);
      setApplyCallback(null); // 清除回调
      toast.success(t('selectorApplied', { defaultValue: 'Selector applied' }));
    } else {
      // 没有活动的字段，显示选择器供用户复制
      toast.success(
        t('selectorCopied', {
          defaultValue: `Selector: ${selector}`,
        }),
      );
    }
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-3xl font-bold tracking-tight">
            {isNew
              ? t('newRule')
              : t('editRule', { defaultValue: 'Edit Rule' })}
          </h2>
          <p className="text-muted-foreground">
            {isNew
              ? t('createNewRule', {
                  defaultValue: 'Create a new crawler rule',
                })
              : t('editRuleDescription', {
                  defaultValue: 'Modify the crawler rule',
                })}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" onClick={() => navigate('/rules')}>
            {t('cancel')}
          </Button>
          <Button variant="outline" onClick={handleValidate}>
            {t('validate', { defaultValue: 'Validate' })}
          </Button>
          <Button onClick={handleSave} disabled={saveMutation.isPending}>
            {t('save')}
          </Button>
        </div>
      </div>

      {/* Mode Toggle */}
      <div className="flex items-center gap-2">
        <Button
          variant={!isJsonMode ? 'default' : 'outline'}
          size="sm"
          onClick={() => toggleJsonMode()}
        >
          {t('formMode', { defaultValue: 'Form' })}
        </Button>
        <Button
          variant={isJsonMode ? 'default' : 'outline'}
          size="sm"
          onClick={() => toggleJsonMode()}
        >
          JSON
        </Button>
      </div>

      {/* Editor Content */}
      {isJsonMode ? (
        <Card>
          <CardHeader>
            <CardTitle>JSON Editor</CardTitle>
            <CardDescription>
              {t('jsonEditorDescription', {
                defaultValue: 'Edit the rule in JSON format',
              })}
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
      ) : (
        <Tabs defaultValue="metadata" className="space-y-4">
          <TabsList className="grid w-full grid-cols-8">
            <TabsTrigger value="metadata">
              {t('metadata', { defaultValue: 'Metadata' })}
            </TabsTrigger>
            <TabsTrigger value="url">{t('urlMatching')}</TabsTrigger>
            <TabsTrigger value="request">
              {t('request', { defaultValue: 'Request' })}
            </TabsTrigger>
            <TabsTrigger value="fields">
              {t('fields', { defaultValue: 'Fields' })}
            </TabsTrigger>
            <TabsTrigger value="pagination">
              {t('pagination', { defaultValue: 'Pagination' })}
            </TabsTrigger>
            <TabsTrigger value="actions">{t('actions')}</TabsTrigger>
            <TabsTrigger value="detection">
              {t('detection', { defaultValue: 'Detection' })}
            </TabsTrigger>
            <TabsTrigger value="preview">{t('preview')}</TabsTrigger>
          </TabsList>

          <TabsContent value="metadata">
            <RuleMetadataForm
              rule={rule}
              onChange={(updates) => updateRule(updates)}
            />
          </TabsContent>

          <TabsContent value="url">
            <UrlMatchingForm
              match={rule.match!}
              onChange={(match) => updateRule({ match })}
            />
          </TabsContent>

          <TabsContent value="request">
            <RequestConfigForm
              request={rule.request}
              onChange={(request) => updateRule({ request })}
            />
          </TabsContent>

          <TabsContent value="fields">
            <FieldMappingEditor
              extract={rule.extract}
              onChange={(extract) => updateRule({ extract })}
            />
          </TabsContent>

          <TabsContent value="pagination">
            <PaginationConfigForm
              pagination={rule.extract?.list?.pagination}
              onChange={(pagination) =>
                updateRule({
                  extract: {
                    ...rule.extract,
                    list: {
                      ...rule.extract?.list,
                      container: rule.extract?.list?.container || {
                        type: 'css',
                        expression: '',
                      },
                      items: rule.extract?.list?.items || [],
                      pagination,
                    },
                  },
                })
              }
            />
          </TabsContent>

          <TabsContent value="actions">
            <ActionSequenceEditor
              beforeActions={rule.beforeActions || []}
              afterActions={rule.afterActions || []}
              onBeforeActionsChange={(beforeActions) =>
                updateRule({ beforeActions })
              }
              onAfterActionsChange={(afterActions) =>
                updateRule({ afterActions })
              }
            />
          </TabsContent>

          <TabsContent value="detection">
            <Card>
              <CardHeader>
                <CardTitle>
                  {t('detectionConfig', {
                    defaultValue: 'Detection Configuration',
                  })}
                </CardTitle>
                <CardDescription>
                  {t('detectionConfigDescription', {
                    defaultValue: 'Configure anti-crawl detection',
                  })}
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex items-center space-x-2">
                  <input
                    type="checkbox"
                    id="detectCloudflare"
                    checked={rule.detection?.detectCloudflare ?? true}
                    onChange={(e) =>
                      updateRule({
                        detection: {
                          ...rule.detection,
                          detectCloudflare: e.target.checked,
                        },
                      })
                    }
                    className="h-4 w-4"
                  />
                  <Label htmlFor="detectCloudflare">
                    {t('detectCloudflare', {
                      defaultValue: 'Detect Cloudflare',
                    })}
                  </Label>
                </div>
                <div className="flex items-center space-x-2">
                  <input
                    type="checkbox"
                    id="autoRetry"
                    checked={rule.detection?.autoRetry ?? true}
                    onChange={(e) =>
                      updateRule({
                        detection: {
                          ...rule.detection,
                          autoRetry: e.target.checked,
                        },
                      })
                    }
                    className="h-4 w-4"
                  />
                  <Label htmlFor="autoRetry">
                    {t('autoRetry', { defaultValue: 'Auto Retry' })}
                  </Label>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="preview">
            <PreviewPanel
              serverUrl={serverStatus?.url || null}
              isConnected={isWsConnected}
              isSelecting={isSelecting}
              selectedElement={selectedElement}
              onStartSelection={startSelection}
              onCancelSelection={cancelSelection}
              onClearSelection={clearSelection}
              onApplySelector={handleApplySelector}
            />
          </TabsContent>
        </Tabs>
      )}

      {/* Validation Results */}
      {validateMutation.data && (
        <Card
          className={
            validateMutation.data.valid ? 'border-green-500' : 'border-red-500'
          }
        >
          <CardHeader>
            <CardTitle>
              {validateMutation.data.valid
                ? t('validationPassed', { defaultValue: 'Validation Passed' })
                : t('validationFailed', { defaultValue: 'Validation Failed' })}
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
