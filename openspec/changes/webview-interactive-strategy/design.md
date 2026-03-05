## Context

`rust-lifecycle-executor` 提供的 `execute_lifecycle_phase()` API 已经内置 WAF 拦截检测：
- 自动检测 403/503 状态码
- 识别 Cloudflare headers (`cf-ray`, `cf-mitigated`)
- 返回 `CrawlerError::AuthRequired` 错误

当 Dart 侧收到 `AuthRequired` 错误时，需要：
1. 暂停当前爬虫任务
2. 弹出 WebView 让用户手动通过验证码
3. 提取 WebView 的 Cookie 和 User-Agent
4. 同步给后续的 Rust HTTP 请求
5. 重试爬虫任务

## Goals / Non-Goals

**Goals:**
- 监听 `AuthRequired` 错误并触发 WebView
- 自动提取 WebView 会话数据（Cookies, User-Agent）
- 持久化会话数据供后续请求使用
- 将会话数据同步给 Rust HTTP 客户端

**Non-Goals:**
- 自动解决验证码（需要 ML 模型，不适合移动端）
- 替代 `execute_lifecycle_phase()` API

## Decisions

**1. 错误处理架构**

- **决策**: Dart 侧监听 `AuthRequired` 错误，不主动检测 WAF
- **理由**: WAF 检测逻辑已由 Rust 的 `execute_lifecycle_phase()` 处理
- **实现**:
  ```dart
  final result = await rust.executeLifecyclePhase(rule, phase, context);
  if (result.error is AuthRequired) {
    await webViewStrategy.handleAuthRequired(result.error.url);
    // 重试
  }
  ```

**2. 会话管理**

- **决策**: 创建 `SessionManager` 管理主机到会话数据的映射
- **理由**: 需要在 WebView 和 Rust HTTP 客户端之间共享会话
- **实现**:
  ```dart
  class SessionManager {
    // host -> (cookies, userAgent)
    Map<String, SessionData> sessions;
    
    Future<void> syncFromWebView(String url);
    Future<void> injectToRust(String host);
  }
  ```

**3. Cookie 持久化**

- **决策**: 使用 `CookieStorage` 持久化 Cookie
- **理由**: 应用重启后仍能使用已通过的验证
- **实现**: 基于 `shared_preferences` 或 SQLite

**4. User-Agent 同步**

- **决策**: WebView User-Agent 必须与 Rust 侧的 `Emulation` 配置一致
- **理由**: 避免指纹不匹配被检测
- **实现**: 
  - 读取规则的 `network.emulation` 配置
  - 在 WebView 启动前设置对应的 User-Agent

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│  Dart Application                                           │
│  ┌────────────────────────────────────────────────────────┐ │
│  │ CrawlerExecutor                                        │ │
│  │  - 调用 execute_lifecycle_phase()                      │ │
│  │  - 监听 AuthRequired 错误                              │ │
│  │  - 触发 WebViewInteractiveStrategy                     │ │
│  └────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  WebViewInteractiveStrategy                                 │
│  1. 弹出 WebView (设置 User-Agent)                          │
│  2. 等待用户通过验证码                                      │
│  3. 提取 Cookies                                           │
│  4. 存储到 SessionManager                                  │
│  5. 同步给 Rust                                            │
│  6. 关闭 WebView                                           │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  SessionManager                                             │
│  - 持久化 Cookie                                           │
│  - 提供 Cookie 给 Rust execute_lifecycle_phase()           │
└─────────────────────────────────────────────────────────────┘
```

## Risks / Trade-offs

**[Risk] Cookie 过期**: 长时间爬虫任务中 Cookie 可能过期
**[Mitigation]**: 
- 监控 403 错误，重新触发 WebView
- 提示用户验证码可能需要重新通过

**[Risk] WebView 指纹检测**: 某些网站检测 WebView 环境
**[Mitigation]**:
- User-Agent 与 Rust 侧保持一致
- 移除 WebView 标识 (`wv` tag on Android)

**[Risk] 后台运行**: 应用后台时 WebView 无法显示
**[Mitigation]**:
- 检测应用状态，后台时暂停任务
- 通过本地通知提示用户打开应用
