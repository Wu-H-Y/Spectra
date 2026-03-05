---
name: react-web-editor-guide
description: 指导 React Web Editor 的代码开发、组件添加和状态管理。当你在 web-editor/ 目录下工作或处理 React 相关任务时，请参考此 Skill。
---

# React Web Editor 开发指南

## COMMANDS

```bash
# 依赖与开发
bun add <package>
bun run dev

# 检查与组件
bunx oxlint src/path/to/file.ts
bunx oxfmt src/path/to/file.ts
bunx shadcn add <component>
```

## DEPENDENCIES

- 优先使用 `bun add <package>` (或 `bun add -d` 为开发依赖)。
- 如需安装 beta/rc/canary 版本，请在命令中指定版本号。

## DO / DON'T

- 使用 `t('key')` 国际化，杜绝硬编码字符串。
- 使用 `Zustand` 管理全局共享状态。
- 使用 `@/` 绝对路径导入组件。
- 组件声明使用 `const Component = () => {}`。

## SHADCN/UI & STYLE

- `new-york` 风格 + `lucide` 图标。
- 遵循 80 字符行宽限制。

## I18N

- 翻译文件位于 `src/i18n/locales/zh.json`。
