import { Bug, Clock3, Eraser, MousePointerClick } from 'lucide-react';
import { useMemo } from 'react';
import { useTranslation } from 'react-i18next';

import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import type {
  ElementSelectedMessage,
  RuntimeDiagnosticsEvent,
} from '@/hooks/useWebSocket';

interface SelectorTestingPanelProps {
  isSelecting: boolean;
  selectedElement: ElementSelectedMessage['data'] | null;
  events: RuntimeDiagnosticsEvent[];
  onClearEvents: () => void;
}

const readStringField = (
  data: Record<string, unknown> | null,
  field: string,
) => {
  const value = data?.[field];
  return typeof value === 'string' ? value : null;
};

const renderJsonPayload = (data: Record<string, unknown> | null) => {
  if (!data) {
    return null;
  }

  return JSON.stringify(data, null, 2);
};

/**
 * 运行态诊断面板。
 *
 * 只读展示附着后的选择事件与 node event 时间线。
 */
export function SelectorTestingPanel({
  isSelecting,
  selectedElement,
  events,
  onClearEvents,
}: SelectorTestingPanelProps) {
  const { t } = useTranslation();

  const timelineEvents = useMemo(() => [...events].reverse(), [events]);

  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Bug className="h-5 w-5" />
          {t('preview.selectorTesting')}
        </CardTitle>
        <CardDescription>
          {t('preview.selectorTestingDescription')}
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="flex flex-wrap items-center justify-between gap-2">
          <div className="flex flex-wrap gap-2">
            <Badge variant={isSelecting ? 'secondary' : 'outline'}>
              {isSelecting
                ? t('preview.selectionStatusActive')
                : t('preview.selectionStatusIdle')}
            </Badge>
            <Badge variant="outline">
              {t('preview.timelineCount', { count: events.length })}
            </Badge>
          </div>
          <Button
            variant="ghost"
            size="sm"
            onClick={onClearEvents}
            disabled={events.length === 0}
          >
            <Eraser className="mr-1 h-4 w-4" />
            {t('preview.clearTimeline')}
          </Button>
        </div>

        {selectedElement && (
          <div className="space-y-2 rounded-lg border bg-muted/20 p-3">
            <div className="flex items-center gap-2 text-sm font-medium">
              <MousePointerClick className="h-4 w-4" />
              {t('preview.selectedElement')}
            </div>
            <div className="flex items-center gap-2">
              <Badge variant="outline">
                {selectedElement.selectorType.toUpperCase()}
              </Badge>
              <code className="flex-1 break-all rounded bg-background px-2 py-1 text-xs">
                {selectedElement.selector}
              </code>
            </div>
            {selectedElement.textContent && (
              <p className="text-xs text-muted-foreground">
                {selectedElement.textContent}
              </p>
            )}
          </div>
        )}

        <div className="space-y-3">
          <div className="flex items-center gap-2 text-sm font-medium">
            <Clock3 className="h-4 w-4" />
            {t('preview.timelineTitle')}
          </div>

          {timelineEvents.length === 0 ? (
            <div className="rounded-lg border border-dashed p-4 text-sm text-muted-foreground">
              {t('preview.timelineEmpty')}
            </div>
          ) : (
            <div className="max-h-96 space-y-3 overflow-y-auto pr-1">
              {timelineEvents.map((event) => {
                const detailMessage =
                  event.type === 'node_event'
                    ? readStringField(event.data, 'message')
                    : event.type === 'element_selected'
                      ? readStringField(event.data, 'selector')
                      : null;

                return (
                  <div
                    key={event.id}
                    className="space-y-2 rounded-lg border bg-muted/10 p-3"
                  >
                    <div className="flex flex-wrap items-center gap-2">
                      <Badge variant="secondary">
                        {event.type === 'node_event'
                          ? event.nodeEvent || event.type
                          : event.type}
                      </Badge>
                      {event.runId && (
                        <Badge variant="outline" className="font-mono text-xs">
                          run:{event.runId}
                        </Badge>
                      )}
                      {event.sessionId && (
                        <Badge variant="outline" className="font-mono text-xs">
                          session:{event.sessionId}
                        </Badge>
                      )}
                      {event.previewSessionId && (
                        <Badge variant="outline" className="font-mono text-xs">
                          preview:{event.previewSessionId}
                        </Badge>
                      )}
                      {event.seq !== null && (
                        <Badge variant="outline">seq {event.seq}</Badge>
                      )}
                    </div>

                    <div className="text-xs text-muted-foreground">
                      {new Date(event.receivedAt).toLocaleString()}
                    </div>

                    {detailMessage && (
                      <p className="text-sm text-foreground">{detailMessage}</p>
                    )}

                    <pre className="overflow-x-auto rounded bg-background p-2 text-xs">
                      {renderJsonPayload(event.data)}
                    </pre>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </CardContent>
    </Card>
  );
}

export default SelectorTestingPanel;
