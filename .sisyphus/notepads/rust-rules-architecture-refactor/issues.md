# Issues

（追加记录，不覆盖。）
- 2026-03-05: `flutter analyze --fatal-infos` 在当前环境触发 `pub.dev` 解析失败（`Failed host lookup`），无法完成在线依赖更新；已使用 `--no-pub` 完成代码本体分析兜底。
- 2026-03-05: Rust LSP 诊断因环境缺少 `rust-analyzer.exe` 初始化失败，无法提供 Rust 文件级 LSP diagnostics；通过 `cargo test` + `cargo clippy -D warnings` 替代质量校验。
- 2026-03-05: 已恢复联网后补充验证：`flutter pub get` 成功，`flutter analyze --fatal-infos`（不带 `--no-pub`）通过。

- 2026-03-05: 本会话环境仍无法访问 `pub.dev`，`flutter analyze --fatal-infos` 失败；已确认 `flutter analyze --fatal-infos --no-pub` 通过，待联网后补跑完整分析以满足计划验收口径。
- 2026-03-05: 引入 `cryptography` 后，`flutter analyze --fatal-infos --no-pub` 在 `cryptography` 包内部触发双源类型冲突（`pub cache` 与 `%TMPDIR%` 同名库并存）；已切换为 `pointycastle` 实现 `AES/GCM + HKDF`，规避该环境问题。
- 2026-03-05: 本次尝试通过 `explore/librarian` 子代理并行收敛规则类型方案时，两路调用均在 5 分钟后超时；最终改为直接基于仓库现有模式完成实现与验证。
- 2026-03-05: 为 `Diagnostic` 追加 `ts_rs` 派生时发现 crate 未列入依赖，初始化 `cargo test` 报错；最终回退到纯 `serde` 定义，仍通过 camelCase 序列化并完善字段别名。
