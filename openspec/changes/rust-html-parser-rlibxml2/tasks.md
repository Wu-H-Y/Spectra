## 1. Rust Environment & Dependency Setup

- [ ] 1.1 Update `rust/Cargo.toml` to add dependencies: `jsonpath-rust`, `rquickjs` (with relevant features), `scraper`, `regex`, `url`, `serde`, `serde_json`. Add `rlibxml2` pointer (ensure git/path dependency works across platforms).
- [ ] 1.2 Create error definition module `rust/src/error.rs` (defining `CrawlerError`, `ParseError`, `BuildError` using `thiserror` for the new engines).
- [ ] 1.3 Create module structures for executors: `rust/src/executor/mod.rs`, `rust/src/executor/selector/`, `rust/src/executor/transform/`.

## 2. Core Excecutor Engines (Rust internal)

- [ ] 2.1 Implement `XPathExecutor` in `rust/src/executor/selector/xpath.rs` utilizing `rlibxml2`. Write internal unit tests.
- [ ] 2.2 Implement `CssExecutor` in `rust/src/executor/selector/css.rs` utilizing `scraper`. Write internal unit tests.
- [ ] 2.3 Implement `JsonPathExecutor` in `rust/src/executor/selector/jsonpath.rs` utilizing `jsonpath-rust`. Write internal unit tests.
- [ ] 2.4 Implement `RegexExecutor` in `rust/src/executor/selector/regex.rs`. Write internal unit tests.
- [ ] 2.5 Implement `StringOps` (`trim`, `lower`, `upper`, `replace`, `url`) in `rust/src/executor/transform/string_ops.rs`. Write internal unit tests.
- [ ] 2.6 Implement `JsExecutor` in `rust/src/executor/transform/js.rs` utilizing `rquickjs`, allowing `val` and `vars` context injection. Write internal unit tests.

## 3. Rust Pipeline Aggregation & FFI API

- [ ] 3.1 Create `rust/src/domain/pipeline.rs` defining the serializable structures `PipelineExecuteRequest` (containing HTML and node definitions) and `PipelineExecuteResult`.
- [ ] 3.2 Create the unified extraction entrypoint `rust/src/api/html_parser.rs` combining all executors. Implement `parse_html` and `execute_pipeline`.
- [ ] 3.3 Register new FFI API modules in `rust/src/api/mod.rs`.
- [ ] 3.4 Run `flutter_rust_bridge_codegen generate` to build Dart bindings for the new HTML parser API.

## 4. Dart Integration & Refactoring

- [ ] 4.1 Update `CrawlerExecutor` and `LifecycleExecutor` to utilize the newly generated `flutter_rust_bridge` FFI endpoints instead of executing nodes in Dart.
- [ ] 4.2 Delete legacy Dart selector files spanning `lib/core/crawler/selector/css_selector.dart`, `xpath_selector.dart`, `jsonpath_selector.dart`, `regex_selector.dart`, `js_selector.dart`.
- [ ] 4.3 Remove `html`, `xml`, `json_path`, and any obsolete JS evaluation packages from `pubspec.yaml`.
- [ ] 4.4 Run `flutter pub get` and clear old `PipelineExecutor` Dart engine code.

## 5. Verification & Analysis

- [ ] 5.1 Run all project Dart unit tests against the new Rust pipeline strategy. Ensure 100% test passing.
- [ ] 5.2 Run `flutter analyze --fatal-infos` on the Dart codebase. Fix any warnings or infos resulting from the refactor until zero issues remain.