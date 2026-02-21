import { Play, Loader2, Check, X } from 'lucide-react';
import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { toast } from 'sonner';

import type { SelectorType } from '@/api/types';
import { Badge } from '@/components/ui/badge';
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

interface TestResult {
  success: boolean;
  count: number;
  elements: Array<{
    text: string;
    html: string;
  }>;
  error?: string;
}

interface SelectorTestingPanelProps {
  serverUrl: string | null;
  previewUrl: string;
}

/**
 * 选择器测试面板组件。
 *
 * 允许用户测试选择器在当前预览页面上的匹配结果。
 */
export function SelectorTestingPanel({
  serverUrl,
  previewUrl,
}: SelectorTestingPanelProps) {
  const { t } = useTranslation();
  const [selectorType, setSelectorType] = useState<SelectorType>('css');
  const [expression, setExpression] = useState('');
  const [isTesting, setIsTesting] = useState(false);
  const [result, setResult] = useState<TestResult | null>(null);

  const handleTest = async () => {
    if (!expression.trim()) {
      toast.warning(t('preview.enterSelector'));
      return;
    }

    if (!serverUrl) {
      toast.error(t('preview.serverNotRunning'));
      return;
    }

    if (!previewUrl.trim()) {
      toast.warning(t('preview.openPreviewFirst'));
      return;
    }

    setIsTesting(true);
    setResult(null);

    try {
      const response = await fetch(`${serverUrl}/api/preview/test-selector`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          url: previewUrl,
          selector: {
            type: selectorType,
            expression,
          },
        }),
      });

      if (!response.ok) {
        throw new Error('Failed to test selector');
      }

      const data = await response.json();
      setResult(data);

      if (data.success && data.count > 0) {
        toast.success(t('preview.foundElements', { count: data.count }));
      } else if (data.success && data.count === 0) {
        toast.warning(t('preview.noElementsFound'));
      }
    } catch {
      toast.error(t('preview.testError'));
      setResult({
        success: false,
        count: 0,
        elements: [],
        error: 'Failed to test selector',
      });
    } finally {
      setIsTesting(false);
    }
  };

  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Play className="h-5 w-5" />
          {t('preview.selectorTesting')}
        </CardTitle>
        <CardDescription>
          {t('preview.selectorTestingDescription')}
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        {/* Selector Input */}
        <div className="space-y-2">
          <Label>{t('preview.selector')}</Label>
          <div className="flex gap-2">
            <Select
              value={selectorType}
              onValueChange={(v) => setSelectorType(v as SelectorType)}
            >
              <SelectTrigger className="w-24 shrink-0">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="css">CSS</SelectItem>
                <SelectItem value="xpath">XPath</SelectItem>
                <SelectItem value="regex">Regex</SelectItem>
                <SelectItem value="jsonpath">JSONPath</SelectItem>
              </SelectContent>
            </Select>
            <Input
              value={expression}
              onChange={(e) => setExpression(e.target.value)}
              placeholder={
                selectorType === 'css'
                  ? '.class or #id'
                  : selectorType === 'xpath'
                    ? '//div[@class]'
                    : selectorType === 'regex'
                      ? 'pattern'
                      : '$.data'
              }
              className="flex-1 font-mono text-sm"
              onKeyDown={(e) => e.key === 'Enter' && handleTest()}
            />
            <Button
              onClick={handleTest}
              disabled={isTesting || !expression.trim()}
              size="icon"
            >
              {isTesting ? (
                <Loader2 className="h-4 w-4 animate-spin" />
              ) : (
                <Play className="h-4 w-4" />
              )}
            </Button>
          </div>
        </div>

        {/* Test Results */}
        {result && (
          <div className="space-y-2">
            <div className="flex items-center gap-2">
              {result.success ? (
                <>
                  <Badge
                    variant="outline"
                    className="bg-green-100 text-green-800"
                  >
                    <Check className="h-3 w-3 mr-1" />
                    {t('preview.success')}
                  </Badge>
                  <span className="text-sm text-muted-foreground">
                    {t('preview.elementsFound', { count: result.count })}
                  </span>
                </>
              ) : (
                <Badge variant="outline" className="bg-red-100 text-red-800">
                  <X className="h-3 w-3 mr-1" />
                  {t('preview.failed')}
                </Badge>
              )}
            </div>

            {result.error && (
              <p className="text-sm text-destructive">{result.error}</p>
            )}

            {result.elements.length > 0 && (
              <div className="space-y-2 max-h-64 overflow-y-auto">
                {result.elements.slice(0, 10).map((el, index) => (
                  <div key={index} className="p-2 bg-muted rounded text-sm">
                    <div className="font-medium mb-1">
                      {t('preview.element')} #{index + 1}
                    </div>
                    {el.text && (
                      <p className="text-muted-foreground line-clamp-2 mb-1">
                        "{el.text}"
                      </p>
                    )}
                    <code className="text-xs bg-background px-2 py-1 rounded block overflow-x-auto">
                      {el.html.slice(0, 200)}
                      {el.html.length > 200 ? '...' : ''}
                    </code>
                  </div>
                ))}
                {result.elements.length > 10 && (
                  <p className="text-xs text-muted-foreground text-center">
                    {t('preview.andMore', {
                      count: result.elements.length - 10,
                    })}
                  </p>
                )}
              </div>
            )}
          </div>
        )}
      </CardContent>
    </Card>
  );
}

export default SelectorTestingPanel;
