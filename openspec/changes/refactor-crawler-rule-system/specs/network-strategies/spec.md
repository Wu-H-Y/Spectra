# Network Strategies

## Overview

网络策略模块提供多种请求方式，从简单的 HTTP 到完整的浏览器模拟，支持各种反爬场景。

## Strategies

### 1. HTTP Strategy

纯 HTTP 请求，最快但容易被检测。

```dart
@freezed
class HttpStrategy with _$HttpStrategy {
  const factory HttpStrategy({
    /// TLS 指纹配置
    TlsFingerprint? tls,
    
    /// 请求头
    Map<String, String>? headers,
    
    /// Cookie
    Map<String, String>? cookies,
    
    /// 超时 (ms)
    @Default(15000) int timeout,
    
    /// 重定向
    @Default(true) bool followRedirects,
  }) = _HttpStrategy;
}
```

**适用场景**:
- 无反爬保护的 API
- 静态 HTML 页面
- 快速批量请求

### 2. WebView Headless Strategy

无头浏览器，自动执行 JavaScript。

```dart
@freezed
class WebViewHeadlessStrategy with _$WebViewHeadlessStrategy {
  const factory WebViewHeadlessStrategy({
    /// 浏览器指纹
    BrowserFingerprint? fingerprint,
    
    /// 等待策略
    @Default(WaitStrategy.networkIdle) WaitStrategy waitStrategy,
    
    /// 等待超时 (ms)
    @Default(30000) int waitTimeout,
    
    /// 执行前动作
    List<CrawlerAction>? beforeActions,
    
    /// Cookie 同步
    @Default(true) bool syncCookies,
  }) = _WebViewHeadlessStrategy;
}

enum WaitStrategy {
  /// 等待网络空闲
  networkIdle,
  
  /// 等待 DOM 内容加载
  domContentLoaded,
  
  /// 等待特定元素
  selector,
  
  /// 固定等待时间
  fixed,
}
```

**适用场景**:
- JavaScript 渲染页面
- Cloudflare 五秒盾 (部分)
- 动态加载内容

### 3. WebView Interact Strategy

交互式浏览器，需要用户操作。

```dart
@freezed
class WebViewInteractStrategy with _$WebViewInteractStrategy {
  const factory WebViewInteractStrategy({
    /// 是否显示界面
    @Default(true) bool showUI,
    
    /// 超时 (ms)
    @Default(120000) int timeout,
    
    /// 成功检测
    SuccessDetection? successDetection,
    
    /// 完成后回调
    @Default(true) bool syncCookiesOnComplete,
  }) = _WebViewInteractStrategy;
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
- 复杂验证码
- 人工确认场景

## TLS Fingerprint

模拟真实浏览器的 TLS 握手特征。

```dart
@freezed
class TlsFingerprint with _$TlsFingerprint {
  const factory TlsFingerprint({
    /// 模拟的浏览器
    @Default(BrowserType.chrome120) BrowserType browser,
    
    /// 是否使用 curl-impersonate
    @Default(true) bool useImpersonate,
  }) = _TlsFingerprint;
}

enum BrowserType {
  chrome110,
  chrome120,
  chrome130,
  firefox110,
  safari156,
  safari17,
  edge101,
}
```

**实现方式**:
- 使用 `curl_cffi` (Python) 或 `curl-impersonate` 模拟
- Dart 端可通过 FFI 调用

## Browser Fingerprint

修补 headless 浏览器的检测点。

```dart
@freezed
class BrowserFingerprint with _$BrowserFingerprint {
  const factory BrowserFingerprint({
    /// 隐藏 webdriver 标志
    @Default(true) bool hideWebdriver,
    
    /// 模拟 Chrome runtime
    @Default(true) bool mockChromeRuntime,
    
    /// 模拟权限 API
    @Default(true) bool mockPermissions,
    
    /// 模拟插件列表
    @Default(true) bool mockPlugins,
    
    /// 模拟语言
    @Default(true) bool mockLanguages,
    
    /// WebGL 厂商信息
    @Default(true) bool mockWebGL,
    
    /// 媒体设备
    @Default(true) bool mockMediaDevices,
    
    /// User Agent (空则自动)
    String? userAgent,
    
    /// 视口
    Viewport? viewport,
    
    /// 时区
    String? timezone,
    
    /// 语言
    String? language,
  }) = _BrowserFingerprint;
}

