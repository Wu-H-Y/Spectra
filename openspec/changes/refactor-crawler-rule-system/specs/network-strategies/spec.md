# Network Strategies

## Overview

网络策略模块提供两层请求方式：
1. **HTTP Strategy** - Rust wreq TLS/HTTP2 指纹伪装 (主力)
2. **WebView Interactive Strategy** - 用户手动交互 (回退)

## 架构决策

**问题**: 由 Rust 还是 Flutter 发起请求？

**决策**: **Rust 统一处理所有 HTTP 请求**

**理由**:
1. **TLS 指纹伪装**: wreq 提供 JA3/JA4 指纹模拟，需要底层网络控制
2. **HTTP/2 指纹**: 精确控制 SETTINGS、Priority Frames
3. **性能**: Rust 异步 HTTP 客户端比 Dart 更高效
4. **一致性**: 所有网络请求逻辑集中在 Rust 层

## Strategies

### 1. HTTP Strategy (主力)

使用 Rust wreq 实现 HTTP 请求，支持 TLS 和 HTTP/2 指纹伪装。

```dart
@freezed
class NetworkConfig with _$NetworkConfig {
  const factory NetworkConfig({
    /// 网络策略
    @Default(NetworkStrategy.http) NetworkStrategy strategy,

    /// 设备模拟
    @Default(BrowserEmulation.chrome131) BrowserEmulation emulation,

    /// 请求头
    Map<String, String>? headers,

    /// Cookie
    Map<String, String>? cookies,

    /// 超时 (ms)
    @Default(15000) int timeout,

    /// 重定向
    @Default(true) bool followRedirects,

    /// 回退配置
    FallbackConfig? fallback,

    /// 代理配置
    ProxyConfig? proxy,
  }) = _NetworkConfig;
}

/// 设备模拟类型
enum BrowserEmulation {
  chrome131,
  chrome120,
  firefox133,
  safari18,
  edge127,
}

/// 网络策略
enum NetworkStrategy {
  http,
  webviewInteractive,
}
```

**适用场景**:
- 大多数网站的 API 和页面请求
- 需要 TLS 指纹伪装的场景
- 快速批量请求

**wreq 特性**:
- TLS 指纹伪装 (JA3/JA4)
- HTTP/2 指纹模拟
- 100+ 预置设备配置 (wreq-util)
- Cookie Store
- 代理支持

### 2. WebView Interactive Strategy (回退)

交互式浏览器，用于需要用户手动操作的场景。

```dart
@freezed
class WebViewInteractiveConfig with _$WebViewInteractiveConfig {
  const factory WebViewInteractiveConfig({
    /// 超时 (ms)
    @Default(120000) int timeout,

    /// 成功检测
    SuccessDetection? successDetection,

    /// 完成后同步 Cookie
    @Default(true) bool syncCookiesOnComplete,
  }) = _WebViewInteractiveConfig;
}

@freezed
class SuccessDetection with _$SuccessDetection {
  const factory SuccessDetection({
    /// 成功 URL 模式
    String? urlPattern,

    /// 成功选择器
    String? selector,

    /// 成功状态码
    @Default([200]) List<int> statusCodes,
  }) = _SuccessDetection;
}
```

**适用场景**:
- 登录验证
- 复杂验证码 (需要人工识别)
- 需要用户交互的鉴权流程
- HTTP 策略失败后的回退

## Rust HTTP Client API

### wreq 集成

```rust
// rust/src/api/http_client.rs
use wreq::{Client, Response};
use wreq_util::Emulation;

/// HTTP 请求配置
pub struct HttpRequest {
    pub url: String,
    pub method: String,
    pub headers: Option<HashMap<String, String>>,
    pub body: Option<String>,
    pub emulation: BrowserEmulation,
    pub timeout_ms: u32,
    pub follow_redirects: bool,
    pub proxy: Option<ProxyConfig>,
}

/// HTTP 响应
pub struct HttpResponse {
    pub status: u16,
    pub headers: HashMap<String, String>,
    pub body: String,
    pub url: String,
    pub cookies: Vec<Cookie>,
}

/// 设备模拟类型
pub enum BrowserEmulation {
    Chrome131,
    Chrome120,
    Firefox133,
    Safari18,
    Edge127,
}

/// 发送 HTTP 请求
pub async fn fetch(request: HttpRequest) -> Result<HttpResponse, String> {
    let emulation = match request.emulation {
        BrowserEmulation::Chrome131 => Emulation::Chrome131,
        BrowserEmulation::Chrome120 => Emulation::Chrome120,
        BrowserEmulation::Firefox133 => Emulation::Firefox133,
        BrowserEmulation::Safari18 => Emulation::Safari18,
        BrowserEmulation::Edge127 => Emulation::Edge127,
    };

    let mut builder = Client::builder()
        .emulation(emulation)
        .timeout(Duration::from_millis(request.timeout_ms as u64));

    if !request.follow_redirects {
        builder = builder.redirect(wreq::redirect::Policy::none());
    }

    if let Some(proxy) = request.proxy {
        builder = builder.proxy(proxy.into());
    }

    let client = builder.build().map_err(|e| e.to_string())?;

    // 构建请求
    let mut req = match request.method.as_str() {
        "GET" => client.get(&request.url),
        "POST" => client.post(&request.url),
        "PUT" => client.put(&request.url),
        "DELETE" => client.delete(&request.url),
        _ => return Err(format!("Unsupported method: {}", request.method)),
    };

    // 设置请求头
    if let Some(headers) = request.headers {
        for (key, value) in headers {
            req = req.header(&key, &value);
        }
    }

    // 设置请求体
    if let Some(body) = request.body {
        req = req.body(body);
    }

    // 发送请求
    let response = req.send().await.map_err(|e| e.to_string())?;

    // 提取 Cookie
    let cookies = extract_cookies(&response);

    Ok(HttpResponse {
        status: response.status().as_u16(),
        headers: response.headers().iter()
            .map(|(k, v)| (k.to_string(), v.to_str().unwrap_or("").to_string()))
            .collect(),
        body: response.text().await.map_err(|e| e.to_string())?,
        url: response.url().to_string(),
        cookies,
    })
}
```

