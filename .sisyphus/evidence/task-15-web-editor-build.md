# Task 15 Evidence

## Scope

- 仅处理 `web-editor` 的规则类型迁移收口，不展开 Task 16 图编辑器工作。
- 主编辑路径从 legacy `CrawlerRule` 表单切到 generated `RuleEnvelope` JSON 编辑。
- 核对 `sample-rules.json` 活跃引用，确认当前 `web-editor` 中不存在活动导入链路。

## Files Changed

- `web-editor/src/api/client.ts`
- `web-editor/src/pages/rules/RuleEditorPage.tsx`
- `web-editor/src/pages/rules/RuleListPage.tsx`
- `.sisyphus/notepads/rust-rules-architecture-refactor/decisions.md`

## Implementation Notes

- 为 `rulesApi` 新增 IR 专用方法：`listSummaries`、`getEnvelope`、`createEnvelope`、`updateEnvelope`、`validateEnvelope`。
- `RuleEditorPage` 改为仅提供 `RuleEnvelope` 的 JSON 编辑 + 既有 preview/session 面板，不再走旧表单组件主路径。
- `RuleListPage` 改为消费 `/api/rules` 摘要响应，并在单条/批量导出时按需拉取完整 `RuleEnvelope`。
- 导入逻辑改为接受 `RuleEnvelope`、`{ rule }`、`{ rules: [] }` 三类 IR 载荷。
- 通过全仓 `grep` 确认当前没有 `sample-rules.json` 或 `sample-rules` 的活动导入引用。

## Verification

### Command

```bash
cd web-editor && bun x oxfmt "src/api/client.ts" "src/pages/rules/RuleEditorPage.tsx" "src/pages/rules/RuleListPage.tsx"
```

### Outcome

- 命令成功，无报错输出。

### Command

```bash
cd web-editor && bun x oxlint "src/api/client.ts" "src/pages/rules/RuleEditorPage.tsx" "src/pages/rules/RuleListPage.tsx"
```

### Outcome

- `Found 0 warnings and 0 errors.`

### Command

```bash
cd web-editor && bun run build
```

### Outcome

- `tsc -b && vite build` 成功。
- Vite 构建完成并产出 `assets/editor/assets/RuleListPage-*.js`、`assets/editor/assets/RuleEditorPage-*.js`。

### Command

```bash
rg -n "sample-rules\.json|sample-rules" web-editor
```

### Outcome

- 未发现匹配，说明旧 `sample-rules` 导入路径不在当前活跃流程中。

## Notes

- 当前环境仍未安装 `typescript-language-server`，无法执行 `lsp_diagnostics`；本次沿用既有仓库问题记录，改以 `bun x oxlint` + `bun run build` 作为 TypeScript 质量门禁。
