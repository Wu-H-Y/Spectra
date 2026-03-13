import { CheckCircle, XCircle } from 'lucide-react';
import { useTranslation } from 'react-i18next';

import type { ValidationResult } from '@/api/types';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';

interface RuleValidationResultCardProps {
  result: ValidationResult | undefined;
}

/**
 * 规则验证结果卡片组件。
 *
 * 显示验证通过或失败的详细信息。
 */
export const RuleValidationResultCard = ({
  result,
}: RuleValidationResultCardProps) => {
  const { t } = useTranslation();

  if (!result) {
    return null;
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          {result.valid ? (
            <CheckCircle className="h-5 w-5 text-green-500" />
          ) : (
            <XCircle className="h-5 w-5 text-red-500" />
          )}
          {result.valid
            ? t('rules.validationPassed')
            : t('rules.validationFailed')}
        </CardTitle>
        <CardDescription>
          {result.valid
            ? t('rules.validationPassed')
            : `${result.errors.length} errors`}
        </CardDescription>
      </CardHeader>
      <CardContent>
        {result.errors.length > 0 && (
          <div className="space-y-2">
            {result.errors.map((error, index) => (
              <div
                key={index}
                className="rounded-lg border border-red-200 bg-red-50 p-3 text-sm"
              >
                <div className="font-mono text-xs text-red-600">
                  {error.path}
                </div>
                <div className="text-red-800">{error.message}</div>
              </div>
            ))}
          </div>
        )}
      </CardContent>
    </Card>
  );
};

export default RuleValidationResultCard;
