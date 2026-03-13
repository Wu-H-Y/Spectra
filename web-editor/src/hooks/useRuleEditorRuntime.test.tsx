import { renderHook } from '@testing-library/react';
import { describe, expect, test, vi } from 'vitest';

import { useRuleEditorRuntime } from '@/hooks/useRuleEditorRuntime';

// Mock the dependencies
vi.mock('@tanstack/react-query', () => ({
  useQuery: vi.fn(() => ({
    data: null,
    isLoading: false,
  })),
}));

vi.mock('@/hooks/useWebSocket', () => ({
  useRuntimeDiagnostics: vi.fn(() => ({
    isConnected: false,
    attachment: null,
    isSelecting: false,
    selectedElement: null,
    events: [],
    attach: vi.fn(),
    detach: vi.fn(),
    clearEvents: vi.fn(),
    connect: vi.fn(),
    disconnect: vi.fn(),
  })),
}));

describe('useRuleEditorRuntime', () => {
  test('returns serverStatus as null when no server', () => {
    const { result } = renderHook(() => useRuleEditorRuntime());

    expect(result.current.serverStatus).toBeNull();
    expect(result.current.runtimeDiagnostics.isConnected).toBe(false);
  });

  test('returns runtimeDiagnostics with expected properties', () => {
    const { result } = renderHook(() => useRuleEditorRuntime());

    expect(result.current.runtimeDiagnostics).toHaveProperty('isConnected');
    expect(result.current.runtimeDiagnostics).toHaveProperty('attachment');
    expect(result.current.runtimeDiagnostics).toHaveProperty('isSelecting');
    expect(result.current.runtimeDiagnostics).toHaveProperty('selectedElement');
    expect(result.current.runtimeDiagnostics).toHaveProperty('events');
    expect(result.current.runtimeDiagnostics).toHaveProperty('attach');
    expect(result.current.runtimeDiagnostics).toHaveProperty('detach');
    expect(result.current.runtimeDiagnostics).toHaveProperty('clearEvents');
  });
});
