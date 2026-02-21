# Web Editor 深度规范化 - 实施任务

## 1. 国际化重构

- [x] 1.1 创建 i18n 文件目录结构 (`src/i18n/locales/`, `src/i18n/@types/`)
- [x] 1.2 创建 `zh.json` 单文件（嵌套结构：common/rules/preview/errors）
- [x] 1.3 创建 `en.json` 单文件（对应翻译）
- [x] 1.4 更新 `i18n/index.ts` 配置（导出 resources as const）
- [x] 1.5 创建 `@types/i18next.d.ts` 类型声明（官方推荐方式）
- [x] 1.6 更新所有组件中的 `t()` 调用为嵌套键格式 (`t('common.save')`)
- [x] 1.7 移除所有 `defaultValue` 参数
- [x] 1.8 添加 i18n lint 规则（禁止 defaultValue、ns 参数）
- [x] 1.9 验证 TypeScript 类型安全（`tsc --noEmit` 检查无效键）

## 2. 组件标准化

- [x] 2.1 审计所有 `src/components/ui/` 组件
- [x] 2.2 为 Input 组件添加 size 变体 (cva)
- [x] 2.3 为 Badge 组件添加 variant 变体 (cva)
- [x] 2.4 检查 Select 组件 className 透传
- [x] 2.5 检查 Tabs 组件 className 透传
- [x] 2.6 检查 DropdownMenu 组件 className 透传
- [x] 2.7 检查 AlertDialog 组件 className 透传
- [x] 2.8 确保所有组件设置 displayName
- [x] 2.9 导出所有变体类型 (`VariantProps`)

## 3. 性能优化

- [x] 3.1 配置路由级代码分割 (React.lazy + Suspense)
- [x] 3.2 更新 vite.config.ts 添加 manualChunks 配置
- [x] 3.3 为 RuleListPage 添加 React.memo (已跳过: 页面级组件已 lazy 加载，memo 无额外收益)
- [x] 3.4 为 RuleEditorPage 子组件添加 useMemo/useCallback (已跳过: 组件已合理优化)
- [x] 3.5 优化 TanStack Query staleTime 配置
- [x] 3.6 验证构建产物 chunk 分离

## 4. Registry 集成

- [x] 4.1 创建 `components.json` 配置文件
- [x] 4.2 配置 Tailwind CSS v4 兼容选项
- [x] 4.3 添加社区 registry 配置 (plate, magicui)
- [x] 4.4 测试 `npx shadcn add` 命令

## 5. 验证与清理

- [x] 6.1 运行 `bun run lint` 检查代码质量
- [x] 6.2 运行 `bun run build` 验证构建成功
- [x] 6.3 运行 `bun run dev` 验证开发服务器
- [x] 6.4 手动测试所有页面功能
- [x] 6.5 验证语言切换功能
- [x] 6.6 更新 `openspec/specs/web-editor/spec.md` (归档 delta)
