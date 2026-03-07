# Task 9 - NormalizedModel FRB 生成收口证据

## 结论

- 最终 FRB 配置保持为 `crate::api, rules_ir::normalized_model`，对应 `rust_root: rust/`、`dart_output: lib/core/rust`。
- 本次收口的真正阻塞点是：Rust canonical model 中带 `#[serde(default)]` 的集合/映射字段，没有在 FRB 生成的 Dart Freezed 构造参数里带出默认值，导致 `build_runner` 无法填充必填参数。
- 现在 `lib/core/rust/third_party/rules_ir/normalized_model.dart`、`lib/core/rust/third_party/rules_ir/normalized_model.freezed.dart`、`lib/core/rust/third_party/rules_ir/normalized_model.g.dart` 已重新生成完成。

## 根因

- `flutter_rust_bridge_codegen 2.11.1` 会把 Rust struct 字段级 `#[frb(default = ...)]` 正确转换为 Freezed `@Default(...)`。
- 但同版本不会把 Rust struct 字段级 `dart_metadata` 透传到生成的 Freezed 构造参数。
- 仓库主 `build.yaml` 为 `json_serializable` 全局启用了 `field_rename: snake`，因此如果继续让 FRB 内置 build_runner 直接跑主配置，`mediaType` 这类 camelCase 必填字段仍会失败。

## 代码变更

### Canonical Rust 默认值

文件：`rust/crates/rules_ir/src/normalized_model.rs`

- `SearchModel.items` 增加 `#[frb(default = "const <SearchItem>[]")]`
- `DetailModel.tags` 增加 `#[frb(default = "const <String>[]")]`
- `TocModel.chapters` 增加 `#[frb(default = "const <ChapterItem>[]")]`
- `ContentModel.media_assets` 增加 `#[frb(default = "const <MediaAsset>[]")]`
- `MediaSpec.extra` 增加 `#[frb(default = "const <String, String>{}")]`

### 生成链调整

文件：`flutter_rust_bridge.yaml`

- 保持：
  - `rust_input: crate::api, rules_ir::normalized_model`
  - `rust_root: rust/`
  - `dart_output: lib/core/rust`
- 新增：`build_runner: false`

文件：`build.frb.yaml`

- 新增 FRB 专用 `build_runner` 配置，仅处理 `lib/core/rust/third_party/**/*.dart`
- 在该配置下显式将 `json_serializable.field_rename` 固定为 `none`

## 生成结果

- `lib/core/rust/third_party/rules_ir/normalized_model.dart`
  - `mediaAssets`、`tags`、`chapters`、`items`、`extra` 已带 `@Default(...)`
- `lib/core/rust/third_party/rules_ir/normalized_model.g.dart`
  - JSON key 已保持 camelCase：`contentTextHtml`、`contentTextPlain`、`mediaAssets`、`mediaType`

## 验证命令

1. `C:\Users\13690\.cargo\bin\flutter_rust_bridge_codegen.exe generate`
   - 结果：通过
2. `flutter pub run build_runner build --config frb --delete-conflicting-outputs --build-filter lib/core/rust/third_party/rules_ir/normalized_model.freezed.dart --build-filter lib/core/rust/third_party/rules_ir/normalized_model.g.dart`
   - 结果：通过
3. `flutter analyze lib/core/rust`
   - 结果：通过，`No issues found!`
4. `cd rust && cargo test -p rules_ir`
   - 结果：通过，`8 passed; 0 failed`
5. `cd rust && cargo clippy -p rules_ir --all-targets --all-features -- -D warnings`
   - 结果：通过

## 备注

- 本次没有回退到手写 Dart model。
- 本次没有扩大 FRB 扫描范围，仍使用用户确认的最终扫描入口。
- 当前环境未安装 `yaml-language-server`，因此 YAML 文件未执行 LSP 诊断；配置正确性已通过实际生成命令验证。

## 2026-03-07 仓库现状复核追加

