# Decisions

（追加记录，不覆盖。）

- 2026-03-05: 计划文件 `.sisyphus/plans/rust-rules-architecture-refactor.md` 保持只读，不直接勾选任务；使用本会话的 TODO 跟踪来“预标记”已在代码库中完成的任务。
- 2026-03-05: 以 `.sisyphus/evidence/task-*.md` + 关键实现文件/命令输出作为“已完成”证据来源；若当前环境离线导致 `flutter analyze --fatal-infos` 失败，则以 `flutter analyze --fatal-infos --no-pub` + 证据记录作为临时通过依据，并在联网环境补跑完整命令。

- 2026-03-05: 在用户请求下，已将计划文件中 Task 0-5 的顶层 checkbox 标记为完成（`- [x]`），对应证据见 `.sisyphus/evidence/task-0-rust-hard-reset.md`、`.sisyphus/evidence/task-1-ir-v1.md`、`.sisyphus/evidence/task-2-nodeevent-protocol.md`、`.sisyphus/evidence/task-3-api-contract.md`、`.sisyphus/evidence/task-4-drift-migration.md`。
- 2026-03-05: 决定通过 `DiagnosticCode`/`DiagnosticPath`/`DiagnosticNodeId`/`DiagnosticMessage` 别名来包装 `Diagnostic` 字段类型，既提升字段语义，也避免为此次更改引入 `ts_rs` 等额外依赖。
- 2026-03-06: Task 7 的 capability gate 先按当前 IR 可表达范围实现为“`supportsPagination=true` 必须存在合法的 `search` 标准化输出且该输出为列表类型”；JS/HTTP/Proxy/WebView 等更细粒度 gate 留待后续节点能力模型落地后再扩展，避免把未建模语义硬编码进 validator。
- 2026-03-06: Task 7 回归修复中，决定保持 `GraphIndex` 作为 validator 的唯一规范视图；重复节点仍单独报 `DUPLICATE_NODE_ID`，但拓扑校验不再把原始 `graph.nodes.len()` 混入环检测判定。
- 2026-03-06: Task 8 重试中继续保持最小 `Join` 语义不变：按输入端口声明顺序收集全部消息；若输出端口类型为 `list<T>`，输出聚合列表，否则输出最后一条消息。本次仅修复 UTF-8 截断与缺失 evidence，不扩展节点功能。
- 2026-03-06: Task 9 保持 `rust/crates/rules_ir/src/normalized_model.rs` 为唯一 canonical source；TypeScript 通过 Rust `export_ts` 生成，Dart 通过 `lib/core/rust/domain/normalized_model.dart` 手写领域模型 + `json_serializable` 生成代码实现跨端字段对齐，不提前引入 Task 10 的 FFI/API 暴露。
- 2026-03-06: Task 9 Dart bugfix 不调整仓库级 `build.yaml`，仅在 `lib/core/rust/domain/normalized_model.dart` 上为协议关键字段增加 `@JsonKey(name: ...)`；这样既修复 camelCase 契约，又避免影响仓库内其他依赖 snake_case 约定的模型。
- 2026-03-06: 决定通过 `.cargo/config.toml` 设定 `TS_RS_EXPORT_DIR` 指向 `web-editor/src/types`，确保 ts-rs 测试产出和手动 `export_ts` 保持一致，同时删除旧的 `rust/crates/rules_ir/bindings` 目录。
- 2026-03-06: 进一步要求 `TS_RS_EXPORT_DIR` 使用 `{ value = ..., relative = true }`，避免 ts-rs 测试导出被解析为 crate 相对路径并产生 `rust/crates/rules_ir/web-editor/`，从根目录统一控制输出目标。
- 2026-03-06: Task 9 最终改为官方 automatic third-party scanning：`flutter_rust_bridge.yaml` 仅扫描 `rules_ir::normalized_model`，并把 `rules_ir` 作为 `NormalizedModel` 家族的唯一 canonical source；显式放弃 root crate mirror duplication 与手写 Dart model。
- 2026-03-06: 用户已明确拒绝 Task 9 的手写 Dart `NormalizedModel` 方案，因此本任务改为“Rust canonical model + FRB 生成 Dart types”，并删除 `lib/core/rust/domain/normalized_model.dart(.g.dart)`。
- 2026-03-06: Task 9 最终将 FRB 标注下沉到 `rust/crates/rules_ir/src/normalized_model.rs`，根 crate `rust/src/lib.rs` 仅保留薄 API 与类型 re-export；Dart 侧以 `lib/core/rust/third_party/rules_ir/normalized_model.dart` 作为生成产物，不再维护第二套手写模型。
- 2026-03-06: 为避免仓库默认 builders 与 FRB 输出冲突，保留主 `build.yaml` 的常规生成职责，同时新增 `build.frb.yaml` 专门生成 `lib/core/rust/**` 的 `freezed/json` 配套文件。
- 2026-03-06: 用户已明确否决手写 Dart `NormalizedModel`；Task 9 最终改为在 `rust/src/lib.rs` 的 `crate::api` 中使用 FRB mirror 暴露 `rules_ir` 外部类型，并删除 `lib/core/rust/domain/normalized_model.dart` / `.g.dart`。
- 2026-03-06: 为避免仓库全局 `json_serializable.field_rename: snake` 破坏 FRB 生成模型的 camelCase JSON key，最终将 `flutter_rust_bridge.yaml` 设为 `build_runner: false`；FRB 仅负责生成绑定，`api.freezed.dart` / `api.g.dart` 由独立 `build_runner` 步骤生成并保留。
- 2026-03-06: Task 9 本轮收口继续保持用户确认的最终扫描入口 `crate::api, rules_ir::normalized_model` 不变；真正修复点放在 `rust/crates/rules_ir/src/normalized_model.rs` 的 canonical field defaults，而不是回退到手写 Dart model 或扩大 FRB 扫描范围。
- 2026-03-06: 因 `flutter_rust_bridge_codegen 2.11.1` 无法把字段级 `dart_metadata` 透传到 Freezed 构造参数，最终决定采用“两段式生成链”：`flutter_rust_bridge_codegen generate` 只生成 FRB 绑定，`flutter pub run build_runner build --config frb` 再为 `lib/core/rust/third_party/**` 单独生成 camelCase 的 `freezed/json` 文件。
- 2026-03-06: 决定去除 `ContentModel` 与 `MediaAsset` 上的类级 `JsonSerializable(fieldRename: FieldRename.none)` metadata，改为只在字段级 `dart_metadata` 为 `JsonKey(name: ...)`，以避免 Freezed 与 class-level JsonSerializable 冲突。
- 2026-03-07: Task 9 本轮按“今天的仓库事实”收口：保留 `rust/crates/rules_ir/src/normalized_model.rs` 作为唯一 canonical source，仅补 `ContentModel.media_assets` 的 FRB 默认值，不恢复任何手写 Dart model，也不恢复历史 evidence 中提到但当前仓库已不存在的 `build.frb.yaml`。
- 2026-03-07: Task 10 决定按最小边界实现 FFI：`ffi` crate 只接受 `envelope_json + Option<FfiExecuteContext>`，先调用 `rules_validate::validate_rule`，成功后再调用 `rules_engine::execute_rule`；返回体统一收口为 `run_id + initial_result_json + error`，避免提前设计 server/WS 语义。
- 2026-03-07: 为了让 FRB 继续把便捷入口生成到 `lib/core/rust/api.dart`，Task 10 保持 `flutter_rust_bridge.yaml` 扫描入口为 `crate::api, rules_ir::normalized_model`，并在根 `crate::api` 中仅做 DTO 镜像与 `ffi` 调用转发。
- 2026-03-07: 依据最新用户指示，计划改为直接在 `rust/src/api`（根 crate）实现并暴露 FFI 入口，取消 `crates/ffi` 前置门面，确保 FRB 仅扫描 `crate::api` 且 DTO/逻辑不再重复。
- 2026-03-07: Task 11 保持 server handler 薄实现：DB 读写最小 helper 放在 `AppDatabase`，HTTP 请求解析、鉴权与响应组装集中在新建 `RulesRoutes`，`server_provider.dart` 只负责 token/数据库注入与挂载，不顺手扩展 validate/execute/ws。
- 2026-03-07: 根据用户的 FRB 更正，计划文件改为允许 `flutter_rust_bridge.yaml` 同时扫描多个 `rust_input: crate::xxx`（全部位于 `rust/src/**`），并继续禁止引入第二套 `crates/ffi` 门面或重复 DTO。
- 2026-03-07: Task 10 架构清理最终落地为“唯一手写实现只保留在 `rust/src/api/mod.rs`”；`crates/ffi` crate 从 workspace 中移除并删除文件，`flutter_rust_bridge.yaml` 保持 `crate::api, rules_ir::normalized_model` 不变。
- 2026-03-07: 根据最新指令，Rust 架构基线永久改为单 `spectra_native` crate，所有实现迁入 `rust/src/**`，`rust/crates/*` 仅作为迁移源并在 Task 5 结束后删除，不得再次创建 workspace 或拆分 crate。
- 2026-03-07: 单 crate finishing pass 维持最终入口为 `crate::ffi`；Flutter 侧保留 `lib/core/rust/api.dart` 作为手写兼容导出层，测试与调用统一消费 `ffi.dart` 生成的 `crateFfi*` API。
- 2026-03-07: Task 9 本轮按“无缺口则不改代码”收口：既然当前 `rust/src/rules_ir/normalized_model.rs` 已满足 Search / Detail / Toc / Content 最小字段集与 `MediaExtension` 可选扩展约束，就只补证据与 notepad，不再重跑代码生成或引入任何额外字段调整。
- 2026-03-07: Task 13 在不扩展现有 Dart FFI surface 的前提下，先把 `/api/rules/execute` 与 `/ws` 打通为“协议兼容的最小运行事件流”：HTTP 侧固定回传/注入 `runId`，WebSocket 侧实现 `auth + subscribe/unsubscribe + runId 过滤 + 最近事件回放`，并仅下发 `run_started/run_finished` 两类 `node_event` 生命周期消息；待后续 Rust 真正把 `Vec<NodeEvent>` 暴露到 Flutter 后，再无缝替换为逐条真实节点事件。
- 2026-03-07: Task 15 采用最小 IR-first 迁移：`RuleEditorPage` 主路由改为只编辑 `RuleEnvelope` JSON，并通过 `rulesApi.getEnvelope/createEnvelope/updateEnvelope/validateEnvelope` 对齐 `/api/rules*` 契约；旧表单组件与 `@/api/types` 的 legacy helper types 暂时保留但不再作为主编辑路径，等待后续 Task 16 图编辑器接手。
- 2026-03-07: Task 16 保持“最小但真实”的图编辑器边界：仅支持 `input` / `transform` / `output` 模板节点、真实连线与拖拽布局持久化，不扩展 Task 17 的运行态高亮或更复杂节点配置；`RuleEditorPage` 继续保留 JSON 标签页作为同一份 `RuleEnvelope` 的备用编辑通道。
