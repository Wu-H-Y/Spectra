## MODIFIED Requirements

### Requirement: Node Execution Delegation
The `PipelineExecutor` SHALL delegate node evaluations (XPath, CSS, Regex, JS) and transformations to the `flutter_rust_bridge` FFI rather than resolving them using Dart packages.

#### Scenario: Evaluate Compound Node
- **WHEN** a complex rule path (e.g. `["@css:.title", "@js: val.replace()"]`) is executed
- **THEN** it passes the entire array to the Rust engine and returns the final transformed string(s)

## REMOVED Requirements

### Requirement: Dart-based HTML and XML parsing
**Reason:** Severe performance and GC overhead on the Dart VM when dealing with large DOMs and complex concurrent crawls.
**Migration:** This capability is completely replaced by `rlibxml2`, requiring no manual migration in the rules DSL themselves as the syntax remains identical.

### Requirement: Dart-based Regex, JSONPath, JS execution
**Reason:** Fragmentation of operations across multiple Dart packages, some of which interact poorly with Isolate spawning.
**Migration:** These packages are removed from `pubspec.yaml` and implemented inside the unified Rust FFI module.