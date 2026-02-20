# 路由规范

## 技术栈

- **go_router**: 声明式路由
- **go_router_builder**: 类型安全路由生成

---

## 路由定义

### Requirement: 声明式类型安全路由

使用 `@TypedGoRoute` 注解定义路由。

```dart
@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}
```

### Requirement: Router Provider 集成

```dart
@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    routes: $appRoutes,
    errorBuilder: (context, state) => const ErrorPage(),
  );
}
```

---

## 导航规范

### Requirement: 类型安全导航

```dart
// ✅ 正确
context.push(const HomeRoute());
context.push(VideoRoute(id: '123'));

// ❌ 错误
context.push('/');
context.push('/video/123');
```

### Requirement: 基础路由

| 路由类 | 路径 | 页面 |
|--------|------|------|
| HomeRoute | `/` | HomePage |
| SettingsRoute | `/settings` | SettingsPage |

---

## 错误处理

### Requirement: 自定义错误页面

```dart
@TypedGoRoute<ErrorRoute>(path: '/error')
class ErrorRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ErrorPage();
  }
}
```

#### Scenario: 未知路由
- **WHEN** 导航到未定义路由
- **THEN** 显示 404 错误页面

#### Scenario: 错误恢复
- **WHEN** 导航错误
- **THEN** 用户可返回首页

---

## 首页规范

### Requirement: 首页结构

- **AppBar**: 显示 Spectra 品牌，使用 Orbitron 字体
- **欢迎区**: 品牌风格内容，支持国际化
- **功能导航**: 卡片式导航到各功能模块

### Requirement: 主题应用

- **背景色**: Deep Void (`#0B0E14`)
- **主色**: Cyber Cyan (`#00F2FF`)
- **次色**: Electric Violet (`#7000FF`)

### Requirement: 文件位置

```
lib/features/home/
├── presentation/
│   ├── pages/
│   │   └── home_page.dart
│   └── widgets/
│       └── feature_card.dart
```