@freezed
class Viewport with _$Viewport {
  const factory Viewport({
    required int width,
    required int height,
    double? deviceScaleFactor,
    bool? isMobile,
    bool? hasTouch,
  }) = _Viewport;
}
```

**检测点修补** (参考 playwright-stealth):

| 检测点 | 修补方式 |
|--------|---------|
| navigator.webdriver | 删除属性 |
| Chrome runtime | 注入模拟对象 |
| Permissions API | 返回默认权限 |
| Plugin array | 注入真实插件信息 |
| WebGL vendor | 修改渲染器信息 |
| iframe contentWindow | 修补差异 |

## Request Interceptors

请求拦截器，在发送前或失败后执行。

```dart
@freezed
class Interceptors with _$Interceptors {
  const factory Interceptors({
    /// 请求前拦截
    List<Interceptor>? onBeforeRequest,
    
    /// 失败回退
    FallbackConfig? onFallback,
  }) = _Interceptors;
}

@freezed
class Interceptor with _$Interceptor {
  const factory Interceptor({
    /// 类型
    required InterceptorType type,
    
    /// JS 脚本 (type = js)
    String? script,
    
    /// 自定义头 (type = headers)
    Map<String, String>? headers,
  }) = _Interceptor;
}

enum InterceptorType {
  js,
  headers,
  sign,
}
```

**使用示例**:

```json
{
  "interceptors": {
    "onBeforeRequest": [
      {
        "type": "js",
        "script": "const token = generateSign(request.url); request.headers['X-Auth'] = token; return request;"
      }
    ]
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
    required FallbackAction action,
    
    /// 解决超时 (ms)
    @Default(30000) int timeout,
    
    /// 同步 Cookie
    @Default(true) bool syncCookies,
    
    /// 最大重试次数
    @Default(3) int maxRetries,
  }) = _FallbackConfig;
}

@freezed
class TriggerCondition with _$TriggerCondition {
  const factory TriggerCondition({
    /// 状态码
    int? statusCode,
    
    /// 正则匹配响应体
    String? bodyRegex,
    
    /// 响应头匹配
    String? headerPattern,
  }) = _TriggerCondition;
}

enum FallbackAction {
  /// 切换到 WebView 解决
  webviewSolve,
  
  /// 切换代理
  switchProxy,
  
  /// 等待重试
  waitRetry,
  
  /// 放弃
  abort,
}
```

**使用示例**:

```json
{
  "onFallback": {
    "trigger": [
      { "statusCode": 403 },
      { "statusCode": 503 },
      { "bodyRegex": "Cloudflare|cf-browser-verification" }
    ],
    "action": "webviewSolve",
    "timeout": 30000,
    "syncCookies": true
  }
}
```

## Proxy Config

代理配置。

```dart
@freezed
class ProxyConfig with _$ProxyConfig {
  const factory ProxyConfig({
    /// 代理列表
    required List<ProxyServer> servers,
    
    /// 轮换策略
    @Default(ProxyRotation.roundRobin) ProxyRotation rotation,
    
    /// 失败切换
    @Default(true) bool failover,
    
    /// 验证 URL
    String? testUrl,
  }) = _ProxyConfig;
}

@freezed
class ProxyServer with _$ProxyServer {
  const factory ProxyServer({
    /// 服务器地址
    required String host,
    
    /// 端口
    required int port,
    
    /// 类型
    required ProxyType type,
    
    /// 用户名
    String? username,
    
    /// 密码
    String? password,
    
    /// 权重
    @Default(1) int weight,
  }) = _ProxyServer;
}

enum ProxyType {
  http,
  https,
  socks5,
}

enum ProxyRotation {
  /// 顺序轮换
  roundRobin,
  
  /// 随机选择
  random,
  
  /// 按权重
  weighted,
  
  /// 固定使用第一个
  fixed,
}
```

## Implementation

### 策略选择器

```dart
class NetworkStrategySelector {
  NetworkStrategy select(
    CrawlerRule rule,
    DetectionResult detection,
  ) {
    // 1. 规则明确指定
    if (rule.network.strategy != null) {
      return rule.network.strategy!;
    }
    
    // 2. 根据检测结果选择
    if (detection.requiresBrowser) {
      return detection.requiresUserInteraction
          ? NetworkStrategy.webviewInteract
          : NetworkStrategy.webviewHeadless;
    }
    
    // 3. 默认 HTTP
    return NetworkStrategy.http;
  }
}
```

### 指纹注入脚本

```javascript
// 隐藏 webdriver
Object.defineProperty(navigator, 'webdriver', { get: () => undefined });

