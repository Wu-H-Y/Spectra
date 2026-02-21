# Web Editor 深度规范化 - 技术设计

## Context

### 当前状态

web-editor 是一个 React + Vite + TypeScript 的爬虫规则编辑器，技术栈：
- React 19.2 + TypeScript 5.9
- Vite 7 + Tailwind CSS 4
- shadcn/ui 组件库（已集成部分组件）
- Zustand 5 状态管理
- TanStack Query 5 数据获取
- i18next 国际化

### 现有问题

| 问题域 | 当前状态 | 影响 |
|--------|----------|------|
| 国际化 | 翻译内联在 `i18n/index.ts`，约 66 键定义，100+ 键散落在 `defaultValue` | 难维护、无类型安全 |
| 组件架构 | UI 组件部分使用 cva，业务组件 props 不一致 | 样式不统一、扩展困难 |
| 性能优化 | 未应用代码分割，状态管理可优化空间大 | 打包体积大、渲染效率低 |
| Registry | 未配置 `components.json`，无法使用社区组件 | 重复造轮子 |

### 约束

- 必须与 Flutter 主项目的 localization spec 兼容
- 不影响现有 API 接口
- 渐进式迁移，保证开发期间可用

---

## Goals / Non-Goals

**Goals:**
1. 将国际化翻译外部化到独立 JSON/TS 文件，支持 namespace 和类型安全
2. 标准化所有 UI 组件，符合 shadcn/ui 最佳实践（className 透传、ref 转发、cva 变体）
3. 应用 Vercel React 性能优化最佳实践
4. 配置 shadcn Registry 集成，支持社区组件

**Non-Goals:**
- 不引入新的状态管理库（继续使用 Zustand）
- 不重构业务逻辑，仅优化组件层面
- 不添加 SSR/SSG 支持（纯 SPA）
- 不创建 Storybook（本次迭代不做）

---

## Decisions

### D1: 国际化文件结构

