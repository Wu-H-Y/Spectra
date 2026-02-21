import { useTranslation } from 'react-i18next';

import type { MatchConfig } from '@/api/types';
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

interface UrlMatchingFormProps {
  match: MatchConfig;
  onChange: (match: MatchConfig) => void;
}

export function UrlMatchingForm({ match, onChange }: UrlMatchingFormProps) {
  const { t } = useTranslation();

  return (
    <Card>
      <CardHeader>
        <CardTitle>{t('rules.urlMatching')}</CardTitle>
        <CardDescription>{t('rules.urlMatchingDescription')}</CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="space-y-2">
          <Label htmlFor="pattern">{t('rules.urlPattern')} *</Label>
          <Input
            id="pattern"
            value={match.pattern}
            onChange={(e) => onChange({ ...match, pattern: e.target.value })}
            placeholder={t('rules.urlPatternPlaceholder')}
          />
        </div>

        <div className="space-y-2">
          <Label htmlFor="patternType">{t('rules.patternType')} *</Label>
          <Select
            value={match.type || 'regex'}
            onValueChange={(value: 'regex' | 'glob') =>
              onChange({ ...match, type: value })
            }
          >
            <SelectTrigger>
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="regex">Regular Expression</SelectItem>
              <SelectItem value="glob">Glob Pattern</SelectItem>
            </SelectContent>
          </Select>
        </div>

        <div className="flex items-center space-x-2">
          <input
            type="checkbox"
            id="fullUrl"
            checked={match.fullUrl ?? false}
            onChange={(e) => onChange({ ...match, fullUrl: e.target.checked })}
            className="h-4 w-4"
          />
          <Label htmlFor="fullUrl">{t('rules.matchFullUrl')}</Label>
        </div>

        <div className="space-y-2">
          <Label>{t('rules.includePatterns')}</Label>
          <textarea
            className="flex min-h-20 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
            value={match.includePatterns?.join('\n') || ''}
            onChange={(e) =>
              onChange({
                ...match,
                includePatterns: e.target.value.split('\n').filter(Boolean),
              })
            }
            placeholder={t('rules.includePatternsPlaceholder')}
          />
        </div>

        <div className="space-y-2">
          <Label>{t('rules.excludePatterns')}</Label>
          <textarea
            className="flex min-h-20 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
            value={match.excludePatterns?.join('\n') || ''}
            onChange={(e) =>
              onChange({
                ...match,
                excludePatterns: e.target.value.split('\n').filter(Boolean),
              })
            }
            placeholder={t('rules.excludePatternsPlaceholder')}
          />
        </div>
      </CardContent>
    </Card>
  );
}
