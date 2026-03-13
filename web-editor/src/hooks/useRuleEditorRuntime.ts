import { useQuery } from '@tanstack/react-query';
import { useCallback, useState } from 'react';

import { serverApi } from '@/api/client';
import type { ServerStatus } from '@/api/types';
import {
  useRuntimeDiagnostics,
  type RuntimeDiagnosticsEvent,
  type RuntimeSubscriptionFilter,
} from '@/hooks/useWebSocket';

interface UseRuleEditorRuntimeResult {
  serverStatus: ServerStatus | null;
  runtimeDiagnostics: {
    isConnected: boolean;
    attachment: RuntimeSubscriptionFilter | null;
    isSelecting: boolean;
    selectedElement: {
      selector: string;
      selectorType: 'css' | 'xpath';
      outerHtml: string;
      textContent?: string;
    } | null;
    events: RuntimeDiagnosticsEvent[];
    attach: (filter: RuntimeSubscriptionFilter) => void;
    detach: () => void;
    clearEvents: () => void;
  };
}

/**
 * 规则编辑器运行时诊断 Hook。
 *
 * 负责服务器状态查询与运行时诊断附着。
 */
export const useRuleEditorRuntime = (): UseRuleEditorRuntimeResult => {
  const [isConnecting, setIsConnecting] = useState(false);

  // 查询服务器状态
  const { data: serverStatus } = useQuery({
    queryKey: ['serverStatus'],
    queryFn: async () => {
      try {
        return await serverApi.status();
      } catch {
        return null;
      }
    },
    refetchInterval: 5000,
    retry: false,
  });

  // 运行时诊断
  const {
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
  } = useRuntimeDiagnostics(
    serverStatus
      ? {
          url: serverStatus.url,
          serverToken: serverStatus.serverToken,
        }
      : null,
  );

  // 包装 attach 以处理连接状态
  const handleAttach = useCallback(
    (filter: RuntimeSubscriptionFilter) => {
      if (!isConnected && !isConnecting) {
        setIsConnecting(true);
        connect();

        // 等待连接后附着
        setTimeout(() => {
          attach(filter);
          setIsConnecting(false);
        }, 1000);
      } else {
        attach(filter);
      }
    },
    [attach, connect, isConnected, isConnecting],
  );

  // 包装 detach 以处理断开
  const handleDetach = useCallback(() => {
    detach();
    disconnect();
  }, [detach, disconnect]);

  return {
    serverStatus: serverStatus ?? null,
    runtimeDiagnostics: {
      isConnected,
      attachment,
      isSelecting,
      selectedElement: selectedElement
        ? {
            selector: selectedElement.selector,
            selectorType: selectedElement.selectorType,
            outerHtml: selectedElement.outerHtml,
            textContent: selectedElement.textContent,
          }
        : null,
      events,
      attach: handleAttach,
      detach: handleDetach,
      clearEvents,
    },
  };
};
