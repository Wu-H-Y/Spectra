# Design: fpdart + hooks_riverpod + dartrelic 全面改造

## Context

### 当前状态

Spectra 项目当前使用以下技术栈：

| 组件 | 当前方案 | 问题 |
|------|----------|------|
| 错误处理 | try-catch + Exception | 运行时错误，编译时无法保证处理 |
| 状态管理 | flutter_riverpod + riverpod_generator | 功能完整，但无 hooks 支持 |
| HTTP 服务器 | shelf + shelf_router + shelf_static + shelf_web_socket | 生态老化，API 不够现代 |

### 利益相关者

- **开发者**：需要学习函数式编程范式和 hooks 模式
- **用户**：受益于更稳定的应用（编译时错误检查）
- **维护者**：代码更易维护和测试

### 约束条件

1. **向后兼容**：Provider 定义保持不变，仅修改消费层
2. **渐进式迁移**：支持新旧代码并存，逐步迁移
3. **最小破坏**：优先选择兼容性好的方案
4. **版本约束**：
   - fpdart: ^1.2.0
   - hooks_riverpod: ^3.2.1（与 flutter_riverpod 版本一致）
   - flutter_hooks: ^0.21.2
   - dartrelic: ^0.3.0（需要验证 API 稳定性）

---

## Goals / Non-Goals

### Goals

1. **类型安全错误处理**：使用 fpdart 的 Either/Option/TaskEither 在编译时强制处理错误
2. **Hooks 集成**：使用 hooks_riverpod 和 flutter_hooks 简化本地状态管理
3. **现代 HTTP 服务器**：使用 dartrelic 替代 shelf，获得更好的类型安全和 API
4. **渐进式迁移**：支持分阶段迁移，不要求一次性重写所有代码
5. **保持现有模式**：@riverpod 注解和代码生成方式保持不变

### Non-Goals

1. **不重写业务逻辑**：仅改变错误处理方式，不改变业务行为
2. **不引入新的架构模式**：保持 Feature-First Clean Architecture
3. **不修改数据库层**：Drift 和 Hive 的使用方式不变
4. **不强制所有 Widget 使用 hooks**：简单 Widget 可以继续使用 ConsumerWidget

---

## Decisions

### Decision 1: fpdart 版本选择

**决定**：使用 `fpdart: ^1.2.0`

**理由**：
- fpdart 1.x 是目前 Dart 生态中最完善的函数式编程库
- dartz 已不再活跃维护
- fpdart 提供完整的 Either、Option、TaskEither 实现
- 社区活跃，文档完善

**替代方案**：
- `dartz`：已不再维护，不推荐
- `either_option`：功能有限，社区小
- 自行实现：维护成本高，不推荐

---

### Decision 2: Either 的错误类型设计

**决定**：使用 sealed class 定义 Failure 类型层次

```dart
/// 基础 Failure 类型
sealed class Failure {
  const Failure(this.message);
  final String message;
}

/// 网络相关错误
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// 数据库相关错误
final class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

/// 验证相关错误
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// 解析相关错误
final class ParseFailure extends Failure {
  const ParseFailure(super.message);
}

/// 未知错误
final class UnknownFailure extends Failure {
  const UnknownFailure(super.message, [this.stackTrace]);
  final StackTrace? stackTrace;
}
```

**理由**：
- sealed class 支持 exhaustive pattern matching
- 每个 Failure 类型可携带不同的上下文信息
- 与 fpdart 的 Either 配合使用，强制处理所有错误情况

**替代方案**：
- 使用 String 作为错误类型：失去类型安全，不推荐
- 使用 Exception 子类：与 fpdart 模式不符
- 使用 record 类型：Dart 3 支持，但 sealed class 更适合此场景

---

### Decision 3: Repository 层返回类型

**决定**：Repository 方法返回 `Future<Either<Failure, T>>`

**理由**：
- 与现有 async/await 模式兼容
- 调用方必须显式处理错误
- 不改变现有架构，仅改变返回类型

**示例**：
```dart
// 旧代码
abstract class RuleRepository {
  Future<List<Rule>> getAll();
  Future<Rule> getById(String id);
  Future<void> save(Rule rule);
}

// 新代码
abstract class RuleRepository {
  Future<Either<Failure, List<Rule>>> getAll();
  Future<Either<Failure, Rule>> getById(String id);
  Future<Either<Failure, void>> save(Rule rule);
}
```

