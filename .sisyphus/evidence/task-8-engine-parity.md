# Task 8 Engine Parity Evidence

## 变更范围

- `rust/crates/rules_engine/src/lib.rs`
- `.sisyphus/evidence/task-8-engine-parity.md`
- `.sisyphus/notepads/rust-rules-architecture-refactor/learnings.md`
- `.sisyphus/notepads/rust-rules-architecture-refactor/issues.md`
- `.sisyphus/notepads/rust-rules-architecture-refactor/decisions.md`

## 本次修复

- 修复 `truncate_utf8` 的 UTF-8 边界算法：不再通过不断 `pop()` 试探固定边界，而是从 `max_bytes` 向左寻找最近的合法字符边界后直接切片，避免多字节字符场景下过度截断。
- 新增多字节回归测试，覆盖 1024 字节上限附近的截断行为，确认结果仍是合法 UTF-8 且不超过上限。
- 保留 Task 8 既有最小 `Join` 语义：按输入端口声明顺序收集全部消息；若输出端口类型为 `list<T>`，输出聚合列表，否则输出最后一条消息。
- 同步修复测试中的 Clippy 失败（布尔断言写法），确保 `bun run lint:rust` 通过。

## 验证命令

```bash
cd rust && cargo test -p rules_engine
cd rust && cargo test --workspace
bun run lint:rust
bun run format:rust
```

## 验证结果

- `cd rust && cargo test -p rules_engine`：通过（4 个测试通过，含新的 UTF-8 截断回归测试）
- `cd rust && cargo test --workspace`：通过
- `bun run lint:rust`：通过
- `bun run format:rust`：执行完成

## 结果说明

- `payloadPreview` 现在保持 UTF-8 安全截断，且结果字节长度不超过 1024。
- 本次范围限定为 Task 8 重试修复；未引入新的运行时特性，也未修改 Flutter、web-editor 或 FFI 代码。
