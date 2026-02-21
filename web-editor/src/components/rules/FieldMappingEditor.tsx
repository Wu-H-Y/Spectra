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
          <CardTitle>
            {t('listFields', { defaultValue: 'List Page Fields' })}
          </CardTitle>
          <CardDescription>
            {t('listFieldsDescription', {
              defaultValue: 'Configure field mappings for list page extraction',
            })}
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          {/* 容器选择器 */}
          <div className="space-y-2">
            <Label>
              {t('containerSelector', { defaultValue: 'Container Selector' })}
            </Label>
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
                placeholder={t('containerSelectorPlaceholder', {
                  defaultValue: 'e.g., .video-item',
                })}
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
            {t('addListField', { defaultValue: 'Add List Field' })}
          </Button>
        </CardContent>
      </Card>

      {/* 详情页字段配置 */}
      <Card>
        <CardHeader>
          <CardTitle>
            {t('detailFields', { defaultValue: 'Detail Page Fields' })}
          </CardTitle>
          <CardDescription>
            {t('detailFieldsDescription', {
              defaultValue:
                'Configure field mappings for detail page extraction',
            })}
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          {/* URL 选择器 */}
          <div className="space-y-2">
            <Label>
              {t('detailUrlSelector', { defaultValue: 'Detail URL Selector' })}
            </Label>
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
                placeholder={t('detailUrlSelectorPlaceholder', {
                  defaultValue: 'e.g., a.title@href',
                })}
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
            {t('addDetailField', { defaultValue: 'Add Detail Field' })}
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
            <Label className="text-xs">
              {t('fieldName', { defaultValue: 'Field Name' })}
            </Label>
            <Input
              value={field.field}
              onChange={(e) => onChange({ field: e.target.value })}
              placeholder={t('fieldNamePlaceholder', {
                defaultValue: 'e.g., title',
              })}
            />
          </div>
          <div className="space-y-1">
            <Label className="text-xs">
              {t('defaultValue', { defaultValue: 'Default Value' })}
            </Label>
            <Input
              value={field.defaultValue || ''}
              onChange={(e) => onChange({ defaultValue: e.target.value })}
              placeholder={t('defaultValuePlaceholder', {
                defaultValue: 'Optional',
              })}
            />
          </div>
        </div>
        <Button variant="ghost" size="icon" onClick={onRemove}>
          <Trash2 className="h-4 w-4 text-destructive" />
        </Button>
      </div>

      <div className="grid grid-cols-[120px_1fr_150px] gap-2">
        <div className="space-y-1">
          <Label className="text-xs">
            {t('selectorType', { defaultValue: 'Type' })}
          </Label>
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
          <Label className="text-xs">
            {t('expression', { defaultValue: 'Expression' })}
          </Label>
          <Input
            value={field.selector.expression}
            onChange={(e) => updateSelector({ expression: e.target.value })}
            placeholder={t('expressionPlaceholder', {
              defaultValue: 'e.g., .title',
            })}
          />
        </div>
        <div className="space-y-1">
          <Label className="text-xs">
            {t('attribute', { defaultValue: 'Attribute' })}
          </Label>
          <Input
            value={field.selector.attribute || ''}
            onChange={(e) =>
              updateSelector({ attribute: e.target.value || undefined })
            }
            placeholder={t('attributePlaceholder', {
              defaultValue: 'e.g., href',
            })}
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
            {t('required', { defaultValue: 'Required' })}
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
            {t('firstOnly', { defaultValue: 'First Only' })}
          </Label>
        </div>
      </div>
    </div>
  );
}
