## 1. FFI Configuration

- [ ] 1.1 In `rust/Cargo.toml`, verify `wreq`, `wreq-util`, and `url` crates.
- [ ] 1.2 Create `rust/src/api/http_client.rs` defining the FRB interface `fetch(request: HttpRequest) -> HttpResponse`.

## 2. Rust HTTP Engine

- [ ] 2.1 Translate `HttpRequest` arguments (URL, Headers, Timeout) into concrete `wreq::RequestBuilder` calls.
- [ ] 2.2 Configure `wreq` to statically enforce Chrome131 TLS and HTTP/2 emulation using `wreq_util::Emulation`.
- [ ] 2.3 Handle connection timeouts, DNS failures, or explicit WAF 403 flags, mapping them into strictly typed `CrawlerError` variations. Ensure `AuthRequired` can be explicitly thrown.

## 3. Dart HTTP Strategy Base

- [ ] 3.1 Define abstract `HttpStrategy` class in Dart.
- [ ] 3.2 Implement `RustFFIHttpStrategy` that invokes the generated `fetch` Rust boundary.
- [ ] 3.3 Implement error caching mapping `CrawlerError::AuthRequired` into a localized `CrawlerFailure.authRequired` state utilizing `fpdart` `Either`.

## 4. Integration

- [ ] 4.1 Refactor the current `crawler-rule-executor` network module in Dart to utilize the abstract `HttpStrategy`.
- [ ] 4.2 Delete legacy `package:http` or `dart:io` usage globally.
- [ ] 4.3 Run `flutter pub get` and clear old network codes.
- [ ] 4.4 Run `flutter analyze --fatal-infos` fixing remaining hints.