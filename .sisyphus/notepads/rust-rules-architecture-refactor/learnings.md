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
- 2026-03-06: `rules_validate` 的 validator 可先通过 `GraphIndex` 聚合节点/端口引用，再分阶段执行 `phaseEntrypoints`、`normalizedOutputs`、边类型、拓扑环与 capability 校验；这样能保证非法 IR 全部降级为 `Diagnostic`，且诊断码常量集中在单文件内维护。
- 2026-03-06: 只要拓扑算法基于 `GraphIndex` 去重视图构图，遍历完成条件也必须使用同一视图的节点数；否则重复 `node.id` 会让“重复节点”误伤成“图有环”。
- 2026-03-06: `rules_engine` 的 UTF-8 preview 截断在字节上限场景下，应该从 `max_bytes` 向左搜索最近合法字符边界并直接切片；对原字符串末尾反复 `pop()` 会把与边界无关的尾部字符也删掉，导致过度截断。
### 2026-03-06\n- Captured cqrs-es service injection guidance for keeping aggregates infrastructure-free.\n- Logged clean_axum_demo layering patterns (domain traits, DTO validation, AppState wiring).\n- Logged clean-architecture-with-rust use case, repository, and JSON-file adapter separation for CQRS rules engines.\n
- 2026-03-06: `ts-rs` 可通过在 `export_ts` 中额外调用 `NormalizedModel::export_all(&cfg)`，把未被 `RuleEnvelope` 直接引用的规范化模型家族稳定导出到 `web-editor/src/types/*.ts`，无需手写 TS 声明。
- 2026-03-06: Dart 侧用单文件 `json_serializable` 模型承接 Rust 规范化输出时，给构造参数提供默认值即可覆盖缺省 JSON 场景；不要再叠加 `JsonKey.defaultValue`，否则 `build_runner` 会持续给出重复默认值告警。
- 2026-03-06: 若仓库级 `build.yaml` 为 `json_serializable` 统一设置了 `field_rename: snake`，则单个协议模型里已经是 camelCase 的跨端字段必须用显式 `@JsonKey(name: '...')` 锁定；仅靠类级 `@JsonSerializable` 不足以保证生成结果符合协议名。
- 2026-03-06: `rust/.cargo/config.toml` 的 `TS_RS_EXPORT_DIR` 现在采用 `{ value = "web-editor/src/types", relative = true }`，避免 ts-rs 环境把输出解析到 `rust/crates/rules_ir/web-editor`，因此只需维护 repo-root `web-editor/src/types`。
- 2026-03-06: 通过 `rust/.cargo/config.toml` 把 `TS_RS_EXPORT_DIR` 固定指向 `web-editor/src/types`，让 ts-rs 测试导出与主流程一致，并可以在不再需要的情况下清理 `rust/crates/rules_ir/bindings` 目录。
- 2026-03-06: FRB 2.11.1 在 Spectra 里可以直接从 `rules_ir::normalized_model` 自动扫描并生成 Dart 模型到 `lib/core/rust/third_party/rules_ir/normalized_model.dart`；只要 canonical Rust struct/enum 上直接写 `#[frb(json_serializable, unignore)]`，就不再需要手写 Dart model。
- 2026-03-06: 若仓库全局 `json_serializable` 默认策略会把 camelCase 字段改回 snake_case，FRB canonical Rust 字段上可以直接补 `dart_metadata = ("JsonKey(name: '...')" import "package:json_annotation/json_annotation.dart")` 来锁定生成 JSON key。
- 2026-03-06: 当仓库已有全局 `build_runner` builders（如 Riverpod/Freezed/JsonSerializable）时，FRB 生成目录最好走独立 `build.<name>.yaml`；否则 `lib/core/rust/**` 很容易与默认 builders 发生输出冲突。
- 2026-03-06: 对外部 crate 的 canonical struct 直接加 `#[frb(json_serializable, unignore)]`，再通过根 `api` 模块公开 re-export，可以让 FRB 直接在 `lib/core/rust/third_party/<crate>/` 下生成 Dart 模型；这样比保留一套根 crate mirror 壳模型更贴近“Rust 单一真源”。
- 2026-03-06: 对外部 crate 的 FRB 类型导出，最稳路径是在根 API crate 使用 `#[frb(mirror(...))] + #[frb(json_serializable)] + #[frb(unignore)]`，而不是在 Flutter 侧手写镜像模型；这样 `rules_ir` 仍保持 canonical source，Dart 类由 FRB 自动生成。
- 2026-03-06: `MediaSpec.extra` 若保持 `BTreeMap<String, String>`，FRB 会把它降级成 opaque，导致 Dart `json_serializable` 无法生成；切换为 FRB 官方支持的 `HashMap<String, String>` 后，才能稳定得到 Dart `Map<String, String>`。
- 2026-03-06: 当仓库全局 `build.yaml` 把 `json_serializable.field_rename` 设为 `snake` 时，FRB 生成的 `api.dart` 仍可先通过一次临时 `build_runner` 生成正确的 `api.g.dart`，再在 `flutter_rust_bridge.yaml` 用 `build_runner: false` 阻止后续 codegen 把该文件回写坏。
- 2026-03-06: 在 `flutter_rust_bridge_codegen 2.11.1` 中，Rust struct 字段级 `#[frb(default = ...)]` 会正确生成 Freezed `@Default(...)`，适合收口 `#[serde(default)]` 的 `Vec` / `HashMap` 字段；但字段级 `dart_metadata` 不会透传到 Freezed 构造参数，因此不能依赖它修复 camelCase 必填字段的 `json_serializable` 映射。
- 2026-03-06: 对 `lib/core/rust/third_party/**` 这类 FRB 生成模型，若仓库主 `build.yaml` 强制 `field_rename: snake`，最稳工作流是让 `flutter_rust_bridge_codegen generate` 只生成绑定，再用独立 `build.frb.yaml` 执行 `flutter pub run build_runner build --config frb` 生成 `freezed/json` 配套文件。
- 2026-03-06: 移除 `ContentModel`/`MediaAsset` 上的类级 `JsonSerializable(fieldRename: FieldRename.none)` metadata 后 `flutter_rust_bridge_codegen generate`、`flutter analyze lib/core/rust`、`cd rust && cargo test -p rules_ir` 均通过，`mediaAssets`/`mediaType` 相关 build_runner 报错消失。
- 2026-03-07: Task 9 复核发现 `ContentModel.media_assets` 不能只保留 `#[serde(default)]`；若缺少同位的 `#[frb(default = "const <MediaAsset>[]")]`，FRB 生成的 Dart `ContentModel.mediaAssets` 就不会带 `@Default([])`，从而比 Rust 端更严格，破坏跨端契约一致性。
- 2026-03-07: 当前仓库的 Task 9 生成链以根目录 `build.yaml` 为准，且 `json_serializable.field_rename` 已是 `none`；若 evidence 仍提到 `build.frb.yaml`，应视为历史信息，不能据此恢复额外生成配置。
- 2026-03-07: 在 Spectra 当前 FRB 生成链里，若直接扫描 `ffi` crate，生成的便捷函数会落到 `lib/core/rust/third_party/ffi.dart`；若希望 Flutter 继续从 `lib/core/rust/api.dart` 获取主入口，仍需由根 `crate::api` 做一层薄转发。
- 2026-03-07: Task 10 采用最小稳定 DTO 最省时：`FfiDiagnostic` / `FfiValidationResult` / `FfiExecuteContext` / `FfiExecuteError` / `FfiExecuteResponse`，其中执行结果通过 `initialResultJson` 字符串收口，可避免把 `RuntimeValue` 或复杂 union 直接暴露给 Dart。
- 2026-03-07: 在 Spectra 现有 Drift schema 只有自增 `id` 与业务 `ruleId` 的前提下，Task 11 的 `/api/rules` 最稳方案是对外把路由参数 `id` 固定为 Drift 主键，并在响应里额外返回 `ruleId`；这样既不改 schema/migration，也能满足 CRUD 路由与 IR 元数据并存。
- 2026-03-07: Task 10 若已先用 `crates/ffi` 落地，后续做架构清理时最稳路径是把整段 validate/execute 真实逻辑与单测原样迁回 `rust/src/api/mod.rs`，再删除 workspace 中的 `ffi` crate；这样外部 Dart API 可以保持不变，只更新 codegen hash。
- 2026-03-07: 单 crate 收尾后，FRB 2.11.1 在当前仓库会把根模块扫描结果生成到 `lib/core/rust/ffi.dart` 与 `lib/core/rust/rules_ir/normalized_model.dart`；历史 `third_party/rules_ir/**` 是陈旧产物，需要手动清理。
- 2026-03-07: 为保持 Flutter 侧导入稳定，`lib/core/rust/api.dart` 最稳做法是改成手写薄兼容层（仅 `export 'ffi.dart';`），而不是继续依赖已不存在的 `crate::api` 生成产物。
- 2026-03-07: 本轮 Task 9 二次复核确认，当前仓库中 `rust/src/rules_ir/normalized_model.rs`、`web-editor/src/types/*.ts` 与 `lib/core/rust/rules_ir/normalized_model.dart` 已在字段名与默认值语义上保持一致；若未来仅做复核，不需要为了“补任务”而强行重跑生成链或恢复历史 `third_party` 路径。
- 2026-03-07: 当前 repo-root `build.yaml` 已把 `json_serializable.field_rename` 固定为 `none`，因此判断跨端模型是否漂移时，应优先看今天的 `build.yaml` 与实际生成物，而不是沿用旧 evidence 里的 `build.frb.yaml` / `snake` 结论。
- 2026-03-07: Task 12 落地 `/api/rules/validate`，直接调用 Rust `validateRule` 返还 `valid` 与结构化 diagnostics，并新增 HTTP 测试覆盖 `fixtures/ir_v1_invalid_edge.json` 的错误路径。
- 2026-03-07: Task 16 复用 `fixtures/ir_v1_min.json` 的最小 `search input -> search output` 结构作为图编辑器默认链最稳；前端只要把 ReactFlow 节点位置落到 `RuleEnvelope.graph.layout.nodes`，并按 `input/output` 节点推导 `phaseEntrypoints` / `normalizedOutputs`，就能在不手改生成类型的前提下完成保存与重载闭环。
