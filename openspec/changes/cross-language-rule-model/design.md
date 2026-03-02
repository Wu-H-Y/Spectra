## Context

With three disparate frontend/backend systems interacting with the same structured data (Dart managing the crawler, Rust executing the parsing, and React/TypeScript building the rules visually), maintaining JSON schemas by hand is highly error-prone. The `PipelineNode`, `NetworkConfig`, and `FallbackStrategy` structures are complex. If a developer renames a field in Dart but forgets the React editor, runtime crashes occur.

## Goals / Non-Goals

**Goals:**
- Establish **Rust** as the absolute Single Source of Truth for all domain models related to web crawling rules.
- Automatically generate 100% of the Dart rule models (using `@freezed` via `flutter_rust_bridge`).
- Automatically generate 100% of the TypeScript interfaces for the React Flow editor (using the `ts-rs` crate).
- Eliminate manual JSON serialization bugs across the three languages.

**Non-Goals:**
- Generating Rust code from Dart/TypeScript (the flow is strictly one-way: Rust -> Dart/TS).
- Managing Flutter UI state models (this applies *only* to the crawling rule domain).

## Decisions

**1. Code Generation Flow (Rust -> Dart/TS)**
- **Decision:** Define all crawler rule models (e.g., `PipelineNode`) as basic Rust `struct` and `enum` types in `rust/src/domain/types.rs`.
- **Rationale:** Rust's strong typing, `serde` ecosystem, and powerful macros make it the perfect candidate for hosting domain definitions.

**2. Dart Model Generation**
- **Decision:** Decorate Rust structs with `#[frb(dart_metadata=("freezed"))]`.
- **Rationale:** `flutter_rust_bridge` already supports outputting immutable, serializable Dart classes via `freezed`. This completely removes the need to write `.freezed.dart` boilerplate by hand.

**3. TypeScript Interface Generation**
- **Decision:** Add the `ts-rs` crate to Rust. Decorate structs with `#[derive(TS)]` and `#[ts(export, export_to = "../../web-editor/src/types/rule.ts")]`.
- **Rationale:** Compiling the Rust code using `cargo test` automatically executes the `ts-rs` macros, writing perfectly matching `.ts` interface definitions directly into the React project folder, guaranteeing the editor outputs JSON that Rust can parse.

## Risks / Trade-offs

- **[Risk] Slower initial module setup:** Learning the specific quirks of `ts-rs` and `flutter_rust_bridge` annotations takes time.
  - **Mitigation:** Start with a very simple struct (`HelloWorldNode`) and ensure it generates cleanly down to Dart and TypeScript before converting the massive, nested crawler rules.
- **[Risk] Complex Enums in TypeScript:** Rust's powerful tagged unions (e.g., `enum Node { Css(String), XPath(String) }`) might generate complicated TypeScript types.
  - **Mitigation:** Use `serde(tag = "type", content = "value")` in Rust to force clean, flattened JSON output that maps easily to TypeScript discriminated unions.