import {
  Eye,
  Loader2,
  X,
  Crosshair,
  Check,
  RefreshCw,
  ZoomIn,
} from 'lucide-react';
import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { toast } from 'sonner';

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
import type { ElementSelectedMessage } from '@/hooks/useWebSocket';

import { SelectorTestingPanel } from './SelectorTestingPanel';

interface PreviewPanelProps {
  serverUrl: string | null;
  isConnected: boolean;
  isSelecting: boolean;
  selectedElement: ElementSelectedMessage['data'] | null;
  screenshot?: string | null; // Base64 图片数据
  onStartSelection: () => void;
  onCancelSelection: () => void;
  onClearSelection: () => void;
  onApplySelector: (selector: string, type: 'css' | 'xpath') => void;
  onRequestScreenshot?: () => void;
}

/**
 * 预览面板组件。
 *
 * 用于触发页面预览和元素选择功能。
 */
export function PreviewPanel({
  serverUrl,
  isConnected,
  isSelecting,
  selectedElement,
  screenshot,
  onStartSelection,
  onCancelSelection,
  onClearSelection,
  onApplySelector,
  onRequestScreenshot,
}: PreviewPanelProps) {
  const { t } = useTranslation();
  const [previewUrl, setPreviewUrl] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [showFullScreenshot, setShowFullScreenshot] = useState(false);

  const handleStartPreview = async () => {
    if (!previewUrl.trim()) {
      toast.warning(
        t('enterPreviewUrl', { defaultValue: 'Please enter a URL to preview' }),
      );
      return;
    }

    if (!serverUrl) {
      toast.error(
        t('serverNotRunning', { defaultValue: 'Server is not running' }),
      );
      return;
    }

    setIsLoading(true);
    try {
      const response = await fetch(`${serverUrl}/api/preview/open`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ url: previewUrl }),
      });

      if (!response.ok) {
        throw new Error('Failed to open preview');
      }

      toast.success(
        t('previewOpened', { defaultValue: 'Preview opened in app' }),
      );
    } catch {
      toast.error(
        t('previewError', { defaultValue: 'Failed to open preview' }),
      );
    } finally {
      setIsLoading(false);
    }
  };

  const handleApplySelector = () => {
    if (selectedElement) {
      onApplySelector(selectedElement.selector, selectedElement.selectorType);
      onClearSelection();
      toast.success(t('selectorApplied', { defaultValue: 'Selector applied' }));
    }
  };

  if (!isConnected) {
    return (
      <Card className="border-yellow-500">
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Eye className="h-5 w-5" />
            {t('preview')}
          </CardTitle>
          <CardDescription>
            {t('previewNotConnected', {
              defaultValue: 'Connect to server to enable preview',
            })}
          </CardDescription>
        </CardHeader>
        <CardContent>
          <Badge variant="secondary">
            {t('disconnected', { defaultValue: 'Disconnected' })}
          </Badge>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Eye className="h-5 w-5" />
          {t('preview')}
        </CardTitle>
        <CardDescription>
          {t('previewDescription', {
            defaultValue: 'Open a page in the app to select elements',
          })}
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        {/* URL Input */}
        <div className="space-y-2">
          <Label htmlFor="preview-url">
            {t('previewUrl', { defaultValue: 'Preview URL' })}
          </Label>
          <div className="flex gap-2">
            <Input
              id="preview-url"
              placeholder="https://example.com"
              value={previewUrl}
              onChange={(e) => setPreviewUrl(e.target.value)}
              onKeyDown={(e) => e.key === 'Enter' && handleStartPreview()}
            />
            <Button
              onClick={handleStartPreview}
              disabled={isLoading || !previewUrl.trim()}
              size="icon"
            >
              {isLoading ? (
                <Loader2 className="h-4 w-4 animate-spin" />
              ) : (
                <Eye className="h-4 w-4" />
              )}
            </Button>
          </div>
        </div>

        {/* Element Selection */}
        <div className="space-y-2">
          <Label>
            {t('elementSelection', { defaultValue: 'Element Selection' })}
          </Label>
          <div className="flex gap-2">
            {isSelecting ? (
              <>
                <Button
                  variant="destructive"
                  size="sm"
                  onClick={onCancelSelection}
                  className="flex-1"
                >
                  <X className="h-4 w-4 mr-1" />
                  {t('cancelSelection', { defaultValue: 'Cancel' })}
                </Button>
              </>
            ) : (
              <Button
                variant="outline"
                size="sm"
                onClick={onStartSelection}
                className="flex-1"
                disabled={!previewUrl.trim()}
              >
                <Crosshair className="h-4 w-4 mr-1" />
                {t('selectElement', { defaultValue: 'Select Element' })}
              </Button>
            )}
          </div>
          {isSelecting && (
            <p className="text-xs text-muted-foreground">
              {t('selectingHint', {
                defaultValue: 'Click on an element in the app to select it',
              })}
            </p>
          )}
        </div>

        {/* Selected Element */}
        {selectedElement && (
          <div className="space-y-2 p-3 bg-muted rounded-lg">
            <div className="flex items-center justify-between">
              <span className="text-sm font-medium">
                {t('selectedElement', { defaultValue: 'Selected Element' })}
              </span>
              <Button variant="ghost" size="sm" onClick={onClearSelection}>
                <X className="h-3 w-3" />
              </Button>
            </div>
            <div className="space-y-1">
              <div className="flex items-center gap-2">
                <Badge variant="outline">
                  {selectedElement.selectorType.toUpperCase()}
                </Badge>
                <code className="text-xs bg-background px-2 py-1 rounded flex-1 break-all">
                  {selectedElement.selector}
                </code>
              </div>
              {selectedElement.textContent && (
                <p className="text-xs text-muted-foreground line-clamp-2">
                  "{selectedElement.textContent}"
                </p>
              )}
            </div>
            <Button size="sm" onClick={handleApplySelector} className="w-full">
              <Check className="h-4 w-4 mr-1" />
              {t('applySelector', { defaultValue: 'Apply Selector' })}
            </Button>
          </div>
        )}

        {/* Screenshot */}
        {screenshot && (
          <div className="space-y-2">
            <div className="flex items-center justify-between">
              <Label>
                {t('pageScreenshot', { defaultValue: 'Page Screenshot' })}
              </Label>
              <div className="flex gap-1">
                {onRequestScreenshot && (
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={onRequestScreenshot}
                    title={t('refreshScreenshot', {
                      defaultValue: 'Refresh screenshot',
                    })}
                  >
                    <RefreshCw className="h-4 w-4" />
                  </Button>
                )}
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => setShowFullScreenshot(!showFullScreenshot)}
                  title={t('toggleSize', { defaultValue: 'Toggle size' })}
                >
                  <ZoomIn className="h-4 w-4" />
                </Button>
              </div>
            </div>
            <div
              className={`border rounded-lg overflow-hidden bg-muted ${
                showFullScreenshot ? '' : 'max-h-64'
              }`}
            >
              <img
                src={`data:image/png;base64,${screenshot}`}
                alt={t('pageScreenshot', { defaultValue: 'Page Screenshot' })}
                className="w-full h-auto"
              />
            </div>
          </div>
        )}

        {/* Selector Testing */}
        <SelectorTestingPanel serverUrl={serverUrl} previewUrl={previewUrl} />
      </CardContent>
    </Card>
  );
}

export default PreviewPanel;
