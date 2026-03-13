import {
  useMutation,
  useQuery,
  useQueryClient,
  type UseMutationResult,
} from '@tanstack/react-query';
import type { TFunction } from 'i18next';
import { useCallback } from 'react';
import { toast } from 'sonner';

import { rulesApi } from '@/api/client';
import type { ValidationResult } from '@/api/types';
import type { RuleEnvelope } from '@/types/rule';

interface UseRuleEditorResourceOptions {
  id: string | undefined;
  isNew: boolean;
  jsonValue: string;
  navigate: (path: string) => void;
  setJsonValue: (value: string) => void;
  t: TFunction;
}

interface SaveResult {
  id: string;
  createdAt?: string;
  updatedAt?: string;
}

interface UseRuleEditorResourceResult {
  isLoading: boolean;
  saveMutation: UseMutationResult<SaveResult, Error, void>;
  validateMutation: UseMutationResult<ValidationResult, Error, void>;
  handleSave: () => void;
  handleValidate: () => void;
}

/**
 * 规则编辑器资源加载与保存 Hook。
 *
 * 负责数据加载、保存、验证等页面级编排逻辑。
 */
export const useRuleEditorResource = (
  options: UseRuleEditorResourceOptions,
): UseRuleEditorResourceResult => {
  const { id, isNew, jsonValue, navigate, setJsonValue, t } = options;
  const queryClient = useQueryClient();

  // 加载已有规则
  const { isLoading } = useQuery({
    queryKey: ['rule', id],
    queryFn: async () => {
      if (isNew || !id) {
        return null;
      }

      const response = await rulesApi.getEnvelope(id);
      return response.rule;
    },
    enabled: !isNew && !!id,
    select: (rule) => {
      if (rule) {
        setJsonValue(JSON.stringify(rule, null, 2));
      }

      return rule;
    },
  });

  // 保存 mutation
  const saveMutation = useMutation({
    mutationFn: async () => {
      const rule = JSON.parse(jsonValue) as RuleEnvelope;

      if (isNew) {
        return rulesApi.createEnvelope(rule);
      }

      if (!id) {
        throw new Error('Rule ID is required for update');
      }

      return rulesApi.updateEnvelope(id, rule);
    },
    onSuccess: () => {
      toast.success(t('errors.saved'));
      queryClient.invalidateQueries({ queryKey: ['rules'] });

      if (isNew) {
        navigate('/rules');
      }
    },
    onError: (error) => {
      toast.error(`${t('errors.error')}: ${error}`);
    },
  });

  // 验证 mutation
  const validateMutation = useMutation({
    mutationFn: async () => {
      const rule = JSON.parse(jsonValue) as RuleEnvelope;
      return rulesApi.validateEnvelope(rule);
    },
    onError: (error) => {
      toast.error(`${t('errors.error')}: ${error}`);
    },
  });

  const handleSave = useCallback(() => {
    saveMutation.mutate();
  }, [saveMutation]);

  const handleValidate = useCallback(() => {
    validateMutation.mutate();
  }, [validateMutation]);

  return {
    isLoading,
    saveMutation,
    validateMutation,
    handleSave,
    handleValidate,
  };
};
