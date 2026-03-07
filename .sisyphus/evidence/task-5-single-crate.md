# Task 5 - Single crate Rust migration

## 完成摘要

- `rust/Cargo.toml` 已收敛为单一 `spectra_native` crate manifest，不再包含 `[workspace]`、members 或 path crate 依赖。
- 手写 Rust 代码已全部迁入 `rust/src/**`：`ffi`、`rules_ir`、`rules_validate`、`rules_engine`、`io_http`、`bin/export_ts.rs`。
- `rust/src/api`、`rust/crates/*` 与陈旧 `lib/core/rust/third_party/rules_ir/**` 已删除，避免未来代理误恢复旧布局。
- FRB 入口已切换到 `crate::ffi, crate::rules_ir::normalized_model`，生成 `rust/src/frb_generated.rs`、`lib/core/rust/ffi.dart` 与 `lib/core/rust/rules_ir/normalized_model.dart`。
- Flutter 侧保留 `lib/core/rust/api.dart` 作为稳定兼容层，仅导出 `ffi.dart`，从而不再依赖已移除的 `crate::api`。

## 验证命令

```bash
cd rust && cargo test
cd rust && cargo clippy --all-targets --all-features -- -D warnings
C:\Users\13690\.cargo\bin\flutter_rust_bridge_codegen.exe generate
bun run build:web
flutter analyze lib/core/rust
flutter test test/ffi_rule_api_test.dart
```

## 验证结果

- `cargo test`：通过。
- `cargo clippy --all-targets --all-features -- -D warnings`：通过。
- `flutter_rust_bridge_codegen.exe generate`：通过。
- `bun run build:web`：通过。
- `flutter analyze lib/core/rust`：通过。
- `flutter test test/ffi_rule_api_test.dart`：通过。
