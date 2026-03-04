## Context

With three disparate frontend/backend systems interacting with the same structured data (Dart managing the crawler, Rust executing the parsing, and React/TypeScript building the rules visually), maintaining JSON schemas by hand is highly error-prone. The legacy Dart models (e.g., `PipelineNode`, `NetworkConfig`, `FallbackStrategy`) have been completely deleted. We must rebuild this entire domain inside Rust.

Crucially, **the new structure must inherently support the React Flow diagramming UI.** The old `crawler_rule.json` architecture (e.g., simple array arrays `["@css:.title", "@text"]`) was overly rigid. The new rules must represent a Directed Acyclic Graph (DAG) architecture where Data flows between distinct visual blocks.

## Goals / Non-Goals

**Goals:**
- Recreate the deleted crawler rule domain models natively in Rust.
- Establish **Rust** as the absolute Single Source of Truth for all domain models related to web crawling rules.
- Design the `Pipeline` specifically to map cleanly to React Flow JSON (`nodes` and `edges`).
- Automatically generate 100% of the Dart rule models (using `@freezed` via `flutter_rust_bridge`).
- Automatically generate 100% of the TypeScript interfaces for the React Flow editor (using the `ts-rs` crate).
- Eliminate manual JSON serialization bugs across the three languages.

**Non-Goals:**
- Generating Rust code from Dart/TypeScript (the flow is strictly one-way: Rust -> Dart/TS).
- Managing Flutter UI state models (this applies *only* to the crawling rule domain).

## Decisions

**1. Code Generation Flow (Rust -> Dart/TS)**
- **Decision:** Define all crawler rule models as basic Rust `struct` and `enum` types in `rust/src/domain/rule/` (e.g., `rule.rs`, `pipeline.rs`, `network.rs`).
- **Rationale:** Rust's strong typing, `serde` ecosystem, and powerful macros make it the perfect candidate for hosting domain definitions.

**2. Core Model Architecture (React Flow Driven)**
- **Decision:** The models will map to a JSON-native structure supporting Node-based execution:
  - `CrawlerRule`: Root structure containing `Metadata`, `NetworkConfig`, `AggregationConfig`, and a `Lifecycle` container mapping to the specific page pipelines.
  - `PipelineGraph`: The overarching container representing a single phase (e.g., Search, Detail). It contains `nodes: Vec<FlowNode>` and `edges: Vec<FlowEdge>`.
  - `FlowNode`: A strongly typed enum containing the graphical position (`x`, `y`) and the core payload (`NodePayload`).
  - `NodePayload`: Defined as an enum:
    - `Selector(SelectorDef)`: Extractor logic (e.g. `Css { selector: String }`, `XPath { query: String }`)
    - `Transform(TransformDef)`: Mutators (e.g. `Regex { pattern: String, replace: String }`, `Trim`)
    - `Aggregation(AggregationDef)`: Joiners & Maps (e.g. `First`, `Join { separator: String }`)
  - `FlowEdge`: Describes the directional parsing flow `sourceNodeId -> targetNodeId`.
- **Rationale:** React Flow natively uses exactly this `nodes` + `edges` array syntax. Defining the exact graph structure in Rust directly prevents the Web GUI from needing ugly mapping logic to display or compile the Crawler Rule JSON.

**3. Advanced Nested Enums for Serialization**
- **Decision:** Use advanced Serde tagging (`#[serde(tag = "type", content = "config")]`) for Node payloads.
- **Rationale:** This instructs Rust to deserialize `{ "type": "Css", "config": { "selector": ".title" } }`, which maps cleanly and directly to a TypeScript Discriminated Union type that the frontend developers can safely interact with via `@xyflow/react`.

**4. Dart Model Generation**
- **Decision:** Decorate Rust structs with `#[frb(dart_metadata=("freezed"))]`.
- **Rationale:** `flutter_rust_bridge` already supports outputting immutable, serializable Dart classes via `freezed`. This completely replaces the 10,000+ lines of `.freezed.dart` boilerplate deleted.

**5. TypeScript Interface Generation**
- **Decision:** Add the `ts-rs` crate to Rust. Decorate structs with `#[derive(TS)]` and `#[ts(export, export_to = "../../web-editor/src/types/rule.ts")]`.
- **Rationale:** Compiling the Rust code automatically outputs perfectly matching `.ts` interface definitions mapping visually to the `NodeData` interface of React Flow.

## Risks / Trade-offs

- **[Risk] Complex Enums in TypeScript:** Rust's powerful tagged unions (e.g., `enum Node { Css, XPath }`) might generate complicated TypeScript types if flattened incorrectly.
  - **Mitigation:** Rely strictly on `serde(tag = "type")` inside the enum configurations. Ensure the `ts-rs` library successfully observes the `serde` tagging layout during TS `.d.ts` output.
- **[Risk] FRB Unsupported Types on Recursion:** `flutter_rust_bridge` sometimes struggles with highly nested generic `enum` types when generating Dart copies.
  - **Mitigation:** The Graph array structure (`nodes: Vec<Node>`, `edges: Vec<Edge>`) flattens the execution flow. Unlike recursive AST trees, a flat vector array guarantees FRB generation will comfortably succeed.
