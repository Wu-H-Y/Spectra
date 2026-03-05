# Learnings

（追加记录，不覆盖。）

- 2026-03-05: 汇总 Cargo 工作区重构指导（集中继承 workspace.package/workspace.dependencies、通过 resolver=2 控制构建边界、保持特性加法性并利用 pub(in)/pub(crate) 约束模块暴露、避免除 dev-dependencies 以外的循环依赖）。- 2026-03-05: Cargo 官方文档强调 root manifest 同时含 [workspace]+[package] 即为根包，可用 workspace.package / workspace.dependencies 共享版本并在 members/default-members 控制 build 范围；FRB 文档指出自动生成代码可 gitignore 并用 flutter_rust_bridge_codegen generate --watch 重新生成，添加到工作区前需删掉 rust Cargo.lock 并可自定义库加载路径。
- 2026-03-05: 在根包与 workspace 共存时，为保证 `cargo test`/`cargo clippy` 默认覆盖新增成员，需要显式配置 `default-members`；否则命令可能只覆盖根包，导致新 crate 未被验证。
- 2026-03-05: 执行“硬删除 FRB 生成物”时，Dart 侧必须同步移除 `frb_generated.dart` 导入与 `RustLib.init()` 调用，否则会在分析阶段出现悬挂引用。
- 2026-03-05: `rust/src` 仅保留手写 `lib.rs` 时，历史模块目录即使为空也应清理，避免后续误判为迁移未完成；同时保持 workspace 成员最小 `lib.rs` 存根可确保 `cargo test` 与严格 clippy 快速通过。

- 2026-03-05: 调研 `package:cryptography` 中 AES-GCM/ChaCha20-Poly1305 与 HKDF 的文档与示例；确认 `cryptography` 示例与 Vania 框架落地做法可直接参考 Spectra。

- 2026-03-05: `ts-rs` v12 的 `TS::export(_cfg)` 需要显式传入 `ts_rs::Config`；通过在 `rules_ir` 新增 `src/bin/export_ts.rs` 并使用 `Config::new().with_out_dir("web-editor/src/types")` 可稳定生成 TS 类型到 `web-editor/src/types/*.ts`。
- 2026-03-05: 在 `rules_ir` 做 Task 6 类型面时，`Graph` 新增字段需全部采用 `Option` 与 `#[serde(default)]` 组合，才能保证旧 fixture 在不含 `metadata/layout` 的情况下继续反序列化通过。
- 2026-03-05: `NodeLayout` 使用 `f64` 坐标时，不应让上层结构强制 `Eq` 派生；对含布局浮点字段的结构改用 `PartialEq` 可以消除 trait 约束冲突并保持序列化能力。
- 2026-03-05: 在 `rules_ir` 补全 `Diagnostic` 类型，确保 `code`/`severity`/`path`/`nodeId`/`message` 均采用 camelCase 序列化，并通过 `DiagnosticCode`/`DiagnosticPath`/`DiagnosticNodeId`/`DiagnosticMessage` 别名提升语义可读性。