### Dart FFI 调用

```dart
// 自动生成的 Dart API (flutter_rust_bridge)
class RustHttpClient {
  Future<HttpResponse> fetch(HttpRequest request) async {
    return await api.fetch(request: request);
  }
}
```

## Fallback Config

失败时的回退策略。

```dart
@freezed
class FallbackConfig with _$FallbackConfig {
  const factory FallbackConfig({
    /// 触发条件
    required List<TriggerCondition> trigger,

    /// 回退动作
    @Default(FallbackAction.webviewInteractive) FallbackAction action,

    /// 超时 (ms)
    @Default(60000) int timeout,
  }) = _FallbackConfig;
}

@freezed
class TriggerCondition with _$TriggerCondition {
  const factory TriggerCondition({
    /// 状态码
    int? statusCode,

    /// 正则匹配响应体
    String? bodyRegex,
  }) = _TriggerCondition;
}

enum FallbackAction {
  /// 切换到 WebView Interactive (用户手动鉴权)
  webviewInteractive,

  /// 放弃
  abort,
}
```

**使用示例**:

```json
{
  "network": {
    "strategy": "http",
    "emulation": "chrome131",
    "fallback": {
      "trigger": [
        { "statusCode": 403 },
        { "statusCode": 503 },
        { "bodyRegex": "Cloudflare|cf-browser-verification" }
      ],
      "action": "webviewInteractive",
      "timeout": 60000
    }
  }
}
```

## Session Management

Cookie 和鉴权状态持久化。

```dart
/// 会话管理器
class SessionManager {
  final CookieStorage _cookieStorage;
  final AuthStateStorage _authStateStorage;

  SessionManager({
    required CookieStorage cookieStorage,
    required AuthStateStorage authStateStorage,
  }) : _cookieStorage = cookieStorage,
       _authStateStorage = authStateStorage;

  /// 保存会话
  Future<void> saveSession({
    required String sourceId,
    required List<Cookie> cookies,
    AuthState? authState,
  }) async {
    await _cookieStorage.save(sourceId, cookies);
    if (authState != null) {
      await _authStateStorage.save(sourceId, authState);
    }
  }

  /// 加载会话
  Future<Session?> loadSession(String sourceId) async {
    final cookies = await _cookieStorage.load(sourceId);
    final authState = await _authStateStorage.load(sourceId);

    if (cookies == null || cookies.isEmpty) {
      return null;
    }

    // 检查是否过期
    if (authState?.isExpired ?? false) {
      await clearSession(sourceId);
      return null;
    }

    return Session(cookies: cookies, authState: authState);
  }

  /// 清除会话
  Future<void> clearSession(String sourceId) async {
    await _cookieStorage.clear(sourceId);
    await _authStateStorage.clear(sourceId);
  }

  /// 同步 Cookie 到 Rust HTTP 客户端
  Future<void> syncToRust(String sourceId) async {
    final session = await loadSession(sourceId);
    if (session != null) {
      await _rustHttpClient.setCookies(session.cookies);
    }
  }
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required bool isAuthenticated,
    required DateTime authenticatedAt,
    DateTime? expiresAt,
    String? userId,
    String? token,
  }) = _AuthState;

  const AuthState._();

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }
}

@freezed
class Session with _$Session {
  const factory Session({
    required List<Cookie> cookies,
    AuthState? authState,
  }) = _Session;
}
```

## Proxy Config

代理配置。