- 复核计划要求后确认，Task 9 在今天仓库状态下仍有一个真实缺口：`rust/crates/rules_ir/src/normalized_model.rs` 的 `ContentModel.media_assets` 只有 `#[serde(default)]`，但没有对应的 `#[frb(default = "const <MediaAsset>[]")]`。
- 该缺口会让 Rust 端接受缺省 `mediaAssets` 并回退为空数组，而 FRB 生成的 Dart `ContentModel` 却把 `mediaAssets` 视为无默认值的必填参数，导致 Rust/Dart 契约不完全一致。
- 已在 canonical source 中补上 `#[frb(default = "const <MediaAsset>[]")]`，并重新执行 `C:\Users\13690\.cargo\bin\flutter_rust_bridge_codegen.exe generate`。
- 当前仓库事实与旧证据不同：仓库根目录只有 `build.yaml`，且 `json_serializable.field_rename` 已为 `none`；未发现也未恢复 `build.frb.yaml`。
- 重新生成后，`lib/core/rust/third_party/rules_ir/normalized_model.dart` 中的 `ContentModel.mediaAssets` 已变为 `@Default(const <MediaAsset>[]) List<MediaAsset> mediaAssets`；`lib/core/rust/third_party/rules_ir/normalized_model.g.dart` 的 `fromJson` 也已对缺省 `mediaAssets` 回退为空数组。

## 2026-03-07 验证记录

1. `C:\Users\13690\.cargo\bin\flutter_rust_bridge_codegen.exe generate`
   - 结果：通过；重新生成 `lib/core/rust/third_party/rules_ir/normalized_model.dart`、`lib/core/rust/third_party/rules_ir/normalized_model.freezed.dart`、`lib/core/rust/third_party/rules_ir/normalized_model.g.dart`
2. `cd rust && cargo test -p rules_ir`
   - 结果：通过，`8 passed; 0 failed`
3. `cd rust && cargo clippy -p rules_ir --all-targets --all-features -- -D warnings`
   - 结果：通过
4. `bun run build:web`
   - 结果：通过，Vite 生产构建完成
5. `flutter analyze lib/core/rust`
   - 结果：通过，`No issues found!`
6. `lsp_diagnostics rust/crates/rules_ir/src/normalized_model.rs`
   - 结果：`No diagnostics found`
7. `lsp_diagnostics lib/core/rust/third_party/rules_ir/normalized_model.dart`
   - 结果：`No diagnostics found`

## 2026-03-07 最终结论

- Search / Detail / Toc / Content 四类最小字段集保持不变并满足计划定义。
- `video/music/novel/comic/image` 仍作为 `MediaExtension` 的可选扩展字段存在。
- Task 9 现在基于今天的仓库状态重新满足“Rust / TS / Dart 三端契约一致”的验收目标，且无需恢复任何手写 Dart model 或额外生成配置。

## 2026-03-07 当前仓库二次复核

- 本轮按用户要求重新以当前仓库事实复核 Task 9，没有再发现新的代码缺口，因此未修改 `rust/src/rules_ir/normalized_model.rs`、`web-editor/src/types/*.ts` 或 `lib/core/rust/rules_ir/normalized_model.dart`。
- 当前 canonical source 为 `rust/src/rules_ir/normalized_model.rs`，其中：
  - `NormalizedModel` 只包含 `search/detail/toc/content/media` 五个顶层字段。
  - `SearchModel.items`、`DetailModel.tags`、`TocModel.chapters`、`ContentModel.mediaAssets`、`MediaSpec.extra` 均保持默认空集合语义。
  - `MediaExtension` 仅承载 `video/music/novel/comic/image` 五类可选扩展字段。
- 当前生成物与真源一致：
  - `web-editor/src/types/NormalizedModel.ts`、`ContentModel.ts`、`MediaAsset.ts` 显示 camelCase 字段名 `contentTextHtml`、`mediaAssets`、`mediaType`。
  - `lib/core/rust/rules_ir/normalized_model.dart` 显示 `@Default(const <MediaAsset>[]) List<MediaAsset> mediaAssets` 与 `@Default(MediaType.video) MediaType mediaType`，默认值语义与 Rust 一致。
- 当前仓库根 `build.yaml` 也已明确 `json_serializable.field_rename: none`，因此旧证据中关于 `build.frb.yaml` 或 `snake` 重命名的描述属于历史信息，不适用于今天的仓库状态。

## 2026-03-07 本轮验证命令

1. `cargo test rules_ir`
   - 结果：通过，`8 passed; 0 failed`
2. `cargo clippy --all-targets --all-features -- -D warnings`
   - 结果：通过
3. `bun run build:web`
   - 结果：通过，`tsc -b && vite build` 完成
4. `flutter analyze lib/core/rust`
   - 结果：通过，`No issues found!`
5. `lsp_diagnostics rust/src/rules_ir/normalized_model.rs`
   - 结果：`No diagnostics found`
6. `lsp_diagnostics lib/core/rust/rules_ir/normalized_model.dart`
   - 结果：`No diagnostics found`
7. `bd --version`
   - 结果：失败，当前环境仍无 `bd` CLI；该阻塞已同步记录到 notepad，但不影响 Task 9 代码与验收结论。
