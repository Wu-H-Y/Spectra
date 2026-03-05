## Context

Spectra relies heavily on its HTML parsing capabilities to extract information (video links, novel chapters, metadata) from various sources. The current implementation uses Dart packages (`html`, `xml`, `json_path`) executing in the Dart VM.
As the number of extraction rules and the size of the DOM increase, running DOM parsing and complex XPath queries in Dart presents memory overhead and single-threaded blocking issues, leading to UI stutters. Integrating `rlibxml2`, built on top of the robust `libxml2` library, directly via the existing `flutter_rust_bridge` infrastructure will drastically improve parsing performance and offload memory and execution pressure from the Dart VM.

## Goals / Non-Goals

**Goals:**
- Completely replace dart's `html` and `xml` parsers with the Rust-based `rlibxml2`.
- Implement XPath, CSS, Regex, and JSONPath processing entirely within Rust.
- Implement JavaScript-based transformations using `rquickjs`.
- Provide a clean and stable `flutter_rust_bridge` API for the Dart `PipelineExecutor` to call into.
- Ensure cross-platform compilation of Rust dependencies (Windows, Linux, macOS, iOS, Android).

**Non-Goals:**
- Changing the underlying Pipeline DSL structure (JSON array syntax) – this is currently handled in Dart and passed down.
- Migrating the HTTP Client (`wreq`) – this is a distinct change/phase outside of the HTML parsing scope.
- Building the React Flow UI Editor.

## Decisions

**1. Parser and Selector Tooling in Rust:**
- **Decision:** Use `rlibxml2` for HTML and XML parsing and XPath selection. Use `scraper` for CSS selectors. Use `jsonpath-rust` for JSONPath querying. Use `regex` for regex evaluation. (https://github.com/Wu-H-Y/rlibxml2 : This is my own public repository. I developed the libxml2 cross-platform FFI library for web crawlers.)
- **Rationale:** `libxml2` is the industry standard for fast, fault-tolerant HTML parsing and complete XPath 1.0 support. `rlibxml2` is an existing, optimized Rust wrapper tailored for this use case. Placing all selector evaluation inside Rust minimizes the ping-ponging of massive HTML strings across the FFI boundary.

**2. Transformation Tooling in Rust:**
- **Decision:** Use `rquickjs` to provide a JS execution context. Native String transformations (`trim`, `replace`, etc.) will be implemented natively in Rust.
- **Rationale:** `rquickjs` is a lightweight, safe binding to QuickJS. It supports the execution of small, dynamic JS snippets which users frequently rely on for string manipulation in crawling rules without pulling in a heavy engine like V8.

**3. Execution Boundary:**
- **Decision:** We will send the raw HTML/JSON string and the list of Pipeline Node configurations from Dart to Rust in a single FFI call. Rust will execute the full chain of extractions and transformations and return the final output string(s) to Dart.
- **Rationale:** If Dart coordinates every step (e.g., Dart calls Rust to get XPath result, then Dart calls Rust again for Regex), the FFI overhead and string copying will severely impact performance. Executing the entire pipeline node sequence inside Rust for a single field extraction guarantees maximum speed.

## Risks / Trade-offs

- **[Risk] Cross-Compilation Complexity with C/C++ dependencies:** `libxml2` (via `rlibxml2`) and QuickJS (`rquickjs`) might introduce complex build requirements (CMake, compilers) across iOS, Android, and Windows targets.
  - **Mitigation:** Rely on pre-configured `build.rs` scripts inside the Rust crates. We must rigorously test `cargo build` on `aarch64-linux-android`, `aarch64-apple-ios`, and Windows MSVC early in the development cycle.
- **[Risk] FFI Data structure translation overhead:** Passing complex nested rule definitions (Pipeline Nodes) from Dart to Rust might be slow.
  - **Mitigation:** We will pass serialized JSON or primitive `String` arrays representing the pipeline rules across the FFI, and let Rust deserialize it via `serde`.
- **[Risk] Dart Isolate memory leaks on FFI boundaries:** Freeing memory pointers manually if `flutter_rust_bridge` auto-cleanup fails on complex nested structs.
  - **Mitigation:** Stick to returning simple `Vec<String>` outputs from the Rust execution functions, letting `flutter_rust_bridge` natively manage scalar arrays safely.