```dart
@freezed
class ProxyConfig with _$ProxyConfig {
  const factory ProxyConfig({
    /// 代理服务器
    required ProxyServer server,

    /// 认证信息
    ProxyAuth? auth,
  }) = _ProxyConfig;
}

@freezed
class ProxyServer with _$ProxyServer {
  const factory ProxyServer({
    required String host,
    required int port,
    @Default(ProxyType.http) ProxyType type,
  }) = _ProxyServer;
}

@freezed
class ProxyAuth with _$ProxyAuth {
  const factory ProxyAuth({
    required String username,
    required String password,
  }) = _ProxyAuth;
}

enum ProxyType {
  http,
  https,
  socks5,
}
```

## Implementation

### 策略选择器

```dart
class NetworkStrategySelector {
  NetworkStrategy select(
    NetworkConfig config,
    HttpResponse? response,
  ) {
    // 1. 规则明确指定
    if (config.strategy != NetworkStrategy.http) {
      return config.strategy;
    }

    // 2. 检查是否需要回退
    if (response != null && config.fallback != null) {
      if (_shouldFallback(response, config.fallback!.trigger)) {
        return NetworkStrategy.webviewInteractive;
      }
    }

    // 3. 默认 HTTP
    return NetworkStrategy.http;
  }

  bool _shouldFallback(HttpResponse response, List<TriggerCondition> triggers) {
    for (final trigger in triggers) {
      if (trigger.statusCode != null && response.status == trigger.statusCode) {
        return true;
      }
      if (trigger.bodyRegex != null) {
        final regex = RegExp(trigger.bodyRegex!);
        if (regex.hasMatch(response.body)) {
          return true;
        }
      }
    }
    return false;
  }
}
```

### HTTP 策略执行器

```dart
class HttpStrategyExecutor {
  final RustHttpClient _client;
  final SessionManager _sessionManager;

  HttpStrategyExecutor(this._client, this._sessionManager);

  Future<Either<Failure, String>> execute({
    required String url,
    required NetworkConfig config,
    String? method,
    String? body,
  }) async {
    try {
      // 1. 加载会话 Cookie
      final session = await _sessionManager.loadSession(_extractSourceId(url));

      // 2. 合并 Cookie
      final cookies = <String, String>{
        ...?config.cookies,
        ...?session?.cookies.map((c) => MapEntry(c.name, c.value)),
      };

      // 3. 构建请求
      final request = HttpRequest(
        url: url,
        method: method ?? 'GET',
        headers: config.headers,
        body: body,
        emulation: _mapEmulation(config.emulation),
        timeoutMs: config.timeout,
        followRedirects: config.followRedirects,
      );

      // 4. 发送请求
      final response = await _client.fetch(request);

      // 5. 保存新的 Cookie
      if (response.cookies.isNotEmpty) {
        await _sessionManager.saveSession(
          sourceId: _extractSourceId(url),
          cookies: response.cookies,
        );
      }

      // 6. 检查回退
      if (config.fallback != null) {
        if (_shouldFallback(response, config.fallback!.trigger)) {
          return Left(FallbackRequiredFailure(config.fallback!));
        }
      }

      // 7. 检查状态码
      if (response.status >= 400) {
        return Left(HttpFailure(
          statusCode: response.status,
          message: 'HTTP ${response.status}',
        ));
      }

      return Right(response.body);
    } on Exception catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
```

## Platform Support

| 平台 | HTTP (Rust wreq) | WebView Interactive | 说明 |
|------|------------------|---------------------|------|
| Windows | 支持 | 支持 (InAppWebView) | 官方 CI 验证 |
| macOS | 支持 | 支持 (InAppWebView) | 官方 CI 验证 |
| Linux | 支持 | 支持 (InAppWebView) | 官方 CI 验证 |
| Android | 支持 | 支持 (Both) | 官方 CI 验证 (cargo-ndk) |
| iOS | 支持 | 支持 (Both) | 社区验证，需配置 |
| Web | 支持 (WASM) | 支持 (Official) | flutter_rust_bridge WASM |

### iOS 配置

```toml
# Cargo.toml - 避免 Debug 模式栈溢出
[profile.dev]
opt-level = 1
```

```bash
# 添加 iOS 目标
rustup target add aarch64-apple-ios aarch64-apple-ios-sim

# 编译
cargo build --target aarch64-apple-ios --release
cargo build --target aarch64-apple-ios-sim --release
```

## Dependencies

### Rust (Cargo.toml)

```toml
[dependencies]
wreq = "6.0.0-rc.28"
wreq-util = "3.0.0-rc.10"
flutter_rust_bridge = "=2.11.1"
```

### Dart (pubspec.yaml)

```yaml
dependencies:
  flutter_rust_bridge: ^2.11.1
  flutter_inappwebview: ^6.2.0-beta.3
  webview_flutter: ^4.13.1
```

## Build Requirements

### Linux

```bash
sudo apt-get install build-essential cmake perl pkg-config libclang-dev musl-tools
```

### Windows

- Visual Studio Build Tools 2022
- CMake

### macOS

- Xcode Command Line Tools
- CMake

### 编译命令

```bash
# 启用 prefix-symbols 避免符号冲突
cargo build --release --features prefix-symbols
```
