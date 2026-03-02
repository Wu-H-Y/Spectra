## Why

The current rule execution system primarily relies on a single pipeline strategy in Dart which delegates HTTP fetching and CSS/XPath parsing to the Dart isolates. However, as Spectra shifts its primary crawling extraction engine to Rust (using `wreq` for advanced TLS simulation and `rlibxml2` for parsing), there needs to be a stable bridge API in Dart to orchestrate these calls. The Dart HTTP Strategy will interact directly with the generated Rust FFI to execute network fetches using `wreq`, managing building request options, forwarding proxies, and capturing headers.

## What Changes

- **Rust HTTP Client Wrapper**: Implement the `HttpStrategy` class in Dart to correctly marshal requests and retrieve responses from the Rust `wreq` HTTP endpoints generated via FFI.
- **Unified Request Abstraction**: Standardize how HTTP headers, timeout parameters, and proxy settings are supplied to the `HttpStrategy`.
- **Response Handling**: Implement error handling correctly capturing timeout, connection drops, or blocked requests (403 mappings) from the Rust side back to Dart types.
- **Fallback Check**: Include basic hooks to identify when a request is blocked and notify upper layers to optionally switch to a `WebViewInteractiveStrategy`.

## Capabilities

### New Capabilities
- `dart-http-strategy`: An encapsulation in Dart responsible solely for invoking the Rust FFI HTTP layer with the correct settings and capturing typed errors or successes.

### Modified Capabilities
- `crawler-rule-executor`: Will now invoke the `dart-http-strategy` for network requests rather than executing native `package:http`.

## Impact
Creates `lib/core/crawler/network/` or similar structure for network abstraction. Adapts Dart services to rely thoroughly on the `fetch` interface provided by the Rust FFI.