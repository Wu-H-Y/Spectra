import { ChevronDown, ChevronUp, Plus, Trash2 } from 'lucide-react';
import { useTranslation } from 'react-i18next';

import type { ActionType, CrawlerAction } from '@/api/types';
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

interface ActionSequenceEditorProps {
  beforeActions: CrawlerAction[];
  afterActions: CrawlerAction[];
  onBeforeActionsChange: (actions: CrawlerAction[]) => void;
  onAfterActionsChange: (actions: CrawlerAction[]) => void;
}

const actionTypes: { value: ActionType; label: string; description: string }[] =
  [
    {
      value: 'wait',
      label: 'Wait',
      description: 'Wait for a specified duration',
    },
    { value: 'click', label: 'Click', description: 'Click on an element' },
    {
      value: 'scroll',
      label: 'Scroll',
      description: 'Scroll the page or element',
    },
    { value: 'fill', label: 'Fill', description: 'Fill in a form field' },
    {
      value: 'script',
      label: 'Script',
      description: 'Execute JavaScript code',
    },
    {
      value: 'condition',
      label: 'Condition',
      description: 'Conditional execution',
    },
    { value: 'loop', label: 'Loop', description: 'Repeat actions' },
  ];

/**
 * 动作序列编辑器组件。
 * 用于配置提取前后的动作序列。
 */
