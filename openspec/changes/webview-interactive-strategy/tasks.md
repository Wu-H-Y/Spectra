## 1. WebView Strategy Interface

- [ ] 1.1 In `lib/shared/webview/`, create `webview_strategy.dart` defining the abstract `WebViewStrategy` class with a `startInteractiveSession` method.
- [ ] 1.2 Add `flutter_inappwebview` to `pubspec.yaml` (ensure version compatibility for desktop if applicable, otherwise strictly mobile).
- [ ] 1.3 Implement `InAppWebViewStrategy` handling the creation of the WebView overlay, explicitly overriding the `User-Agent` and `applicationNameForUserAgent` to remove Android `wv` identifiers.

## 2. Session Management

- [ ] 2.1 In `lib/core/network/session/`, create `session_manager.dart` to act as a singleton storing a map of `Host -> (Cookies, UserAgent)`.
- [ ] 2.2 Implement a method in `InAppWebViewStrategy` to listen to `onLoadStop` or `onProgressChanged` to evaluate when Cloudflare/Akamai challenges are successfully fully cleared (typically returning HTTP 200 on the target page).
- [ ] 2.3 Once cleared, utilize the WebView's `CookieManager` to extract all cookies for the `host` and store them in the `SessionManager`. Close the WebView overlay automatically upon success.

## 3. Crawler Interception Logic

- [ ] 3.1 In `CrawlerExecutor` (or equivalent execution orchestrator), catch the explicit `CrawlerFailure.authRequired` (or Rust equivalent exception) thrown by the `dart-http-strategy`.
- [ ] 3.2 Implement a pause state for the current executing pipeline node.
- [ ] 3.3 Trigger the `InAppWebViewStrategy` to pop the interactive window over the Flutter UI, passing the original requested URL.
- [ ] 3.4 Upon the `WebViewStrategy` resolving with success, retrieve the newly stored credentials from `SessionManager`, and re-invoke the failed Rust FFI pipeline execution request.

## 4. Verification & UI Refinements

- [ ] 4.1 Create a generic visual overlay / loading state in Flutter indicating "Waiting for security verification..." while the WebView is active.
- [ ] 4.2 Provide a manual "Close/Abort" button in the WebView overlay in case the challenge is genuinely unsolvable (e.g., region ban), which aborts the crawl attempt.
- [ ] 4.3 Run `flutter analyze --fatal-infos` on the newly added dart files to ensure strict typing and analyzer compliance across the interception logic.
