## 1. Project Setup
- [ ] 1.1 In `rust/Cargo.toml`, add dependencies: `serde`, `serde_json`. Add `ts-rs` with the `chrono` feature if using timestamps. Ensure `flutter_rust_bridge` is updated.
- [ ] 1.2 Create `rust/src/domain/types.rs` logic module to house crawler rule structural definitions.

## 2. Rust Domain Modelling
- [ ] 2.1 Define enums for Operator definitions (e.g., `NodeOperator`, `Transformation`).
- [ ] 2.2 Define structures for `PipelineNode`, `NetworkConfig`, `ExploreConfig`, `AuthStrategy` etc., fully deriving `Serialize`, `Deserialize`, and `TS`. Add `#[frb(dart_metadata=("freezed"))]` tags.
- [ ] 2.3 Expose the structures into the FFI by defining dummy or valid API boundaries in `rust/src/api/crawler_models.rs` so FRB detects and translates them.

## 3. Toolchain & Code Generation Execution
- [ ] 3.1 Execute `cargo test` in the `rust` directory to trigger the `ts-rs` macro, proving generation of `.ts` interfaces directly into the `web-editor/src/types/` destination directory.
- [ ] 3.2 Execute `flutter_rust_bridge_codegen generate` to generate `.freezed.dart` models.

## 4. Cleaning Legacy Dart Models
- [ ] 4.1 Delete the entirety of `lib/core/crawler/models/`.
- [ ] 4.2 Fix import statements globally across the Flutter app (e.g., `lib/features/crawler/`) from local model paths to `lib/rust/api/`. Fix any field casing mismatches caused by the new unified generated models.
- [ ] 4.3 Validate `flutter analyze` shows absolutely zero warnings across the entire Dart codebase.