export function ActionSequenceEditor({
  beforeActions,
  afterActions,
  onBeforeActionsChange,
  onAfterActionsChange,
}: ActionSequenceEditorProps) {
  const { t } = useTranslation();

  const addAction = (type: 'before' | 'after') => {
    const newAction: CrawlerAction = {
      type: 'wait',
      params: { duration: 1000 },
    };
    if (type === 'before') {
      onBeforeActionsChange([...beforeActions, newAction]);
    } else {
      onAfterActionsChange([...afterActions, newAction]);
    }
  };

  const removeAction = (type: 'before' | 'after', index: number) => {
    if (type === 'before') {
      onBeforeActionsChange(beforeActions.filter((_, i) => i !== index));
    } else {
      onAfterActionsChange(afterActions.filter((_, i) => i !== index));
    }
  };

  const updateAction = (
    type: 'before' | 'after',
    index: number,
    updates: Partial<CrawlerAction>,
  ) => {
    const actions = type === 'before' ? beforeActions : afterActions;
    const newActions = actions.map((action, i) =>
      i === index ? { ...action, ...updates } : action,
    );
    if (type === 'before') {
      onBeforeActionsChange(newActions);
    } else {
      onAfterActionsChange(newActions);
    }
  };

  const moveAction = (
    type: 'before' | 'after',
    index: number,
    direction: 'up' | 'down',
  ) => {
    const actions = type === 'before' ? [...beforeActions] : [...afterActions];
    const newIndex = direction === 'up' ? index - 1 : index + 1;
    if (newIndex < 0 || newIndex >= actions.length) return;
    [actions[index], actions[newIndex]] = [actions[newIndex], actions[index]];
    if (type === 'before') {
      onBeforeActionsChange(actions);
    } else {
      onAfterActionsChange(actions);
    }
  };

  return (
    <div className="space-y-6">
      {/* 提取前动作 */}
      <Card>
        <CardHeader>
          <CardTitle>{t('rules.beforeActions')}</CardTitle>
          <CardDescription>
            {t('rules.beforeActionsDescription')}
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          {beforeActions.length === 0 ? (
            <p className="text-sm text-muted-foreground">
              {t('rules.noBeforeActions')}
            </p>
          ) : (
            <div className="space-y-3">
              {beforeActions.map((action, index) => (
                <ActionItem
                  key={index}
                  action={action}
                  index={index}
                  total={beforeActions.length}
                  onChange={(updates) => updateAction('before', index, updates)}
                  onRemove={() => removeAction('before', index)}
                  onMove={(direction) => moveAction('before', index, direction)}
                />
              ))}
            </div>
          )}

          <Button
            variant="outline"
            size="sm"
            onClick={() => addAction('before')}
          >
            <Plus className="h-4 w-4 mr-2" />
            {t('rules.addBeforeAction')}
          </Button>
        </CardContent>
      </Card>

      {/* 提取后动作 */}
      <Card>
        <CardHeader>
          <CardTitle>{t('rules.afterActions')}</CardTitle>
          <CardDescription>
            {t('rules.afterActionsDescription')}
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          {afterActions.length === 0 ? (
            <p className="text-sm text-muted-foreground">
              {t('rules.noAfterActions')}
            </p>
          ) : (
            <div className="space-y-3">
              {afterActions.map((action, index) => (
                <ActionItem
                  key={index}
                  action={action}
                  index={index}
                  total={afterActions.length}
                  onChange={(updates) => updateAction('after', index, updates)}
                  onRemove={() => removeAction('after', index)}
                  onMove={(direction) => moveAction('after', index, direction)}
                />
              ))}
            </div>
          )}

          <Button
            variant="outline"
            size="sm"
            onClick={() => addAction('after')}
          >
            <Plus className="h-4 w-4 mr-2" />
            {t('rules.addAfterAction')}
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}

interface ActionItemProps {
  action: CrawlerAction;
  index: number;
  total: number;
  onChange: (updates: Partial<CrawlerAction>) => void;
  onRemove: () => void;
  onMove: (direction: 'up' | 'down') => void;
}

function ActionItem({
  action,
  index,
  total,
  onChange,
  onRemove,
  onMove,
}: ActionItemProps) {
  const { t } = useTranslation();

  const updateParams = (key: string, value: unknown) => {
    onChange({
      params: { ...action.params, [key]: value },
    });
  };

  const renderParamsEditor = () => {
    switch (action.type) {
      case 'wait':
        return (
          <div className="space-y-2">
            <Label className="text-xs">{t('rules.durationMs')}</Label>
            <Input
              type="number"
              min={0}
              value={(action.params.duration as number) || ''}
              onChange={(e) =>
                updateParams(
                  'duration',
                  e.target.value ? parseInt(e.target.value, 10) : 0,
                )
              }
              placeholder={t('rules.durationPlaceholder')}
            />
          </div>
        );

      case 'click':
        return (
          <div className="space-y-2">
            <Label className="text-xs">{t('rules.selector')}</Label>
            <Input
              value={(action.params.selector as string) || ''}
              onChange={(e) => updateParams('selector', e.target.value)}
              placeholder={t('rules.clickSelectorPlaceholder')}
            />
          </div>
        );

      case 'scroll':
        return (
          <div className="grid grid-cols-2 gap-3">
            <div className="space-y-2">
              <Label className="text-xs">{t('rules.scrollTo')}</Label>
              <Select
                value={(action.params.scrollTo as string) || 'bottom'}
                onValueChange={(value) => updateParams('scrollTo', value)}
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="top">{t('rules.scrollTop')}</SelectItem>
                  <SelectItem value="bottom">
                    {t('rules.scrollBottom')}
                  </SelectItem>
                  <SelectItem value="element">
                    {t('rules.scrollElement')}
                  </SelectItem>
                </SelectContent>
              </Select>
            </div>
            {action.params.scrollTo === 'element' && (
              <div className="space-y-2">
                <Label className="text-xs">{t('rules.scrollSelector')}</Label>
                <Input
                  value={(action.params.selector as string) || ''}
                  onChange={(e) => updateParams('selector', e.target.value)}
                  placeholder={t('rules.scrollSelectorPlaceholder')}
                />
              </div>
            )}
          </div>
        );

      case 'fill':
        return (
          <div className="grid grid-cols-2 gap-3">
            <div className="space-y-2">
              <Label className="text-xs">{t('rules.fillSelector')}</Label>
              <Input
                value={(action.params.selector as string) || ''}
                onChange={(e) => updateParams('selector', e.target.value)}
                placeholder={t('rules.fillSelectorPlaceholder')}
              />
            </div>
            <div className="space-y-2">
              <Label className="text-xs">{t('rules.fillValue')}</Label>
              <Input
                value={(action.params.value as string) || ''}
                onChange={(e) => updateParams('value', e.target.value)}
                placeholder={t('rules.fillValuePlaceholder')}
              />
            </div>
          </div>
        );

      case 'script':
        return (
          <div className="space-y-2">
            <Label className="text-xs">{t('rules.scriptCode')}</Label>
            <textarea
              className="flex min-h-25 w-full rounded-md border border-input bg-background px-3 py-2 text-sm font-mono ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
              value={(action.params.code as string) || ''}
              onChange={(e) => updateParams('code', e.target.value)}
              placeholder={t('rules.scriptCodePlaceholder')}
            />
          </div>
        );

      case 'condition':
        return (
          <div className="space-y-2">
            <Label className="text-xs">{t('rules.conditionExpression')}</Label>
            <Input
              value={(action.params.condition as string) || ''}
              onChange={(e) => updateParams('condition', e.target.value)}
              placeholder={t('rules.conditionPlaceholder')}
            />
          </div>
        );

      case 'loop':
        return (
          <div className="grid grid-cols-2 gap-3">
            <div className="space-y-2">
              <Label className="text-xs">{t('rules.loopCount')}</Label>
              <Input
                type="number"
                min={1}
                value={(action.params.count as number) || ''}
                onChange={(e) =>
                  updateParams(
                    'count',
                    e.target.value ? parseInt(e.target.value, 10) : 1,
                  )
                }
                placeholder={t('rules.loopCountPlaceholder')}
              />
            </div>
            <div className="space-y-2">
              <Label className="text-xs">{t('rules.loopDelay')}</Label>
              <Input
                type="number"
                min={0}
                value={(action.params.delay as number) || ''}
                onChange={(e) =>
                  updateParams(
                    'delay',
                    e.target.value ? parseInt(e.target.value, 10) : 0,
                  )
                }
                placeholder={t('rules.loopDelayPlaceholder')}
              />
            </div>
          </div>
        );

      default:
        return null;
    }
  };

  return (
    <div className="border rounded-lg p-4 space-y-3">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <span className="text-xs text-muted-foreground">#{index + 1}</span>
          <Select
            value={action.type}
            onValueChange={(value: ActionType) =>
              onChange({ type: value, params: {} })
            }
          >
            <SelectTrigger className="w-35">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              {actionTypes.map((type) => (
                <SelectItem key={type.value} value={type.value}>
                  {type.label}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        <div className="flex items-center gap-1">
          <Button
            variant="ghost"
            size="icon"
            onClick={() => onMove('up')}
            disabled={index === 0}
          >
            <ChevronUp className="h-4 w-4" />
          </Button>
          <Button
            variant="ghost"
            size="icon"
            onClick={() => onMove('down')}
            disabled={index === total - 1}
          >
            <ChevronDown className="h-4 w-4" />
          </Button>
          <Button variant="ghost" size="icon" onClick={onRemove}>
            <Trash2 className="h-4 w-4 text-destructive" />
          </Button>
        </div>
      </div>

      {renderParamsEditor()}
    </div>
  );
}
