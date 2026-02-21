## MODIFIED Requirements

### Requirement: 前端技术

| 技术 | 用途 |
|------|------|
| React 19 + TypeScript | UI框架 |
| Vite | 构建工具 |
| Tailwind CSS v4 | 样式 |
| shadcn/ui | 组件库 |
| Zustand | 状态管理 |
| TanStack Query | API调用 |

#### Scenario: 构建输出
- **WHEN** 执行构建
- **THEN** 产物输出到 `assets/editor/`

#### Scenario: React 19 特性
- **WHEN** 使用 React 19
- **THEN** 可使用 useOptimistic、use 等 Hook

---

## ADDED Requirements

### Requirement: 组件架构规范

所有 UI 组件必须遵循 shadcn/ui 最佳实践：

- 使用 `forwardRef` 支持引用传递
- 支持 `className` 透传
- 使用 `cva` (class-variance-authority) 实现变体系统
- 设置 `displayName` 便于调试

#### Scenario: 组件引用传递
- **WHEN** 使用 `ref` prop
- **THEN** 引用正确传递到底层 DOM 元素

#### Scenario: 组件样式扩展
- **WHEN** 传入 `className` prop
- **THEN** 样式与默认样式合并，不覆盖

---

### Requirement: 性能优化

应用 Vercel React 最佳实践：

- 路由级代码分割（React.lazy + Suspense）
- 使用 `React.memo` 优化高频渲染组件
- 使用 `useMemo` / `useCallback` 避免不必要重渲染
- TanStack Query 配置合理的 `staleTime`

#### Scenario: 路由懒加载
- **WHEN** 访问路由
- **THEN** 仅加载当前路由所需的代码块

#### Scenario: 组件 Memo 优化
- **WHEN** 父组件重渲染
- **THEN** props 未变化的 memo 组件不重渲染
