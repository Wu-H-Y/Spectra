import { useCallback, useMemo } from 'react';

import type { KeyRef } from '@/types/KeyRef';
import type { KeyRefProvider } from '@/types/KeyRefProvider';

type SecretSource = 'inline' | 'variable' | 'secureStore';

interface UseRuleEditorTransformFieldsOptions {
  selectedTransformNode: {
    id: string;
    params: Record<string, string>;
  } | null;
  onChange: (key: string, value: string) => void;
}

interface UseRuleEditorTransformFieldsResult {
  isCryptoTransform: boolean;
  keySource: SecretSource;
  ivSource: SecretSource;
  selectedKeyRef: KeyRef | null;
  selectedIvRef: KeyRef | null;
  selectedTransformOpOptions: string[];
  showIvEditor: boolean;
  handleSecretSourceChange: (param: 'key' | 'iv', source: SecretSource) => void;
  handleSecretRefNameChange: (param: 'key' | 'iv', name: string) => void;
}

const CRYPTO_OPS = [
  'aesEncode',
  'aesDecode',
  'aesCbcEncode',
  'aesCbcDecode',
  'aesEcbEncode',
  'aesEcbDecode',
];

const parseKeyRef = (value: string | undefined): KeyRef | null => {
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

const getSecretSource = (keyRef: KeyRef | null): SecretSource => {
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
 * 规则编辑器 Transform 字段编辑 Hook。
 *
 * 负责 crypto transform 参数的 key/iv 编辑逻辑。
 */
export const useRuleEditorTransformFields = (
  options: UseRuleEditorTransformFieldsOptions,
): UseRuleEditorTransformFieldsResult => {
  const { selectedTransformNode, onChange } = options;

  // 判断是否为 crypto transform
  const isCryptoTransform = useMemo(() => {
    if (!selectedTransformNode) {
      return false;
    }

    const family = selectedTransformNode.params.family;
    const op = selectedTransformNode.params.op;

    return family === 'crypto' || CRYPTO_OPS.includes(op);
  }, [selectedTransformNode]);

  // 解析 key/iv 引用
  const selectedKeyRef = useMemo(() => {
    if (!selectedTransformNode) {
      return null;
    }

    return parseKeyRef(selectedTransformNode.params.key);
  }, [selectedTransformNode]);

  const selectedIvRef = useMemo(() => {
    if (!selectedTransformNode) {
      return null;
    }

    return parseKeyRef(selectedTransformNode.params.iv);
  }, [selectedTransformNode]);

  // 获取 secret source
  const keySource = useMemo(
    () => getSecretSource(selectedKeyRef),
    [selectedKeyRef],
  );
  const ivSource = useMemo(
    () => getSecretSource(selectedIvRef),
    [selectedIvRef],
  );

  // 判断是否显示 IV 编辑器
  const showIvEditor = useMemo(() => {
    if (!selectedTransformNode) {
      return false;
    }

    const op = selectedTransformNode.params.op;

    // ECB 模式不需要 IV
    if (op?.toLowerCase().includes('ecb')) {
      return false;
    }

    return isCryptoTransform;
  }, [selectedTransformNode, isCryptoTransform]);

  // Transform 操作选项
  const selectedTransformOpOptions = useMemo(() => {
    return CRYPTO_OPS;
  }, []);

  // 处理 secret source 变更
  const handleSecretSourceChange = useCallback(
    (param: 'key' | 'iv', source: SecretSource) => {
      const keyRef: KeyRef = {
        provider: source as KeyRefProvider,
        name: null,
        value: null,
      };

      onChange(param, JSON.stringify(keyRef));
    },
    [onChange],
  );

  // 处理 secret ref name 变更
  const handleSecretRefNameChange = useCallback(
    (param: 'key' | 'iv', name: string) => {
      const currentRef = param === 'key' ? selectedKeyRef : selectedIvRef;

      const keyRef: KeyRef = {
        provider: currentRef?.provider ?? 'variable',
        name: name || null,
        value: null,
      };

      onChange(param, JSON.stringify(keyRef));
    },
    [onChange, selectedKeyRef, selectedIvRef],
  );

  return {
    isCryptoTransform,
    keySource,
    ivSource,
    selectedKeyRef,
    selectedIvRef,
    selectedTransformOpOptions,
    showIvEditor,
    handleSecretSourceChange,
    handleSecretRefNameChange,
  };
};
