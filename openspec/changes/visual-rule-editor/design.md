## Context

The raw pipeline structure `["@css:.author-name", "@text", "@trim"]` is powerful and concise for developers, but hostile to non-technical users. To democratize rule creation, we are building a node-editor (React Flow) that visually maps 1:1 to these arrays. We also need a real-time testing playground rendering the target page so users can verify their selectors against real HTML instantly.

## Goals / Non-Goals

**Goals:**
- Provide a Node-Based Visual Rule Editor using `@xyflow/react`.
- Build a live DOM picker overlay onto an iframe/webview to automatically generate `@css` nodes by clicking elements.
- Instantiate a unidirectional data flow (Zustand) mapping Visual Nodes ←→ Pipeline JSON arrays perfectly.
- Ingest the auto-generated `.ts` interfaces natively from `ts-rs` (cross-language alignment).

**Non-Goals:**
- Implementing the Rust crawling logic in the Web Editor. The editor only generates the JSON.
- Embedding complex IDE features (Code highlighting is enough).

## Decisions

- **Decision:** Use `@xyflow/react` for the graph UI.
- **Rationale:** It's the industry standard for React node-based editors (used by n8n, Stripe, etc.) providing perfect zooming, panning, and customizable node types.
- **Decision:** State Management via Zustand.
- **Rationale:** Deeply nested graph updates are difficult in raw React state; Zustand provides a clean, predictable, and boilerplate-free store for nodes and edges.

## Risks / Trade-offs

- **[Risk] Syncing UI state and JSON model:** A user editing a node might generate an invalid pipeline array.
- **[Mitigation]** The JSON output must strictly conform to the `ts-rs` generated interface (`PipelineNode[]`). If the graph has dangling edges or circular dependencies, the serialization step natively rejects it and highlights the broken link.