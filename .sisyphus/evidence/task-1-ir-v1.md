# Task 1 - IR v1 证据记录

## 执行命令

1. `cargo test -p rules_ir`（workdir: `rust/`）

## 输出摘要

- 新增并编译 `serde` / `serde_json` 依赖成功。
- `rules_ir` 单元测试执行完成：2 通过，0 失败。
- Doc-tests 执行完成：0 通过，0 失败（无 doctest 用例）。

## 关键校验结果

- `fixtures/ir_v1_min.json` 可被 `RuleEnvelope` 反序列化。
- `fixtures/ir_v1_invalid_edge.json` 可被 `RuleEnvelope` 反序列化。
- `rust/crates/rules_ir/src/lib.rs` LSP 诊断无错误（No diagnostics found）。
