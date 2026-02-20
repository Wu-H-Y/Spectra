/// Either 扩展方法
///
/// 为 fpdart 的 Either 类型提供便捷的扩展方法，简化错误处理流程。
library;

import 'package:fpdart/fpdart.dart';

import 'package:spectra/core/functional/failures.dart';

/// `Either<L, R>` 的扩展方法
extension EitherExtensions<L, R> on Either<L, R> {
  /// 如果是 Right，执行回调；否则跳过
  ///
  /// 返回原始 Either 以便链式调用。
  Either<L, R> tapRight(void Function(R right) fn) {
    return fold(
      Left.new,
      (right) {
        fn(right);
        return Right(right);
      },
    );
  }

  /// 如果是 Left，执行回调；否则跳过
  ///
  /// 返回原始 Either 以便链式调用。
  Either<L, R> tapLeft(void Function(L left) fn) {
    return fold(
      (left) {
        fn(left);
        return Left(left);
      },
      Right.new,
    );
  }

  /// 将 Right 值转换为 Option
  Option<R> toOption() => fold((_) => none(), some);

  /// 获取 Right 值，如果不存在则返回默认值
  R getOrElse(R defaultValue) => fold((_) => defaultValue, identity);

  /// 获取 Right 值，如果不存在则抛出异常
  R getOrThrow() => fold(
    (left) => throw left is Exception ? left : Exception(left.toString()),
    identity,
  );
}

/// `Either<Failure, R>` 的专用扩展方法
extension FailureEitherExtensions<R> on Either<Failure, R> {
  /// 获取错误消息
  String get errorMessage => fold(
    (failure) => failure.message,
    (_) => '',
  );

  /// 将 Failure 转换为用户友好的消息
  String toUserMessage() => fold(
    _failureToUserMessage,
    (right) => '操作成功',
  );
}

/// 将 Failure 转换为用户友好的消息
String _failureToUserMessage(Failure failure) {
  return switch (failure) {
    NetworkFailure() => '网络请求失败: ${failure.message}',
    DatabaseFailure() => '数据库操作失败: ${failure.message}',
    ValidationFailure() => '数据验证失败: ${failure.message}',
    ParseFailure() => '数据解析失败: ${failure.message}',
    CrawlerFailure() => '爬虫执行失败: ${failure.message}',
    ServerFailure() => '服务器错误: ${failure.message}',
    UnknownFailure() => '未知错误: ${failure.message}',
  };
}
