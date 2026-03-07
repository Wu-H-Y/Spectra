import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { Download, Upload } from 'lucide-react';
import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { toast } from 'sonner';

import { rulesApi, type RuleListItem } from '@/api/client';
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from '@/components/ui/alert-dialog';
import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import type { RuleEnvelope } from '@/types/rule';

const parseImportPayload = (data: unknown): RuleEnvelope[] => {
  if (Array.isArray(data)) {
    return data as RuleEnvelope[];
  }

  if (typeof data !== 'object' || data === null) {
    return [];
  }

  if ('rules' in data && Array.isArray(data.rules)) {
    return data.rules as RuleEnvelope[];
  }

  if ('rule' in data && typeof data.rule === 'object' && data.rule !== null) {
    return [data.rule as RuleEnvelope];
  }

  return [data as RuleEnvelope];
};

const downloadJson = (filename: string, data: unknown) => {
  const blob = new Blob([JSON.stringify(data, null, 2)], {
    type: 'application/json',
  });
  const url = URL.createObjectURL(blob);
  const link = document.createElement('a');
  link.href = url;
  link.download = filename;
  link.click();
  URL.revokeObjectURL(url);
};

/**
 * 规则列表页面。
 */
export function RuleListPage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const queryClient = useQueryClient();
  const [searchQuery, setSearchQuery] = useState('');
  const [deleteRuleId, setDeleteRuleId] = useState<string | null>(null);

  const {
    data: ruleSummaries,
    isLoading,
    error,
  } = useQuery({
    queryKey: ['rules'],
    queryFn: rulesApi.listSummaries,
    staleTime: 5 * 60 * 1000,
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => rulesApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['rules'] });
      setDeleteRuleId(null);
      toast.success(t('errors.deleted'));
    },
    onError: () => {
      toast.error(t('errors.deleteError'));
    },
  });

  const filteredRules = ruleSummaries?.items.filter((rule) => {
    if (!searchQuery) {
      return true;
    }

    const query = searchQuery.toLowerCase();
    return (
      rule.name.toLowerCase().includes(query) ||
      rule.ruleId.toLowerCase().includes(query)
    );
  });

  const handleCreateRule = () => {
    navigate('/rules/new');
  };

  const handleEditRule = (id: string) => {
    navigate(`/rules/${id}`);
  };

  const handleDeleteRule = (id: string) => {
    deleteMutation.mutate(id);
  };

  const handleExportRule = async (rule: RuleListItem) => {
    try {
      const storedRule = await rulesApi.getEnvelope(rule.id);
      downloadJson(`${storedRule.rule.metadata.name}.json`, storedRule.rule);
      toast.success(t('errors.exportSuccess'));
    } catch {
      toast.error(t('errors.exportError'));
    }
  };

  const handleExportAllRules = async () => {
    const items = ruleSummaries?.items ?? [];
    if (items.length === 0) {
      toast.warning(t('errors.noRulesToExport'));
      return;
    }

    try {
      const storedRules = await Promise.all(
        items.map((rule) => rulesApi.getEnvelope(rule.id)),
      );

      downloadJson(
        `crawler-rules-${new Date().toISOString().split('T')[0]}.json`,
        {
          version: '1.0',
          exportedAt: new Date().toISOString(),
          rules: storedRules.map((item) => item.rule),
        },
      );

      toast.success(
        t('errors.exportAllSuccess', { count: storedRules.length }),
      );
    } catch {
      toast.error(t('errors.exportError'));
    }
  };

  const handleImportRules = () => {
    const input = document.createElement('input');
    input.type = 'file';
    input.accept = '.json';
    input.multiple = true;
    input.onchange = async (event) => {
      const files = (event.target as HTMLInputElement).files;
      if (!files || files.length === 0) {
        return;
      }

      let importedCount = 0;
      let errorCount = 0;

      for (const file of Array.from(files)) {
        try {
          const text = await file.text();
          const data = JSON.parse(text) as unknown;
          const rulesToImport = parseImportPayload(data);

          for (const rule of rulesToImport) {
            try {
              if (
                !rule.metadata?.name ||
                !rule.metadata?.ruleId ||
                !rule.irVersion
              ) {
                errorCount++;
                continue;
              }

              await rulesApi.createEnvelope(rule);
              importedCount++;
            } catch {
              errorCount++;
            }
          }
        } catch {
          errorCount++;
        }
      }

      queryClient.invalidateQueries({ queryKey: ['rules'] });

      if (importedCount > 0 && errorCount === 0) {
        toast.success(t('errors.importSuccess', { count: importedCount }));
      } else if (importedCount > 0 && errorCount > 0) {
        toast.warning(
          t('errors.importPartial', {
            count: importedCount,
            errorCount,
          }),
        );
      } else {
        toast.error(t('errors.importError'));
      }
    };
    input.click();
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-100">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
      </div>
    );
  }

  if (error) {
    return (
      <Card className="border-destructive">
        <CardHeader>
          <CardTitle className="text-destructive">
            {t('errors.error')}
          </CardTitle>
        </CardHeader>
        <CardContent>
          <p>{String(error)}</p>
          <Button
            className="mt-4"
            onClick={() =>
              queryClient.invalidateQueries({ queryKey: ['rules'] })
            }
          >
            {t('common.retry')}
          </Button>
        </CardContent>
      </Card>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-3xl font-bold tracking-tight">
            {t('common.rules')}
          </h2>
          <p className="text-muted-foreground">
            {t('common.ruleEditorDescription')}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" size="sm" onClick={handleImportRules}>
            <Upload className="h-4 w-4 mr-1" />
            {t('common.import')}
          </Button>
          <Button variant="outline" size="sm" onClick={handleExportAllRules}>
            <Download className="h-4 w-4 mr-1" />
            {t('common.exportAll')}
          </Button>
          <Button size="sm" onClick={handleCreateRule}>
            {t('common.newRule')}
          </Button>
        </div>
      </div>

      <div className="flex items-center gap-4">
        <Input
          placeholder={t('common.searchRules')}
          value={searchQuery}
          onChange={(event) => setSearchQuery(event.target.value)}
          className="max-w-sm"
        />
      </div>

      {filteredRules && filteredRules.length > 0 ? (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {filteredRules.map((rule) => (
            <Card
              key={rule.id}
              className="cursor-pointer hover:border-primary/50 transition-colors"
              onClick={() => handleEditRule(rule.id)}
            >
              <CardHeader className="pb-2">
                <div className="flex items-start justify-between gap-3">
                  <div className="space-y-1 min-w-0">
                    <CardTitle className="text-lg line-clamp-1">
                      {rule.name}
                    </CardTitle>
                    <CardDescription className="line-clamp-1">
                      {rule.ruleId}
                    </CardDescription>
                  </div>
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={(event) => {
                      event.stopPropagation();
                      handleExportRule(rule);
                    }}
                  >
                    <Download className="h-4 w-4" />
                  </Button>
                </div>
              </CardHeader>
              <CardContent className="space-y-2 text-sm text-muted-foreground">
                <p className="font-mono text-xs">{rule.irVersion}</p>
                <p>{new Date(rule.updatedAt).toLocaleString()}</p>
                <div className="flex gap-2 pt-2">
                  <Button
                    size="sm"
                    variant="outline"
                    onClick={(event) => {
                      event.stopPropagation();
                      handleEditRule(rule.id);
                    }}
                  >
                    {t('common.edit')}
                  </Button>
                  <Button
                    size="sm"
                    variant="destructive"
                    onClick={(event) => {
                      event.stopPropagation();
                      setDeleteRuleId(rule.id);
                    }}
                  >
                    {t('common.delete')}
                  </Button>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      ) : (
        <Card>
          <CardContent className="flex flex-col items-center justify-center py-12">
            <p className="text-muted-foreground mb-4">{t('common.noRules')}</p>
            <Button onClick={handleCreateRule}>{t('common.newRule')}</Button>
          </CardContent>
        </Card>
      )}

      <AlertDialog
        open={!!deleteRuleId}
        onOpenChange={() => setDeleteRuleId(null)}
      >
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>{t('common.confirmDelete')}</AlertDialogTitle>
            <AlertDialogDescription>
              {t('common.confirmDeleteDescription')}
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>{t('common.cancel')}</AlertDialogCancel>
            <AlertDialogAction
              className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
              onClick={() => deleteRuleId && handleDeleteRule(deleteRuleId)}
            >
              {t('common.delete')}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}

export default RuleListPage;
