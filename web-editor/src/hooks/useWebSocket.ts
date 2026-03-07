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

/**
 * 使用元素选择 WebSocket Hook。
 *
 * 专门用于处理元素选择功能的 WebSocket 连接。
 */
export function useElementSelection(
  server: Pick<ServerStatus, 'url' | 'serverToken'> | null,
) {
  const [selectedElement, setSelectedElement] = useState<
    ElementSelectedMessage['data'] | null
  >(null);
  const [isSelecting, setIsSelecting] = useState(false);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [previewSessionId, setPreviewSessionId] = useState<string | null>(null);
  const subscribedPreviewSessionIdRef = useRef<string | null>(null);

  const matchesPreviewSession = useCallback(
    (data: unknown) => {
      if (!previewSessionId || !data || typeof data !== 'object') {
        return true;
      }

      const scopedPreviewSessionId =
        'previewSessionId' in data && typeof data.previewSessionId === 'string'
          ? data.previewSessionId
          : null;

      return (
        scopedPreviewSessionId == null ||
        scopedPreviewSessionId === previewSessionId
      );
    },
    [previewSessionId],
  );

  const handleMessage = useCallback(
    (message: WebSocketMessage) => {
      switch (message.type) {
        case 'auth_ok':
          setIsAuthenticated(true);
          break;

        case 'element_selected':
          {
            const data = message.data as ElementSelectedMessage['data'];
            if (!matchesPreviewSession(data)) {
              break;
            }
            setSelectedElement(data);
          }
          setIsSelecting(false);
          break;

        case 'selection_started':
          if (!matchesPreviewSession(message.data)) {
            break;
          }
          setIsSelecting(true);
          break;

        case 'selection_cancelled':
          if (!matchesPreviewSession(message.data)) {
            break;
          }
          setIsSelecting(false);
          break;
      }
    },
    [matchesPreviewSession],
  );

  const wsUrl = server?.url
    ? server.url.replace('http://', 'ws://').replace('https://', 'wss://') +
      '/ws'
    : '';

  const { isConnected, send, connect, disconnect } = useWebSocket({
    url: wsUrl,
    onMessage: handleMessage,
    onClose: () => {
      setIsAuthenticated(false);
      subscribedPreviewSessionIdRef.current = null;
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

    const previousPreviewSessionId = subscribedPreviewSessionIdRef.current;
    if (
      previousPreviewSessionId &&
      previousPreviewSessionId !== previewSessionId
    ) {
      send({
        type: 'unsubscribe',
        data: { previewSessionId: previousPreviewSessionId },
      });
      subscribedPreviewSessionIdRef.current = null;
    }

    if (
      previewSessionId &&
      previewSessionId !== subscribedPreviewSessionIdRef.current
    ) {
      send({
        type: 'subscribe',
        data: { previewSessionId },
      });
      subscribedPreviewSessionIdRef.current = previewSessionId;
    }
  }, [isAuthenticated, isConnected, previewSessionId, send]);

  const startSelection = useCallback(() => {
    if (isConnected && isAuthenticated && previewSessionId) {
      setIsSelecting(true);
    }
  }, [isAuthenticated, isConnected, previewSessionId]);

  const cancelSelection = useCallback(() => {
    if (isConnected && isAuthenticated) {
      setIsSelecting(false);
    }
  }, [isAuthenticated, isConnected]);

  const clearSelection = useCallback(() => {
    setSelectedElement(null);
  }, []);

  const openPreviewSession = useCallback(
    (nextPreviewSessionId: string | null) => {
      setPreviewSessionId(nextPreviewSessionId);
      setSelectedElement(null);
      setIsSelecting(false);
    },
    [],
  );

  const sendSelectedElement = useCallback(() => {
    if (isConnected && selectedElement) {
      send({
        type: 'element_selected',
        data: selectedElement,
      });
    }
  }, [isConnected, send, selectedElement]);

  return {
    isConnected,
    previewSessionId,
    isSelecting,
    selectedElement,
    openPreviewSession,
    startSelection,
    cancelSelection,
    clearSelection,
    sendSelectedElement,
    connect,
    disconnect,
  };
}
