# Refactor Crawler Rule System - Technical Design

## Context

### 背景

基于对以下项目的深入研究：

1. **Legado (阅读)** - 小说聚合器
   - 使用 Jaccard Similarity 进行章节匹配，阈值 0.96
   - 搜索窗口 +-10 章节优化性能
   - 两阶段匹配: 相似度 -> 章节号回退

2. **TachiyomiSY** - 漫画聚合器
   - 手动源合并，用户配置优先级
   - `MergedMangaReference` 追踪每个源的引用
   - 并发获取 (Semaphore 限制 5 个)

3. **n8n / Node-RED** - 工作流引擎
   - 声明式节点定义 (displayName, inputs, outputs, properties)
   - connections 分离存储，与 nodes 解耦
   - JSON Schema 验证节点配置

4. **wreq** - Rust HTTP 客户端 (核心参考)
   - TLS 指纹伪装 (JA3/JA4)
   - HTTP/2 指纹模拟
   - 100+ 预置设备配置 (wreq-util)
   - 基于 BoringSSL，支持全平台

5. **flutter_rust_bridge** - Rust FFI 代码生成
   - 自动生成双向绑定 (Dart <-> Rust)
   - 支持高级类型和 async/await
   - 同时支持原生和 Web 平台 (WASM)

### 约束

- **Flutter 跨平台**: Android, iOS, Windows, macOS, Linux
- **freezed 强制**: 所有数据模型使用 freezed
- **Pipeline 可序列化**: 支持字符串数组格式和 React Flow 格式
- **向后兼容**: 尽量保留现有选择器实现
- **Rust FFI**: 使用 flutter_rust_bridge 集成 Rust 模块
- **统一网络层**: 所有 HTTP 请求由 Rust wreq 处理

---

## Goals / Non-Goals

### Goals

1. **设计 Pipeline DSL** - 字符串数组格式，支持可视化映射
2. **实现完整生命周期** - Explore, Search, Detail, TOC, Content 五阶段
3. **Rust 统一网络层** - 使用 wreq 处理所有 HTTP 请求，支持 TLS/HTTP2 指纹
4. **实现多源聚合** - Jaccard/Levenshtein 相似度匹配
5. **重构可视化编辑器** - React Flow 节点流编辑

### Non-Goals

1. **WebView Stealth** - 不实现自动 Cloudflare 解决，复杂场景由用户手动处理
2. **后端代理** - 不依赖远程服务器执行反爬
3. **第三方验证码服务** - 不集成付费验证码求解服务
4. **移动端 headless** - 移动端不支持 headless WebView

---

## Architecture

### 整体架构

```
+------------------------------------------------------------------+
|                        Flutter UI Layer                           |
|  +--------------------+  +--------------------+  +--------------+ |
|  | Rule Editor        |  | Rule List          |  | Settings     | |
|  | (React Flow)       |  |                    |  |              | |
|  +--------------------+  +--------------------+  +--------------+ |
+------------------------------------------------------------------+
                                |
                                v
+------------------------------------------------------------------+
|                     Dart Business Layer                           |
|  +--------------------+  +--------------------+  +--------------+ |
|  | Pipeline Executor  |  | Source Aggregator  |  | Rule Manager | |
|  | (Squadron Worker)  |  |                    |  |              | |
|  +--------------------+  +--------------------+  +--------------+ |
+------------------------------------------------------------------+
                                |
                                | FFI (flutter_rust_bridge)
                                v
+------------------------------------------------------------------+
|                        Rust Layer                                 |
|  +--------------------+  +--------------------+  +--------------+ |
|  | HTTP Client        |  | Text Processor     |  | Similarity   | |
|  | (wreq + TLS 指纹)  |  | (jieba, opencc)    |  | (textdistance)|
|  +--------------------+  +--------------------+  +--------------+ |
+------------------------------------------------------------------+
                                |
                                v
+------------------------------------------------------------------+
|                        Network                                    |
|                    目标网站 (HTTP/HTTPS)                           |
+------------------------------------------------------------------+
```

