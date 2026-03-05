---
name: rust-ffi-guide
description: 指导 Rust 模块（FFI）的代码编写、桥接配置和构建。当你在 rust/ 目录下工作或处理 Flutter Rust Bridge 相关任务时，请参考此 Skill。
---

# Rust FFI 开发指南 (Spectra Native)

## COMMANDS

```bash
# 检查与格式化
cargo clippy -- -W clippy::all src/path/to/file.rs
cargo +nightly fmt -- src/path/to/file.rs

# 代码生成 (修改 API 后)
cd .. && dart run flutter_rust_bridge_codegen generate
```

## DEPENDENCIES

- 优先使用 `cargo add <crate>`。
- 只有在需要特定 feature 或版本锁定（如 beta/rc）时，才手动修改 `Cargo.toml`。

## DO / DON'T

- 使用 `#[frb]` 标记需要暴露给 Flutter 的函数。
- 使用 `OnceLock` 管理全局单例。
- 严禁修改 `frb_generated.rs`。
- 注释必须使用中文。
- 必须使用 `use xxx`. 而不是 `xxx:xxx` 使用

## FRB PATTERNS

```rust
#[frb]
pub fn my_api(input: String) -> Result<String, String> { ... }
```

## LINT RULES

- 启用严格 lint，所有警告视为错误 (`-D warnings`)。
- 避免使用 `unwrap()`，优先使用 `?` 或 `expect()`。
