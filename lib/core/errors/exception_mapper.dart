import 'package:dio/dio.dart';

import 'package:spectra/core/errors/app_failure.dart';

/// 异常到 AppFailure 的映射工具类。
///
/// 提供统一的异常转换方法，将常见的异常类型映射为强类型的 [AppFailure]。
///
/// ## 使用示例
///
/// ```dart
/// try {
///   final response = await dio.get('/api/data');
///   return parseData(response.data);
/// } catch (e) {
///   final failure = ExceptionMapper.map(e);
///   logger.e('请求失败', error: failure);
///   return Left(failure);
/// }
/// ```
///
/// ## 核心原则
///
/// - 日志记录原始异常（保留堆栈信息）
/// - UI 展示映射后的本地化文案
abstract final class ExceptionMapper {
  /// 将异常映射为 [AppFailure]。
  ///
  /// 支持的异常类型：
  /// - [DioException]: HTTP 网络请求错误
  /// - [FormatException]: 数据格式解析错误
  /// - [AppFailure]: 直接返回（已经是强类型错误）
  /// - 其他异常: 映射为 [AppFailure.unknown]
  static AppFailure map(Object error, [StackTrace? stackTrace]) {
    // 如果已经是 AppFailure，直接返回
    if (error is AppFailure) {
      return error;
    }

    // Dio HTTP 异常映射
    if (error is DioException) {
      return _mapDioException(error);
    }

    // 格式解析异常
    if (error is FormatException) {
      return AppFailure.parseError(details: error.message);
    }

    // 其他异常映射为未知错误
    return AppFailure.unknown(error);
  }

  /// 映射 DioException 到 AppFailure。
  static AppFailure _mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppFailure.connectionTimeout();

      case DioExceptionType.connectionError:
        return const AppFailure.networkUnreachable();

      case DioExceptionType.badResponse:
        return _mapHttpError(error.response?.statusCode, error.response?.data);

      case DioExceptionType.cancel:
        // 用户取消请求，通常不需要显示错误
        return const AppFailure.unknown('Request cancelled');

      case DioExceptionType.badCertificate:
        return const AppFailure.badRequest(details: 'SSL 证书验证失败');

      case DioExceptionType.unknown:
        // 检查是否是网络相关的错误
        if (_isNetworkError(error)) {
          return const AppFailure.networkUnreachable();
        }
        return AppFailure.unknown(error);
    }
  }

  /// 映射 HTTP 状态码到 AppFailure。
  static AppFailure _mapHttpError(int? statusCode, dynamic data) {
    // 尝试从响应中提取后端错误码
    final backendCode = _extractBackendCode(data);

    // 优先使用后端错误码映射
    if (backendCode != null) {
      return _mapBackendCode(backendCode, data);
    }

    // 根据 HTTP 状态码映射
    return switch (statusCode) {
      400 => AppFailure.badRequest(details: _extractMessage(data)),
      401 => const AppFailure.unauthorized(),
      403 => const AppFailure.forbidden(),
      404 => const AppFailure.notFound(),
      final int code when code >= 500 && code < 600 => AppFailure.serverError(
        statusCode: code,
      ),
      _ => AppFailure.unknown('HTTP $statusCode'),
    };
  }

  /// 映射后端业务错误码。
  ///
  /// 根据项目实际的后端错误码规范进行调整。
  static AppFailure _mapBackendCode(int code, dynamic data) {
    // 这里可以根据实际的后端错误码进行映射
    // 示例：
    // switch (code) {
    //   case 10401:
    //     return const AppFailure.unauthorized();
    //   case 10402:
    //     return const AppFailure.invalidCode();
    //   ...
    // }

    // 默认：尝试提取消息或使用通用错误
    final message = _extractMessage(data);
    return AppFailure.validationError(message: message ?? '请求失败 ($code)');
  }

  /// 从响应数据中提取后端错误码。
  static int? _extractBackendCode(dynamic data) {
    if (data is Map<String, dynamic>) {
      // 尝试常见的错误码字段名
      return data['code'] as int? ?? data['error_code'] as int?;
    }
    return null;
  }

  /// 从响应数据中提取错误消息。
  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      // 尝试常见的消息字段名
      return data['message'] as String? ??
          data['msg'] as String? ??
          data['error'] as String?;
    }
    if (data is String) {
      return data;
    }
    return null;
  }

  /// 检查是否是网络相关的错误。
  static bool _isNetworkError(DioException error) {
    final message = error.message?.toLowerCase() ?? '';
    final errorString = error.toString().toLowerCase();

    return message.contains('socketexception') ||
        message.contains('network') ||
        message.contains('connection') ||
        errorString.contains('socketexception') ||
        errorString.contains('failed host lookup');
  }
}
