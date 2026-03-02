## MODIFIED Requirements

### Requirement: Node Execution Delegation
The `crawler-rule-executor` network module SHALL delegate HTTP requests to the newly designed `dart-http-strategy` abstraction rather than executing via `dart:io` or `package:http`.

#### Scenario: Request Remote Node
- **WHEN** a crawler attempts to fetch remote content
- **THEN** it triggers the centralized `dart-http-strategy` proxy methods

## REMOVED Requirements

### Requirement: dart:io HTTP fetching
**Reason:** Vulnerable to TLS fingerprinting on anti-bot systems (Cloudflare, Akamai etc.). Cannot perfectly mimic Chromium network profiles via HTTP/2 window sizes and priorities.
**Migration:** This functionality is entirely disabled. Network dependencies are transitioned exclusively to `flutter_rust_bridge` + `wreq`.