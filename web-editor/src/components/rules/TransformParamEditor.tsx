import { useTranslation } from 'react-i18next';

import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';

type SecretSource = 'inline' | 'variable' | 'secureStore';

interface TransformParamEditorProps {
  isCryptoTransform: boolean;
  ivSource: SecretSource;
  keySource: SecretSource;
  nodeId: string;
  params: Record<string, string>;
  selectedIvName: string;
  selectedKeyName: string;
  showIvEditor: boolean;
  onChange: (key: string, value: string) => void;
  onSecretRefNameChange: (param: 'key' | 'iv', name: string) => void;
  onSecretSourceChange: (param: 'key' | 'iv', source: SecretSource) => void;
}

/**
 * Transform 节点参数编辑器组件。
 *
 * 负责编辑 transform 节点的参数，包括 crypto 相关的 key/iv。
 */
export const TransformParamEditor = ({
  isCryptoTransform,
  ivSource,
  keySource,
  nodeId,
  params,
  selectedIvName,
  selectedKeyName,
  showIvEditor,
  onChange,
  onSecretRefNameChange,
  onSecretSourceChange,
}: TransformParamEditorProps) => {
  const { t } = useTranslation();

  return (
    <div className="rounded-lg border bg-muted/30 p-4">
      <div className="mb-3 text-sm font-medium">
        {t('rules.transformParamEditorTitle', { nodeId })}
      </div>

      <div className="grid gap-4">
        {/* family 参数 */}
        <div className="space-y-2">
          <Label htmlFor="transform-family">
            {t('rules.transformParamFamily')}
          </Label>
          <Input
            id="transform-family"
            value={params.family || ''}
            onChange={(event) => onChange('family', event.target.value)}
            placeholder={t('rules.transformParamFamilyPlaceholder')}
          />
        </div>

        {/* op 参数 */}
        <div className="space-y-2">
          <Label htmlFor="transform-op">{t('rules.transformParamOp')}</Label>
          <Input
            id="transform-op"
            value={params.op || ''}
            onChange={(event) => onChange('op', event.target.value)}
            placeholder={t('rules.transformParamOpPlaceholder')}
          />
        </div>

        {/* crypto 相关参数 - 仅在 crypto transform 时显示 */}
        {isCryptoTransform && (
          <>
            {/* key 来源选择 */}
            <div className="space-y-2">
              <Label>{t('rules.transformParamKey')}</Label>
              <Select
                value={keySource}
                onValueChange={(value) =>
                  onSecretSourceChange('key', value as SecretSource)
                }
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="inline">
                    {t('rules.transformSecretSourceInline')}
                  </SelectItem>
                  <SelectItem value="variable">
                    {t('rules.transformSecretSourceVariable')}
                  </SelectItem>
                  <SelectItem value="secureStore">
                    {t('rules.transformSecretSourceSecureStore')}
                  </SelectItem>
                </SelectContent>
              </Select>
            </div>

            {/* key 值输入 */}
            {keySource === 'inline' && (
              <div className="space-y-2">
                <Label htmlFor="transform-key-value">
                  {t('rules.transformParamKey')}
                </Label>
                <Input
                  id="transform-key-value"
                  type="password"
                  placeholder={t('rules.transformParamKeyPlaceholder')}
                  onChange={(event) => {
                    const keyRef = {
                      provider: 'inline',
                      value: event.target.value,
                      name: null,
                    };
                    onChange('key', JSON.stringify(keyRef));
                  }}
                />
                <p className="text-xs text-muted-foreground">
                  {t('rules.transformParamKeyHint')}
                </p>
              </div>
            )}

            {/* key 变量名输入 */}
            {(keySource === 'variable' || keySource === 'secureStore') && (
              <div className="space-y-2">
                <Label htmlFor="transform-key-name">
                  {t('rules.transformParamKey')}
                </Label>
                <Input
                  id="transform-key-name"
                  value={selectedKeyName}
                  onChange={(event) =>
                    onSecretRefNameChange('key', event.target.value)
                  }
                  placeholder={t('rules.transformParamKeyRefNamePlaceholder')}
                />
              </div>
            )}

            {/* iv 相关 - 仅在非 ECB 模式时显示 */}
            {showIvEditor && (
              <>
                {/* iv 来源选择 */}
                <div className="space-y-2">
                  <Label>{t('rules.transformParamIv')}</Label>
                  <Select
                    value={ivSource}
                    onValueChange={(value) =>
                      onSecretSourceChange('iv', value as SecretSource)
                    }
                  >
                    <SelectTrigger>
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="inline">
                        {t('rules.transformSecretSourceInline')}
                      </SelectItem>
                      <SelectItem value="variable">
                        {t('rules.transformSecretSourceVariable')}
                      </SelectItem>
                      <SelectItem value="secureStore">
                        {t('rules.transformSecretSourceSecureStore')}
                      </SelectItem>
                    </SelectContent>
                  </Select>
                </div>

                {/* iv 值输入 */}
                {ivSource === 'inline' && (
                  <div className="space-y-2">
                    <Label htmlFor="transform-iv-value">
                      {t('rules.transformParamIv')}
                    </Label>
                    <Input
                      id="transform-iv-value"
                      type="password"
                      placeholder={t('rules.transformParamIvPlaceholder')}
                      onChange={(event) => {
                        const ivRef = {
                          provider: 'inline',
                          value: event.target.value,
                          name: null,
                        };
                        onChange('iv', JSON.stringify(ivRef));
                      }}
                    />
                    <p className="text-xs text-muted-foreground">
                      {t('rules.transformParamIvHint')}
                    </p>
                  </div>
                )}

                {/* iv 变量名输入 */}
                {(ivSource === 'variable' || ivSource === 'secureStore') && (
                  <div className="space-y-2">
                    <Label htmlFor="transform-iv-name">
                      {t('rules.transformParamIv')}
                    </Label>
                    <Input
                      id="transform-iv-name"
                      value={selectedIvName}
                      onChange={(event) =>
                        onSecretRefNameChange('iv', event.target.value)
                      }
                      placeholder={t(
                        'rules.transformParamIvRefNamePlaceholder',
                      )}
                    />
                  </div>
                )}
              </>
            )}
          </>
        )}
      </div>
    </div>
  );
};

export default TransformParamEditor;
