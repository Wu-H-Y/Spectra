import { useTranslation } from 'react-i18next';

import type { PaginationConfig, Selector, SelectorType } from '@/api/types';
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

interface PaginationConfigFormProps {
  pagination: PaginationConfig | undefined;
  onChange: (pagination: PaginationConfig | undefined) => void;
}

const selectorTypes: { value: SelectorType; label: string }[] = [
  { value: 'css', label: 'CSS' },
  { value: 'xpath', label: 'XPath' },
  { value: 'regex', label: 'Regex' },
  { value: 'jsonpath', label: 'JSONPath' },
  { value: 'js', label: 'JavaScript' },
];

/**
 * 分页配置表单组件。
 * 用于配置列表页的分页规则。
 */
export function PaginationConfigForm({
  pagination,
  onChange,
}: PaginationConfigFormProps) {
  const { t } = useTranslation();

  const updatePagination = (updates: Partial<PaginationConfig>) => {
    onChange({ ...pagination, ...updates } as PaginationConfig);
  };

  const updateNextSelector = (updates: Partial<Selector>) => {
    updatePagination({
      nextSelector: {
        type: pagination?.nextSelector?.type || 'css',
        expression: '',
        ...pagination?.nextSelector,
        ...updates,
      } as Selector,
    });
  };

  const updateClickSelector = (updates: Partial<Selector>) => {
    updatePagination({
      clickSelector: {
        type: pagination?.clickSelector?.type || 'css',
        expression: '',
        ...pagination?.clickSelector,
        ...updates,
      } as Selector,
    });
  };

  const updateScrollContainer = (updates: Partial<Selector>) => {
    updatePagination({
      scrollContainer: {
        type: pagination?.scrollContainer?.type || 'css',
        expression: '',
        ...pagination?.scrollContainer,
        ...updates,
      } as Selector,
    });
  };

  return (
    <Card>
      <CardHeader>
        <CardTitle>{t('rules.paginationConfig')}</CardTitle>
        <CardDescription>
          {t('rules.paginationConfigDescription')}
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        {/* 分页类型 */}
        <div className="space-y-2">
          <Label>{t('rules.paginationType')}</Label>
          <Select
            value={pagination?.type || 'url'}
            onValueChange={(value: 'url' | 'click' | 'infiniteScroll') =>
              updatePagination({ type: value })
            }
          >
            <SelectTrigger>
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="url">{t('rules.paginationUrl')}</SelectItem>
              <SelectItem value="click">
                {t('rules.paginationClick')}
              </SelectItem>
              <SelectItem value="infiniteScroll">
                {t('rules.paginationInfiniteScroll')}
              </SelectItem>
            </SelectContent>
          </Select>
        </div>

        {/* URL 分页配置 */}
        {pagination?.type === 'url' && (
          <>
            <div className="space-y-2">
              <Label>{t('rules.urlTemplate')}</Label>
              <Input
                value={pagination.urlTemplate || ''}
                onChange={(e) =>
                  updatePagination({ urlTemplate: e.target.value })
                }
                placeholder={t('rules.urlTemplatePlaceholder')}
              />
              <p className="text-xs text-muted-foreground">
                {t('rules.urlTemplateHint')}
              </p>
            </div>

            <div className="space-y-2">
              <Label>{t('rules.nextPageSelector')}</Label>
              <div className="grid grid-cols-[120px_1fr] gap-2">
                <Select
                  value={pagination.nextSelector?.type || 'css'}
                  onValueChange={(value: SelectorType) =>
                    updateNextSelector({ type: value })
                  }
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {selectorTypes.map((type) => (
                      <SelectItem key={type.value} value={type.value}>
                        {type.label}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                <Input
                  value={pagination.nextSelector?.expression || ''}
                  onChange={(e) =>
                    updateNextSelector({ expression: e.target.value })
                  }
                  placeholder={t('rules.nextPageSelectorPlaceholder')}
                />
              </div>
            </div>
          </>
        )}

        {/* 点击分页配置 */}
        {pagination?.type === 'click' && (
          <div className="space-y-2">
            <Label>{t('rules.clickSelector')}</Label>
            <div className="grid grid-cols-[120px_1fr] gap-2">
              <Select
                value={pagination.clickSelector?.type || 'css'}
                onValueChange={(value: SelectorType) =>
                  updateClickSelector({ type: value })
                }
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  {selectorTypes.map((type) => (
                    <SelectItem key={type.value} value={type.value}>
                      {type.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              <Input
                value={pagination.clickSelector?.expression || ''}
                onChange={(e) =>
                  updateClickSelector({ expression: e.target.value })
                }
                placeholder={t('rules.clickSelectorPlaceholder')}
              />
            </div>
          </div>
        )}

        {/* 无限滚动配置 */}
        {pagination?.type === 'infiniteScroll' && (
          <div className="space-y-2">
            <Label>{t('rules.scrollContainer')}</Label>
            <div className="grid grid-cols-[120px_1fr] gap-2">
              <Select
                value={pagination.scrollContainer?.type || 'css'}
                onValueChange={(value: SelectorType) =>
                  updateScrollContainer({ type: value })
                }
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  {selectorTypes.map((type) => (
                    <SelectItem key={type.value} value={type.value}>
                      {type.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              <Input
                value={pagination.scrollContainer?.expression || ''}
                onChange={(e) =>
                  updateScrollContainer({ expression: e.target.value })
                }
                placeholder={t('rules.scrollContainerPlaceholder')}
              />
            </div>
          </div>
        )}

        {/* 通用配置 */}
        <div className="grid grid-cols-3 gap-4">
          <div className="space-y-2">
            <Label>{t('rules.maxPages')}</Label>
            <Input
              type="number"
              min={1}
              value={pagination?.maxPages || ''}
              onChange={(e) =>
                updatePagination({
                  maxPages: e.target.value
                    ? parseInt(e.target.value, 10)
                    : undefined,
                })
              }
              placeholder={t('rules.maxPagesPlaceholder')}
            />
          </div>

          <div className="space-y-2">
            <Label>{t('rules.delayMs')}</Label>
            <Input
              type="number"
              min={0}
              value={pagination?.delayMs || ''}
              onChange={(e) =>
                updatePagination({
                  delayMs: e.target.value
                    ? parseInt(e.target.value, 10)
                    : undefined,
                })
              }
              placeholder={t('rules.delayMsPlaceholder')}
            />
          </div>

          <div className="space-y-2">
            <Label>{t('rules.waitAfterLoadMs')}</Label>
            <Input
              type="number"
              min={0}
              value={pagination?.waitAfterLoadMs || ''}
              onChange={(e) =>
                updatePagination({
                  waitAfterLoadMs: e.target.value
                    ? parseInt(e.target.value, 10)
                    : undefined,
                })
              }
              placeholder={t('rules.waitAfterLoadMsPlaceholder')}
            />
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
