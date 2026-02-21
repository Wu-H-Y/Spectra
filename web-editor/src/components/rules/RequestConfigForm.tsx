import { useTranslation } from 'react-i18next';

import type { RequestConfig } from '@/api/types';
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

interface RequestConfigFormProps {
  request?: RequestConfig;
  onChange: (request: RequestConfig) => void;
}

export function RequestConfigForm({
  request = {},
  onChange,
}: RequestConfigFormProps) {
  const { t } = useTranslation();

  const updateField = <K extends keyof RequestConfig>(
    key: K,
    value: RequestConfig[K],
  ) => {
    onChange({ ...request, [key]: value });
  };

  return (
    <Card>
      <CardHeader>
        <CardTitle>{t('rules.requestConfiguration')}</CardTitle>
        <CardDescription>
          {t('rules.requestConfigurationDescription')}
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="grid grid-cols-2 gap-4">
          <div className="space-y-2">
            <Label>{t('rules.method')}</Label>
            <Select
              value={request.method || 'GET'}
              onValueChange={(value) => updateField('method', value)}
            >
              <SelectTrigger>
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="GET">GET</SelectItem>
                <SelectItem value="POST">POST</SelectItem>
                <SelectItem value="PUT">PUT</SelectItem>
                <SelectItem value="DELETE">DELETE</SelectItem>
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-2">
            <Label>{t('rules.timeout')}</Label>
            <Input
              type="number"
              value={request.timeoutMs || 30000}
              onChange={(e) =>
                updateField('timeoutMs', parseInt(e.target.value, 10))
              }
            />
          </div>
        </div>

        <div className="space-y-2">
          <Label>{t('rules.userAgent')}</Label>
          <Input
            value={request.userAgent || ''}
            onChange={(e) => updateField('userAgent', e.target.value)}
            placeholder={t('rules.userAgentPlaceholder')}
          />
        </div>

        <div className="flex items-center space-x-2">
          <input
            type="checkbox"
            id="mobileUserAgent"
            checked={request.mobileUserAgent ?? false}
            onChange={(e) => updateField('mobileUserAgent', e.target.checked)}
            className="h-4 w-4"
          />
          <Label htmlFor="mobileUserAgent">{t('rules.mobileUserAgent')}</Label>
        </div>

        <div className="space-y-2">
          <Label>{t('rules.referer')}</Label>
          <Input
            value={request.referer || ''}
            onChange={(e) => updateField('referer', e.target.value)}
            placeholder={t('rules.refererPlaceholder')}
          />
        </div>

        <div className="space-y-2">
          <Label>{t('rules.headers')}</Label>
          <textarea
            className="flex min-h-25 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
            value={JSON.stringify(request.headers || {}, null, 2)}
            onChange={(e) => {
              try {
                updateField('headers', JSON.parse(e.target.value));
              } catch {
                // Invalid JSON, ignore
              }
            }}
            placeholder={'{"Header-Name": "Value"}'}
          />
        </div>

        <div className="space-y-2">
          <Label>{t('rules.cookies')}</Label>
          <textarea
            className="flex min-h-25 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
            value={JSON.stringify(request.cookies || {}, null, 2)}
            onChange={(e) => {
              try {
                updateField('cookies', JSON.parse(e.target.value));
              } catch {
                // Invalid JSON, ignore
              }
            }}
            placeholder={'{"cookie_name": "value"}'}
          />
        </div>

        <div className="grid grid-cols-2 gap-4">
          <div className="flex items-center space-x-2">
            <input
              type="checkbox"
              id="followRedirects"
              checked={request.followRedirects ?? true}
              onChange={(e) => updateField('followRedirects', e.target.checked)}
              className="h-4 w-4"
            />
            <Label htmlFor="followRedirects">
              {t('rules.followRedirects')}
            </Label>
          </div>

          <div className="space-y-2">
            <Label>{t('rules.maxRedirects')}</Label>
            <Input
              type="number"
              value={request.maxRedirects || 5}
              onChange={(e) =>
                updateField('maxRedirects', parseInt(e.target.value, 10))
              }
            />
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
