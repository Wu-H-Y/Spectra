/// TaskEither 扩展方法
///
/// 为 fpdart 的 TaskEither 类型提供便捷的扩展方法，简化异步错误处理流程。
library;

import 'package:fpdart/fpdart.dart';

import 'package:spectra/core/functional/failures.dart';

/// `TaskEither<L, R>` 的扩展方法
extension TaskEitherExtensions<L, R> on TaskEither<L, R> {
  /// 如果是 Right，执行回调；否则跳过
  ///
  /// 返回原始 TaskEither 以便链式调用。
  TaskEither<L, R> tapRight(void Function(R right) fn) {
    return flatMap(
      (right) => TaskEither(() async {
        fn(right);
        return Right(right);
      }),
    );
  }

  /// 如果是 Left，执行回调；否则跳过
  ///
  /// 返回原始 TaskEither 以便链式调用。
  TaskEither<L, R> tapLeft(void Function(L left) fn) {
    return mapLeft((left) {
      fn(left);
      return left;
    });
  }

  /// 将 TaskEither 转换为 `Future<Either>`
  Future<Either<L, R>> toFuture() => run();
}

/// `TaskEither<Failure, R>` 的专用扩展方法
extension FailureTaskEitherExtensions<R> on TaskEither<Failure, R> {
  /// 将 TaskEither 转换为 AsyncValue（与 Riverpod 集成）
  // 注意: AsyncValue 需要在使用时从 flutter_riverpod 导入
  // Future<AsyncValue<R>> toAsyncValue() async {
  //   final either = await run();
  //   return either.fold(
  //     (failure) => AsyncValue.error(failure, StackTrace.current),
  //     (data) => AsyncValue.data(data),
  //   );
  // }

  /// 执行并返回 Right 值，如果失败则抛出异常
  Future<R> runOrThrow() async {
    final either = await run();
    return either.fold(
      (failure) => throw Exception(failure.message),
      identity,
    );
  }
}

/// 从异步操作创建 TaskEither
///
/// 将可能抛出异常的异步操作包装为 `TaskEither<Failure, T>`。
TaskEither<Failure, T> taskEitherFrom<T>(
  Future<T> Function() fn,
) {
  return TaskEither<Failure, T>(() async {
    try {
      final result = await fn();
      return Right(result);
    } on Exception catch (e, st) {
      return Left(failureFromException(e, st));
    }
  });
}

/// 从同步操作创建 TaskEither
///
/// 将可能抛出异常的同步操作包装为 `TaskEither<Failure, T>`。
TaskEither<Failure, T> taskEitherFromSync<T>(
  T Function() fn,
) {
  return TaskEither<Failure, T>(() async {
    try {
      final result = fn();
      return Right(result);
    } on Exception catch (e, st) {
      return Left(failureFromException(e, st));
    }
  });
}

/// 组合多个 TaskEither 操作
///
/// 按顺序执行多个 TaskEither，如果任一失败则返回第一个错误。
TaskEither<Failure, List<T>> sequenceTaskEither<T>(
  List<TaskEither<Failure, T>> tasks,
) {
  return TaskEither(() async {
    final results = <T>[];
    for (final task in tasks) {
      final either = await task.run();
      final result = either.fold(
        Left<Failure, List<T>>.new,
        (data) {
          results.add(data);
          return null;
        },
      );
      if (result != null) return result;
    }
    return Right<Failure, List<T>>(results);
  });
}
