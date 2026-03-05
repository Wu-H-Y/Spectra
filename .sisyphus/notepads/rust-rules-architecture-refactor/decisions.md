# Decisions

（追加记录，不覆盖。）

- 2026-03-05: 计划文件 `.sisyphus/plans/rust-rules-architecture-refactor.md` 保持只读，不直接勾选任务；使用本会话的 TODO 跟踪来“预标记”已在代码库中完成的任务。
- 2026-03-05: 以 `.sisyphus/evidence/task-*.md` + 关键实现文件/命令输出作为“已完成”证据来源；若当前环境离线导致 `flutter analyze --fatal-infos` 失败，则以 `flutter analyze --fatal-infos --no-pub` + 证据记录作为临时通过依据，并在联网环境补跑完整命令。

- 2026-03-05: 在用户请求下，已将计划文件中 Task 0-5 的顶层 checkbox 标记为完成（`- [x]`），对应证据见 `.sisyphus/evidence/task-0-rust-hard-reset.md`、`.sisyphus/evidence/task-1-ir-v1.md`、`.sisyphus/evidence/task-2-nodeevent-protocol.md`、`.sisyphus/evidence/task-3-api-contract.md`、`.sisyphus/evidence/task-4-drift-migration.md`。
- 2026-03-05: 决定通过 `DiagnosticCode`/`DiagnosticPath`/`DiagnosticNodeId`/`DiagnosticMessage` 别名来包装 `Diagnostic` 字段类型，既提升字段语义，也避免为此次更改引入 `ts_rs` 等额外依赖。
