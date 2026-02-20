# Proposal: fpdart + hooks_riverpod + dartrelic 全面改造

## Why

当前项目采用传统的命令式错误处理（try-catch）和 flutter_riverpod 状态管理，存在以下问题：

1. **错误处理不安全**：运行时错误无法在编译时捕获，容易遗漏异常处理逻辑
2. **UI 代码冗余**：ConsumerWidget 不支持 hooks，状态复用能力有限
3. **服务器框架老化**：shelf 生态更新缓慢，dartrelic 提供更现代的 API 和更好的类型安全

通过引入 fpdart 的函数式编程范式、hooks_riverpod 的 hooks 能力、以及 dartrelic 的现代服务器框架，可以显著提升代码质量、可维护性和类型安全性。

## What Changes

### 依赖变更

**新增依赖：**
- `fpdart: ^1.2.0` - 函数式编程核心库（Either, Option, TaskEither 等）
- `hooks_riverpod: ^3.2.1` - 带 hooks 支持的 Riverpod
- `flutter_hooks: ^0.21.2` - React 风格的 hooks 支持
- `dartrelic: ^0.3.0` - 现代化 HTTP 服务器框架

**移除依赖：**
- `flutter_riverpod` - 替换为 hooks_riverpod
- `shelf` - 替换为 dartrelic
- `shelf_router` - dartrelic 内置路由
- `shelf_static` - 需要重新实现或替代
- `shelf_web_socket` - 需要重新实现或替代

### 代码变更

**BREAKING** - 所有 Widget 需要迁移：
- `ConsumerWidget` → `HookConsumerWidget`
- `ConsumerStatefulWidget` → `HookConsumerWidget`（优先使用 hooks）

**BREAKING** - 错误处理模式变更：
```dart
// 旧模式
Future<User> getUser() async {
  try {
    return await api.fetch();
  } catch (e) {
    throw Exception('Failed to fetch user');
  }
}

// 新模式
Future<Either<Failure, User>> getUser() async {
  try {
    final user = await api.fetch();
    return Right(user);
  } catch (e) {
    return Left(NetworkFailure(e.toString()));
  }
}
```

**BREAKING** - Provider 定义保持兼容：
- `@riverpod` 注解继续使用
- `ref.watch`/`ref.read` 用法不变
- ProviderScope 用法不变

**BREAKING** - HTTP 服务器完全重写：
- shelf Router → dartrelic Router
- shelf Middleware → dartrelic Middleware（签名可能不同）
- shelf_static 静态文件服务需要重新实现

## Capabilities

### New Capabilities

- **functional-error-handling**: 使用 fpdart 的 Either/Option/TaskEither 进行类型安全的错误处理，替代 try-catch
- **flutter-hooks**: 引入 flutter_hooks 提供 React 风格的状态复用能力
- **dartrelic-server**: 使用 dartrelic 替代 shelf 构建 HTTP 服务器

### Modified Capabilities

- **state-management**: 
  - 从 flutter_riverpod 迁移到 hooks_riverpod
  - Widget 基类从 ConsumerWidget 变为 HookConsumerWidget
  - Provider 定义方式保持不变
  - 新增 useProvider 等 hooks 访问方式

## Impact

### 受影响的代码

| 模块 | 文件数 | 代码行数 | 变更类型 |
|------|--------|----------|----------|
| 状态管理 | 4+ | ~200 | 中等 |
| HTTP 服务器 | 7 | ~670 | 高（重写） |
| 所有 ConsumerWidget | 1+ | 待统计 | 低 |

### 受影响的文件

**状态管理（需要迁移到 hooks_riverpod）：**
- `lib/main.dart` - ProviderScope 保持不变，SpectraApp 改为 HookConsumerWidget
- `lib/shared/providers/*.dart` - Provider 定义保持不变
- `lib/features/settings/presentation/pages/settings_page.dart` - ConsumerWidget → HookConsumerWidget

**HTTP 服务器（需要完全重写）：**
- `lib/core/server/server_provider.dart` - 重写为 dartrelic
- `lib/core/server/routes/server_routes.dart` - 重写路由定义
- `lib/core/server/routes/rules_routes.dart` - 重写路由定义
- `lib/core/server/middleware/cors_middleware.dart` - 迁移中间件
- `lib/core/server/handlers/static_handler.dart` - 重写静态文件服务
- `lib/core/server/handlers/websocket_handler.dart` - 重写 WebSocket 支持

### API 兼容性

- **Provider API**: 完全兼容，无需修改
- **Widget API**: 需要更改基类，但 ref 用法不变
- **HTTP Server API**: 完全重写，不兼容

### 迁移风险

| 风险 | 等级 | 缓解措施 |
|------|------|----------|
| hooks_riverpod 迁移不完整 | 低 | 逐个文件迁移，保持测试覆盖 |
| dartrelic API 不稳定 | 中 | 封装抽象层，便于未来替换 |
| fpdart 学习曲线 | 中 | 提供详细文档和代码示例 |
| 静态文件服务缺失 | 高 | 使用 dart:io 自行实现或寻找替代包 |

### 迁移顺序建议

1. **Phase 1**: hooks_riverpod 迁移（低风险）
   - 更新 pubspec.yaml
   - 迁移 ConsumerWidget → HookConsumerWidget
   - 验证功能正常

2. **Phase 2**: fpdart 错误处理（中等风险）
   - 定义 Failure 类型层次
   - 逐步将 try-catch 改为 Either
   - 更新 UI 层处理 Either

3. **Phase 3**: dartrelic 服务器迁移（高风险）
   - 创建 dartrelic 版本的服务器
   - 并行运行测试
   - 逐步切换