// 模拟 Chrome runtime
window.chrome = { runtime: {} };

// 模拟权限
const originalQuery = window.navigator.permissions.query;
window.navigator.permissions.query = (parameters) => (
  parameters.name === 'notifications' ?
    Promise.resolve({ state: Notification.permission }) :
    originalQuery(parameters)
);
```

## Platform Support

| 平台 | HTTP | WebView Headless | WebView Interact |
|------|------|------------------|------------------|
| Windows | ✅ | ✅ (InAppWebView) | ✅ (InAppWebView) |
| macOS | ✅ | ✅ (InAppWebView) | ✅ (InAppWebView) |
| Linux | ✅ | ✅ (InAppWebView) | ✅ (InAppWebView) |
| Android | ✅ | ✅ (InAppWebView) | ✅ (Both) |
| iOS | ✅ | ✅ (InAppWebView) | ✅ (Both) |
| Web | ✅ | ❌ | ✅ (Official) |

**移动端限制**:
- iOS 不支持 headless WebView
- Android headless 功能有限
- 建议移动端使用 HTTP + 后端代理

## WebView Engine Selection

### 双引擎架构

```dart
/// WebView 策略抽象
abstract class WebViewStrategy {
  /// 加载 URL
  Future<void> loadUrl(String url);
  
  /// 执行 JavaScript
  Future<String?> evaluateJs(String script);
  
  /// Headless 模式运行
  Future<void> runHeadless(String url);
  
  /// 请求拦截流
  Stream<NetworkRequest>? interceptRequests();
  
  /// 设置 Cookie
  Future<void> setCookies(List<Cookie> cookies);
  
  /// 设置代理
  Future<void> setProxy(ProxyConfig? proxy);
  
  /// 是否支持 Headless
  bool get supportsHeadless;
  
  /// 是否支持请求拦截
  bool get supportsInterception;
}
```

### InAppWebView 策略 (flutter_inappwebview)

```dart
class InAppWebViewStrategy implements WebViewStrategy {
  HeadlessInAppWebView? _headlessWebView;
  InAppWebViewController? _controller;
  
  @override
  bool get supportsHeadless => true;
  
  @override
  bool get supportsInterception => true;
  
  @override
  Future<void> runHeadless(String url) async {
    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(url)),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        useShouldInterceptRequest: true,
      ),
      onLoadStop: (controller, url) async {
        _controller = controller;
      },
    );
    await _headlessWebView!.run();
  }
  
  @override
  Stream<NetworkRequest>? interceptRequests() {
    // 通过 shouldInterceptRequest 实现
  }
}
```

### Official WebView 策略 (webview_flutter)

```dart
class OfficialWebViewStrategy implements WebViewStrategy {
  WebViewController? _controller;
  
  @override
  bool get supportsHeadless => false;
  
  @override
  bool get supportsInterception => false;
  
  @override
  Future<void> runHeadless(String url) async {
    throw UnsupportedError('Official WebView does not support headless mode');
  }
  
  @override
  Stream<NetworkRequest>? interceptRequests() {
    return null; // 不支持
  }
}
```

### 策略选择器

```dart
class WebViewStrategySelector {
  static WebViewStrategy select({
    required bool requiresHeadless,
    required bool requiresInterception,
  }) {
    // Web 平台只能用官方 WebView
    if (kIsWeb) {
      return OfficialWebViewStrategy();
    }
    
    // 需要 Headless 或请求拦截 → InAppWebView
    if (requiresHeadless || requiresInterception) {
      return InAppWebViewStrategy();
    }
    
    // 桌面平台 → InAppWebView (唯一支持)
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return InAppWebViewStrategy();
    }
    
    // 默认 → InAppWebView (功能更全)
    return InAppWebViewStrategy();
  }
}
```

### 依赖配置

```yaml
# pubspec.yaml
dependencies:
  # WebView 主力引擎 (全平台 + Headless)
  flutter_inappwebview: ^6.2.0-beta.3
  
  # WebView 备选引擎 (官方维护 + Web 平台)
  webview_flutter: ^4.13.1
  webview_flutter_android: ^4.10.11
  webview_flutter_wkwebview: ^3.23.7
```
