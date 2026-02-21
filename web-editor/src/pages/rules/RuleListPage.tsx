import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Download, Upload } from 'lucide-react';
import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { toast } from 'sonner';

import { rulesApi } from '@/api/client';
import type { CrawlerRule } from '@/api/types';
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
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { Input } from '@/components/ui/input';

const mediaTypeColors: Record<string, string> = {
  video: 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200',
  music: 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200',
  novel: 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200',
  comic:
    'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200',
  image:
    'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200',
  audio: 'bg-pink-100 text-pink-800 dark:bg-pink-900 dark:text-pink-200',
  rss: 'bg-orange-100 text-orange-800 dark:bg-orange-900 dark:text-orange-200',
  generic: 'bg-gray-100 text-gray-800 dark:bg-gray-800 dark:text-gray-200',
};

// 媒体类型翻译键映射
const mediaTypeKeys: Record<
  string,
  | 'rules.mediaTypeVideo'
  | 'rules.mediaTypeMusic'
  | 'rules.mediaTypeNovel'
  | 'rules.mediaTypeComic'
  | 'rules.mediaTypeImage'
  | 'rules.mediaTypeAudio'
  | 'rules.mediaTypeRss'
  | 'rules.mediaTypeGeneric'
> = {
  video: 'rules.mediaTypeVideo',
  music: 'rules.mediaTypeMusic',
  novel: 'rules.mediaTypeNovel',
  comic: 'rules.mediaTypeComic',
  image: 'rules.mediaTypeImage',
  audio: 'rules.mediaTypeAudio',
  rss: 'rules.mediaTypeRss',
  generic: 'rules.mediaTypeGeneric',
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

  // Fetch rules
  const {
    data: rules,
    isLoading,
    error,
  } = useQuery({
    queryKey: ['rules'],
    queryFn: rulesApi.list,
    staleTime: 5 * 60 * 1000, // 5 minutes
  });

  // Delete mutation
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

  // Filter rules by search query
  const filteredRules = rules?.filter((rule) => {
    if (!searchQuery) return true;
    const query = searchQuery.toLowerCase();
    return (
      rule.name.toLowerCase().includes(query) ||
      rule.description?.toLowerCase().includes(query) ||
      rule.tags?.some((tag) => tag.toLowerCase().includes(query))
    );
  });

  // Group rules by media type
  const groupedRules = filteredRules?.reduce(
    (acc, rule) => {
      const type = rule.mediaType;
      if (!acc[type]) acc[type] = [];
      acc[type].push(rule);
      return acc;
    },
    {} as Record<string, CrawlerRule[]>,
  );

  const handleCreateRule = () => {
    navigate('/rules/new');
  };

  const handleEditRule = (id: string) => {
    navigate(`/rules/${id}`);
  };

  const handleDeleteRule = (id: string) => {
    deleteMutation.mutate(id);
  };

  const handleExportRule = async (rule: CrawlerRule) => {
    try {
      const blob = new Blob([JSON.stringify(rule, null, 2)], {
        type: 'application/json',
      });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `${rule.name}.json`;
      a.click();
      URL.revokeObjectURL(url);
      toast.success(t('errors.exportSuccess'));
    } catch {
      toast.error(t('errors.exportError'));
    }
  };

  const handleExportAllRules = async () => {
    if (!rules || rules.length === 0) {
      toast.warning(t('errors.noRulesToExport'));
      return;
    }
    try {
      const exportData = {
        version: '1.0',
        exportedAt: new Date().toISOString(),
        rules: rules,
      };
      const blob = new Blob([JSON.stringify(exportData, null, 2)], {
        type: 'application/json',
      });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `crawler-rules-${new Date().toISOString().split('T')[0]}.json`;
      a.click();
      URL.revokeObjectURL(url);
      toast.success(t('errors.exportAllSuccess', { count: rules.length }));
    } catch {
      toast.error(t('errors.exportError'));
    }
  };

  const handleImportRules = () => {
    const input = document.createElement('input');
    input.type = 'file';
    input.accept = '.json';
    input.multiple = true;
    input.onchange = async (e) => {
      const files = (e.target as HTMLInputElement).files;
      if (!files || files.length === 0) return;

      let importedCount = 0;
      let errorCount = 0;

      for (const file of Array.from(files)) {
        try {
          const text = await file.text();
          const data = JSON.parse(text);

          // 支持两种格式：单个规则或包含 rules 数组的导出文件
          const rulesToImport: CrawlerRule[] = Array.isArray(data)
            ? data
            : data.rules
              ? data.rules
              : [data];

          for (const rule of rulesToImport) {
            try {
              // 验证规则基本结构
              if (!rule.name || !rule.mediaType || !rule.match) {
                errorCount++;
                continue;
              }
              // 导入时移除 id 和时间戳，让后端生成新的
              // eslint-disable-next-line @typescript-eslint/no-unused-vars
              const {
                id: _id,
                createdAt: _createdAt,
                updatedAt: _updatedAt,
                ...ruleData
              } = rule;
              await rulesApi.create(ruleData as CrawlerRule);
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
      {/* Header */}
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

      {/* Search */}
      <div className="flex items-center gap-4">
        <Input
          placeholder={t('common.searchRules')}
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          className="max-w-sm"
        />
      </div>

      {/* Rules by Media Type */}
      {groupedRules && Object.keys(groupedRules).length > 0 ? (
        <div className="space-y-8">
          {Object.entries(groupedRules).map(([mediaType, mediaRules]) => (
            <div key={mediaType} className="space-y-4">
              <div className="flex items-center gap-2">
                <Badge
                  className={
                    mediaTypeColors[mediaType] || mediaTypeColors.generic
                  }
                >
                  {t(mediaTypeKeys[mediaType] || 'rules.mediaTypeGeneric')}
                </Badge>
                <span className="text-sm text-muted-foreground">
                  ({mediaRules.length})
                </span>
              </div>

              <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                {mediaRules.map((rule) => (
                  <Card
                    key={rule.id}
                    className="cursor-pointer hover:border-primary/50 transition-colors"
                    onClick={() => handleEditRule(rule.id)}
                  >
                    <CardHeader className="pb-2">
                      <div className="flex items-start justify-between">
                        <CardTitle className="text-lg line-clamp-1">
                          {rule.name}
                        </CardTitle>
                        <DropdownMenu>
                          <DropdownMenuTrigger
                            asChild
                            onClick={(e) => e.stopPropagation()}
                          >
                            <Button variant="ghost" size="sm">
                              ···
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuItem
                              onClick={(e) => {
                                e.stopPropagation();
                                handleEditRule(rule.id);
                              }}
                            >
                              {t('common.edit')}
                            </DropdownMenuItem>
                            <DropdownMenuItem
                              onClick={(e) => {
                                e.stopPropagation();
                                handleExportRule(rule);
                              }}
                            >
                              {t('common.export')}
                            </DropdownMenuItem>
                            <DropdownMenuItem
                              className="text-destructive"
                              onClick={(e) => {
                                e.stopPropagation();
                                setDeleteRuleId(rule.id);
                              }}
                            >
                              {t('common.delete')}
                            </DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </div>
                      <CardDescription className="line-clamp-2">
                        {rule.description || t('common.noDescription')}
                      </CardDescription>
                    </CardHeader>
                    <CardContent>
                      <div className="flex flex-wrap gap-1">
                        {rule.tags?.slice(0, 3).map((tag) => (
                          <Badge
                            key={tag}
                            variant="secondary"
                            className="text-xs"
                          >
                            {tag}
                          </Badge>
                        ))}
                        {rule.tags && rule.tags.length > 3 && (
                          <Badge variant="secondary" className="text-xs">
                            +{rule.tags.length - 3}
                          </Badge>
                        )}
                      </div>
                      {rule.author && (
                        <p className="text-xs text-muted-foreground mt-2">
                          {t('common.author')}: {rule.author}
                        </p>
                      )}
                    </CardContent>
                  </Card>
                ))}
              </div>
            </div>
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

      {/* Delete Confirmation Dialog */}
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
