# Task 16 Graph Edit Evidence

## 变更摘要

- 在 `web-editor/src/pages/rules/RuleEditorPage.tsx` 新增基于 `@xyflow/react` 的最小图编辑标签页。
- 图编辑器使用真实节点、端口和边，编辑结果同步写回 `RuleEnvelope.graph` 与 `RuleEnvelope.normalizedOutputs`。
- 新建规则默认生成一条最小合法链，重载时从已保存的 `RuleEnvelope.graph` 恢复节点、边与布局。

## 关键文件

- `web-editor/src/pages/rules/RuleEditorPage.tsx`
- `web-editor/src/lib/ruleGraph.ts`
- `web-editor/src/components/rules/RuleGraphNode.tsx`
- `web-editor/src/stores/index.ts`
- `web-editor/src/lib/ruleGraph.test.ts`
- `web-editor/package.json`

## 验证命令与结果

1. 安装图编辑依赖

```bash
cd web-editor
bun add @xyflow/react
```

结果：成功安装 `@xyflow/react@12.10.1`，并更新 `package.json` / `bun.lock`。

2. focused QA：最小图创建 -> 编辑 -> 序列化 -> 重载

```bash
cd web-editor
bun "src/lib/ruleGraph.test.ts"
```

结果：命令退出码为 0，无异常抛出。脚本验证了：

- 在最小默认图上追加 `transform_1` 节点；
- 连接 `search_input.query -> transform_1.in -> search_output.items`；
- 将结果写回 `RuleEnvelope.graph`；
- 经 `JSON.stringify` / `JSON.parse` 重载后，节点、边、`graph.layout.nodes.transform_1`、`graph.phaseEntrypoints.search` 与 `normalizedOutputs.search` 保持一致。

3. 静态检查

```bash
cd web-editor
bun run lint
```

结果：通过，`0 warnings`，`0 errors`。

4. 格式检查

```bash
cd web-editor
bun run fmt:check
```

结果：通过，所有匹配文件格式正确。

5. 构建验证

```bash
cd web-editor
bun run build
```

结果：通过。`tsc -b && vite build` 成功，产出包含更新后的 `RuleEditorPage` 资源。

## 备注

- 本机缺少 `typescript-language-server` 与 `biome`，因此无法通过 LSP 工具拿到 TS/JSON diagnostics；本任务已使用项目实际门禁命令替代验证。
