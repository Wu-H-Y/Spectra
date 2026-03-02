## Context

The system must support fetching raw HTML headers and bodies using advanced TLS and HTTP/2 spoofing via the Rust-based `wreq` client. The Dart codebase previously used `dart:io` or `package:http`. Now, it must seamlessly interop with the `flutter_rust_bridge` FFI generated endpoints.

Modern anti-bot systems (Cloudflare, Datadome, Akamai) actively block standard HTTP clients. The `dart-http-strategy` must represent the **1st and 2nd tiers of our 3-tier Anti-Bot Defense Matrix**, handling these sophisticated protections silently before ever involving a WebView or the user.

## Goals / Non-Goals

**Goals:**
- Provide a clean Dart asynchronous service (`HttpStrategy`) mapping to the underlying FFI methods.
- Correctly serialize `ProxySettings`, `CookieSettings`, and Timeout structures to the Rust struct format.
- Intercept connection errors mapped from Rust and return standardized Dart `Failure` classes.
- **Implement Tier 1 & 2 Anti-Bot Defenses**: Configure the Rust `wreq` client to utilize byte-perfect TLS Client Hello (JA3) and HTTP/2 SETTINGS frames (JA4) spoofing to completely bypass 90% of WAF blocks statically.

**Non-Goals:**
- Modifying the underlying `wreq` Rust crate directly.
- Managing interactive login sessions or complex JS challenges (Tier 3/4 defenses belong in `WebViewInteractiveStrategy`).

## Decisions

**1. Interface-Driven Architecture:**
- **Decision:** Utilize an interface approach (`Strategy`) so we can inject mocks for testing HTTP network conditions without executing FFI during Widget testing.
- **Rationale:** Strict unit tests shouldn't require real networks or compiled Rust binaries if testing high-level extraction logic.

**2. Anti-Bot Defense Integration (Status Code Mapping):**
- **Decision:** The FFI layer will strictly intercept HTTP 403, 503, and specific Cloudflare signature headers (e.g., `cf-ray`, `cf-mitigated`). The Dart strategy maps these to a specialized `CrawlerFailure.authRequired` state.
- **Rationale:** We cannot treat a WAF block as a standard network error. Signaling `authRequired` immediately halts the current pipeline and defers to the `WebViewInteractiveStrategy` for the Tier 3/4 JS Challenge handling.

**3. Functional Error Handling:**
- **Decision:** Catch all FFI exceptions explicitly inside the strategy layer and convert them to `Either<Failure, HttpResponse>`.
- **Rationale:** Enforces functional error handling across the Dart codebase as strictly mandated by style guidelines.

## Anti-Bot Defense Matrix (Tier 1 & 2)

| Tier | Defense Type | Strategy Implementation |
|---|---|---|
| **Tier 1** | IP/Frequency & Basic Header Checks | Dart passes strict `User-Agent` (matching Desktop Chrome explicitly) and `Accept-Language` headers via the FFI. Support proxy pool rotation built into the `NetworkConfig`. |
| **Tier 2** | TLS (JA3) & HTTP/2 (JA4) Fingerprinting | The core reason for this FFI bridge. By instructing `wreq` to use `Emulation::Chrome131` (or newer), the underlying BoringSSL stack mimics desktop browsers identically. This silently bypasses the vast majority of Cloudflare initial checks without encountering a 5-second shield. |

## Risks / Trade-offs

- **[Risk] Serialization Overhead:** Moving large response bodies from Rust memory to Dart strings may block the main isolate.
  - **Mitigation:** Ensure the FFI is called on an Isolate or via async Squadron workers.
- **[Risk] Hardcoded Emulation Profiles Stale:** If Chrome updates, `Chrome131` emulation might trigger suspicion if the `User-Agent` string provided by Dart says `Chrome/135`.
  - **Mitigation:** Ensure the `User-Agent` string synthesized by the Dart crawler engine perfectly aligns with the `Emulation` enum selected for the `wreq` Rust backend.