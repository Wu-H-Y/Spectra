# Issues

（追加记录，不覆盖。）
- 2026-03-05: `flutter analyze --fatal-infos` 在当前环境触发 `pub.dev` 解析失败（`Failed host lookup`），无法完成在线依赖更新；已使用 `--no-pub` 完成代码本体分析兜底。
- 2026-03-05: Rust LSP 诊断因环境缺少 `rust-analyzer.exe` 初始化失败，无法提供 Rust 文件级 LSP diagnostics；通过 `cargo test` + `cargo clippy -D warnings` 替代质量校验。
- 2026-03-05: 已恢复联网后补充验证：`flutter pub get` 成功，`flutter analyze --fatal-infos`（不带 `--no-pub`）通过。

- 2026-03-05: 本会话环境仍无法访问 `pub.dev`，`flutter analyze --fatal-infos` 失败；已确认 `flutter analyze --fatal-infos --no-pub` 通过，待联网后补跑完整分析以满足计划验收口径。
- 2026-03-05: 引入 `cryptography` 后，`flutter analyze --fatal-infos --no-pub` 在 `cryptography` 包内部触发双源类型冲突（`pub cache` 与 `%TMPDIR%` 同名库并存）；已切换为 `pointycastle` 实现 `AES/GCM + HKDF`，规避该环境问题。
- 2026-03-05: 本次尝试通过 `explore/librarian` 子代理并行收敛规则类型方案时，两路调用均在 5 分钟后超时；最终改为直接基于仓库现有模式完成实现与验证。
- 2026-03-05: 为 `Diagnostic` 追加 `ts_rs` 派生时发现 crate 未列入依赖，初始化 `cargo test` 报错；最终回退到纯 `serde` 定义，仍通过 camelCase 序列化并完善字段别名。
- 2026-03-06: 当前 shell 不提供 `bd` CLI（`bd --version` 返回“not recognized”），因此本次 Task 7 未使用 Beads 跟踪，但不影响代码实现、测试与证据产出。
- 2026-03-06: 回归修复过程中，`cargo test` 先暴露了 `validate_topology` 的闲置参数告警；在仓库要求 `clippy -D warnings` 的前提下，必须同步收紧函数签名，否则 `bun run lint:rust` 会失败。
- 2026-03-06: Task 8 重试时，`bun run lint:rust` 暴露出测试中 `assert_eq!(bool, true)` 的 Clippy 违规；虽然与 UTF-8 根因无关，但若不一起收敛，验收命令无法通过。
- 2026-03-06: 当前环境未安装 `typescript-language-server`，无法对 `web-editor/src/types/*.ts` 执行 LSP diagnostics；本次改以 `bun run build:web`（包含 `tsc -b`）作为 TypeScript 类型验收兜底。
- 2026-03-06: Task 9 Dart retry 发现 `build.yaml` 的全局 `json_serializable.field_rename: snake` 会覆盖协议模型的自然 camelCase 输出；若不在字段级显式命名，生成的 `.g.dart` 会与 Rust/TS 契约漂移。
- 2026-03-06: 先前 `.cargo/config.toml` 的 `TS_RS_EXPORT_DIR` 缺少 `relative = true`，导致 ts-rs 测试导出写入 `rust/crates/rules_ir/web-editor/src/types`；已删除该目录并通过 `relative = true` 固定输出。
- 2026-03-06: FRB 2.11.1 宏在 `cargo clippy -D warnings` 下会触发 `unexpected_cfgs`（`frb_expand`）；本次通过在 `rules_ir/Cargo.toml` 仅对该 crate 放宽 `unexpected_cfgs` lint 收口，避免影响其他包的严格 lint。
- 2026-03-06: `flutter_rust_bridge_codegen` CLI 实际来自 Cargo 安装，不是 pub 依赖；当前环境已安装，但 PATH 未包含 `C:\Users\13690\.cargo\bin`，因此需要用绝对路径执行。
- 2026-03-06: FRB 默认尝试在 workspace 内自动升级 `flutter_rust_bridge` 依赖；若根 crate / canonical crate 未 pin 到 `=2.11.1`，生成日志会持续出现 `cargo add` 失败噪声。
- 2026-03-06: 仓库默认 `build_runner` 配置会让 FRB 生成的 `lib/core/rust/**` 与 Riverpod/Freezed 等 builder 发生输出冲突，因此 Task 9 最终采用独立 `build.frb.yaml` 作为专用生成链。
- 2026-03-06: `flutter_rust_bridge_codegen generate` 在 Cargo workspace 下会尝试自动执行不带 `--package` 的 `cargo add flutter_rust_bridge@=2.11.1`，因此会输出 warning；该 warning 不影响 codegen 退出码，但若要彻底消除，需要上游工具支持 workspace root package 选择。
- 2026-03-06: `analysis_options.yaml` 补充 `flutter_rust_bridge-master/**` 到 `analyzer.exclude`，以确保 `flutter analyze` 不再报告 vendored FRB 源的错误。
- 2026-03-06: 在 `flutter_rust_bridge_codegen 2.11.1` 中，Rust struct 字段级 `dart_metadata` 不会透传到生成的 Freezed 构造参数；因此即便 Rust canonical 字段声明了 `JsonKey(name: 'mediaType')`，仓库主 `build.yaml` 的 `json_serializable.field_rename: snake` 仍会让 `mediaType` 这类必填 camelCase 字段在 build_runner 阶段失败。
- 2026-03-06: 当前环境未安装 `yaml-language-server`，因此 `flutter_rust_bridge.yaml` 与 `build.frb.yaml` 本次未能执行 YAML LSP 诊断；已改用 `flutter_rust_bridge_codegen generate` 与 `flutter pub run build_runner build --config frb` 的实际结果作为配置正确性的验证依据。
- 2026-03-06: Task 9 FRB 生成依旧在 `ContentModel`/`MediaAsset` 上附带 `JsonSerializable(fieldRename: FieldRename.none)` 时，`mediaAssets`/`mediaType` build_runner 直接报错；删除类级 metadata 后问题消失。
- 2026-03-07: 本次 Task 9 复核再次尝试 `bd --version`，当前 shell 仍返回“`bd` is not recognized as an internal or external command”，因此无法按 Beads CLI 记录任务进度；已改为仅在 notepad/evidence 中追加阻塞与结论，不影响本任务验收。
- 2026-03-07: Task 10 生成绑定时，历史遗留的 `lib/core/rust/third_party/ffi.dart` 不会因恢复 `rust_input: crate::api, rules_ir::normalized_model` 自动删除；需在确认 `frb_generated*.dart` 已不再引用后手动清理该陈旧生成物。
- 2026-03-07: Task 11 当前 shell 依旧不可用 `bd` CLI，因此本次未按 Beads 记录执行轨迹，改为仅在 `.sisyphus/evidence/task-11-crud.md` 与 notepad 追加证据，不影响 CRUD 实现与验收。
- 2026-03-07: 本轮单 crate 收尾尝试在 `flutter_rust_bridge.yaml` 显式配置 `rust_output` 时，Windows 路径归一化会报 `prefix not found`；最终回退到默认 `generate` 流程，并保留已正确生成的 `rust/src/frb_generated.rs`。
- 2026-03-07: 本轮 Task 9 复核再次确认当前 shell 中 `bd --version` 仍返回“`bd` is not recognized as an internal or external command`”，因此无法按 Beads CLI 落库，只能继续以 evidence + notepad 记录执行轨迹。
- 2026-03-07: Task 16 验证阶段尝试对 `web-editor/src/**/*.ts(x)` 执行 LSP diagnostics 时，当前环境缺少 `typescript-language-server` 与 `biome` 二进制；本次改以 `bun run lint`、`bun run fmt:check`、`bun run build` 和 focused QA 脚本作为 TypeScript 质量门禁兜底。
