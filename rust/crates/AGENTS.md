# rust/crates/ 目录知识库

## OVERVIEW

按能力拆分的 Rust crate 集合，供 workspace 复用与跨语言导出。

## WHERE TO LOOK

| 任务 | 位置 | 说明 |
|------|------|------|
| IR 模型与 TS 导出 | `rust/crates/rules_ir/` | `serde` + `ts-rs` 协议模型 |
| IR 结构校验 | `rust/crates/rules_validate/` | 图校验、能力约束、诊断输出 |
| 引擎占位 | `rust/crates/rules_engine/` | 执行引擎扩展点 |
| HTTP I/O 占位 | `rust/crates/io_http/` | 网络采集扩展点 |
| FFI 占位 | `rust/crates/ffi/` | Flutter 边界扩展点 |

## SKILLS

- crate 设计问题：`m09-domain`、`m05-type-driven`。
- crate 依赖集成：`m11-ecosystem`。
- FFI/unsafe 触点：`unsafe-checker`。

## CONVENTIONS

- crate 之间共享类型优先放在 `rules_ir`。
- 校验逻辑优先放 `rules_validate`，不要散落到模型 crate。
- crate 新增依赖优先 `cargo add -p <crate> <dep>`。
- 默认使用仓库根目录 `package.json` 脚本执行 Rust lint/format。
- Rust 检查统一使用 `cargo clippy`，禁止使用 `cargo check`。
- Rust 格式化统一使用 `cargo +nightly fmt`，禁止使用 `cargo fmt`。

## ANTI-PATTERNS

- 禁止把业务规则硬编码进 FFI crate。
- 禁止跨 crate 循环依赖。
- 禁止在占位 crate（`rules_engine/io_http/ffi`）提前塞入未验证的大量实现。

## COMMANDS

```bash
# 推荐：在仓库根目录执行
bun run lint:rust
bun run format:rust

# 定向测试
cd rust && cargo test -p rules_ir
cd rust && cargo test -p rules_validate
```