### 请求处理流程

```
1. Flutter 配置规则
   |
   v
2. Dart 调用 Rust FFI: fetch(url, config)
   |
   v
3. Rust wreq 处理请求:
   - 应用 TLS 指纹 (Chrome/Firefox/Safari)
   - 应用 HTTP/2 指纹
   - 设置请求头
   - 处理重定向
   |
   v
4. 返回响应给 Dart:
   - status code
   - headers
   - body (HTML/JSON)
   |
   v
5. Dart Pipeline Executor 处理响应:
   - CSS/XPath 选择器
   - 文本变换
   - 变量插值
   |
   v
6. 返回结构化数据
```

---

## Key Designs

### 1. Rust HTTP Client API

使用 wreq 库实现 HTTP 客户端，支持 TLS 指纹伪装。

```rust
// rust/src/api/http_client.rs
use wreq::{Client, Response};
use wreq_util::Emulation;

/// 浏览器设备类型
pub enum BrowserEmulation {
    Chrome131,
    Chrome120,
    Firefox133,
    Safari18,
    Edge127,
}

/// HTTP 请求配置
pub struct HttpRequest {
    pub url: String,
    pub method: String,
    pub headers: Option<HashMap<String, String>>,
    pub body: Option<String>,
    pub emulation: BrowserEmulation,
    pub timeout_ms: u32,
    pub follow_redirects: bool,
}

/// HTTP 响应
pub struct HttpResponse {
    pub status: u16,
    pub headers: HashMap<String, String>,
    pub body: String,
    pub url: String,  // 最终 URL (重定向后)
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

    let client = Client::builder()
        .emulation(emulation)
        .timeout(Duration::from_millis(request.timeout_ms as u64))
        .redirect(if request.follow_redirects {
            wreq::redirect::Policy::default()
        } else {
            wreq::redirect::Policy::none()
        })
        .build()
        .map_err(|e| e.to_string())?;

    let mut req = match request.method.as_str() {
        "GET" => client.get(&request.url),
        "POST" => client.post(&request.url),
        _ => return Err(format!("Unsupported method: {}", request.method)),
    };

    if let Some(headers) = request.headers {
        for (key, value) in headers {
            req = req.header(&key, &value);
        }
    }

    if let Some(body) = request.body {
        req = req.body(body);
    }

    let response = req.send().await.map_err(|e| e.to_string())?;

    Ok(HttpResponse {
        status: response.status().as_u16(),
        headers: response.headers().iter()
            .map(|(k, v)| (k.to_string(), v.to_str().unwrap_or("").to_string()))
            .collect(),
        body: response.text().await.map_err(|e| e.to_string())?,
        url: response.url().to_string(),
    })
}
```

### 2. Network Config Model

```dart
// lib/core/crawler/models/network_config.dart

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
  /// HTTP 请求 (Rust wreq)
  http,

  /// 用户交互 WebView
  webviewInteractive,
}

/// 网络配置
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

/// 回退配置
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

/// 触发条件
@freezed
class TriggerCondition with _$TriggerCondition {
  const factory TriggerCondition({
    /// 状态码
    int? statusCode,

    /// 正则匹配响应体
    String? bodyRegex,
  }) = _TriggerCondition;
}

/// 回退动作
enum FallbackAction {
  /// 切换到 WebView Interactive (用户手动鉴权)
  webviewInteractive,

  /// 放弃
  abort,
}
```

### 3. HTTP Strategy Implementation

```dart
// lib/core/crawler/executor/http_strategy.dart

/// HTTP 策略实现 (调用 Rust FFI)
class HttpStrategy {
  final RustHttpClient _client;

  HttpStrategy(this._client);

  /// 发送请求
  Future<Either<Failure, String>> fetch({
    required String url,
    required NetworkConfig config,
    String? method,
    String? body,
  }) async {
    try {
      final response = await _client.fetch(
        HttpRequest(
          url: url,
          method: method ?? 'GET',
          headers: config.headers,
          body: body,
          emulation: _mapEmulation(config.emulation),
          timeoutMs: config.timeout,
          followRedirects: config.followRedirects,
        ),
      );

      // 检查回退触发条件
      if (config.fallback != null) {
        if (_shouldFallback(response, config.fallback!.trigger)) {
          return Left(FallbackRequiredFailure(config.fallback!));
        }
      }

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

  BrowserEmulation _mapEmulation(BrowserEmulation dart) {
    // 映射 Dart enum 到 Rust enum
    return dart;
  }
}
```

