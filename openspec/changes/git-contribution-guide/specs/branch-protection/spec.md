# 分支保护规范

## ADDED Requirements

### Requirement: Main 分支保护

main 分支 SHALL 设置为受保护分支，禁止直接推送。

#### Scenario: 禁止直接推送到 main
- **WHEN** 用户尝试直接推送到 main 分支
- **THEN** 推送被拒绝

#### Scenario: 必须通过 PR 合并
- **WHEN** 代码需要合并到 main
- **THEN** 必须通过 Pull Request 流程

### Requirement: PR 必须通过 CI

Pull Request SHALL 通过所有 CI 检查后才能合并。

#### Scenario: CI 通过后可合并
- **WHEN** PR 的 CI 检查全部通过
- **THEN** PR 可以被合并

#### Scenario: CI 失败时禁止合并
- **WHEN** PR 的 CI 检查失败
- **THEN** PR 不能被合并

### Requirement: 分支命名规范

功能分支 SHALL 使用以下命名前缀之一：`feat/`、`fix/`、`docs/`、`refactor/`、`test/`、`chore/`。

#### Scenario: 有效的分支名
- **WHEN** 分支名为 `feat/add-login` 或 `fix/crash-bug`
- **THEN** 分支名符合规范

#### Scenario: 分支名前缀建议
- **WHEN** 贡献者创建新分支
- **THEN** 文档中提供推荐的分支命名前缀

### Requirement: Squash Merge 策略

合并到 main 分支 SHALL 使用 Squash Merge 方式。

#### Scenario: 单次提交合并
- **WHEN** PR 被合并
- **THEN** 所有 commits 被压缩为单个 commit

#### Scenario: 保持 main 历史整洁
- **WHEN** 使用 squash merge
- **THEN** main 分支的提交历史保持线性和整洁

### Requirement: Fork 工作流

外部贡献者 SHALL 通过 Fork 方式参与贡献。

#### Scenario: Fork 创建 PR
- **WHEN** 外部贡献者想要贡献代码
- **THEN** Fork 项目，在 Fork 中创建分支，然后提交 PR
