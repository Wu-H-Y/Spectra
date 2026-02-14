import 'dart:io';
import 'package:git_hooks/git_hooks.dart';
import 'package:talker/talker.dart';

final _talker = Talker(
  settings: TalkerSettings(useConsoleLogs: true),
);

void main(List<String> arguments) {
  final params = <Git, UserBackFun>{
    Git.commitMsg: commitMsg,
    Git.preCommit: preCommit,
  };
  GitHooks.call(arguments, params);
}

/// 验证提交消息格式: Conventional Commits
Future<bool> commitMsg() async {
  final commitMsg = Utils.getCommitEditMsg();

  // Conventional Commits 正则
  // 格式: <type>(<scope>): <description>
  // scope 是可选的
  final pattern = RegExp(
    r'^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)'
    r'(\([\w\-]+\))?:\s.{1,50}',
  );

  if (pattern.hasMatch(commitMsg)) {
    _talker.info('提交格式正确');
    return true;
  }

  _talker.error('''
提交消息格式错误！

格式: <type>(<scope>): <description>

类型 (type):
  feat      新功能
  fix       Bug 修复
  docs      文档更新
  style     代码格式 (不影响代码运行的变动)
  refactor  重构 (既不是新增功能，也不是修改 bug 的代码变动)
  perf      性能优化
  test      增加测试
  build     构建过程或辅助工具的变动
  ci        CI 配置文件和脚本的变动
  chore     其他不修改 src 或测试文件的变动
  revert    回滚之前的 commit

范围 (scope): 可选，表示影响范围，如: feat(auth): 添加登录功能

示例:
  feat: 添加用户登录功能
  fix: 修复登录页面崩溃的问题
  docs: 更新 README 安装说明
  feat(auth): 添加第三方登录支持
  fix(ios): 修复 iOS 15 下的兼容性问题
  refactor(utils): 重构日期格式化工具

破坏性变更:
  在 footer 中添加 BREAKING CHANGE: 描述

示例:
  feat: 重新设计 API 接口

  BREAKING CHANGE: 完全重构了 API 接口，旧接口不再兼容
''');
  return false;
}

/// 提交前检查: 运行 flutter analyze
Future<bool> preCommit() async {
  _talker.info('运行 flutter analyze...');

  try {
    final result = await Process.run(
      'flutter',
      ['analyze'],
      environment: Platform.environment,
      runInShell: true,
    );

    if (result.stdout.toString().isNotEmpty) {
      _talker.info(result.stdout);
    }

    if (result.exitCode != 0) {
      _talker.error('代码分析失败，请修复后再提交');
      if (result.stderr.toString().isNotEmpty) {
        _talker.error(result.stderr);
      }
      return false;
    }

    _talker.info('代码分析通过');
    return true;
  } catch (e) {
    _talker.warning('无法运行 flutter analyze: $e');
    _talker.warning('跳过代码分析，请确保代码质量');
    return true; // 找不到 flutter 时跳过而不是失败
  }
}
