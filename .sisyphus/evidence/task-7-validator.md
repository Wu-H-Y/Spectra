# Task 7 Validator v1 证据

## 变更文件

- `rust/crates/rules_validate/src/lib.rs`

## 实现摘要

- 在 `rules_validate` 中新增 `validate_rule(&RuleEnvelope) -> Vec<Diagnostic>` 入口。
- 覆盖节点/端口存在性、重复定义、边阶段顺序、`DataType` 兼容性、环检测、`normalizedOutputs` 约束与分页 capability gate。
- 所有失败均通过 `Diagnostic` 返回，不对非法 IR 执行 panic。
- 新增基于 fixture 的聚焦单测：最小合法、未知节点、类型不匹配、环路，以及分页 capability 缺失输出场景。

## 验证命令

### 1. Rust LSP 诊断

命令/工具：`lsp_diagnostics rust/crates/rules_validate/src/lib.rs`

结果：通过，未发现诊断。

### 2. Rust 格式化

命令：`bun run format:rust`

结果：通过。

### 3. Validator 定向测试

命令：`cd rust && cargo test -p rules_validate`

结果：通过，`5 passed; 0 failed`。

### 4. Rust 质量门禁

命令：`bun run lint:rust`

结果：通过，实际执行 `cd rust && cargo clippy --all-targets --all-features -- -D warnings` 成功。

## 结论

- Task 7 要求的 validator v1 已在 `rules_validate` 内实现。
- 验收要求中的定向测试与 Rust lint 均已通过。

## 2026-03-06 回归修复

- 修复 `validate_topology` 使用 `rule.graph.nodes.len()` 与 `GraphIndex` 去重视图不一致的问题；现改为基于 `graph_index.nodes.len()` 判断拓扑遍历是否完整。
- 新增回归测试：重复节点 ID 但无环时，必须保留 `DUPLICATE_NODE_ID`，且不得误报 `GRAPH_CYCLE`。
- 回归验证结果：`cd rust && cargo test -p rules_validate` 通过（`6 passed; 0 failed`）；`bun run lint:rust` 通过。
