# Web Editor - React 规则编辑器

爬虫规则可视化编辑器，基于 React 19 + TypeScript + Vite + shadcn/ui 构建。

---

## COMMANDS

```bash
# 包管理 (使用 bun)
bun install                    # 安装依赖
bun add <package>              # 添加依赖
bun add -d <package>           # 添加 dev 依赖

# 开发
bun run dev                    # 启动开发服务器

# 单文件检查
bunx oxlint src/path/to/file.ts      # 单文件 lint
bunx oxfmt src/path/to/file.ts       # 单文件格式化

# 全量检查
bun run lint                   # oxlint 全量
bun run fmt:check              # 格式化检查
bun run build                  # TypeScript 编译 + 构建

# shadcn 组件
bunx shadcn add <component>    # 添加组件
```

---

## PROJECT STRUCTURE

```
web-editor/
├── src/
│   ├── api/           # API 类型定义
│   ├── components/    # React 组件
│   │   └── ui/        # shadcn/ui 组件
│   ├── hooks/         # 自定义 Hooks
│   ├── i18n/          # 国际化 (i18next)
│   ├── lib/           # 工具函数
│   ├── pages/         # 页面组件
│   ├── stores/        # Zustand 状态
│   ├── App.tsx        # 路由配置
│   ├── main.tsx       # 入口
│   └── index.css      # Tailwind CSS
├── components.json    # shadcn/ui 配置
├── .oxlintrc.json     # oxlint 配置
└── .oxfmtrc.json      # oxfmt 配置
```

---

## DO / DON'T

| Do | Don't |
|-------|---------|
| `t('common.save')` 国际化 | 硬编码字符串 `'保存'` |
| `@/components/ui/button` 导入 | 相对路径 `../../ui/button` |
| Zustand 管理全局状态 | `useState` 管理共享状态 |
| 中文注释 | 英文注释 |
| `const Component = () => {}` | `function Component() {}` |

---

## CODE STYLE

### oxfmt 配置

```json
{
  "printWidth": 80,
  "tabWidth": 2,
  "semi": true,
  "singleQuote": true,
  "trailingComma": "all"
}
```

### oxlint 规则

- `correctness`: error
- `suspicious`: warn
- 自定义 `i18n/no-default-value`: 禁止默认值回退

---

## STATE MANAGEMENT (Zustand)

```typescript
// stores/index.ts
interface MyState {
  value: string;
  setValue: (value: string) => void;
}

export const useMyStore = create<MyState>((set) => ({
  value: '',
  setValue: (value) => set({ value }),
}));

// 使用
const { value, setValue } = useMyStore();
```

---

## I18N

```typescript
// 添加翻译
// src/i18n/locales/zh.json
{
  "common": {
    "save": "保存",
    "cancel": "取消"
  }
}

// 使用
import { useTranslation } from 'react-i18next';
const { t } = useTranslation();
<Button>{t('common.save')}</Button>
```

---

## SHADCN/UI

```bash
# 添加组件
bunx shadcn add button
bunx shadcn add dialog

# 使用
import { Button } from '@/components/ui/button';
```

**配置**: `new-york` 风格 | `lucide` 图标 | `neutral` 基础色

---

## ROUTING

```typescript
// 懒加载路由
const Page = lazy(() =>
  import('@/pages/Page').then((m) => ({ default: m.Page })),
);

// 路由配置
<Route path="/rules/:id" element={<RuleEditorPage />} />

// 获取参数
const { id } = useParams();
```

---

## LEARNING FROM MISTAKES

| 错误模式 | 正确做法 |
|---------|---------|
| 硬编码 UI 文本 | 使用 `t('key')` |
| 忘记 `Suspense` 包裹懒加载组件 | 懒加载路由必须包裹 |
| 直接修改 `node_modules` | 复制到 `components/ui` 后修改 |
| `any` 类型 | 定义明确接口 |
| 猜测包 API | 先查官方文档 |

---

## PACKAGE DOCUMENTATION

不熟悉的包或版本，**先查官方文档，不要猜测 API**:

| 来源 | 链接格式 |
|------|---------|
| npm 包详情 | `https://www.npmjs.com/package/<package_name>` |
| React 文档 | https://react.dev/reference/react |
| Tailwind CSS | https://tailwindcss.com/docs |
| shadcn/ui | https://ui.shadcn.com/docs 或 https://ui.shadcn.com/llms.txt |
| Zustand | https://zustand-demo.pmnd.rs/ |
| i18next | https://www.i18next.com/ |
| React Query | https://tanstack.com/query/latest/docs/framework/react/overview |
| React Router | https://reactrouter.com/dev |

**示例**:
- react: https://www.npmjs.com/package/react
- @tanstack/react-query: https://www.npmjs.com/package/@tanstack/react-query
- lucide-react: https://www.npmjs.com/package/lucide-react

---

## PERMISSIONS

**允许**: 读文件 | 单文件 lint/fmt | `bun install` | 添加 shadcn 组件

**需询问**: 添加新依赖 | 修改 `tsconfig.json` | 修改 `.oxlintrc.json`

---

## WHEN STUCK

1. 提具体问题或建议方案
2. **不猜测 API**，先查文档:
   - npm: `https://www.npmjs.com/package/<name>`
   - 框架: React/Tailwind/shadcn 官方站点
   - shadcn/ui: https://ui.shadcn.com/llms.txt (LLM 友好)
3. 用 `// TODO:` 标记草稿
4. 不确认不重构
