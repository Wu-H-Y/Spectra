import { useCallback, useEffect, useRef, useState } from 'react';

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

        // Send connection message
        ws.send(JSON.stringify({ type: 'connect' }));

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
  };
}

/**
 * 使用元素选择 WebSocket Hook。
 *
 * 专门用于处理元素选择功能的 WebSocket 连接。
 */
export function useElementSelection(serverUrl: string | null) {
  const [selectedElement, setSelectedElement] = useState<
    ElementSelectedMessage['data'] | null
  >(null);
  const [isSelecting, setIsSelecting] = useState(false);

  const handleMessage = useCallback((message: WebSocketMessage) => {
    switch (message.type) {
      case 'element_selected':
        setSelectedElement(message.data as ElementSelectedMessage['data']);
        setIsSelecting(false);
        break;

      case 'selection_started':
        setIsSelecting(true);
        break;

      case 'selection_cancelled':
        setIsSelecting(false);
        break;
    }
  }, []);

  const wsUrl = serverUrl
    ? serverUrl.replace('http://', 'ws://').replace('https://', 'wss://') +
      '/ws'
    : '';

  const { isConnected, send, connect, disconnect } = useWebSocket({
    url: wsUrl,
    onMessage: handleMessage,
    autoReconnect: true,
  });

  const startSelection = useCallback(() => {
    if (isConnected) {
      send({ type: 'start_selection' });
      setIsSelecting(true);
    }
  }, [isConnected, send]);

  const cancelSelection = useCallback(() => {
    if (isConnected) {
      send({ type: 'cancel_selection' });
      setIsSelecting(false);
    }
  }, [isConnected, send]);

  const clearSelection = useCallback(() => {
    setSelectedElement(null);
  }, []);

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
    isSelecting,
    selectedElement,
    startSelection,
    cancelSelection,
    clearSelection,
    sendSelectedElement,
    connect,
    disconnect,
  };
}
