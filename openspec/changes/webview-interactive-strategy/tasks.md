## 1. WebView 交互策略

- [ ] 1.1 在 `lib/shared/webview/` 创建 `webview_interactive_strategy.dart`
- [ ] 1.2 实现 `handleAuthRequired(String url)` 方法：
  - 弹出 WebView overlay
  - 根据 Rust 侧 `Emulation` 配置设置 User-Agent
  - 等待用户通过验证码
- [ ] 1.3 在 `pubspec.yaml` 添加 `flutter_inappwebview` 依赖

## 2. 会话管理

- [ ] 2.1 在 `lib/core/network/session/` 创建 `session_manager.dart`
- [ ] 2.2 实现 `SessionManager` 单例，维护 `host -> (Cookies, UserAgent)` 映射
- [ ] 2.3 实现 `syncFromWebView(String url)` 方法，从 WebView 提取 Cookies
- [ ] 2.4 实现 `persist()` 方法，使用 `shared_preferences` 持久化会话数据

## 3. 错误处理集成

- [ ] 3.1 在 `CrawlerExecutor` 或相关服务中，监听 `execute_lifecycle_phase()` 的返回值
- [ ] 3.2 当收到 `CrawlerError::AuthRequired` 时：
  - 调用 `WebViewInteractiveStrategy.handleAuthRequired(url)`
  - 调用 `SessionManager.syncFromWebView(url)`
  - 重试 `execute_lifecycle_phase()`
- [ ] 3.3 实现最大重试次数限制（避免无限循环）

## 4. User-Agent 同步

- [ ] 4.1 读取规则的 `network.emulation` 配置（如 `Chrome131`）
- [ ] 4.2 实现 `UserAgentMapper`，将 Rust 侧的 `Emulation` 映射为 WebView 可用的 User-Agent 字符串
- [ ] 4.3 在 WebView 启动前设置 User-Agent，确保与 Rust HTTP 请求一致

## 5. Cookie 持久化

- [ ] 5.1 创建 `lib/core/network/session/cookie_storage.dart`
- [ ] 5.2 实现 `saveCookies(String host, List<Cookie> cookies)` 方法
- [ ] 5.3 实现 `loadCookies(String host)` 方法
- [ ] 5.4 应用启动时恢复持久化的 Cookie 到 `SessionManager`

## 6. UI 优化

- [ ] 6.1 创建 WebView overlay UI，显示"等待安全验证..."提示
- [ ] 6.2 添加手动关闭按钮，允许用户放弃验证
- [ ] 6.3 添加超时机制（如 60 秒后自动关闭）

## 7. 测试与验证

- [ ] 7.1 编写单元测试：`SessionManager` 的 Cookie 存取
- [ ] 7.2 编写集成测试：模拟 `AuthRequired` 错误流程
- [ ] 7.3 在真实网站测试（如 Cloudflare 保护的网站）
- [ ] 7.4 运行 `flutter analyze` 确保无错误
