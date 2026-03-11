import { Activity, Link2, Unplug } from 'lucide-react';
import { useEffect, useState } from 'react';
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
import type {
  ElementSelectedMessage,
  RuntimeDiagnosticsEvent,
  RuntimeSubscriptionFilter,
} from '@/hooks/useWebSocket';

import { SelectorTestingPanel } from './SelectorTestingPanel';

interface PreviewPanelProps {
  serverUrl: string | null;
  isConnected: boolean;
  attachment: RuntimeSubscriptionFilter | null;
  isSelecting: boolean;
  selectedElement: ElementSelectedMessage['data'] | null;
  events: RuntimeDiagnosticsEvent[];
  onAttach: (filter: RuntimeSubscriptionFilter) => void;
  onDetach: () => void;
  onClearEvents: () => void;
}

interface AttachmentFormState {
  sessionId: string;
  previewSessionId: string;
  runId: string;
}

const createFormState = (
  attachment: RuntimeSubscriptionFilter | null,
): AttachmentFormState => ({
  sessionId: attachment?.sessionId ?? '',
  previewSessionId: attachment?.previewSessionId ?? '',
  runId: attachment?.runId ?? '',
});

/**
 * 运行时调试附着面板。
 *
 * web-editor 仅附着到 Flutter 已创建的运行态，做只读诊断展示。
 */
export function PreviewPanel({
  serverUrl,
  isConnected,
  attachment,
  isSelecting,
  selectedElement,
  events,
  onAttach,
  onDetach,
  onClearEvents,
}: PreviewPanelProps) {
  const { t } = useTranslation();
  const [formState, setFormState] = useState<AttachmentFormState>(() =>
    createFormState(attachment),
  );

  useEffect(() => {
    setFormState(createFormState(attachment));
  }, [attachment]);

  const hasAttachment = attachment !== null;

  const handleAttach = () => {
    if (
      !formState.sessionId.trim() &&
      !formState.previewSessionId.trim() &&
      !formState.runId.trim()
    ) {
      toast.warning(t('preview.enterAttachFilter'));
      return;
    }

    onAttach(formState);
    toast.success(t('preview.attachSuccess'));
  };

  if (!isConnected) {
    return (
      <Card className="border-yellow-500">
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Activity className="h-5 w-5" />
            {t('preview.preview')}
          </CardTitle>
          <CardDescription>{t('preview.previewNotConnected')}</CardDescription>
        </CardHeader>
        <CardContent>
          <Badge variant="secondary">{t('preview.disconnected')}</Badge>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Activity className="h-5 w-5" />
          {t('preview.preview')}
        </CardTitle>
        <CardDescription>{t('preview.previewDescription')}</CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="flex flex-wrap items-center gap-2">
          <Badge variant="secondary">{t('preview.connected')}</Badge>
          <Badge variant={hasAttachment ? 'default' : 'outline'}>
            {hasAttachment ? t('preview.attached') : t('preview.notAttached')}
          </Badge>
          <Badge variant={isSelecting ? 'secondary' : 'outline'}>
            {isSelecting
              ? t('preview.selectionStatusActive')
              : t('preview.selectionStatusIdle')}
          </Badge>
          {serverUrl && (
            <Badge variant="outline" className="font-mono text-xs">
              {serverUrl}
            </Badge>
          )}
        </div>

        <div className="rounded-lg border bg-muted/20 p-4">
          <div className="mb-3 flex items-center gap-2 text-sm font-medium">
            <Link2 className="h-4 w-4" />
            {t('preview.attachSectionTitle')}
          </div>
          <div className="grid gap-3 md:grid-cols-3">
            <div className="space-y-2">
              <Label htmlFor="attach-session-id">
                {t('preview.sessionIdLabel')}
              </Label>
              <Input
                id="attach-session-id"
                value={formState.sessionId}
                onChange={(event) => {
                  setFormState((currentState) => ({
                    ...currentState,
                    sessionId: event.target.value,
                  }));
                }}
                placeholder={t('preview.sessionIdPlaceholder')}
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="attach-preview-session-id">
                {t('preview.previewSessionIdLabel')}
              </Label>
              <Input
                id="attach-preview-session-id"
                value={formState.previewSessionId}
                onChange={(event) => {
                  setFormState((currentState) => ({
                    ...currentState,
                    previewSessionId: event.target.value,
                  }));
                }}
                placeholder={t('preview.previewSessionIdPlaceholder')}
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="attach-run-id">{t('preview.runIdLabel')}</Label>
              <Input
                id="attach-run-id"
                value={formState.runId}
                onChange={(event) => {
                  setFormState((currentState) => ({
                    ...currentState,
                    runId: event.target.value,
                  }));
                }}
                placeholder={t('preview.runIdPlaceholder')}
              />
            </div>
          </div>

          <p className="mt-3 text-xs text-muted-foreground">
            {t('preview.attachHint')}
          </p>

          <div className="mt-3 flex flex-wrap gap-2">
            <Button onClick={handleAttach}>{t('preview.attachAction')}</Button>
            <Button
              variant="outline"
              onClick={onDetach}
              disabled={!hasAttachment}
            >
              <Unplug className="mr-1 h-4 w-4" />
              {t('preview.detachAction')}
            </Button>
          </div>
        </div>

        <SelectorTestingPanel
          isSelecting={isSelecting}
          selectedElement={selectedElement}
          events={events}
          onClearEvents={onClearEvents}
        />
      </CardContent>
    </Card>
  );
}

export default PreviewPanel;
