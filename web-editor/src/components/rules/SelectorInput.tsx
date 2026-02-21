import { Crosshair } from 'lucide-react';
import { useTranslation } from 'react-i18next';

import type { Selector, SelectorType } from '@/api/types';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';

interface SelectorInputProps {
  value: Selector;
  onChange: (selector: Selector) => void;
  onStartSelection?: () => void;
  isSelecting?: boolean;
  placeholder?: string;
  disabled?: boolean;
  showType?: boolean;
}

/**
 * 选择器输入组件。
 *
 * 支持输入选择器表达式，选择选择器类型，以及启动元素选择。
 */
export function SelectorInput({
  value,
  onChange,
  onStartSelection,
  isSelecting,
  placeholder = '.class or //xpath',
  disabled,
  showType = true,
}: SelectorInputProps) {
  const { t } = useTranslation();

  const handleTypeChange = (type: SelectorType) => {
    onChange({ ...value, type });
  };

  const handleExpressionChange = (expression: string) => {
    onChange({ ...value, expression });
  };

  return (
    <div className="flex gap-2">
      {showType && (
        <Select
          value={value.type}
          onValueChange={handleTypeChange}
          disabled={disabled}
        >
          <SelectTrigger className="w-24 shrink-0">
            <SelectValue />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="css">CSS</SelectItem>
            <SelectItem value="xpath">XPath</SelectItem>
            <SelectItem value="regex">Regex</SelectItem>
            <SelectItem value="jsonpath">JSONPath</SelectItem>
            <SelectItem value="js">JS</SelectItem>
          </SelectContent>
        </Select>
      )}
      <Input
        value={value.expression}
        onChange={(e) => handleExpressionChange(e.target.value)}
        placeholder={placeholder}
        disabled={disabled}
        className="flex-1 font-mono text-sm"
      />
      {onStartSelection && (
        <Button
          type="button"
          variant="outline"
          size="icon"
          onClick={onStartSelection}
          disabled={disabled || isSelecting}
          className={isSelecting ? 'animate-pulse' : ''}
          title={t('selectElement', {
            defaultValue: 'Select element from page',
          })}
        >
          <Crosshair className="h-4 w-4" />
        </Button>
      )}
    </div>
  );
}

export default SelectorInput;
