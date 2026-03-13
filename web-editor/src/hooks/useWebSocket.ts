import { useCallback, useEffect, useRef, useState } from 'react';

import type { ServerStatus } from '@/api/types';

export interface WebSocketMessage {
  type: string;
  data?: unknown;
}

export interface WebSocketHookOptions {
  url: string;
  onMessage?: (message: WebSocketMessage) => void;
  onOpen?: () => void;
  onClose?: () => void;
  onError?: (error: Event) => void;
  autoReconnect?: boolean;
  reconnectDelay?: number;
  maxReconnectAttempts?: number;
}

export interface WebSocketHookResult {
  isConnected: boolean;
  isConnecting: boolean;
  error: string | null;
  send: (message: WebSocketMessage) => void;
  connect: () => void;
  disconnect: () => void;
}

/**
 * WebSocket 连接 Hook。
 *
 * 用于与 Flutter 后端建立 WebSocket 连接，支持自动重连。
 */
export function useWebSocket(
  options: WebSocketHookOptions,
): WebSocketHookResult {
  const {
    url,
    onMessage,
    onOpen,
    onClose,
    onError,
    autoReconnect = true,
    reconnectDelay = 3000,
    maxReconnectAttempts = 5,
  } = options;

  const [isConnected, setIsConnected] = useState(false);
  const [isConnecting, setIsConnecting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const wsRef = useRef<WebSocket | null>(null);
  const reconnectAttemptsRef = useRef(0);
  const reconnectTimeoutRef = useRef<ReturnType<typeof setTimeout> | null>(
    null,
  );
  const mountedRef = useRef(true);

  const clearReconnectTimeout = useCallback(() => {
    if (reconnectTimeoutRef.current) {
      clearTimeout(reconnectTimeoutRef.current);
      reconnectTimeoutRef.current = null;
    }
  }, []);

  const connect = useCallback(() => {
    if (wsRef.current?.readyState === WebSocket.OPEN) {
      return;
    }

    if (!mountedRef.current) {
      return;
    }

    setIsConnecting(true);
    setError(null);

    try {
      const ws = new WebSocket(url);
      wsRef.current = ws;

      ws.onopen = () => {
        if (!mountedRef.current) return;

        setIsConnected(true);
        setIsConnecting(false);
        setError(null);
        reconnectAttemptsRef.current = 0;

        onOpen?.();
      };

      ws.onmessage = (event) => {
        if (!mountedRef.current) return;

        try {
          const message = JSON.parse(event.data) as WebSocketMessage;
          onMessage?.(message);
        } catch {
          console.error('Failed to parse WebSocket message:', event.data);
        }
      };

      ws.onclose = () => {
        if (!mountedRef.current) return;

        setIsConnected(false);
        setIsConnecting(false);
        onClose?.();

        // Auto reconnect
        if (
          autoReconnect &&
          reconnectAttemptsRef.current < maxReconnectAttempts
        ) {
          reconnectAttemptsRef.current++;
          clearReconnectTimeout();

          reconnectTimeoutRef.current = setTimeout(() => {
            if (mountedRef.current) {
              connect();
            }
          }, reconnectDelay);
        }
      };

      ws.onerror = (event) => {
        if (!mountedRef.current) return;

        setIsConnecting(false);
        setError('WebSocket connection error');
        onError?.(event);
      };
    } catch {
      if (!mountedRef.current) return;

      setIsConnecting(false);
      setError('Failed to create WebSocket connection');
    }
  }, [
    url,
    onMessage,
    onOpen,
    onClose,
    onError,
    autoReconnect,
    reconnectDelay,
    maxReconnectAttempts,
    clearReconnectTimeout,
  ]);

  const disconnect = useCallback(() => {
    clearReconnectTimeout();
    reconnectAttemptsRef.current = maxReconnectAttempts; // Prevent auto reconnect

    if (wsRef.current) {
      wsRef.current.close();
      wsRef.current = null;
    }

    setIsConnected(false);
    setIsConnecting(false);
  }, [clearReconnectTimeout, maxReconnectAttempts]);

  const send = useCallback((message: WebSocketMessage) => {
    if (wsRef.current?.readyState === WebSocket.OPEN) {
      wsRef.current.send(JSON.stringify(message));
    } else {
      console.warn('WebSocket is not connected');
    }
  }, []);

  useEffect(() => {
    mountedRef.current = true;

    return () => {
      mountedRef.current = false;
      clearReconnectTimeout();

      if (wsRef.current) {
        wsRef.current.close();
        wsRef.current = null;
      }
    };
  }, [clearReconnectTimeout]);

  return {
    isConnected,
    isConnecting,
    error,
    send,
    connect,
    disconnect,
  };
}

/**
 * 元素选择消息类型。
 */
export interface ElementSelectedMessage {
  type: 'element_selected';
  data: {
    previewSessionId?: string;
    selector: string;
    selectorType: 'css' | 'xpath';
    outerHtml: string;
    textContent?: string;
    rect?: {
      x: number;
      y: number;
      width: number;
      height: number;
    };
  };
}

/**
 * 预览请求消息类型。
 */
export interface PreviewRequestMessage {
  type: 'preview_request';
  data: {
    url: string;
    previewSessionId?: string;
  };
}

export interface RuntimeSubscriptionFilter {
  runId?: string;
  sessionId?: string;
  previewSessionId?: string;
}

export interface RuntimeDiagnosticsEvent {
  id: string;
  type: string;
  receivedAt: string;
  data: Record<string, unknown> | null;
  runId: string | null;
  sessionId: string | null;
  previewSessionId: string | null;
  seq: number | null;
  nodeEvent: string | null;
}

const MAX_RUNTIME_EVENTS = 200;

const toMessageRecord = (value: unknown): Record<string, unknown> | null => {
  if (!value || typeof value !== 'object') {
    return null;
  }

  return value as Record<string, unknown>;
};

const readStringField = (
  data: Record<string, unknown> | null,
  field: string,
) => {
  const value = data?.[field];
  return typeof value === 'string' ? value : null;
};

const readNumberField = (
  data: Record<string, unknown> | null,
  field: string,
) => {
  const value = data?.[field];
  return typeof value === 'number' ? value : null;
};

const normalizeSubscriptionFilter = (
  filter: RuntimeSubscriptionFilter | null,
): RuntimeSubscriptionFilter | null => {
  if (!filter) {
    return null;
  }

  const normalized = {
    runId: filter.runId?.trim() || undefined,
    sessionId: filter.sessionId?.trim() || undefined,
    previewSessionId: filter.previewSessionId?.trim() || undefined,
  } satisfies RuntimeSubscriptionFilter;

  return normalized.runId || normalized.sessionId || normalized.previewSessionId
    ? normalized
    : null;
};

const serializeSubscriptionFilter = (
  filter: RuntimeSubscriptionFilter | null,
) =>
  JSON.stringify({
    runId: filter?.runId ?? null,
    sessionId: filter?.sessionId ?? null,
    previewSessionId: filter?.previewSessionId ?? null,
  });

const toDiagnosticsEvent = (
  message: WebSocketMessage,
): RuntimeDiagnosticsEvent => {
  const data = toMessageRecord(message.data);

  return {
    id: `${Date.now()}-${Math.random().toString(36).slice(2, 10)}`,
    type: message.type,
    receivedAt: new Date().toISOString(),
    data,
    runId: readStringField(data, 'runId'),
    sessionId: readStringField(data, 'sessionId'),
    previewSessionId: readStringField(data, 'previewSessionId'),
    seq: readNumberField(data, 'seq'),
    nodeEvent: readStringField(data, 'event'),
  };
};

/**
 * 使用运行态诊断 WebSocket Hook。
 *
 * 仅用于附着到 Flutter 已创建的运行态并只读查看事件流。
 */
export function useRuntimeDiagnostics(
  server: Pick<ServerStatus, 'url' | 'serverToken'> | null,
) {
  const [selectedElement, setSelectedElement] = useState<
    ElementSelectedMessage['data'] | null
  >(null);
  const [isSelecting, setIsSelecting] = useState(false);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [attachment, setAttachment] =
    useState<RuntimeSubscriptionFilter | null>(null);
  const [events, setEvents] = useState<RuntimeDiagnosticsEvent[]>([]);
  const subscribedFilterRef = useRef<RuntimeSubscriptionFilter | null>(null);

  const handleMessage = useCallback((message: WebSocketMessage) => {
    switch (message.type) {
      case 'auth_ok':
        setIsAuthenticated(true);
        break;

      case 'element_selected': {
        const data = message.data as ElementSelectedMessage['data'];
        setSelectedElement(data);
        setIsSelecting(false);
        break;
      }

      case 'selection_started':
        setIsSelecting(true);
        break;

      case 'selection_cancelled':
        setIsSelecting(false);
        break;
    }

    if (message.type === 'auth_ok') {
      return;
    }

    setEvents((currentEvents) => {
      const nextEvents = [...currentEvents, toDiagnosticsEvent(message)];
      return nextEvents.slice(-MAX_RUNTIME_EVENTS);
    });
  }, []);

  const wsUrl = server?.url
    ? server.url.replace('http://', 'ws://').replace('https://', 'wss://') +
      '/ws'
    : '';

  const { isConnected, send, connect, disconnect } = useWebSocket({
    url: wsUrl,
    onMessage: handleMessage,
    onClose: () => {
      setIsAuthenticated(false);
      subscribedFilterRef.current = null;
    },
    autoReconnect: true,
  });

  useEffect(() => {
    if (!isConnected || isAuthenticated || !server?.serverToken) {
      return;
    }

    send({
      type: 'auth',
      data: { token: server.serverToken },
    });
  }, [isAuthenticated, isConnected, send, server?.serverToken]);

  useEffect(() => {
    if (!isConnected || !isAuthenticated) {
      return;
    }

    const previousFilter = subscribedFilterRef.current;
    if (
      previousFilter &&
      serializeSubscriptionFilter(previousFilter) !==
        serializeSubscriptionFilter(attachment)
    ) {
      send({
        type: 'unsubscribe',
        data: previousFilter,
      });
      subscribedFilterRef.current = null;
    }

    if (
      attachment &&
      serializeSubscriptionFilter(attachment) !==
        serializeSubscriptionFilter(subscribedFilterRef.current)
    ) {
      send({
        type: 'subscribe',
        data: attachment,
      });
      subscribedFilterRef.current = attachment;
    }
  }, [attachment, isAuthenticated, isConnected, send]);

  const attach = useCallback((filter: RuntimeSubscriptionFilter | null) => {
    setAttachment(normalizeSubscriptionFilter(filter));
    setSelectedElement(null);
    setIsSelecting(false);
    setEvents([]);
  }, []);

  const detach = useCallback(() => {
    setAttachment(null);
    setSelectedElement(null);
    setIsSelecting(false);
    setEvents([]);
  }, []);

  const clearEvents = useCallback(() => {
    setEvents([]);
  }, []);

  return {
    isConnected,
    attachment,
    isSelecting,
    selectedElement,
    events,
    attach,
    detach,
    clearEvents,
    connect,
    disconnect,
  };
}
