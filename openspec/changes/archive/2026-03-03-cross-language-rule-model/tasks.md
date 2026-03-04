## 1. Project Setup
- [x] 1.1 In `rust/Cargo.toml`, add dependencies: `serde`, `serde_json`, `ts-rs` (with the `chrono` feature). Ensure `flutter_rust_bridge` is appropriately configured for model generation.
- [x] 1.2 Create directory `rust/src/domain/rule/` to house the new crawler rule structural definitions.

## 2. Rust Domain Modelling (Replacement Pipeline)
- [x] 2.1 Recreate the root rule structure in `rust/src/domain/rule/crawler_rule.rs`: Define `CrawlerRule` holding metadata, `NetworkConfig`, `AggregationConfig`, and a `Lifecycle` container. Fully derive `Serialize`, `Deserialize`, and `TS`. Add `#[frb(dart_metadata=("freezed"))]` tags.
- [x] 2.2 Recreate the network models in `rust/src/domain/rule/network.rs`: Define `NetworkConfig`, `ProxyConfig`, `FallbackConfig`, and `TlsFingerprint` (enums mapping to Chrome/Firefox emulation).
- [x] 2.3 Recreate the pipeline executor models in `rust/src/domain/rule/pipeline.rs`: Define `PipelineNode` as an enum (`Selector`, `Transform`, `Aggregation`) to logically replace the deleted `PipelineNode` models. Use `serde(tag = "type")` for clean JSON mapping.
- [x] 2.4 Recreate the lifecycle models in `rust/src/domain/rule/lifecycle.rs`: Define `ExploreConfig`, `SearchConfig`, `DetailConfig`, `TocConfig`, and `ContentConfig` matching the deleted Dart schemas.
- [x] 2.5 Expose the structures into the FFI by defining dummy or valid API boundaries in `rust/src/api/crawler_models.rs` so FRB detects and translates them.

## 3. Toolchain & Code Generation Execution
- [x] 3.1 Execute `cargo test` in the `rust` directory to trigger the `ts-rs` macro, proving generation of `.ts` interfaces directly into the `web-editor/src/types/` destination directory.
- [x] 3.2 Execute `flutter_rust_bridge_codegen generate` to generate `.freezed.dart` models.

## 4. UI/Dart Model Synchronization
- [x] 4.1 Verify the generated FRB models successfully replace the deleted `lib/core/crawler/models/`.
- [x] 4.2 Fix import statements globally across the Flutter app (e.g., `lib/features/crawler/`) routing them to the new `lib/rust/api/` definitions. Fix any field casing mismatches (Rust snake_case -> Dart camelCase) via FRB configuration.
- [x] 4.3 Validate `flutter analyze` shows exactly zero warnings related to missing models across the codebase.