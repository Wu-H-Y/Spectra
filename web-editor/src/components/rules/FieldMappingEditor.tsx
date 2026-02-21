import { Plus, Trash2 } from 'lucide-react';
import { useTranslation } from 'react-i18next';

import type {
  ExtractConfig,
  FieldMapping,
  Selector,
  SelectorType,
} from '@/api/types';
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

interface FieldMappingEditorProps {
  extract: ExtractConfig | undefined;
  onChange: (extract: ExtractConfig) => void;
}

const selectorTypes: { value: SelectorType; label: string }[] = [
  { value: 'css', label: 'CSS' },
  { value: 'xpath', label: 'XPath' },
  { value: 'regex', label: 'Regex' },
  { value: 'jsonpath', label: 'JSONPath' },
  { value: 'js', label: 'JavaScript' },
];

/**
 * 字段映射编辑器组件。
 * 用于配置数据提取的字段映射规则。
 */
export function FieldMappingEditor({
  extract,
  onChange,
}: FieldMappingEditorProps) {
  const { t } = useTranslation();

  const listItems = extract?.list?.items || [];
  const detailItems = extract?.detail?.items || [];

  const updateListItems = (items: FieldMapping[]) => {
    onChange({
      ...extract,
      list: {
        ...extract?.list,
        container: extract?.list?.container || { type: 'css', expression: '' },
        items,
      },
    });
  };

  const updateDetailItems = (items: FieldMapping[]) => {
    onChange({
      ...extract,
      detail: {
        ...extract?.detail,
        items,
      },
    });
  };

  const addField = (type: 'list' | 'detail') => {
    const newField: FieldMapping = {
      field: '',
      selector: { type: 'css', expression: '' },
      required: false,
    };
    if (type === 'list') {
      updateListItems([...listItems, newField]);
    } else {
      updateDetailItems([...detailItems, newField]);
    }
  };

  const removeField = (type: 'list' | 'detail', index: number) => {
    if (type === 'list') {
      updateListItems(listItems.filter((_, i) => i !== index));
    } else {
      updateDetailItems(detailItems.filter((_, i) => i !== index));
    }
  };

  const updateField = (
    type: 'list' | 'detail',
    index: number,
    updates: Partial<FieldMapping>,
  ) => {
    const items = type === 'list' ? listItems : detailItems;
    const newItems = items.map((item, i) =>
      i === index ? { ...item, ...updates } : item,
    );
    if (type === 'list') {
      updateListItems(newItems);
    } else {
      updateDetailItems(newItems);
    }
  };

  return (
    <div className="space-y-6">
      {/* 列表页字段配置 */}
      <Card>
        <CardHeader>
          <CardTitle>{t('rules.listFields')}</CardTitle>
          <CardDescription>{t('rules.listFieldsDescription')}</CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          {/* 容器选择器 */}
          <div className="space-y-2">
            <Label>{t('rules.containerSelector')}</Label>
            <div className="grid grid-cols-[120px_1fr] gap-2">
              <Select
                value={extract?.list?.container?.type || 'css'}
                onValueChange={(value: SelectorType) =>
                  onChange({
                    ...extract,
                    list: {
                      ...extract?.list,
                      container: {
                        ...extract?.list?.container,
                        type: value,
                        expression: extract?.list?.container?.expression || '',
                      },
                      items: listItems,
                    },
                  })
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
                value={extract?.list?.container?.expression || ''}
                onChange={(e) =>
                  onChange({
                    ...extract,
                    list: {
                      ...extract?.list,
                      container: {
                        type: extract?.list?.container?.type || 'css',
                        expression: e.target.value,
                      },
                      items: listItems,
                    },
                  })
                }
                placeholder={t('rules.containerSelectorPlaceholder')}
              />
            </div>
          </div>

          {/* 字段列表 */}
          <div className="space-y-3">
            {listItems.map((field, index) => (
              <FieldItem
                key={index}
                field={field}
                onChange={(updates) => updateField('list', index, updates)}
                onRemove={() => removeField('list', index)}
              />
            ))}
          </div>

          <Button variant="outline" size="sm" onClick={() => addField('list')}>
            <Plus className="h-4 w-4 mr-2" />
            {t('rules.addListField')}
          </Button>
        </CardContent>
      </Card>

      {/* 详情页字段配置 */}
      <Card>
        <CardHeader>
          <CardTitle>{t('rules.detailFields')}</CardTitle>
          <CardDescription>
            {t('rules.detailFieldsDescription')}
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          {/* URL 选择器 */}
          <div className="space-y-2">
            <Label>{t('rules.detailUrlSelector')}</Label>
            <div className="grid grid-cols-[120px_1fr] gap-2">
              <Select
                value={extract?.detail?.urlFromList?.type || 'css'}
                onValueChange={(value: SelectorType) =>
                  onChange({
                    ...extract,
                    detail: {
                      ...extract?.detail,
                      urlFromList: {
                        ...extract?.detail?.urlFromList,
                        type: value,
                        expression:
                          extract?.detail?.urlFromList?.expression || '',
                      },
                      items: detailItems,
                    },
                  })
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
                value={extract?.detail?.urlFromList?.expression || ''}
                onChange={(e) =>
                  onChange({
                    ...extract,
                    detail: {
                      ...extract?.detail,
                      urlFromList: {
                        type: extract?.detail?.urlFromList?.type || 'css',
                        expression: e.target.value,
                      },
                      items: detailItems,
                    },
                  })
                }
                placeholder={t('rules.detailUrlSelectorPlaceholder')}
              />
            </div>
          </div>

          {/* 字段列表 */}
          <div className="space-y-3">
            {detailItems.map((field, index) => (
              <FieldItem
                key={index}
                field={field}
                onChange={(updates) => updateField('detail', index, updates)}
                onRemove={() => removeField('detail', index)}
              />
            ))}
          </div>

          <Button
            variant="outline"
            size="sm"
            onClick={() => addField('detail')}
          >
            <Plus className="h-4 w-4 mr-2" />
            {t('rules.addDetailField')}
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}

interface FieldItemProps {
  field: FieldMapping;
  onChange: (updates: Partial<FieldMapping>) => void;
  onRemove: () => void;
}

function FieldItem({ field, onChange, onRemove }: FieldItemProps) {
  const { t } = useTranslation();

  const updateSelector = (updates: Partial<Selector>) => {
    onChange({
      selector: { ...field.selector, ...updates } as Selector,
    });
  };

  return (
    <div className="border rounded-lg p-4 space-y-3">
      <div className="flex items-start justify-between gap-4">
        <div className="flex-1 grid grid-cols-[1fr_1fr] gap-3">
          <div className="space-y-1">
            <Label className="text-xs">{t('rules.fieldName')}</Label>
            <Input
              value={field.field}
              onChange={(e) => onChange({ field: e.target.value })}
              placeholder={t('rules.fieldNamePlaceholder')}
            />
          </div>
          <div className="space-y-1">
            <Label className="text-xs">{t('rules.fieldDefaultValue')}</Label>
            <Input
              value={field.defaultValue || ''}
              onChange={(e) => onChange({ defaultValue: e.target.value })}
              placeholder={t('rules.fieldDefaultValuePlaceholder')}
            />
          </div>
        </div>
        <Button variant="ghost" size="icon" onClick={onRemove}>
          <Trash2 className="h-4 w-4 text-destructive" />
        </Button>
      </div>

      <div className="grid grid-cols-[120px_1fr_150px] gap-2">
        <div className="space-y-1">
          <Label className="text-xs">{t('rules.fieldType')}</Label>
          <Select
            value={field.selector.type}
            onValueChange={(value: SelectorType) =>
              updateSelector({ type: value })
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
        </div>
        <div className="space-y-1">
          <Label className="text-xs">{t('rules.expression')}</Label>
          <Input
            value={field.selector.expression}
            onChange={(e) => updateSelector({ expression: e.target.value })}
            placeholder={t('rules.expressionPlaceholder')}
          />
        </div>
        <div className="space-y-1">
          <Label className="text-xs">{t('rules.attribute')}</Label>
          <Input
            value={field.selector.attribute || ''}
            onChange={(e) =>
              updateSelector({ attribute: e.target.value || undefined })
            }
            placeholder={t('rules.attributePlaceholder')}
          />
        </div>
      </div>

      <div className="flex items-center gap-4">
        <div className="flex items-center space-x-2">
          <input
            type="checkbox"
            id={`required-${field.field}`}
            checked={field.required ?? false}
            onChange={(e) => onChange({ required: e.target.checked })}
            className="h-4 w-4"
          />
          <Label htmlFor={`required-${field.field}`} className="text-xs">
            {t('rules.required')}
          </Label>
        </div>
        <div className="flex items-center space-x-2">
          <input
            type="checkbox"
            id={`firstOnly-${field.field}`}
            checked={field.selector.firstOnly ?? false}
            onChange={(e) => updateSelector({ firstOnly: e.target.checked })}
            className="h-4 w-4"
          />
          <Label htmlFor={`firstOnly-${field.field}`} className="text-xs">
            {t('rules.firstOnly')}
          </Label>
        </div>
      </div>
    </div>
  );
}
