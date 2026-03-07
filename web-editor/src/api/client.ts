import type { RuleEnvelope } from '@/types/rule';

import type {
  CrawlerRule,
  ValidationResult,
  ExecutionResult,
  ServerStatus,
} from './types';

const API_BASE = '/api';

async function fetchJson<T>(url: string, options?: RequestInit): Promise<T> {
  const response = await fetch(url, {
    headers: {
      'Content-Type': 'application/json',
    },
    ...options,
  });

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }

  return response.json();
}

async function validateRuleEnvelope(
  rule: RuleEnvelope,
): Promise<ValidationResult> {
  const response = await fetch(`${API_BASE}/rules/validate`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ rule }),
  });

  if (response.ok) {
    const data = (await response.json()) as {
      valid?: boolean;
      diagnostics?: Array<{ path?: string; message?: string }>;
    };

    return {
      valid: data.valid ?? false,
      errors: (data.diagnostics ?? []).map((item) => ({
        path: item.path ?? '',
        message: item.message ?? '',
      })),
    };
  }

  const errorBody = (await response.json().catch(() => null)) as {
    error?: {
      details?: Array<{ path?: string; message?: string }>;
    };
  } | null;

  if (response.status === 400) {
    return {
      valid: false,
      errors: (errorBody?.error?.details ?? []).map((item) => ({
        path: item.path ?? '',
        message: item.message ?? '',
      })),
    };
  }

  throw new Error(`HTTP error! status: ${response.status}`);
}

export interface RuleListItem {
  id: string;
  ruleId: string;
  name: string;
  irVersion: string;
  updatedAt: string;
}

export interface RuleListResponse {
  items: RuleListItem[];
  total: number;
}

export interface StoredRuleResponse {
  id: string;
  ruleId: string;
  rule: RuleEnvelope;
  displayConfig: unknown;
  enabled: boolean;
  createdAt: string;
  updatedAt: string;
}

// Rules API
export const rulesApi = {
  list: () => fetchJson<CrawlerRule[]>(`${API_BASE}/rules`),

  get: (id: string) => fetchJson<CrawlerRule>(`${API_BASE}/rules/${id}`),

  create: (rule: CrawlerRule) =>
    fetchJson<CrawlerRule>(`${API_BASE}/rules`, {
      method: 'POST',
      body: JSON.stringify(rule),
    }),

  update: (id: string, rule: Partial<CrawlerRule>) =>
    fetchJson<CrawlerRule>(`${API_BASE}/rules/${id}`, {
      method: 'PUT',
      body: JSON.stringify(rule),
    }),

  delete: (id: string) =>
    fetchJson<void>(`${API_BASE}/rules/${id}`, {
      method: 'DELETE',
    }),

  validate: (rule: CrawlerRule) =>
    fetchJson<ValidationResult>(`${API_BASE}/validate`, {
      method: 'POST',
      body: JSON.stringify(rule),
    }),

  execute: (id: string, url: string) =>
    fetchJson<ExecutionResult>(`${API_BASE}/execute`, {
      method: 'POST',
      body: JSON.stringify({ ruleId: id, url }),
    }),

  listSummaries: () => fetchJson<RuleListResponse>(`${API_BASE}/rules`),

  getEnvelope: (id: string) =>
    fetchJson<StoredRuleResponse>(`${API_BASE}/rules/${id}`),

  createEnvelope: (rule: RuleEnvelope) =>
    fetchJson<{ id: string; createdAt: string }>(`${API_BASE}/rules`, {
      method: 'POST',
      body: JSON.stringify({ rule }),
    }),

  updateEnvelope: (id: string, rule: RuleEnvelope) =>
    fetchJson<{ id: string; updatedAt: string }>(`${API_BASE}/rules/${id}`, {
      method: 'PUT',
      body: JSON.stringify({ rule }),
    }),

  validateEnvelope: (rule: RuleEnvelope) => validateRuleEnvelope(rule),
};

// Server API
export const serverApi = {
  status: () => fetchJson<ServerStatus>(`${API_BASE}/server/status`),

  start: () =>
    fetchJson<ServerStatus>(`${API_BASE}/server/start`, { method: 'POST' }),

  stop: () => fetchJson<void>(`${API_BASE}/server/stop`, { method: 'POST' }),
};