---

### Decision 4: UseCase 层使用 TaskEither

**决定**：UseCase 的 `call()` 方法返回 `TaskEither<Failure, T>`

**理由**：
- TaskEither 提供更好的组合能力（flatMap, andThen）
- 延迟执行，便于测试
- 与 fpdart 的函数式风格一致

**示例**：
```dart
class GetRuleUseCase {
  final RuleRepository _repository;
  
  GetRuleUseCase(this._repository);
  
  TaskEither<Failure, Rule> call(String id) {
    return TaskEither.tryCatch(
      () => _repository.getById(id).then((result) => result.getOrElse(
        (failure) => throw failure,
      )),
      (error, _) => error as Failure,
    );
  }
}
```

**替代方案**：
- 返回 `Future<Either>`：更简单，但组合能力弱
- 返回 `Either<Failure, Future<T>>`：不符合 Either 的语义

---

### Decision 5: Provider 与 fpdart 的集成

**决定**：Provider 返回 AsyncValue 包装的 Either

```dart
@riverpod
class RuleDetail extends _$RuleDetail {
  @override
  Future<Either<Failure, Rule>> build(String id) async {
    return _getRuleUseCase(id).run();
  }
}

// UI 层处理
class RuleDetailPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ruleState = ref.watch(ruleDetailProvider(id));
    
    return ruleState.when(
      data: (either) => either.fold(
        (failure) => ErrorWidget(message: failure.message),
        (rule) => RuleContent(rule: rule),
      ),
      loading: () => LoadingIndicator(),
      error: (e, st) => ErrorWidget(message: e.toString()),
    );
  }
}
```

**理由**：
- AsyncValue 提供 loading/error 状态管理
- Either 提供业务错误处理
- 两者职责分离，各司其职

---

### Decision 6: Widget 基类迁移策略

**决定**：渐进式迁移，优先迁移 HookConsumerWidget

**迁移优先级**：
1. **高优先级**：包含多个 Controller 的 StatefulWidget
2. **中优先级**：需要本地状态的 ConsumerWidget
3. **低优先级**：简单的只读 ConsumerWidget

**迁移模式**：
```dart
// 旧代码
class SettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ...
  }
}

// 新代码
class SettingsPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 可以使用 hooks
    final scrollController = useScrollController();
    // ...
  }
}
```

---

### Decision 7: dartrelic 服务器架构

**决定**：完全重写 HTTP 服务器，使用 dartrelic

**新架构**：
```
lib/core/server/
├── server.dart              # 导出文件
├── server_provider.dart     # Riverpod Provider
├── router/                  # 路由定义
│   ├── app_router.dart      # 主路由
│   ├── rules_router.dart    # 规则 API 路由
│   └── server_router.dart   # 服务器控制路由
├── middleware/              # 中间件
│   ├── cors_middleware.dart
│   ├── logging_middleware.dart
│   └── error_middleware.dart
├── handlers/                # 处理器
│   ├── static_handler.dart  # 静态文件服务（dart:io 实现）
│   └── websocket_handler.dart
└── context/                 # 请求上下文
    └── context_properties.dart
```

**理由**：
- dartrelic 的类型安全 API 更现代
- 内置 WebSocket 支持，无需额外依赖
- 路由和中间件模式更清晰

**替代方案**：
- 保留 shelf：生态老化，不推荐
- 使用 shelf + dartrelic 混合：复杂度高，不推荐

---

### Decision 8: 静态文件服务实现

**决定**：使用 dart:io 自行实现静态文件处理器

**理由**：
- dartrelic 没有内置静态文件服务
- shelf_static 不兼容 dartrelic
- dart:io 的 File API 足够简单

**实现要点**：
```dart
Handler createStaticHandler(String rootPath) {
  return (Request request) async {
    final path = request.uri.path;
    final file = File('$rootPath$path');
    
    if (!await file.exists()) {
      return Response.notFound(body: Body.fromString('Not Found'));
    }
    
    final mimeType = _getMimeType(path);
    final content = await file.readAsString();
    
    return Response.ok(
      body: Body.fromString(content, mimeType: mimeType),
    );
  };
}
```

---

## Risks / Trade-offs

### Risk 1: fpdart 学习曲线

