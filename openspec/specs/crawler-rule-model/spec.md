## MODIFIED Requirements

### Requirement: Cross Language Code Generation
The system SHALL treat the Rust domain layer as the Single Source of Truth for all crawling rule models instead of defining them inside Dart (`lib/core/crawler/models/`).

#### Scenario: Rust Struct Definition
- **WHEN** a crawler rule definition (e.g., `PipelineNode`) is modified inside `rust/src/domain/types.rs`
- **THEN** it automatically updates across Dart (`flutter_rust_bridge`) and TypeScript (`ts-rs`) during the compilation step

## REMOVED Requirements

### Requirement: Manual Dart Crawling Models
**Reason:** Severe synchronization issues between the React (TypeScript) Web Editor, Dart Executor, and Rust Parse Engine when manually defining identical schemas.
**Migration:** Delete `lib/core/crawler/models/`, relying completely on the generated `rust/api/` definitions with `freezed` wrappers.