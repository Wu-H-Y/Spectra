/// Either 处理 Widget
///
/// 简化 `Either<Failure, T>` 在 UI 层的处理，提供统一的成功和错误状态展示。
library;

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/functional/failures.dart';
import 'package:spectra/l10n/generated/l10n.dart';

/// EitherBuilder - 简化 Either 处理的 Widget
///
/// 根据Either 的状态自动渲染对应的 Widget：
/// - Left(Failure): 渲染错误状态
/// - Right(T): 渲染成功状态
///
/// 使用示例：
/// ```dart
/// EitherBuilder<User>(
///   either: userEither,
///   loading: () => CircularProgressIndicator(),
///   data: (user) => UserCard(user: user),
///   error: (failure) => FailureWidget(failure: failure),
/// )
/// ```
class EitherBuilder<T> extends StatelessWidget {
  /// 创建 EitherBuilder
  const EitherBuilder({
    required this.either,
    required this.data,
    required this.error,
    this.loading,
    super.key,
  });

  /// 要处理的 Either
  final Either<Failure, T> either;

  /// 成功状态的 Widget 构建器
  final Widget Function(T data) data;

  /// 错误状态的 Widget 构建器
  final Widget Function(Failure failure) error;

  /// 加载状态（可选，默认使用 CircularProgressIndicator）
  final Widget Function()? loading;

  @override
  Widget build(BuildContext context) {
    return either.fold(error, data);
  }
}

/// AsyncEitherBuilder - 处理 `AsyncValue<Either<Failure, T>>` 的 Widget
///
/// 结合 Riverpod 的 AsyncValue 和 fpdart 的 Either，提供完整的加载/错误/成功状态处理。
///
/// 使用示例：
/// ```dart
/// AsyncEitherBuilder<User>(
///   asyncValue: ref.watch(userProvider(id)),
///   data: (user) => UserCard(user: user),
///   loading: () => UserLoadingSkeleton(),
///   error: (failure) => FailureWidget(failure: failure),
/// )
/// ```
class AsyncEitherBuilder<T> extends StatelessWidget {
  /// 创建 AsyncEitherBuilder
  const AsyncEitherBuilder({
    required this.asyncValue,
    required this.data,
    required this.error,
    this.loading,
    this.loadingError,
    super.key,
  });

  /// 要处理的 AsyncValue
  final AsyncValue<Either<Failure, T>> asyncValue;

  /// 成功状态的 Widget 构建器
  final Widget Function(T data) data;

  /// 业务错误状态的 Widget 构建器（Either 为 Left 时）
  final Widget Function(Failure failure) error;

  /// 加载状态（可选）
  final Widget Function()? loading;

  /// 加载错误状态的 Widget 构建器（AsyncValue 为 error 时）
  final Widget Function(Object error, StackTrace stackTrace)? loadingError;

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: (either) => either.fold(error, data),
      loading:
          loading ?? () => const Center(child: CircularProgressIndicator()),
      error: loadingError ?? _defaultLoadingError,
    );
  }

  Widget _defaultLoadingError(Object err, StackTrace stack) {
    return FailureWidget(failure: failureFromException(err, stack));
  }
}

/// FailureWidget - 显示错误信息的 Widget
///
/// 根据Failure 类型显示相应的错误信息，支持重试操作。
///
/// 使用示例：
/// ```dart
/// FailureWidget(
///   failure: NetworkFailure('网络连接失败'),
///   onRetry: () => ref.read(provider.notifier).retry(),
/// )
/// ```
class FailureWidget extends StatelessWidget {
  /// 创建 FailureWidget
  const FailureWidget({
    required this.failure,
    this.onRetry,
    super.key,
  });

  /// 要显示的错误
  final Failure failure;

  /// 重试回调（可选）
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = _getIconAndColor(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: color),
            const SizedBox(height: 16),
            Text(
              failure.message,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(S.of(context).retry),
              ),
            ],
          ],
        ),
      ),
    );
  }

  (IconData, Color) _getIconAndColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return switch (failure) {
      NetworkFailure() => (Icons.wifi_off, colorScheme.error),
      DatabaseFailure() => (Icons.storage, colorScheme.error),
      ValidationFailure() => (Icons.warning, colorScheme.tertiary),
      ParseFailure() => (Icons.code, colorScheme.tertiary),
      CrawlerFailure() => (Icons.bug_report, colorScheme.error),
      ServerFailure() => (Icons.dns, colorScheme.error),
      UnknownFailure() => (Icons.help_outline, colorScheme.outline),
    };
  }
}
