# Task 10 - Rust FFI validate/execute

## 实现摘要

- 在 `rust/crates/ffi/src/lib.rs` 新增最小 DTO：`FfiDiagnostic`、`FfiValidationResult`、`FfiExecuteContext`、`FfiExecuteError`、`FfiExecuteResponse`。
- 在 `rust/crates/ffi/src/lib.rs` 暴露 `validate_rule(envelope_json)` 与 `execute_rule(envelope_json, context)`；其中 `execute_rule` 先校验，成功后再调用 `rules_engine::execute_rule`。
- 在 `rust/src/api/mod.rs` 通过根 `crate::api` 做薄转发，让 FRB 继续把主入口生成到 `lib/core/rust/api.dart`，并在 Dart 侧得到 `validateRule(...)` / `executeRule(...)`。
- `execute_rule` 成功时返回 `runId` 与可选 `initialResultJson`；失败时返回结构化 `error`，不让 panic 穿透边界。
- 新增 `test/ffi_rule_api_test.dart`，使用 `RustLib.initMock(...)` 验证 Dart 侧新 API 的调用面。

## 验证命令

```bash
cd rust && cargo test -p ffi
cd rust && cargo clippy -p ffi --all-targets --all-features -- -D warnings
cd rust && cargo test --workspace
C:\Users\13690\.cargo\bin\flutter_rust_bridge_codegen.exe generate
flutter analyze lib/core/rust
flutter test test/ffi_rule_api_test.dart
```

## 验证结果

- `cargo test -p ffi`：通过（4/4 测试通过）。
- `cargo clippy -p ffi --all-targets --all-features -- -D warnings`：通过。
- `cargo test --workspace`：通过。
- `flutter_rust_bridge_codegen generate`：通过；仅保留既有 `ProtocolVersionV1` 跳过提示，不影响生成。
- `flutter analyze lib/core/rust`：通过，无诊断。
- `flutter test test/ffi_rule_api_test.dart`：通过（2/2 测试通过）。

## 备注

- 为了让根 `crate::api` 能调用 workspace 内的 `ffi` crate，并让 `lib/core/rust/api.dart` 生成主入口，本任务额外最小修改了 `rust/Cargo.toml` 为根 crate 增加 `ffi` 依赖；这是保持 `crate::api` 薄转发所必需的连接变更。
- 生成链切回根 `crate::api` 后，历史遗留的 `lib/core/rust/third_party/ffi.dart` 已手动删除，最终产物不再依赖该文件。

## 2026-03-07 架构清理追加

- 已按新基线把 Task 10 的真实 validate/execute 实现与单测全部收口到 `rust/src/api/mod.rs`，删除了根 `crate::api` 到 `crates/ffi` 的转发镜像。
- 已删除 `rust/crates/ffi/src/lib.rs` 与 `rust/crates/ffi/Cargo.toml`，并同步清理 `rust/Cargo.toml` 中的 workspace member / workspace dependency / root dependency 引用。
- `flutter_rust_bridge.yaml` 未调整；生成后的 `lib/core/rust/api.dart` 仍稳定提供 `validateRule(...)` 与 `executeRule(...)`。

### 本轮验证命令

```bash
cd rust && cargo test --workspace
cd rust && cargo clippy --all-targets --all-features -- -D warnings
C:\Users\13690\.cargo\bin\flutter_rust_bridge_codegen.exe generate
flutter analyze lib/core/rust
flutter test test/ffi_rule_api_test.dart
```

### 本轮验证结果

- `cargo test --workspace`：通过（根 crate `api::tests::*` 4 条用例通过）。
- `cargo clippy --all-targets --all-features -- -D warnings`：通过。
- `flutter_rust_bridge_codegen generate`：通过；仅保留既有 `ProtocolVersionV1` 跳过提示，不影响生成。
- `flutter analyze lib/core/rust`：通过。
- `flutter test test/ffi_rule_api_test.dart`：通过。

## 2026-03-07 单 crate finishing pass 追加

- `rust/src/rules_engine/mod.rs` 已补齐为根 crate 内的真实执行引擎实现，所有 `rules_engine`/`rules_validate`/`rules_ir` 依赖已改为 `crate::...` 根模块引用。
- `rust/src/api` 与整个 `rust/crates` 目录树已物理删除；当前手写 Rust 仅位于 `rust/src/**`。
- FRB 最终生成入口为 `crate::ffi, crate::rules_ir::normalized_model`；生成产物实际落在 `lib/core/rust/ffi.dart` 与 `lib/core/rust/rules_ir/normalized_model.dart`。
- 为保持 Flutter 侧稳定导入，`lib/core/rust/api.dart` 已改为手写兼容层，仅重新导出 `ffi.dart`。

### 本轮验证命令

```bash
cd rust && cargo test
cd rust && cargo clippy --all-targets --all-features -- -D warnings
C:\Users\13690\.cargo\bin\flutter_rust_bridge_codegen.exe generate
bun run build:web
flutter analyze lib/core/rust
flutter test test/ffi_rule_api_test.dart
```

### 本轮验证结果

- `cargo test`：通过（`spectra_native` 单 crate 22/22 测试通过）。
- `cargo clippy --all-targets --all-features -- -D warnings`：通过。
- `flutter_rust_bridge_codegen.exe generate`：通过；仅保留 `ProtocolVersionV1` 的既有 skip 提示，不影响生成。
- `bun run build:web`：通过。
- `flutter analyze lib/core/rust`：通过。
- `flutter test test/ffi_rule_api_test.dart`：通过（2/2 测试通过）。
