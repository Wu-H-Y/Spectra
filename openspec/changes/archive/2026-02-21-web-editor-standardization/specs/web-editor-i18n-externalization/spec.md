# web-editor 国际化外部化规范

> 遵循 [react-i18next TypeScript 官方文档](https://react.i18next.com/latest/typescript) 和 [i18next TypeScript 文档](https://www.i18next.com/overview/typescript)

## 文件结构

### Requirement: 单文件嵌套结构

翻译采用单文件嵌套 JSON 结构，避免多 namespace 文件碎片化：

```
web-editor/src/i18n/
├── index.ts              # i18n 初始化 + 导出 resources
├── locales/
│   ├── zh.json           # 中文翻译（嵌套结构）
│   └── en.json           # 英文翻译（嵌套结构）
└── @types/
    └── i18next.d.ts      # TypeScript 类型声明（官方推荐）
```

#### Scenario: 多语言切换
- **WHEN** 用户切换语言
- **THEN** i18next 加载对应语言的 JSON 文件

---

## 翻译文件结构

### Requirement: 嵌套键结构

单文件内使用嵌套结构组织翻译键：

```json
// locales/zh.json
{
  "common": {
    "save": "保存",
    "cancel": "取消",
    "delete": "删除",
    "edit": "编辑",
    "create": "创建",
    "confirm": "确认"
  },
  "rules": {
    "ruleName": "规则名称",
    "ruleDescription": "描述",
    "mediaType": "媒体类型",
    "baseUrl": "基础 URL"
  },
  "preview": {
    "previewUrl": "预览 URL",
    "selectElement": "选择元素",
    "foundElements": "找到 {{count}} 个元素"
  },
  "errors": {
    "saved": "保存成功",
    "deleteError": "删除失败",
    "networkError": "网络错误，请重试"
  }
}
```

#### Scenario: 嵌套键访问
- **WHEN** 组件调用 `t('common.save')`
- **THEN** 返回当前语言的 "保存" 或 "Save"

#### Scenario: 插值翻译
- **WHEN** 调用 `t('preview.foundElements', { count: 5 })`
- **THEN** 返回 "找到 5 个元素"

---

## TypeScript 类型安全

### Requirement: 官方类型声明

遵循 i18next 官方 TypeScript 最佳实践，创建类型声明文件：

**`src/i18n/index.ts`**:
```typescript
import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';

import zh from './locales/zh.json';
import en from './locales/en.json';

export const defaultNS = 'translation';
export const resources = {
  zh: { translation: zh },
  en: { translation: en },
} as const;

i18n.use(initReactI18next).init({
  lng: 'zh',
  defaultNS,
  resources,
  interpolation: {
    escapeValue: false,
  },
});

export default i18n;
```

**`src/i18n/@types/i18next.d.ts`**:
```typescript
import 'i18next';
import { defaultNS, resources } from '../index';

declare module 'i18next' {
  interface CustomTypeOptions {
    defaultNS: typeof defaultNS;
    resources: typeof resources['zh'];
    returnNull: false;
  }
}
```

#### Scenario: 类型安全的翻译键
- **WHEN** 调用 `t('common.save')`
- **THEN** TypeScript 校验键路径正确，提供自动补全

#### Scenario: 无效键检测
- **WHEN** 调用 `t('invalid.key')`
- **THEN** TypeScript 报错：键不存在

---

## 组件使用规范

### Requirement: useTranslation Hook

使用标准 hook 获取翻译函数：

```tsx
import { useTranslation } from 'react-i18next';

function MyComponent() {
  const { t } = useTranslation();
  
  return (
    <div>
      <h1>{t('rules.ruleName')}</h1>
      <button>{t('common.save')}</button>
    </div>
  );
}
```

### Requirement: Trans 组件处理 JSX

包含 JSX 元素的翻译使用 Trans 组件：

```tsx
import { Trans } from 'react-i18next';

// 翻译键: "welcome": "欢迎来到 <1>Spectra</1>"
function WelcomeMessage() {
  return (
    <Trans i18nKey="welcome">
      欢迎来到 <strong>Spectra</strong>
    </Trans>
  );
}
```

---

## 禁止模式

### Requirement: 禁止 defaultValue 内联

不再使用 `defaultValue` 参数作为翻译回退。

#### Scenario: 错误用法检测
- **WHEN** 代码中出现 `t('key', { defaultValue: '...' })`
- **THEN** lint 规则警告，要求将键添加到 JSON 文件

### Requirement: 禁止硬编码文本

所有 UI 文本必须通过 i18n 系统获取。

#### Scenario: 硬编码检测
- **WHEN** JSX 中出现中文或英文字面量
- **THEN** lint 规则警告

### Requirement: 禁止 namespace 分离

不使用多 namespace 文件分离模式。

#### Scenario: 拒绝多 namespace 结构
- **WHEN** 尝试创建 `locales/zh/common.json` 等多文件结构
- **THEN** 代码审查拒绝，要求使用单文件嵌套结构

---

## 配置要求

### Requirement: tsconfig.json 配置

确保 TypeScript 严格模式启用：

```json
{
  "compilerOptions": {
    "strict": true,
    "skipLibCheck": true
  }
}
```

#### Scenario: 类型检查启用
- **WHEN** 运行 `tsc --noEmit`
- **THEN** 所有翻译键调用都经过类型检查