**决策**: 采用单文件嵌套 JSON + TypeScript 类型生成，遵循 [i18next 官方 TypeScript 文档](https://www.i18next.com/overview/typescript)

**目录结构**:
```
web-editor/src/i18n/
├── index.ts              # i18n 初始化配置 + 导出 resources
├── locales/
│   ├── zh.json           # 中文翻译（嵌套结构）
│   └── en.json           # 英文翻译（嵌套结构）
└── @types/
    └── i18next.d.ts      # TypeScript 类型声明（官方推荐方式）
```

**翻译文件结构** (单文件嵌套):
```json
// zh.json
{
  "common": {
    "save": "保存",
    "cancel": "取消",
    "delete": "删除",
    "confirm": "确认"
  },
  "rules": {
    "ruleName": "规则名称",
    "mediaType": "媒体类型",
    "baseUrl": "基础 URL"
  },
  "preview": {
    "previewUrl": "预览 URL",
    "selectElement": "选择元素"
  },
  "errors": {
    "saved": "保存成功",
    "deleteError": "删除失败"
  }
}
```

**i18n 初始化配置** (`src/i18n/index.ts`):
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

**TypeScript 类型声明** (`src/i18n/@types/i18next.d.ts`):
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

**使用方式** (无需 namespace 前缀):
```typescript
// 使用点号访问嵌套键，获得完整的类型安全和自动补全
const { t } = useTranslation();
t('common.save')      // → "保存"
t('rules.ruleName')   // → "规则名称"
t('errors.saved')     // → "保存成功"

// 无效键会在编译时报错
t('invalid.key')      // TypeScript 错误：键不存在
```

**理由**:
- 单文件简化管理，避免文件碎片化
- 嵌套结构保持逻辑分组，可读性好
- 无需 namespace 前缀，调用更简洁
- **官方 TypeScript 类型声明方式**，获得完整类型安全和 IDE 自动补全
- `as const` 确保 JSON 导入保持字面量类型

**替代方案**:
- ❌ 多文件 namespace: 增加管理复杂度，调用繁琐 (`t('common:save')`)
- ❌ TS 文件: 翻译工具支持差
- ❌ YAML: 需要额外解析
- ❌ 扁平结构: 难以组织，命名冗长

**参考文档**:
- [i18next TypeScript 官方文档](https://www.i18next.com/overview/typescript)
- [react-i18next TypeScript](https://react.i18next.com/latest/typescript)

### D2: 组件标准化规范

**决策**: 所有 UI 组件必须遵循以下规范

**必需特性**:
```typescript
// 1. forwardRef 支持
const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(...)

// 2. className 透传
className={cn(baseStyles, className)}

// 3. cva 变体系统（有变体需求的组件）
const buttonVariants = cva(base, { variants: {...} })

// 4. displayName
Button.displayName = 'Button'

// 5. 导出变体类型
export type ButtonVariantProps = VariantProps<typeof buttonVariants>
```

**组件分类**:

| 组件 | 当前状态 | 需要修复 |
|------|----------|----------|
| button | ✅ 完整 | - |
| input | ✅ className + ref | 添加 size 变体 |
| card | ✅ 完整 | - |
| select | ⚠️ Radix 封装 | 确保透传 |
| tabs | ⚠️ Radix 封装 | 确保透传 |
| badge | ✅ 基本完整 | 添加 variant |
| label | ✅ cva | - |
| sonner | ✅ 第三方 | - |

**理由**: 保持与 shadcn/ui 官方组件一致，方便后续升级和社区组件集成

### D3: 性能优化策略

**决策**: 应用以下 Vercel React 最佳实践

**1. 路由级代码分割**
```typescript
// 使用 React.lazy + Suspense
const RuleEditorPage = lazy(() => import('@/pages/rules/RuleEditorPage'))
const RuleListPage = lazy(() => import('@/pages/rules/RuleListPage'))
```

**2. 组件级优化**
- 使用 `React.memo` 包装纯展示组件
- 使用 `useMemo` / `useCallback` 避免不必要重渲染
- 状态下沉，减少 Context 范围

**3. TanStack Query 优化**
```typescript
// 使用 staleTime 减少不必要的 refetch
useQuery({ queryKey: ['rules'], queryFn: fetchRules, staleTime: 5 * 60 * 1000 })
```

**4. Vite 构建优化**
```typescript
// vite.config.ts
build: {
  rollupOptions: {
    output: {
      manualChunks: {
        'vendor-react': ['react', 'react-dom', 'react-router-dom'],
        'vendor-ui': ['radix-ui', 'lucide-react'],
        'vendor-data': ['@tanstack/react-query', 'zustand'],
      }
    }
  }
}
```

**理由**: 
- 代码分割减少首屏加载时间
- Memo 优化高频渲染组件
- Chunk 策略优化缓存利用率

### D4: shadcn Registry 配置

**决策**: 配置 `components.json` 支持社区注册表

**配置文件**:
```json
{
  "$schema": "https://ui.shadcn.com/schema/components.json",
  "style": "new-york",
  "rsc": false,
  "tsx": true,
  "tailwind": {
    "config": "tailwind.config.ts",
    "css": "src/index.css",
    "baseColor": "slate",
    "cssVariables": true
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils",
    "ui": "@/components/ui"
  },
  "registries": {
    "plate": "https://platejs.org/r",
    "magicui": "https://magicui.design/r"
  }
}
```

**社区组件集成步骤**:
```bash
# 安装社区组件
npx shadcn@latest add @plate/ui
npx shadcn@latest add @magicui/magic-card
```

**推荐社区组件**:
- `@plate/ui` - 富文本编辑器（如果需要 JSON 编辑增强）
- `@magicui/animated-beam` - 连接动画（可视化规则流程）
- `@prompt-kit/chat` - AI 辅助界面

**理由**: 利用成熟社区组件，避免重复开发

## Risks / Trade-offs

### R1: 国际化迁移兼容性

**风险**: 现有 `t()` 调用需要更新为嵌套键格式  
**缓解**: 
1. 保留原有键名作为嵌套结构的顶层键
2. 编写迁移脚本自动更新 `t('key')` → `t('common.key')`
3. 渐进式迁移，按模块分批处理

### R2: 组件重构引入 Bug

**风险**: 修改组件 props 接口可能破坏现有使用  
**缓解**:
1. 保持向后兼容，新增可选 props
2. 添加 TypeScript 严格检查
3. 渐进式重构，优先处理问题最多的组件

### R3: 性能优化过度

**风险**: 过度 memo 化可能适得其反  
**缓解**:
1. 仅对有明显性能问题的组件使用 memo
2. 使用 React DevTools Profiler 验证效果
3. 优先优化大数据量渲染场景

### R4: 社区组件兼容性

**风险**: 社区组件可能与现有 Tailwind 4 配置不兼容  
**缓解**:
1. 安装前检查组件依赖和 Tailwind 版本
2. 优先选择官方或高星社区组件
3. 保持 `components.json` 配置更新

---

## Migration Plan

### 阶段 1: 国际化重构 (优先级: 高)

1. 创建 `i18n/locales/` 目录
2. 创建 `zh.json` 单文件（嵌套结构）
3. 创建 `en.json` 单文件（对应翻译）
4. 配置 i18next 加载单文件
5. 生成 TypeScript 类型
6. 更新组件中的 `t()` 调用为嵌套键格式
7. 移除 `defaultValue` 模式

### 阶段 2: 组件标准化 (优先级: 中)

1. 审计所有 UI 组件
2. 统一添加 forwardRef + className 透传
3. 为需要变体的组件添加 cva
4. 添加缺失的 displayName

### 阶段 3: 性能优化 (优先级: 中)

1. 配置路由级代码分割
2. 优化 Vite 构建配置
3. 对高频渲染组件添加 memo
4. 优化 TanStack Query 配置

### 阶段 4: Registry 集成 (优先级: 低)

1. 创建 `components.json`
2. 添加社区 registry 配置
3. 按需安装社区组件

---

## Open Questions

1. **Q: 是否需要支持语言切换持久化？**
   - 当前: 使用 localStorage 或 zustand persist
   - 建议: 如果有用户设置页面，可以添加

2. **Q: 是否需要服务端翻译加载？**
   - 当前: 静态打包
   - 建议: 小项目不需要，保持静态加载

3. **Q: 组件文档是否需要 Storybook？**
   - 当前: 不需要
   - 建议: 后续如果组件库扩展再考虑

4. **Q: 是否需要创建内部 Registry？**
   - 当前: 无
   - 建议: 如果有可复用的业务组件，可以创建
