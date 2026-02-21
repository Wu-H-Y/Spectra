import { useTranslation } from 'react-i18next';

import type { CrawlerRule, MediaType } from '@/api/types';
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

interface RuleMetadataFormProps {
  rule: Partial<CrawlerRule>;
  onChange: (updates: Partial<CrawlerRule>) => void;
}

const mediaTypes: { value: MediaType; label: string }[] = [
  { value: 'video', label: 'Video' },
  { value: 'music', label: 'Music' },
  { value: 'novel', label: 'Novel' },
  { value: 'comic', label: 'Comic' },
  { value: 'image', label: 'Image' },
  { value: 'audio', label: 'Audio' },
  { value: 'rss', label: 'RSS' },
  { value: 'generic', label: 'Generic' },
];

export function RuleMetadataForm({ rule, onChange }: RuleMetadataFormProps) {
  const { t } = useTranslation();

  return (
    <Card>
      <CardHeader>
        <CardTitle>
          {t('ruleMetadata', { defaultValue: 'Rule Metadata' })}
        </CardTitle>
        <CardDescription>
          {t('ruleMetadataDescription', {
            defaultValue: 'Basic information about the rule',
          })}
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="space-y-2">
          <Label htmlFor="name">{t('ruleName')} *</Label>
          <Input
            id="name"
            value={rule.name || ''}
            onChange={(e) => onChange({ name: e.target.value })}
            placeholder={t('ruleNamePlaceholder', {
              defaultValue: 'Enter rule name',
            })}
          />
        </div>

        <div className="space-y-2">
          <Label htmlFor="description">{t('ruleDescription')}</Label>
          <Input
            id="description"
            value={rule.description || ''}
            onChange={(e) => onChange({ description: e.target.value })}
            placeholder={t('ruleDescriptionPlaceholder', {
              defaultValue: 'Enter rule description',
            })}
          />
        </div>

        <div className="space-y-2">
          <Label htmlFor="mediaType">{t('mediaType')} *</Label>
          <Select
            value={rule.mediaType || 'generic'}
            onValueChange={(value: MediaType) => onChange({ mediaType: value })}
          >
            <SelectTrigger>
              <SelectValue
                placeholder={t('selectMediaType', {
                  defaultValue: 'Select media type',
                })}
              />
            </SelectTrigger>
            <SelectContent>
              {mediaTypes.map((type) => (
                <SelectItem key={type.value} value={type.value}>
                  {t(`mediaType.${type.value}`, { defaultValue: type.label })}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        <div className="space-y-2">
          <Label htmlFor="author">
            {t('author', { defaultValue: 'Author' })}
          </Label>
          <Input
            id="author"
            value={rule.author || ''}
            onChange={(e) => onChange({ author: e.target.value })}
            placeholder={t('authorPlaceholder', {
              defaultValue: 'Enter author name',
            })}
          />
        </div>

        <div className="space-y-2">
          <Label htmlFor="tags">{t('tags', { defaultValue: 'Tags' })}</Label>
          <Input
            id="tags"
            value={rule.tags?.join(', ') || ''}
            onChange={(e) =>
              onChange({
                tags: e.target.value
                  .split(',')
                  .map((tag) => tag.trim())
                  .filter(Boolean),
              })
            }
            placeholder={t('tagsPlaceholder', {
              defaultValue: 'Enter tags separated by commas',
            })}
          />
        </div>

        <div className="flex items-center space-x-2">
          <input
            type="checkbox"
            id="enabled"
            checked={rule.enabled ?? true}
            onChange={(e) => onChange({ enabled: e.target.checked })}
            className="h-4 w-4"
          />
          <Label htmlFor="enabled">
            {t('enabled', { defaultValue: 'Enabled' })}
          </Label>
        </div>
      </CardContent>
    </Card>
  );
}
