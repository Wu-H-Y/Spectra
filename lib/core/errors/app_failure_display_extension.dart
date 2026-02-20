import 'package:flutter/widgets.dart';

import 'package:spectra/core/errors/app_failure.dart';
import 'package:spectra/l10n/generated/l10n.dart';

/// AppFailure 扩展方法，提供错误到本地化文案的映射。
///
/// 核心原则：日志看原始堆栈，用户看本地化文案。
///
/// 使用示例：
/// ```dart
/// try {
///   final result = await repository.fetchData();
/// } catch (e) {
///   final failure = ExceptionMapper.map(e);
///
///   // 1. 日志记录（给开发者，保留原始信息）
///   logger.e('获取数据失败', error: failure);
///
///   // 2. 展示给用户（本地化）
///   ScaffoldMessenger.of(context).showSnackBar(
///     SnackBar(content: Text(failure.localizedMessage(context))),
///   );
/// }
/// ```
extension AppFailureDisplay on AppFailure {
  /// 获取本地化的错误消息。
  ///
  /// 如果无法获取本地化实例（例如在 Widget 树外），
  /// 会返回一个通用的错误消息。
  String localizedMessage(BuildContext context) {
    final l10n = S.maybeOf(context);
    if (l10n == null) {
      return _getFallbackMessage();
    }
    return _getLocalizedMessage(l10n);
  }

  /// 获取本地化的错误标题（用于对话框等场景）。
  String localizedTitle(BuildContext context) {
    final l10n = S.maybeOf(context);
    if (l10n == null) {
      return '错误';
    }
    return _getLocalizedTitle(l10n);
  }

  /// 获取不带 context 的错误消息（用于无法访问 Widget 树的场景）。
  ///
  /// 注意：此方法会尝试使用 S.current，如果未初始化会返回通用消息。
  /// 优先使用 [localizedMessage] 方法。
  String get message {
    try {
      return _getLocalizedMessage(S.current);
    } on Exception catch (_) {
      return _getFallbackMessage();
    }
  }

  String _getLocalizedMessage(S l10n) {
    // 使用 freezed 生成的 map 方法进行模式匹配
    return map(
      // ============== 网络类错误 ==============
      networkUnreachable: (_) => l10n.errorNetworkUnreachable,
      connectionTimeout: (_) => l10n.errorConnectionTimeout,
      serverError: (e) => l10n.errorServerError(e.statusCode ?? 500),
      // ============== 业务类错误 ==============
      unauthorized: (_) => l10n.errorUnauthorized,
      forbidden: (_) => l10n.errorForbidden,
      notFound: (_) => l10n.errorNotFound,
      badRequest: (_) => l10n.errorBadRequest,
      // ============== 数据处理类错误 ==============
      parseError: (_) => l10n.errorParseError,
      validationError: (e) => e.message,
      // ============== 爬虫规则类错误 ==============
      ruleParseError: (e) => l10n.errorRuleParseError(e.message),
      ruleExecutionError: (e) => l10n.errorRuleExecutionError(e.message),
      selectorError: (e) => l10n.errorSelectorError(e.selector),
      // ============== 用户输入类错误 ==============
      weakPassword: (e) => l10n.errorWeakPassword(e.minLength),
      usernameExists: (e) => l10n.errorUsernameExists(e.username),
      // ============== 存储类错误 ==============
      databaseError: (_) => l10n.errorDatabaseError,
      cacheError: (_) => l10n.errorCacheError,
      // ============== 特殊错误 ==============
      serverSideMessage: (e) => e.message,
      unknown: (_) => l10n.errorUnknown,
    );
  }

  String _getLocalizedTitle(S l10n) {
    return map(
      // 网络错误
      networkUnreachable: (_) => l10n.errorTitleNetwork,
      connectionTimeout: (_) => l10n.errorTitleNetwork,
      serverError: (_) => l10n.errorTitleNetwork,
      // 认证错误
      unauthorized: (_) => l10n.errorTitleAuth,
      // 权限错误
      forbidden: (_) => l10n.errorTitlePermission,
      notFound: (_) => l10n.errorTitlePermission,
      // 规则错误
      ruleParseError: (_) => l10n.errorTitleRule,
      ruleExecutionError: (_) => l10n.errorTitleRule,
      selectorError: (_) => l10n.errorTitleRule,
      // 未知错误
      unknown: (_) => l10n.errorTitleUnknown,
      // 其他使用默认标题
      badRequest: (_) => l10n.errorTitleDefault,
      parseError: (_) => l10n.errorTitleDefault,
      validationError: (_) => l10n.errorTitleDefault,
      weakPassword: (_) => l10n.errorTitleDefault,
      usernameExists: (_) => l10n.errorTitleDefault,
      databaseError: (_) => l10n.errorTitleDefault,
      cacheError: (_) => l10n.errorTitleDefault,
      serverSideMessage: (_) => l10n.errorTitleDefault,
    );
  }

  String _getFallbackMessage() {
    return map(
      // ============== 网络类错误 ==============
      networkUnreachable: (_) => '网络不可达，请检查您的网络连接',
      connectionTimeout: (_) => '连接超时，请稍后重试',
      serverError: (e) => '服务器错误 (${e.statusCode ?? 500})',
      // ============== 业务类错误 ==============
      unauthorized: (_) => '登录已过期，请重新登录',
      forbidden: (_) => '您没有权限执行此操作',
      notFound: (_) => '请求的资源不存在',
      badRequest: (_) => '请求参数有误',
      // ============== 数据处理类错误 ==============
      parseError: (_) => '数据解析失败',
      validationError: (e) => e.message,
      // ============== 爬虫规则类错误 ==============
      ruleParseError: (e) => '规则解析失败: ${e.message}',
      ruleExecutionError: (e) => '规则执行失败: ${e.message}',
      selectorError: (e) => '选择器匹配失败: ${e.selector}',
      // ============== 用户输入类错误 ==============
      weakPassword: (e) => '密码长度不能少于 ${e.minLength} 位',
      usernameExists: (e) => '用户名 "${e.username}" 已存在',
      // ============== 存储类错误 ==============
      databaseError: (_) => '数据库操作失败',
      cacheError: (_) => '缓存操作失败',
      // ============== 特殊错误 ==============
      serverSideMessage: (e) => e.message,
      unknown: (_) => '发生未知错误，请稍后重试',
    );
  }
}
