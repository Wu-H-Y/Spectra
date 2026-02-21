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
        <CardTitle>
          {t('paginationConfig', { defaultValue: 'Pagination Configuration' })}
        </CardTitle>
        <CardDescription>
          {t('paginationConfigDescription', {
            defaultValue: 'Configure how to navigate through multiple pages',
          })}
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        {/* 分页类型 */}
        <div className="space-y-2">
          <Label>
            {t('paginationType', { defaultValue: 'Pagination Type' })}
          </Label>
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
              <SelectItem value="url">
                {t('paginationUrl', { defaultValue: 'URL Pattern' })}
              </SelectItem>
              <SelectItem value="click">
                {t('paginationClick', { defaultValue: 'Click Next' })}
              </SelectItem>
              <SelectItem value="infiniteScroll">
                {t('paginationInfiniteScroll', {
                  defaultValue: 'Infinite Scroll',
                })}
              </SelectItem>
            </SelectContent>
          </Select>
        </div>

        {/* URL 分页配置 */}
        {pagination?.type === 'url' && (
          <>
            <div className="space-y-2">
              <Label>
                {t('urlTemplate', { defaultValue: 'URL Template' })}
              </Label>
              <Input
                value={pagination.urlTemplate || ''}
                onChange={(e) =>
                  updatePagination({ urlTemplate: e.target.value })
                }
                placeholder={t('urlTemplatePlaceholder', {
                  defaultValue: 'e.g., https://example.com/page/{page}',
                })}
              />
              <p className="text-xs text-muted-foreground">
                {t('urlTemplateHint', {
                  defaultValue: 'Use {page} as placeholder for page number',
                })}
              </p>
            </div>

            <div className="space-y-2">
              <Label>
                {t('nextPageSelector', {
                  defaultValue: 'Next Page Selector (Optional)',
                })}
              </Label>
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
                  placeholder={t('nextPageSelectorPlaceholder', {
                    defaultValue: 'e.g., a.next@href',
                  })}
                />
              </div>
            </div>
          </>
        )}

        {/* 点击分页配置 */}
        {pagination?.type === 'click' && (
          <div className="space-y-2">
            <Label>
              {t('clickSelector', { defaultValue: 'Click Selector' })}
            </Label>
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
                placeholder={t('clickSelectorPlaceholder', {
                  defaultValue: 'e.g., button.load-more',
                })}
              />
            </div>
          </div>
        )}

        {/* 无限滚动配置 */}
        {pagination?.type === 'infiniteScroll' && (
          <div className="space-y-2">
            <Label>
              {t('scrollContainer', {
                defaultValue: 'Scroll Container (Optional)',
              })}
            </Label>
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
                placeholder={t('scrollContainerPlaceholder', {
                  defaultValue: 'e.g., .scroll-container',
                })}
              />
            </div>
          </div>
        )}

        {/* 通用配置 */}
        <div className="grid grid-cols-3 gap-4">
          <div className="space-y-2">
            <Label>{t('maxPages', { defaultValue: 'Max Pages' })}</Label>
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
              placeholder={t('maxPagesPlaceholder', {
                defaultValue: 'Unlimited',
              })}
            />
          </div>

          <div className="space-y-2">
            <Label>{t('delayMs', { defaultValue: 'Delay (ms)' })}</Label>
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
              placeholder={t('delayMsPlaceholder', { defaultValue: '1000' })}
            />
          </div>

          <div className="space-y-2">
            <Label>
              {t('waitAfterLoadMs', { defaultValue: 'Wait After Load (ms)' })}
            </Label>
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
              placeholder={t('waitAfterLoadMsPlaceholder', {
                defaultValue: '500',
              })}
            />
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
