# 状态管理规范

## 核心技术栈

- **hooks_riverpod** + **flutter_hooks**: 状态管理
- **fpdart**: 函数式编程 (Either, TaskEither, Option)

---

## Provider 规范

### Requirement: ProviderScope 包裹应用

应用根节点必须包裹 ProviderScope。

#### Scenario: 应用初始化
- **WHEN** 应用启动
- **THEN** ProviderScope 作为根 Widget 包裹 SpectraApp

### Requirement: 代码生成 Provider

使用 `@riverpod` 注解生成类型安全的 Provider。

```dart
@riverpod
class Example extends _$Example {
  @override
  String build() => 'initial';
}
```

#### Scenario: Provider 定义
- **WHEN** 定义 Provider
- **THEN** 使用 `@riverpod` 注解，继承 `_$ClassName`

### Requirement: Provider 放置位置

- **全局 Provider**: `lib/shared/providers/`
- **功能 Provider**: `lib/features/<feature>/presentation/providers/`

---

## Widget 规范

### Requirement: HookConsumerWidget 基类

需要 Provider 访问的 Widget 继承 `HookConsumerWidget`。

```dart
class MyWidget extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 同时支持 hooks 和 providers
  }
}
```

#### Scenario: Widget 同时使用 hooks 和 providers
- **WHEN** Widget 需要 hooks 和 provider
- **THEN** 继承 `HookConsumerWidget`

---

## Hooks 规范

### Requirement: useState 管理本地状态

```dart
final count = useState(0);
count.value++;  // 触发重建
```

### Requirement: useEffect 处理副作用

```dart
useEffect(() {
  // 初始化逻辑
  return () {
    // 清理逻辑（可选）
  };
}, [dependency]);  // 依赖数组
```

### Requirement: useMemoized 缓存计算

```dart
final result = useMemoized(
  () => expensiveComputation(data),
  [data],
);
```

### Requirement: Controller hooks

```dart
final controller = useTextEditingController();
final animation = useAnimationController();
final focusNode = useFocusNode();
```

### Requirement: Hooks 规则

- 必须在 build 方法顶层无条件调用
- 调用顺序在每次 build 中必须一致
- 禁止在条件语句、循环、嵌套函数中调用

---

## 错误处理规范

### Requirement: Either 类型处理错误

使用 `Either<L, R>` 表示可能失败的操作。

```dart
Future<Either<Failure, User>> fetchUser(String id);
```

#### Scenario: 成功返回 Right
- **WHEN** 操作成功
- **THEN** 返回 `Right(value)`

#### Scenario: 失败返回 Left
- **WHEN** 操作失败
- **THEN** 返回 `Left(Failure)`

### Requirement: Option 类型处理可空值

```dart
Option<User> findUser(String id);
// Some(value) 或 None()
```

### Requirement: TaskEither 处理异步操作

```dart
TaskEither<Failure, Data> fetchData();
```

### Requirement: Failure 类型层次

```dart
@freezed
sealed class AppFailure with _$AppFailure {
  const factory AppFailure.network() = _Network;
  const factory AppFailure.server(int code) = _Server;
  const factory AppFailure.validation(String field) = _Validation;
  const factory AppFailure.unknown(Object? error) = _Unknown;
}
```

### Requirement: UI 显式处理 Either

```dart
result.fold(
  (failure) => ErrorWidget(message: failure.localizedMessage(context)),
  (data) => DataWidget(data: data),
);
```
