import type { KeyRef } from '@/types/KeyRef';
import type { KeyRefProvider } from '@/types/KeyRefProvider';

type SecretSource = 'inline' | 'variable' | 'secureStore';

/**
 * 解析 KeyRef JSON 字符串。
 *
 * @param value - JSON 字符串或原始值
 * @returns 解析后的 KeyRef，解析失败时返回 null
 */
export const parseKeyRef = (value: string | undefined): KeyRef | null => {
  if (!value) {
    return null;
  }

  try {
    return JSON.parse(value) as KeyRef;
  } catch {
    // 如果不是 JSON，则作为内联值处理
    return {
      provider: 'inline' as KeyRefProvider,
      value,
      name: null,
    };
  }
};

/**
 * 获取密钥来源类型。
 *
 * @param keyRef - KeyRef 对象
 * @returns 密钥来源类型
 */
export const getSecretSource = (keyRef: KeyRef | null): SecretSource => {
  if (!keyRef) {
    return 'inline';
  }

  switch (keyRef.provider) {
    case 'inline':
      return 'inline';
    case 'variable':
      return 'variable';
    case 'secureStore':
      return 'secureStore';
    default:
      return 'inline';
  }
};

/**
 * 创建 KeyRef 对象。
 *
 * @param source - 密钥来源类型
 * @param name - 变量名或密钥别名
 * @param value - 内联值
 * @returns KeyRef 对象
 */
export const createKeyRef = (
  source: SecretSource,
  name?: string,
  value?: string,
): KeyRef => {
  return {
    provider: source as KeyRefProvider,
    name: name || null,
    value: source === 'inline' ? value || null : null,
  };
};

/**
 * 序列化 KeyRef 为 JSON 字符串。
 *
 * @param keyRef - KeyRef 对象
 * @returns JSON 字符串
 */
export const serializeKeyRef = (keyRef: KeyRef): string => {
  return JSON.stringify(keyRef);
};
