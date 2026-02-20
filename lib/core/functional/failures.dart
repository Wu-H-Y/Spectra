/// Failure 类型定义
///
/// 使用 sealed class 定义 Failure 类型层次，支持 exhaustive pattern matching。
/// 每个 Failure 类型可携带不同的上下文信息，与 fpdart 的 Either 配合使用。
library;

/// 基础 Failure 类型
///
/// 所有错误类型的基类，使用 sealed class 确保编译时穷尽匹配。
sealed class Failure {
  /// 创建 Failure 实例
  const Failure(this.message);

  /// 错误消息
  final String message;

  @override
  String toString() => 'Failure: $message';
}

/// 网络相关错误
///
/// 用于 HTTP 请求、网络连接等场景的错误。
final class NetworkFailure extends Failure {
  /// 创建网络错误实例
  const NetworkFailure(super.message, [this.statusCode]);

  /// HTTP 状态码（可选）
  final int? statusCode;
}

/// 数据库相关错误
///
/// 用于 Drift、Hive 等数据存储操作的错误。
final class DatabaseFailure extends Failure {
  /// 创建数据库错误实例
  const DatabaseFailure(super.message);
}

/// 验证相关错误
///
/// 用于输入验证、数据校验等场景的错误。
final class ValidationFailure extends Failure {
  /// 创建验证错误实例
  const ValidationFailure(super.message, [this.field]);

  /// 验证失败的字段名（可选）
  final String? field;
}

/// 解析相关错误
///
/// 用于 JSON 解析、HTML 解析等场景的错误。
final class ParseFailure extends Failure {
  /// 创建解析错误实例
  const ParseFailure(super.message);
}

/// 爬虫规则相关错误
///
/// 用于爬虫规则执行、选择器匹配等场景的错误。
final class CrawlerFailure extends Failure {
  /// 创建爬虫错误实例
  const CrawlerFailure(super.message);
}

/// 服务器相关错误
///
/// 用于 HTTP 服务器、WebSocket 等场景的错误。
final class ServerFailure extends Failure {
  /// 创建服务器错误实例
  const ServerFailure(super.message);
}

/// 未知错误
///
/// 用于无法分类的其他错误，包含原始堆栈跟踪。
final class UnknownFailure extends Failure {
  /// 创建未知错误实例
  const UnknownFailure(super.message, [this.stackTrace]);

  /// 原始堆栈跟踪
  final StackTrace? stackTrace;

  @override
  String toString() => 'UnknownFailure: $message\n$stackTrace';
}

/// 从异常创建 Failure
///
/// 根据异常类型自动选择合适的 Failure 子类。
Failure failureFromException(Object error, [StackTrace? stackTrace]) {
  if (error is Failure) return error;

  // 根据异常类型映射到对应的 Failure
  final message = error.toString();

  // 网络相关异常
  if (error.toString().contains('SocketException') ||
      error.toString().contains('HttpException') ||
      error.toString().contains('TimeoutException')) {
    return NetworkFailure(message);
  }

  // 数据库相关异常
  if (error.toString().contains('SqliteException') ||
      error.toString().contains('HiveException') ||
      error.toString().contains('DatabaseException')) {
    return DatabaseFailure(message);
  }

  // 解析相关异常
  if (error.toString().contains('FormatException') ||
      error.toString().contains('JsonDecoder') ||
      error.toString().contains('XmlParser')) {
    return ParseFailure(message);
  }

  // 默认返回未知错误
  return UnknownFailure(message, stackTrace);
}
