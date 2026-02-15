# Git Hooks 规范

## ADDED Requirements

### Requirement: Commit 消息格式验证

系统 SHALL 在每次 commit 时验证提交消息符合 Conventional Commits 格式。

#### Scenario: 有效的提交消息
- **WHEN** 用户提交消息格式为 `<type>(<scope>): <description>`
- **THEN** commit 被接受

#### Scenario: 无效的提交消息被拒绝
- **WHEN** 用户提交消息不符合 Conventional Commits 格式
- **THEN** commit 被拒绝并显示中文错误提示和格式说明

### Requirement: Pre-commit 代码分析

系统 SHALL 在每次 commit 前自动运行 `flutter analyze`。

#### Scenario: 代码分析通过
- **WHEN** `flutter analyze` 返回退出码 0
- **THEN** commit 被接受

#### Scenario: 代码分析失败
- **WHEN** `flutter analyze` 返回非零退出码
- **THEN** commit 被拒绝并显示分析错误

### Requirement: Git Hooks 安装

系统 SHALL 提供安装命令来配置 Git hooks。

#### Scenario: 安装 hooks
- **WHEN** 用户运行 `dart run git_hooks create git_hooks.dart`
- **THEN** 在 `.git/hooks/` 目录下创建 hook 文件

#### Scenario: 验证安装成功
- **WHEN** hooks 安装完成
- **THEN** `.git/hooks/commit-msg` 和 `.git/hooks/pre-commit` 文件存在且可执行

### Requirement: 纯 Dart 实现

Git hooks 配置 SHALL 使用纯 Dart 实现，不依赖 Node.js。

#### Scenario: 无 Node.js 依赖
- **WHEN** 用户安装 git_hooks
- **THEN** 不需要在系统中安装 Node.js 或 npm

### Requirement: 中文错误提示

系统 SHALL 提供中文的错误提示信息。

#### Scenario: 提交格式错误提示
- **WHEN** 提交消息格式不正确
- **THEN** 显示包含中文类型说明和示例的错误信息
