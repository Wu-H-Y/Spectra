import {
  createMinimalRuleGraph,
  deriveNormalizedOutputs,
} from '@/lib/ruleGraph';
import type { RuleEnvelope } from '@/types/rule';

/**
 * 创建空的 RuleEnvelope，用于新建规则页面初始化。
 */
export const createEmptyRuleEnvelope = (): RuleEnvelope => {
  const graph = createMinimalRuleGraph();

  return {
    irVersion: '1.0.0',
    metadata: {
      ruleId: '',
      name: '',
      description: null,
    },
    graph,
    normalizedOutputs: deriveNormalizedOutputs(graph),
    capabilities: {
      supportsPagination: false,
      supportsConcurrency: false,
      requiresAuth: false,
      supportsJs: false,
      codec: false,
      crypto: {
        aes: false,
      },
      allowInlineSecrets: false,
    },
    rateLimit: null,
  };
};

/**
 * 解析 JSON 字符串为 RuleEnvelope。
 *
 * @param jsonValue - JSON 字符串
 * @returns 解析后的 RuleEnvelope，解析失败时抛出错误
 */
export const parseRuleEnvelope = (jsonValue: string): RuleEnvelope => {
  if (!jsonValue.trim()) {
    throw new Error('JSON value is empty');
  }

  const parsed = JSON.parse(jsonValue) as unknown;

  if (
    typeof parsed !== 'object' ||
    parsed === null ||
    !('irVersion' in parsed) ||
    !('metadata' in parsed) ||
    !('graph' in parsed)
  ) {
    throw new Error('Invalid RuleEnvelope structure');
  }

  return parsed as RuleEnvelope;
};

/**
 * 将 RuleEnvelope 序列化为 JSON 字符串。
 *
 * @param envelope - RuleEnvelope 对象
 * @returns 格式化的 JSON 字符串
 */
export const serializeRuleEnvelope = (envelope: RuleEnvelope): string => {
  return JSON.stringify(envelope, null, 2);
};
