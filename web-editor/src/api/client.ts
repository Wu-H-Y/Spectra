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
};

// Server API
export const serverApi = {
  status: () => fetchJson<ServerStatus>(`${API_BASE}/server/status`),

  start: () =>
    fetchJson<ServerStatus>(`${API_BASE}/server/start`, { method: 'POST' }),

  stop: () => fetchJson<void>(`${API_BASE}/server/stop`, { method: 'POST' }),
};
