# 函数式编程指南

本文档描述 Spectra 项目中使用的函数式编程模式，基于 `fpdart` 库实现。

## 概述

Spectra 采用函数式编程范式来处理错误和副作用，主要使用以下概念：

- **Either**: 表示可能成功或失败的结果
- **TaskEither**: 表示可能成功或失败的异步操作
- **Option**: 表示可能存在或不存在的值
- **Failure**: 统一的错误类型层次

## 核心概念

### Failure 类型层次

所有错误都继承自 `Failure` sealed class：

```dart
// lib/core/functional/failures.dart

sealed class Failure {
  const Failure(this.message);
  final String message;
}

final class NetworkFailure extends Failure { ... }
final class DatabaseFailure extends Failure { ... }
final class ValidationFailure extends Failure { ... }
final class ParseFailure extends Failure { ... }
final class CrawlerFailure extends Failure { ... }
final class ServerFailure extends Failure { ... }
final class UnknownFailure extends Failure { ... }
```

### Either 类型

`Either<L, R>` 表示一个值可能是 `Left<L>`（错误）或 `Right<R>`（成功）：

```dart
// 返回 Either 的函数
Either<Failure, User> getUser(String id) {
  if (id.isEmpty) {
    return Left(ValidationFailure('ID 不能为空'));
  }
  return Right(User(id: id, name: 'Test'));
}

// 使用 fold 处理结果
final result = getUser('123');
result.fold(
  (failure) => print('错误: ${failure.message}'),
  (user) => print('用户: ${user.name}'),
);
```

### TaskEither 类型

`TaskEither<L, R>` 是返回 `Either` 的异步操作：

```dart
// 使用 taskEitherFrom 包装异步操作
final fetchUser = taskEitherFrom(() => dio.get('/user/123'));

// 链式操作
fetchUser
  .flatMap((response) => taskEitherFrom(() => parseUser(response.data)))
  .map((user) => user.name)
  .run()
  .then((result) {
    result.fold(
      (failure) => handleError(failure),
      (name) => print('用户名: $name'),
    );
  });
```

## 扩展方法

项目提供了便捷的扩展方法：

### Either 扩展

```dart
// lib/core/functional/either_extensions.dart

extension EitherExtensions<L, R> on Either<L, R> {
  // 链式调用时执行副作用
  Either<L, R> tapRight(void Function(R) fn);
  Either<L, R> tapLeft(void Function(L) fn);
  
  // 转换为 Option
  Option<R> toOption();
  
  // 获取值或默认值
  R getOrElse(R defaultValue);
  
  // 获取值或抛出异常
  R getOrThrow();
}
```

### TaskEither 扩展

```dart
// lib/core/functional/task_either_extensions.dart

extension TaskEitherExtensions<L, R> on TaskEither<L, R> {
  // 链式调用时执行副作用
  TaskEither<L, R> tapRight(void Function(R) fn);
  TaskEither<L, R> tapLeft(void Function(L) fn);
  
  // 转换为 Future
  Future<Either<L, R>> toFuture();
}

// 便捷函数
TaskEither<Failure, T> taskEitherFrom<T>(Future<T> Function() fn);
TaskEither<Failure, T> taskEitherFromSync<T>(T Function() fn);
```

## UI 层处理

### EitherBuilder Widget

用于简化 UI 中的 Either 处理：

```dart
EitherBuilder<User>(
  either: userEither,
  data: (user) => UserCard(user: user),
  error: (failure) => FailureWidget(failure: failure),
);
```

### AsyncEitherBuilder Widget

结合 Riverpod 的 AsyncValue：

```dart
AsyncEitherBuilder<User>(
  asyncValue: ref.watch(userProvider),
  data: (user) => UserCard(user: user),
  loading: () => CircularProgressIndicator(),
  error: (failure) => FailureWidget(failure: failure),
);
```

### FailureWidget

显示错误信息的通用 Widget：

```dart
FailureWidget(
  failure: NetworkFailure('网络连接失败'),
  onRetry: () => ref.read(provider.notifier).retry(),
);
```

## 最佳实践

### 1. 在 Repository 层使用 TaskEither

```dart
abstract class UserRepository {
  TaskEither<Failure, User> getUser(String id);
  TaskEither<Failure, List<User>> getUsers();
  TaskEither<Failure, void> saveUser(User user);
}
```

### 2. 在 UseCase 层组合操作

```dart
class GetUserProfileUseCase {
  final UserRepository _userRepository;
  final PreferenceRepository _prefRepository;
  
  TaskEither<Failure, UserProfile> call(String id) {
    return _userRepository.getUser(id)
      .flatMap((user) => _prefRepository.getPreferences(id)
        .map((prefs) => UserProfile(user: user, preferences: prefs)));
  }
}
```

### 3. 在 Provider 层处理状态

```dart
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  AsyncValue<Either<Failure, User>> build(String id) {
    _loadUser(id);
    return const AsyncLoading();
  }
  
  Future<void> _loadUser(String id) async {
    state = const AsyncLoading();
    final result = await _getUserUseCase(id).run();
    state = AsyncData(result);
  }
}
```

### 4. 错误恢复

```dart
// 使用 getOrElse 提供默认值
final name = result.getOrElse((_) => '未知用户');

// 使用 fold 处理两种情况
final message = result.fold(
  (failure) => '错误: ${failure.message}',
  (user) => '欢迎, ${user.name}',
);
```

## 常见模式

### 模式匹配

使用 Dart 3 的 switch expression 进行穷尽匹配：

```dart
String getErrorMessage(Failure failure) {
  return switch (failure) {
    NetworkFailure(:final message) => '网络错误: $message',
    DatabaseFailure(:final message) => '数据库错误: $message',
    ValidationFailure(:final message) => '验证错误: $message',
    ParseFailure(:final message) => '解析错误: $message',
    CrawlerFailure(:final message) => '爬虫错误: $message',
    ServerFailure(:final message) => '服务器错误: $message',
    UnknownFailure(:final message) => '未知错误: $message',
  };
}
```

### 组合多个 TaskEither

```dart
TaskEither<Failure, List<T>> sequenceTaskEither<T>(
  List<TaskEither<Failure, T>> tasks,
);
```

## 参考资料

- [fpdart 官方文档](https://pub.dev/packages/fpdart)
- [函数式编程在 Dart 中的应用](https://dart.dev/guides/language/functional-programming)
