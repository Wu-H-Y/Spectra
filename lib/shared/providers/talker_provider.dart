import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'talker_provider.g.dart';

/// 创建 Talker 实例
///
/// 提供全局 Talker 实例，用于日志记录和错误处理。
/// 支持以下功能：
/// - 控制台日志输出
/// - 日志历史记录
/// - 错误和异常处理
/// - 与 Riverpod、Dio 集成
Talker createTalker() {
  return TalkerFlutter.init(
    settings: TalkerSettings(
      /// 最大历史记录数量
      maxHistoryItems: 500,
    ),
  );
}

/// Talker 实例 Provider
///
/// 提供全局 Talker 实例，用于日志记录和错误处理。
@riverpod
Talker talker(Ref ref) {
  return createTalker();
}
