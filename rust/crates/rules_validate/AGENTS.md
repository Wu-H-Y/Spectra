# rules_validate 知识库

## OVERVIEW

规则图校验层：检查节点、端口、边、拓扑环、能力声明与阶段输出约束，并产出诊断。

## WHERE TO LOOK

| 任务 | 位置 | 说明 |
|------|------|------|
| 校验入口 | `rust/crates/rules_validate/src/lib.rs` | `validate_rule` 总调度 |
| 图结构校验 | `rust/crates/rules_validate/src/lib.rs` | 节点/端口/边合法性 |
| 能力约束校验 | `rust/crates/rules_validate/src/lib.rs` | `supportsPagination`/`supportsConcurrency` 逻辑 |

## SKILLS

- 校验规则建模与错误分层优先 `m13-domain-error`、`m06-error-handling`。
- 图算法与复杂逻辑优先 `m10-performance`、`m09-domain`。
- Rust 错误定位默认先经 `rust-router`。

## CONVENTIONS

- 诊断码常量统一集中声明，避免字符串散落。
- 诊断信息保持“可定位路径 + 可读中文原因 + 关联节点”三要素。
- 新校验规则优先补充对应测试用例，防止回归。
- 默认使用仓库根目录 `package.json` 脚本执行 Rust lint/format。
- 代码检查统一使用 `cargo clippy`，禁止使用 `cargo check`。
- 代码格式化统一使用 `cargo +nightly fmt`，禁止使用 `cargo fmt`。

## ANTI-PATTERNS

- 禁止把业务数据转换逻辑塞进 validate crate。
- 禁止输出无路径的模糊错误（难以给 UI 高亮定位）。
- 禁止通过放宽规则掩盖真实不一致。

## COMMANDS

```bash
# 推荐：在仓库根目录执行
bun run lint:rust
bun run format:rust

# 定向测试
cd rust && cargo test -p rules_validate
```
