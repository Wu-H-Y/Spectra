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

const mediaTypes: { value: MediaType }[] = [
  { value: 'video' },
  { value: 'music' },
  { value: 'novel' },
  { value: 'comic' },
  { value: 'image' },
  { value: 'audio' },
  { value: 'rss' },
  { value: 'generic' },
];

// 媒体类型翻译键映射
const mediaTypeKeys: Record<
  MediaType,
  | 'rules.mediaTypeVideo'
  | 'rules.mediaTypeMusic'
  | 'rules.mediaTypeNovel'
  | 'rules.mediaTypeComic'
  | 'rules.mediaTypeImage'
  | 'rules.mediaTypeAudio'
  | 'rules.mediaTypeRss'
  | 'rules.mediaTypeGeneric'
> = {
  video: 'rules.mediaTypeVideo',
  music: 'rules.mediaTypeMusic',
  novel: 'rules.mediaTypeNovel',
  comic: 'rules.mediaTypeComic',
  image: 'rules.mediaTypeImage',
  audio: 'rules.mediaTypeAudio',
  rss: 'rules.mediaTypeRss',
  generic: 'rules.mediaTypeGeneric',
};

export function RuleMetadataForm({ rule, onChange }: RuleMetadataFormProps) {
  // 加载 common 和 rules namespace
  const { t } = useTranslation();

  return (
    <Card>
      <CardHeader>
        <CardTitle>{t('rules.ruleMetadata')}</CardTitle>
        <CardDescription>{t('rules.ruleMetadataDescription')}</CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="space-y-2">
          <Label htmlFor="name">{t('rules.ruleName')} *</Label>
          <Input
            id="name"
            value={rule.name || ''}
            onChange={(e) => onChange({ name: e.target.value })}
            placeholder={t('rules.ruleNamePlaceholder')}
          />
        </div>

        <div className="space-y-2">
          <Label htmlFor="description">{t('rules.ruleDescription')}</Label>
          <Input
            id="description"
            value={rule.description || ''}
            onChange={(e) => onChange({ description: e.target.value })}
            placeholder={t('rules.ruleDescriptionPlaceholder')}
          />
        </div>

        <div className="space-y-2">
          <Label htmlFor="mediaType">{t('rules.mediaType')} *</Label>
          <Select
            value={rule.mediaType || 'generic'}
            onValueChange={(value: MediaType) => onChange({ mediaType: value })}
          >
            <SelectTrigger>
              <SelectValue placeholder={t('rules.selectMediaType')} />
            </SelectTrigger>
            <SelectContent>
              {mediaTypes.map((type) => (
                <SelectItem key={type.value} value={type.value}>
                  {t(mediaTypeKeys[type.value])}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        <div className="space-y-2">
          <Label htmlFor="author">{t('common.author')}</Label>
          <Input
            id="author"
            value={rule.author || ''}
            onChange={(e) => onChange({ author: e.target.value })}
            placeholder={t('rules.authorPlaceholder')}
          />
        </div>

        <div className="space-y-2">
          <Label htmlFor="tags">{t('rules.tags')}</Label>
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
            placeholder={t('rules.tagsPlaceholder')}
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
          <Label htmlFor="enabled">{t('rules.enabled')}</Label>
        </div>
      </CardContent>
    </Card>
  );
}
