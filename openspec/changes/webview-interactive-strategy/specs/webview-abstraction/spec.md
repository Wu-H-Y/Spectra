## ADDED Requirements

### Requirement: Unified WebView Control
The system MUST implement a bridging abstraction ensuring crawling mechanics don't depend directly on one explicit WebView implementation package (e.g., locking only to `flutter_inappwebview`).

#### Scenario: Abstract Engine
- **WHEN** evaluating if a WebView should be visible or hidden
- **THEN** it resolves to standard methods inside the `WebViewStrategy` interface