**风险**：团队成员不熟悉函数式编程，可能导致代码质量下降

**缓解措施**：
- 提供详细的代码示例和文档
- 新功能使用 fpdart，旧功能渐进迁移
- Code Review 重点关注函数式模式的使用

### Risk 2: dartrelic API 不稳定

**风险**：dartrelic 版本较新，API 可能变化

**缓解措施**：
- 封装服务器抽象层，便于未来替换
- 保持测试覆盖，API 变化时快速发现问题
- 关注 dartrelic 的 changelog

### Risk 3: 迁移工作量大

**风险**：HTTP 服务器需要完全重写，工作量大

**缓解措施**：
- 分阶段迁移：先 hooks_riverpod，再 fpdart，最后 dartrelic
- 并行开发：新服务器与旧服务器可以共存测试
- 充分测试：每个阶段完成后进行全面测试

### Risk 4: 性能影响

**风险**：fpdart 的 Either/TaskEither 可能带来性能开销

**缓解措施**：
- Flutter UI 层通常不是性能瓶颈
- 必要时使用 profiling 工具验证
- 对于热点路径，可以保留传统模式

### Trade-off 1: 代码复杂度 vs 类型安全

**权衡**：Either 模式增加了代码复杂度，但提供了编译时类型安全

**决策**：接受复杂度增加，换取更高的代码质量

### Trade-off 2: 灵活性 vs 一致性

**权衡**：渐进式迁移提供灵活性，但可能导致代码风格不一致

**决策**：制定迁移计划，在合理时间内完成全面迁移

---

## Migration Plan

### Phase 1: hooks_riverpod 迁移（1-2 天）

1. 更新 pubspec.yaml：
   ```yaml
   dependencies:
     hooks_riverpod: ^3.2.1
     flutter_hooks: ^0.21.2
     # 移除 flutter_riverpod
   ```

2. 迁移 Widget 基类：
   - `main.dart`: SpectraApp → HookConsumerWidget
   - `settings_page.dart`: SettingsPage → HookConsumerWidget

3. 验证：
   - `flutter analyze`
   - 手动测试应用功能

### Phase 2: fpdart 集成（3-5 天）

1. 添加依赖：
   ```yaml
   dependencies:
     fpdart: ^1.2.0
   ```

2. 定义 Failure 类型：
   - 创建 `lib/core/errors/failures.dart`
   - 定义 sealed class 层次结构

3. 迁移顺序：
   - 新功能优先使用 Either
   - Repository 层逐步迁移
   - UseCase 层使用 TaskEither
   - UI 层处理 Either

4. 验证：
   - 单元测试覆盖错误处理路径
   - 集成测试验证端到端流程

### Phase 3: dartrelic 服务器迁移（3-5 天）

1. 添加依赖：
   ```yaml
   dependencies:
     relic: ^0.3.0
   # 移除 shelf, shelf_router, shelf_static, shelf_web_socket
   ```

2. 重写服务器：
   - 创建 `RelicApp` 实例
   - 迁移路由定义（`<id>` → `:id`）
   - 迁移中间件
   - 实现静态文件服务
   - 迁移 WebSocket

3. 验证：
   - API 端点测试
   - WebSocket 连接测试
   - 静态文件服务测试

### Rollback Strategy

每个阶段都可以独立回滚：

1. **Phase 1 回滚**：恢复 `flutter_riverpod`，恢复 ConsumerWidget
2. **Phase 2 回滚**：移除 fpdart 依赖，恢复 try-catch 模式
3. **Phase 3 回滚**：恢复 shelf 依赖，恢复旧服务器代码

---

## Open Questions

1. **dartrelic 版本选择**：dartrelic 的最新稳定版本是多少？API 是否稳定？
   - 待确认：访问 pub.dev 查询最新版本

2. **WebSocket 实现细节**：dartrelic 的 WebSocket API 是否满足需求？
   - 待验证：创建 POC 验证 WebSocket 功能

3. **静态文件服务性能**：dart:io 实现的静态文件服务性能是否足够？
   - 待验证：压力测试静态文件服务

4. **国际化错误消息**：Failure 类型的 message 如何国际化？
   - 待决策：使用 l10n key 还是直接使用翻译后的消息

5. **测试策略**：如何为 Either 返回类型编写单元测试？
   - 待制定：创建测试模板和最佳实践文档