### 4. Pipeline Executor

```dart
// lib/core/crawler/executor/pipeline_executor.dart

/// Pipeline 执行器
class PipelineExecutor {
  final HttpStrategy _httpStrategy;
  final WebViewInteractiveStrategy _webViewStrategy;

  PipelineExecutor(this._httpStrategy, this._webViewStrategy);

  /// 执行 Pipeline
  Future<Either<Failure, Map<String, dynamic>>> execute({
    required String url,
    required NetworkConfig networkConfig,
    required Map<String, List<String>> pipeline,
  }) async {
    // 1. 获取页面内容
    final contentResult = await _fetchContent(url, networkConfig);
    if (contentResult.isLeft()) {
      return contentResult.fold(
        (failure) => Left(failure),
        (_) => throw StateError('Unexpected'),
      );
    }

    final content = contentResult.getRight()!;

    // 2. 执行 Pipeline
    final result = <String, dynamic>{};
    for (final entry in pipeline.entries) {
      final fieldResult = _executePipeline(content, entry.value);
      result[entry.key] = fieldResult;
    }

    return Right(result);
  }

  /// 获取内容 (处理回退)
  Future<Either<Failure, String>> _fetchContent(
    String url,
    NetworkConfig config,
  ) async {
    final result = await _httpStrategy.fetch(url: url, config: config);

    return result.fold(
      (failure) {
        // 处理回退
        if (failure is FallbackRequiredFailure) {
          return _handleFallback(url, failure.config);
        }
        return Left(failure);
      },
      (content) => Right(content),
    );
  }

  /// 处理回退
  Future<Either<Failure, String>> _handleFallback(
    String url,
    FallbackConfig config,
  ) async {
    switch (config.action) {
      case FallbackAction.webviewInteractive:
        return _webViewStrategy.fetch(url: url, timeout: config.timeout);
      case FallbackAction.abort:
        return Left(AbortFailure('Request aborted by fallback'));
    }
  }

  /// 执行单条 Pipeline
  dynamic _executePipeline(String input, List<String> pipeline) {
    dynamic value = input;
    for (final node in pipeline) {
      value = _executeNode(value, node);
    }
    return value;
  }

  /// 执行单个节点
  dynamic _executeNode(dynamic input, String node) {
    final parsed = parsePipelineNode(node);
    switch (parsed.type) {
      case NodeType.css:
        return _cssSelector(input, parsed.param);
      case NodeType.xpath:
        return _xpathSelector(input, parsed.param);
      case NodeType.text:
        return _extractText(input);
      case NodeType.attr:
        return _extractAttr(input, parsed.param);
      case NodeType.trim:
        return (input as String).trim();
      case NodeType.replace:
        return _replace(input, parsed.param);
      // ... 其他节点类型
    }
  }
}
```

### 5. WebView Interactive Strategy

用于需要用户手动操作的场景（登录、复杂验证码等）。

