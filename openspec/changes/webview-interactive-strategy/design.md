## Context

The system must support fetching raw HTML headers and bodies using advanced TLS and HTTP/2 spoofing via the Rust-based `wreq` client. However, powerful anti-bot systems (Cloudflare 5s checks, reCAPTCHA, Datadome, Akamai, custom Web Application Firewalls) often deploy Javascript challenges that `wreq` (being a command-line-style fetcher) fundamentally cannot solve.

When the programmatic rust layer hits an impassable anti-bot wall, the system must gracefully yield execution back to the Flutter UI, display an interactive WebView (a real browser) where the user can manually pass the check, extract the valid session data (Cookies, User-Agent), and resume the programmatic Rust pipeline with the new credentials.

## Goals / Non-Goals

**Goals:**
- Implement "Yield and Resume" pattern: Rust executes pure stateless fetches. On 403/Challenge detection, it throws a specific `AuthRequired` exception, forcing Dart to handle it.
- Dynamically invoke a Flutter WebView overlay (`flutter_inappwebview`) pointing at the targeted host.
- Provide automatic cookie and User-Agent extraction once the WebView indicates a successful load (200 OK / challenge passed).
- Re-run the paused Rust Pipeline seamlessly with injected session parameters.

**Non-Goals:**
- Completely automated, invisible Captcha solving (requires massive headless Chrome binaries and ML bypasses, unsuitable for mobile).
- Replacing `wreq` with headless browsers globally (WebViews are too slow and resource-heavy for parallel crawling).

## Decisions

**1. Architecture: The "Yield and Resume" Exception Pattern**
- **Decision:** Do not let Rust attempt to spawn UI threads. Instead, if Rust's `wreq` receives an HTTP 403 or detects standard Cloudflare/Akamai HTML fingerprints, it immediately throws `CrawlerError::AuthRequired(url, reason)`. Dart `CrawlerExecutor` catches this, suspends the queue, pops the WebView, awaits user interaction, then resumes the scrape.
- **Rationale:** Keeps Rust strictly as a stateless, high-performance execution engine and avoids complex FFI async polling loops connecting UI and background isolates.

**2. State Sync: Bi-Directional Session Manager**
- **Decision:** Build `SessionManager` in Dart to store a global `host -> (Cookies, UserAgent)` map. When Dart calls Rust `executePipeline()`, it injects these specific headers dynamically in the FFI boundary request. When a WebView passes a challenge, Dart calls `CookieManager.getCookies(url)` and stores them in this map.
- **Rationale:** Ensures that the Rust `wreq` engine flawlessly mimics the exact session of the real mobile browser engine that just solved the captcha logic, avoiding TLS/Cookie mismatch detection.

**3. Anti-Bot / Anti-Fingerprint Strategies (Advanced)**

To bypass modern anti-bot systems (like Cloudflare, Datadome, Akamai), relying *solely* on WebViews is not enough, as some WebViews expose their mobile identifiers. Our design explicitly leverages the following techniques:

- **1. wreq TLS + HTTP/2 Fingerprinting (Rust Layer):**
  - **Concept:** Firewalls inspect the JA3 (TLS client hello) and JA4 (HTTP/2 SETTINGS frames, window updates) of incoming requests. `wreq` + `wreq-util` provides byte-perfect mimicry of Chrome, Firefox, and Safari network stacks.
  - **Design:** Instead of raw cURL/Dart HTTP requests, the API explicitly configures `wreq` to use `Emulation::Chrome131` (or newer) to disguise the underlying BoringSSL packets as a genuine desktop browser's handshake.

- **2. WebView Fingerprint Obfuscation (Flutter Layer):**
  - **Concept:** `flutter_inappwebview` on Android defaults to a `Version/4.0 Chrome/XX Mobile Safari/` string. Custom WAFs block `wv` (WebView) and older Chrome versions immediately.
  - **Design:** Before launching the Interactive WebView, the `WebViewInteractiveStrategy` must **override the User-Agent** to perfectly match the `wreq` Desktop Chrome User-Agent used in step 1. Furthermore, we must set `applicationNameForUserAgent` to an empty string to erase the `wv` tag on Android.

- **3. Header Order Preservation (Rust Layer):**
  - **Concept:** Go and Dart `http` packages reorder headers alphabetically or in unpredictable ways. Browsers send headers in a very specific order (e.g., `Host`, `Connection`, `Pragma`, `Cache-Control`, `User-Agent`, `Accept`).
  - **Design:** Rely on `wreq`'s `HttpRequest` to preserve strict header ordering during the TLS payload construction.

## Risks / Trade-offs

- **[Risk] Cookie Expiration during Long Crawls**: Cloudflare clearance cookies typically last between 30 minutes to 1 year. If a background download task is running and the clearance expires, throwing an interactive WebView popup while the app is backgrounded will crash or fail.
- **[Mitigation]**: If the app is actively backgrounded, transition the queued crawler tasks to an "Auth Pending" global state and notify the user via local OS notifications to open the app, rather than attempting to render a WebView in a background isolate.
- **[Risk] WebView Headless Defeats**: Some sites run intense JS challenges (Canvas fingerprinting, Audio context). Mobile WebViews can sometimes fail these due to hardware mismatch compared to the injected Desktop User-Agent.
- **[Mitigation]**: Allow the fallback `WebViewInteractiveStrategy` to optionally use the native mobile User-Agent if the desktop emulation fails twice in a row, syncing the mobile UA down to Rust for subsequent requests.