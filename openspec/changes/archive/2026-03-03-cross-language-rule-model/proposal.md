## Why

Currently, Spectra's crawler rule models are defined independently. As we move core parsing to Rust and build a visual editor in React (TypeScript), maintaining the same `CrawlerRule`, `PipelineNode`, and `NetworkConfig` models across Dart, Rust, and TypeScript will lead to severe synchronization issues, serialization bugs, and massive mental overhead. We need a "Single Source of Truth" for defining these models.

## What Changes

- **Rust as the Source of Truth**: Move all core rule struct definitions (`Rule`, `PipelineNode`, `NetworkConfig`, `FallbackStrategy`, etc.) into Rust (`rust/src/domain/types.rs`).
- **Dart Code Generation**: Utilize the existing `flutter_rust_bridge` (FRB) to automatically generate `freezed` annotated Dart models from the Rust structs.
- **TypeScript Code Generation**: Introduce `ts-rs` or `typeshare` crates into the Rust project. Decorate Rust structs with `#[derive(TS)]` to automatically output `.ts` interfaces directly into the `web-editor/src/types/` directory during the Rust build process.

## Capabilities

### New Capabilities
- `cross-language-rule-model`: An automated, annotation-driven code generation pipeline that ensures Rust structs are automatically converted into strongly-typed Dart classes and TypeScript interfaces.

### Modified Capabilities
- `crawler-rule-model`: The source of rule definitions is deleted from Dart (`lib/core/crawler/models/`) and migrated to the Rust domain layer. Dart will import the FRB generated models instead.

## Impact

- **Build Process**: The `cargo build` step will now generate TypeScript files. The `flutter_rust_bridge_codegen` step will generate `freezed` Dart classes.
- **Code Deletion**: All manual Dart model files in `lib/core/crawler/models/` will be removed.
- **UI Editor**: The React Flow web editor will consume the generated `.ts` types natively, ensuring the JSON it produces matches exactly what Rust expects to parse.