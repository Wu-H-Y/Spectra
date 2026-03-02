## ADDED Requirements

### Requirement: Intercept Challenge Responses
The execution pipeline MUST be capable of pausing Rust programmatic extraction and injecting a WebView layer when anti-bot challenges are encountered.

#### Scenario: Encounter Turnstile Challenge
- **WHEN** the `AuthRequired` exception bubbles up from an HTTP fetch
- **THEN** the Dart runtime presents the WebView pointing at the challenged URL and waits for user interaction

### Requirement: UA and Viewport Disguise
Before launching the fallback WebView, it MUST overwrite standard mobile identification strings to match the WAF footprints.

#### Scenario: WAF Evasion
- **WHEN** launching the interactive proxy to solve Cloudflare
- **THEN** the User-Agent is explicitly stripped of `wv` identifiers and matches a Desktop Chrome string
