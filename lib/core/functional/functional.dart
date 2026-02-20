/// 函数式编程核心模块
///
/// 提供基于 fpdart 的函数式编程工具，包括：
/// - Failure 类型层次：类型安全的错误定义
/// - Either 扩展：简化 Either 操作
/// - TaskEither 扩展：简化异步错误处理
///
/// 使用示例：
/// ```dart
/// import 'package:spectra/core/functional/functional.dart';
///
/// // 定义返回 Either 的方法
/// Future<Either<Failure, User>> getUser(String id) async {
///   try {
///     final user = await api.fetchUser(id);
///     return Right(user);
///   } catch (e) {
///     return Left(NetworkFailure(e.toString()));
///   }
/// }
///
/// // 使用 TaskEither 简化异步错误处理
/// TaskEither<Failure, User> getUserTask(String id) {
///   return taskEitherFrom(() => api.fetchUser(id));
/// }
///
/// // 在 UI 中处理 Either
/// either.fold(
///   (failure) => showError(failure.message),
///   (user) => showUser(user),
/// );
/// ```
library;

export 'either_extensions.dart';
export 'failures.dart';
export 'task_either_extensions.dart';
