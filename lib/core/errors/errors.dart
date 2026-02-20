/// 应用级错误处理模块。
///
/// 提供强类型错误定义和国际化错误消息映射。
///
/// ## 核心原则
///
/// **日志看原始堆栈，用户看本地化文案。**
///
/// ## 使用示例
///
/// ```dart
/// import 'package:spectra/core/errors/errors.dart';
///
/// try {
///   final result = await repository.fetchData();
/// } catch (e) {
///   // 1. 映射为强类型错误
///   final failure = ExceptionMapper.map(e);
///
///   // 2. 日志记录（给开发者，保留原始信息）
///   logger.e('获取数据失败', error: failure);
///
///   // 3. 展示给用户（本地化）
///   ScaffoldMessenger.of(context).showSnackBar(
///     SnackBar(content: Text(failure.localizedMessage(context))),
///   );
/// }
/// ```
library;

export 'app_failure.dart';
export 'app_failure_display_extension.dart';
export 'exception_mapper.dart';
