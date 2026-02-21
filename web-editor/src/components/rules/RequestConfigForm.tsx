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
        <CardTitle>
          {t('requestConfiguration', { defaultValue: 'Request Configuration' })}
        </CardTitle>
        <CardDescription>
          {t('requestConfigurationDescription', {
            defaultValue: 'Configure how requests are made',
          })}
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="grid grid-cols-2 gap-4">
          <div className="space-y-2">
            <Label>{t('method', { defaultValue: 'HTTP Method' })}</Label>
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
            <Label>{t('timeout', { defaultValue: 'Timeout (ms)' })}</Label>
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
          <Label>{t('userAgent', { defaultValue: 'User Agent' })}</Label>
          <Input
            value={request.userAgent || ''}
            onChange={(e) => updateField('userAgent', e.target.value)}
            placeholder={t('userAgentPlaceholder', {
              defaultValue: 'Custom user agent string',
            })}
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
          <Label htmlFor="mobileUserAgent">
            {t('mobileUserAgent', { defaultValue: 'Use mobile user agent' })}
          </Label>
        </div>

        <div className="space-y-2">
          <Label>{t('referer', { defaultValue: 'Referer' })}</Label>
          <Input
            value={request.referer || ''}
            onChange={(e) => updateField('referer', e.target.value)}
            placeholder={t('refererPlaceholder', {
              defaultValue: 'Referer URL',
            })}
          />
        </div>

        <div className="space-y-2">
          <Label>{t('headers', { defaultValue: 'Custom Headers' })}</Label>
          <textarea
            className="flex min-h-[100px] w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
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
          <Label>{t('cookies', { defaultValue: 'Cookies' })}</Label>
          <textarea
            className="flex min-h-[100px] w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
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
              {t('followRedirects', { defaultValue: 'Follow redirects' })}
            </Label>
          </div>

          <div className="space-y-2">
            <Label>
              {t('maxRedirects', { defaultValue: 'Max Redirects' })}
            </Label>
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
