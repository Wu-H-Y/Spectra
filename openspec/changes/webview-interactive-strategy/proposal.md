## Why

Spectra 使用 Rust `wreq` 客户端进行高性能 HTTP 请求，但某些网站使用复杂的反爬虫措施（Cloudflare、Akamai、reCAPTCHA），纯程序化的 HTTP 请求无法绕过。当 Rust 侧的 `execute_lifecycle_phase()` 检测到 WAF 拦截时（返回 `CrawlerError::AuthRequired`），需要交互式回退机制，显示 WebView 让用户手动解决验证码或登录，然后同步会话状态。

## What Changes

- **错误监听**: Dart 侧监听 `execute_lifecycle_phase()` 返回的 `AuthRequired` 错误
- **WebView 交互**: 创建 `WebViewInteractiveStrategy` 处理用户交互流程
- **会话同步**: 实现 `SessionManager` 和 `CookieStorage` 持久化 WebView 生成的 Cookie，并同步给 Rust HTTP 客户端
- **用户指纹伪装**: WebView User-Agent 与 Rust 侧保持一致

## Capabilities

### New Capabilities

- `webview-interactive`: 监听 `AuthRequired` 错误后弹出 WebView，等待用户通过验证码，提取并同步会话数据

### Modified Capabilities

- `crawler-rule-executor`: 使用新的 `execute_lifecycle_phase()` API，自动处理 WAF 拦截检测

## Impact

- 新增目录 `lib/shared/webview/` 和 `lib/core/network/session/`
- 依赖 `flutter_inappwebview` 或 `webview_flutter`
- 简化爬虫执行生命周期，WAF 检测逻辑移至 Rust 侧
