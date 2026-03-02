## Why

The current HTML parsing and data extraction logic in Spectra is implemented in Dart using packages like `html`, `xml`, and `json_path`. This approach is memory-intensive on the Dart VM, single-threaded (blocking the Isolate/UI), and lacks full cross-platform performance parity. By migrating the HTML parsing and selection engine to Rust using `rlibxml2` (a fast libxml2 wrapper) and introducing `rquickjs` for JavaScript transformations, we can achieve high-performance, memory-safe, and thread-safe data extraction that executes completely outside the Dart VM garbage collector.

## What Changes

- **Integrate `rlibxml2`**: Add Rust dependencies for HTML/XML parsing and XPath extraction.
- **Implement Selection Engines**: Build XPath, CSS (via `scraper`), JSONPath (via `jsonpath-rust`), and Regex extractors in Rust.
- **Implement Transformation Engines**: Build string operations and JS evaluation (`rquickjs`) in Rust.
- **Implement FFI Bindings**: Expose `parse_html`, `xpath_select`, and JavaScript evaluations via `flutter_rust_bridge`.
- **Dart Refactoring**: Remove old Dart-based selector implementations (`html`, `xml`, `xpath_selector` packages etc.) and migrate the `PipelineExecutor` to call Rust FFI.

## Capabilities

### New Capabilities
- `rust-html-parser`: High-performance HTML parsing and extraction through Rust (XPath, CSS, Regex, JSONPath).
- `rust-js-executor`: JavaScript evaluation context for data transformations using `rquickjs`.
- `rust-transform-ops`: String manipulation and URL processing operations in Rust (`trim`, `replace`, `lower`, `upper`, etc.).

### Modified Capabilities
- `crawler-rule-executor`: The engine that evaluates crawling rules will now delegate node execution to Rust instead of processing them purely in Dart.

## Impact

- **Dependencies**: Adds `rlibxml2`, `rquickjs`, `jsonpath-rust` to Rust workspace. Removes `html`, `xml`, `json_path` from `pubspec.yaml`.
- **API**: Exposes new Rust APIs like `parse_html` and `execute_js` to Dart codebase.
- **Performance**: Significant reduction in Dart GC pauses during large DOM parsing, as memory management for DOM trees moves to Rust.
- **Cross-platform**: Requires ensuring `libxml2` and `rquickjs` compile correctly across Windows, macOS, Linux, iOS, and Android targets.