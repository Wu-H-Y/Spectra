## Why

Spectra relies heavily on the capabilities of the underlying HTTP client to retrieve data. Sometimes, sites employ sophisticated anti-bot measures (like Cloudflare, Akamai, or reCaptcha) that purely programmatic Rust-level HTTP requests (`wreq` with TLS fingerprints) cannot bypass. In these cases, the system needs an interactive fallback mechanism. This change abstracts WebView logic to display a browser to the user, allowing them to manually solve captchas or log in, then captures and synchronizes the session state (Cookies) back to the programmatic Rust HTTP clients.

## What Changes

- **Abstraction Layer**: Introduce `WebViewStrategy` to provide a unified interface for WebView operations, supporting both `flutter_inappwebview` and `webview_flutter`.
- **Interactive Engine**: Create the `WebViewInteractiveStrategy` that handles the fallback logic when an HTTP request gets blocked (e.g., 403, Cloudflare Challenge).
- **Session Sync**: Implement `SessionManager` and `CookieStorage` to persist cookies generated inside a WebView session and synchronize them so the Rust FFI wreq client can reuse them.

## Capabilities

### New Capabilities
- `webview-abstraction`: Interface allowing selection of the underlying WebView rendering engine, decoupling it from the crawling logic.
- `webview-interactive`: Logic orchestrating the UI popup when an anti-bot check fails, observing network responses until a successful load is detected.
- `session-management`: Storage and bidirectional synchronization of authentication data (Cookies) between the WebView engine and programmatic HTTP states.

### Modified Capabilities
- None.

## Impact

- Adds new directories `lib/shared/webview/` and `lib/core/network/session/`.
- Potentially adds standard `webview_flutter` or relies on `flutter_inappwebview` logic.
- Affects the overall data crawling execution lifecycle which must now account for pausing and blocking while waiting for an asynchronous interactive session to conclude.
