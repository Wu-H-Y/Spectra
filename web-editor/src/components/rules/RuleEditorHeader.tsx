import { useTranslation } from 'react-i18next';

import { Button } from '@/components/ui/button';

interface RuleEditorHeaderProps {
  isNew: boolean;
  isSaving: boolean;
  onCancel: () => void;
  onSave: () => void;
  onValidate: () => void;
}

/**
 * 规则编辑器头部组件。
 *
 * 包含标题、验证和保存按钮。
 */
export const RuleEditorHeader = ({
  isNew,
  isSaving,
  onCancel,
  onSave,
  onValidate,
}: RuleEditorHeaderProps) => {
  const { t } = useTranslation();

  return (
    <div className="flex items-center justify-between">
      <div>
        <h1 className="text-2xl font-bold">
          {isNew ? t('rules.createNewRule') : t('rules.editRule')}
        </h1>
        <p className="text-sm text-muted-foreground">
          {isNew
            ? t('rules.editRuleDescription')
            : t('rules.editRuleDescription')}
        </p>
      </div>

      <div className="flex gap-2">
        <Button variant="outline" onClick={onCancel}>
          {t('common.cancel')}
        </Button>
        <Button variant="secondary" onClick={onValidate}>
          {t('rules.validate')}
        </Button>
        <Button onClick={onSave} disabled={isSaving}>
          {isSaving ? t('common.save') + '...' : t('common.save')}
        </Button>
      </div>
    </div>
  );
};

export default RuleEditorHeader;
