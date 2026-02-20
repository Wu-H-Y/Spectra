# 核心功能规范

## HTTP 服务器 (dartrelic)

### Requirement: RelicApp 基础

```dart
final app = RelicApp();
app.get('/api/:id', (request) async {
  final id = request.pathParameters.raw['id'];
  return Response.ok(body: Body.fromString('Hello $id'));
});
await app.serve('localhost', 8080);
```

### Requirement: 路由定义

```dart
app.get('/path/:id', handler)
app.post('/path', handler)
```

### Requirement: 响应 Body

```dart
// 字符串
Body.fromString(content)

// JSON
Body.fromString(jsonEncode(data), mimeType: MimeType.json)

// HTML
Body.fromString(html, mimeType: MimeType.html)
```

### Requirement: WebSocket 支持

```dart
WebSocketUpgrade((ws) {
  ws.sendText('Hello');
  ws.events.listen((event) { });
});
```

### Requirement: CORS 中间件

处理 preflight 请求，添加 CORS 头。

### Requirement: 错误处理中间件

捕获异常，返回 500 响应，记录日志。

---

## 日志系统 (Talker)

### Requirement: 全局 Talker 实例

```dart
final talker = Talker();
// 通过 Provider 注入
```

### Requirement: 日志级别

| 级别 | 方法 | 用途 |
|------|------|------|
| debug | `talker.debug()` | 开发调试 |
| info | `talker.info()` | 一般操作 |
| warning | `talker.warning()` | 警告 |
| error | `talker.error()` | 错误（含异常） |
| critical | `talker.critical()` | 严重错误 |

### Requirement: Riverpod 状态监听

```dart
ProviderScope(
  observers: [TalkerRiverpodObserver(talker: talker)],
);
```

### Requirement: 路由导航监听

```dart
GoRouter(
  observers: [TalkerRouteObserver(talker: talker)],
);
```

### Requirement: 禁止 print

禁止使用 `print()`, `debugPrint()`, `log()`，必须使用 Talker。

---

## 启动画面

### Requirement: 原生启动画面

使用 `flutter_native_splash`。

- **背景色**: Deep Void (`#0B0E14`)
- **Logo**: 居中显示
- **平台**: Android, iOS

### Requirement: 保持启动画面

```dart
FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
```

### Requirement: 移除启动画面

首帧渲染后移除。

```dart
WidgetsBinding.instance.addPostFrameCallback((_) {
  FlutterNativeSplash.remove();
});
```

### Requirement: 桌面窗口管理

```dart
await windowManager.setSize(Size(1280, 720));
await windowManager.setMinimumSize(Size(800, 600));
await windowManager.center();
// 首帧渲染后显示
await windowManager.show();
await windowManager.focus();
```

---

## 应用图标

### Requirement: 矢量图标源

- **位置**: `assets/icon.svg`
- **内容**: 渐变、发光效果

### Requirement: 多平台图标生成

使用 `flutter_launcher_icons` 生成：

| 平台 | 产物 |
|------|------|
| Android | Adaptive Icon |
| iOS | AppIcon Asset Catalog |
| Windows | app icon |
| macOS | app icon |
| Linux | desktop entry icon |

### Requirement: Android Adaptive Icon

- 前景层: 图标
- 背景层: 品牌色
