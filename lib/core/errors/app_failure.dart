import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

/// 应用级错误类型定义。
///
/// 使用强类型错误对象替代字符串错误，便于：
/// - 日志记录（保留原始错误信息）
/// - 错误映射（转换为用户友好的本地化文案）
/// - 错误处理（根据类型进行不同处理）
///
/// 核心原则：日志看原始堆栈，用户看本地化文案。
@freezed
sealed class AppFailure with _$AppFailure {
  // ============== 网络类错误 ==============

  /// 网络不可达。
  ///
  /// 设备无法连接到网络或目标服务器。
  const factory AppFailure.networkUnreachable() = _NetworkUnreachable;

  /// 连接超时。
  ///
  /// 网络请求在指定时间内未收到响应。
  const factory AppFailure.connectionTimeout() = _ConnectionTimeout;

  /// 服务器错误。
  ///
  /// 服务器返回 5xx 错误。
  const factory AppFailure.serverError({int? statusCode}) = _ServerError;

  // ============== 业务类错误 ==============

  /// 未授权。
  ///
  /// 用户未登录或登录已过期。
  const factory AppFailure.unauthorized() = _Unauthorized;

  /// 禁止访问。
  ///
  /// 用户无权限执行此操作。
  const factory AppFailure.forbidden() = _Forbidden;

  /// 资源未找到。
  ///
  /// 请求的资源不存在。
  const factory AppFailure.notFound() = _NotFound;

  /// 请求无效。
  ///
  /// 请求参数验证失败。
  const factory AppFailure.badRequest({String? details}) = _BadRequest;

  // ============== 数据处理类错误 ==============

  /// 数据解析失败。
  ///
  /// 响应数据无法解析为预期格式。
  const factory AppFailure.parseError({String? details}) = _ParseError;

  /// 数据验证失败。
  ///
  /// 数据不符合业务规则。
  const factory AppFailure.validationError({required String message}) =
      _ValidationError;

  // ============== 爬虫规则类错误 ==============

  /// 规则解析失败。
  ///
  /// 爬虫规则 JSON 格式错误或缺少必要字段。
  const factory AppFailure.ruleParseError({required String message}) =
      _RuleParseError;

  /// 规则执行失败。
  ///
  /// 爬虫规则执行过程中发生错误。
  const factory AppFailure.ruleExecutionError({required String message}) =
      _RuleExecutionError;

  /// 选择器匹配失败。
  ///
  /// CSS/XPath/JSONPath 选择器未能匹配到元素。
  const factory AppFailure.selectorError({
    required String selector,
    String? details,
  }) = _SelectorError;

  // ============== 用户输入类错误（带参数）==============

  /// 密码强度不足。
  ///
  /// 密码不满足最小长度要求。
  const factory AppFailure.weakPassword({required int minLength}) =
      _WeakPassword;

  /// 用户名已存在。
  ///
  /// 注册时用户名已被占用。
  const factory AppFailure.usernameExists({required String username}) =
      _UsernameExists;

  // ============== 存储类错误 ==============

  /// 数据库错误。
  ///
  /// 本地数据库操作失败。
  const factory AppFailure.databaseError({String? details}) = _DatabaseError;

  /// 缓存错误。
  ///
  /// 缓存读取或写入失败。
  const factory AppFailure.cacheError({String? details}) = _CacheError;

  // ============== 特殊错误 ==============

  /// 服务器端已国际化的消息。
  ///
  /// 当后端已根据 Accept-Language 返回对应语言的消息时使用。
  /// 注意：仅在后端已实现国际化时使用此类型。
  const factory AppFailure.serverSideMessage({required String message}) =
      _ServerSideMessage;

  /// 未知错误。
  ///
  /// 无法分类的错误，保留原始错误用于日志记录。
  /// 注意：原始错误信息不得直接展示给用户。
  const factory AppFailure.unknown(Object? originalError) = _Unknown;
}
