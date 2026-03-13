import Editor from '@monaco-editor/react';
import { useTranslation } from 'react-i18next';

import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';

interface RuleJsonEditorCardProps {
  jsonValue: string;
  onChange: (value: string | undefined) => void;
}

/**
 * 规则 JSON 编辑器卡片组件。
 *
 * 包含 Monaco JSON 编辑器。
 */
export const RuleJsonEditorCard = ({
  jsonValue,
  onChange,
}: RuleJsonEditorCardProps) => {
  const { t } = useTranslation();

  return (
    <Card>
      <CardHeader>
        <CardTitle>{t('rules.json')}</CardTitle>
        <CardDescription>{t('rules.jsonEditorDescription')}</CardDescription>
      </CardHeader>
      <CardContent>
        <div className="h-96 border rounded-lg overflow-hidden">
          <Editor
            height="100%"
            defaultLanguage="json"
            value={jsonValue}
            onChange={onChange}
            options={{
              minimap: { enabled: false },
              fontSize: 14,
              lineNumbers: 'on',
              scrollBeyondLastLine: false,
              wordWrap: 'on',
              automaticLayout: true,
            }}
          />
        </div>
      </CardContent>
    </Card>
  );
};

export default RuleJsonEditorCard;
