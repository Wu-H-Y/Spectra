## ADDED Requirements

### Requirement: Centralized Rust Models
The system MUST define all crawling rule primitives (`PipelineNode`, `CrawlerRule`, `NetworkConfig`) exclusively as Rust structures to act as the single source of truth.

#### Scenario: Rule Parsing
- **WHEN** a JSON crawling rule is evaluated by the FFI
- **THEN** it strictly deserializes into the Rust types via `serde`

### Requirement: Dart Code Generation
The system MUST automatically transpose the Rust structures into Dart `freezed` classes via FRB macros.

#### Scenario: Build Step
- **WHEN** `flutter_rust_bridge_codegen` is invoked
- **THEN** it generates immutable Dart classes mapping mapping exactly to the Rust properties

### Requirement: TypeScript Interface Generation
The system MUST automatically output TypeScript interfaces to the React development folder representing the core rule models.

#### Scenario: Rust Compilation
- **WHEN** `cargo test` is executed for the `ts-rs` macros
- **THEN** matching `.ts` definitions are generated inside `web-editor/src/types/`
