# rules_ir 知识库

## OVERVIEW

规则 IR 的权威模型层，负责 Rust 结构定义、序列化契约与 TypeScript 导出。

## WHERE TO LOOK

| 任务 | 位置 | 说明 |
|------|------|------|
| 核心封套结构 | `rust/crates/rules_ir/src/lib.rs` | `RuleEnvelope` 与图模型 |
| 诊断模型 | `rust/crates/rules_ir/src/diagnostic.rs` | 诊断码与严重级别 |
| 标准化模型 | `rust/crates/rules_ir/src/normalized_model.rs` | 统一输出模型 |
| WS 协议模型 | `rust/crates/rules_ir/src/ws_protocol.rs` | WebSocket 消息结构 |

## SKILLS

- 类型与建模优先 `m05-type-driven`、`m09-domain`。
- 跨语言导出与生态集成优先 `m11-ecosystem`。
- Rust 入口与错误路由先经 `rust-router`。

## CONVENTIONS

- 新字段默认 `serde(rename_all = "camelCase")` 保持 JSON 兼容。
- 变更导出类型时同步检查 `#[ts(export)]` 与导出目标文件。
- 文档注释保持中文且聚焦字段语义，不写空泛描述。
- 默认使用仓库根目录 `package.json` 脚本执行 Rust lint/format。
- 代码检查统一使用 `cargo clippy`，禁止使用 `cargo check`。
- 代码格式化统一使用 `cargo +nightly fmt`，禁止使用 `cargo fmt`。

## ANTI-PATTERNS

- 禁止破坏 `RuleEnvelope` 顶层必需字段契约。
- 禁止在模型层夹带校验副作用逻辑（校验应在 `rules_validate`）。
- 禁止引入不必要的 `serde`/`ts-rs` 不兼容类型。

## COMMANDS

```bash
# 推荐：在仓库根目录执行
bun run lint:rust
bun run format:rust

# 定向测试
cd rust && cargo test -p rules_ir
```
