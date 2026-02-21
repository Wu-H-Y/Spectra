import { create } from 'zustand';

import type { CrawlerRule, Selector } from '@/api/types';

interface RuleState {
  rules: CrawlerRule[];
  selectedRule: CrawlerRule | null;
  isLoading: boolean;
  error: string | null;

  setRules: (rules: CrawlerRule[]) => void;
  selectRule: (rule: CrawlerRule | null) => void;
  addRule: (rule: CrawlerRule) => void;
  updateRule: (id: string, rule: Partial<CrawlerRule>) => void;
  deleteRule: (id: string) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
}

export const useRuleStore = create<RuleState>((set) => ({
  rules: [],
  selectedRule: null,
  isLoading: false,
  error: null,

  setRules: (rules) => set({ rules }),
  selectRule: (rule) => set({ selectedRule: rule }),
  addRule: (rule) => set((state) => ({ rules: [...state.rules, rule] })),
  updateRule: (id, updates) =>
    set((state) => ({
      rules: state.rules.map((r) => (r.id === id ? { ...r, ...updates } : r)),
    })),
  deleteRule: (id) =>
    set((state) => ({
      rules: state.rules.filter((r) => r.id !== id),
    })),
  setLoading: (isLoading) => set({ isLoading }),
  setError: (error) => set({ error }),
}));

// 活动字段路径类型
type ActiveFieldPath =
  | { type: 'list_item_field'; index: number }
  | { type: 'detail_item_field'; index: number }
  | { type: 'list_container' }
  | { type: 'pagination_next' }
  | { type: 'custom'; path: string };

interface EditorState {
  isJsonMode: boolean;
  jsonValue: string;
  previewUrl: string;
  isPreviewVisible: boolean;
  activeFieldPath: ActiveFieldPath | null;

  toggleJsonMode: () => void;
  setJsonValue: (value: string) => void;
  setPreviewUrl: (url: string) => void;
  setPreviewVisible: (visible: boolean) => void;
  setActiveFieldPath: (path: ActiveFieldPath | null) => void;
}

export const useEditorStore = create<EditorState>((set) => ({
  isJsonMode: false,
  jsonValue: '',
  previewUrl: '',
  isPreviewVisible: false,
  activeFieldPath: null,

  toggleJsonMode: () => set((state) => ({ isJsonMode: !state.isJsonMode })),
  setJsonValue: (jsonValue) => set({ jsonValue }),
  setPreviewUrl: (previewUrl) => set({ previewUrl }),
  setPreviewVisible: (isPreviewVisible) => set({ isPreviewVisible }),
  setActiveFieldPath: (activeFieldPath) => set({ activeFieldPath }),
}));

// 选择器应用回调类型
interface SelectorApplyCallback {
  (selector: Selector): void;
}

interface SelectorApplyState {
  applyCallback: SelectorApplyCallback | null;
  setApplyCallback: (callback: SelectorApplyCallback | null) => void;
}

export const useSelectorApplyStore = create<SelectorApplyState>((set) => ({
  applyCallback: null,
  setApplyCallback: (applyCallback) => set({ applyCallback }),
}));