```dart
// lib/core/crawler/executor/webview_interactive_strategy.dart

/// 用户交互 WebView 策略
class WebViewInteractiveStrategy {
  final WebViewStrategy _webView;
  final SessionManager _sessionManager;

  WebViewInteractiveStrategy(this._webView, this._sessionManager);

  /// 获取内容 (用户交互)
  Future<Either<Failure, String>> fetch({
    required String url,
    required int timeout,
  }) async {
    try {
      // 1. 检查是否有保存的会话
      final session = await _sessionManager.loadSession(url);
      if (session != null) {
        // 尝试使用保存的 Cookie
        final result = await _tryWithSession(url, session);
        if (result.isRight()) {
          return result;
        }
      }

      // 2. 显示 WebView 让用户操作
      final completer = Completer<Either<Failure, String>>();

      await _webView.loadUrl(
        url,
        onComplete: (html) {
          completer.complete(Right(html));
        },
        onError: (error) {
          completer.complete(Left(WebviewFailure(error)));
        },
      );

      // 3. 等待用户完成或超时
      return completer.future.timeout(
        Duration(milliseconds: timeout),
        onTimeout: () => Left(TimeoutFailure('User interaction timeout')),
      );
    } on Exception catch (e) {
      return Left(WebviewFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> _tryWithSession(
    String url,
    Session session,
  ) async {
    // 使用保存的 Cookie 尝试请求
    await _webView.setCookies(session.cookies);
    // ... 尝试逻辑
  }
}
```

---

## Platform Support

| 平台 | HTTP (Rust wreq) | WebView Interactive | 说明 |
|------|------------------|---------------------|------|
| Windows | 支持 | 支持 (InAppWebView) | 官方 CI 验证 |
| macOS | 支持 | 支持 (InAppWebView) | 官方 CI 验证 |
| Linux | 支持 | 支持 (InAppWebView) | 官方 CI 验证 |
| Android | 支持 | 支持 (Both) | 官方 CI 验证 (cargo-ndk) |
| iOS | 支持 | 支持 (Both) | 社区验证，需配置 |
| Web | 支持 (WASM) | 支持 (Official) | flutter_rust_bridge WASM |

### iOS 特殊配置

iOS 平台需要额外配置：

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

**已知问题**:
- Debug 模式栈溢出：设置 `opt-level = 1` 或更新到 wreq-util v3.0.0-rc.2+
- Xcode 16.4+ bindgen：更新 bindgen 到最新版本

**策略选择建议**:
1. 优先使用 HTTP (Rust wreq) 策略
2. 遇到反爬 (403/Cloudflare) 时回退到 WebView Interactive
3. 移动端和桌面端策略一致

---

## Dependencies

### Rust (Cargo.toml)

```toml
[dependencies]
flutter_rust_bridge = "=2.11.1"

# HTTP 客户端 (TLS 指纹)
wreq = "6.0.0-rc.28"
wreq-util = "3.0.0-rc.10"

# 中文处理
jieba-rs = { version = "0.8.1", features = ["default-dict", "tfidf"] }
chinese-number = "0.7.8"
ferrous-opencc = "0.3.1"

# 相似度计算
textdistance = "1.1.1"

# 日志
log = "0.4.29"
```

### Dart (pubspec.yaml)

```yaml
dependencies:
  # 已有
  freezed: latest
  freezed_annotation: latest
  json_serializable: latest
  build_runner: latest
  relic: ^1.0.0

  # Rust FFI
  flutter_rust_bridge: ^2.11.1

  # Isolate 并行
  squadron: latest
  squadron_builder: latest

  # WebView (用户交互)
  flutter_inappwebview: ^6.2.0-beta.3
  webview_flutter: ^4.13.1
```

---

## Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| wreq 编译复杂 | 高 | 提供预编译脚本，CI/CD 自动构建 |
| BoringSSL 符号冲突 | 中 | 使用 prefix-symbols feature |
| WebView 交互体验 | 中 | 提供清晰的用户引导 |
| TLS 指纹被检测 | 中 | 定期更新 wreq-util 设备配置 |

---

## Implementation Notes

1. **wreq 编译**
   - Linux: 需要 build-essential, cmake, perl, pkg-config, libclang-dev
   - Windows: 需要 Visual Studio Build Tools
   - macOS: 需要 Xcode Command Line Tools

2. **Cookie 同步**
   - Rust HTTP 和 WebView 之间的 Cookie 需要手动同步
   - 使用 SessionManager 统一管理

3. **错误处理**
   - 所有错误使用 Either<Failure, T> 返回
   - 用户看到的错误信息需要国际化
