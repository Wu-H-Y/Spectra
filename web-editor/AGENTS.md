# web-editor/ 目录知识库

## OVERVIEW

规则编辑器前端子项目（React + TypeScript + Vite + Bun），负责规则建模、预览与编辑体验。

## WHERE TO LOOK

| 任务       | 位置                            | 说明                   |
| ---------- | ------------------------------- | ---------------------- |
| 前端入口   | `web-editor/src/main.tsx`       | 应用挂载与全局初始化   |
| 路由页面   | `web-editor/src/pages/rules/**` | 规则列表与规则编辑页面 |
| API 客户端 | `web-editor/src/api/client.ts`  | 后端交互封装           |
| 共享类型   | `web-editor/src/types/**`       | IR 对齐类型定义        |
| 国际化     | `web-editor/src/i18n/**`        | 词条与 i18n 初始化     |

## SKILLS

- 默认先读 `react-web-editor-guide`。
- 性能/重渲染问题联动 `vercel-react-best-practices`。
- 规则类型与 Rust IR 对齐问题联动 `m11-ecosystem`。
- 涉及页面视觉升级、交互体验优化时，补充 `frontend-design`、`ui-ux-pro-max`。
- 涉及主题风格方案（配色/字体）时，补充 `theme-factory`。

## CONVENTIONS

- 文本必须使用 `t('...')`，禁止硬编码 UI 字符串。
- 共享状态优先放 `src/stores/`，避免页面内碎片化全局状态。
- 保持 `@/` 别名导入风格一致。
- 依赖新增使用 `bun add` 或 `bun add -d`。

## ANTI-PATTERNS

- 禁止在 `t()` 中传 `defaultValue` 或 `ns`（受项目自定义 oxlint 规则约束）。
- 禁止绕过 `oxlint`/`oxfmt` 直接提交。
- 禁止手写与 `rules_ir` 已不一致的类型字段。

## COMMANDS

```bash
cd web-editor
bun install
bun run lint
bun run fmt:check
bun run build
```

## NOTES

- 与 Rust IR 结构联动时，先核对 `rust/crates/rules_ir/src/lib.rs`。
- Web 构建产物由根命令 `bun run build:web` 统一触发。
