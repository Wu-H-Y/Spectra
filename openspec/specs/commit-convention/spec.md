# 提交消息规范

## Requirements

### Requirement: Conventional Commits 格式

所有提交消息 SHALL 遵循 Conventional Commits 规范格式。

#### Scenario: 标准格式
- **WHEN** 用户创建提交
- **THEN** 消息格式为 `<type>(<scope>): <description>`

#### Scenario: 带 scope 的格式
- **WHEN** 用户指定影响范围
- **THEN** 消息格式为 `feat(auth): add biometric login`

#### Scenario: 无 scope 的格式
- **WHEN** 用户不指定影响范围
- **THEN** 消息格式为 `feat: add new feature`

### Requirement: 提交类型定义

系统 SHALL 定义并支持以下提交类型：

| 类型 | 说明 | 版本影响 | Releasable |
|------|------|----------|------------|
| feat | 新功能 | minor | ✓ |
| fix | Bug 修复 | patch | ✓ |
| deps | 依赖更新 | patch | ✓ |
| docs | 文档更新 | 无 | ✗ |
| style | 代码格式 | 无 | ✗ |
| refactor | 重构 | 无 | ✗ |
| perf | 性能优化 | patch | ✗ |
| test | 测试相关 | 无 | ✗ |
| build | 构建/依赖 | patch | ✗ |
| ci | CI 配置 | 无 | ✗ |
| chore | 其他杂项 | 无 | ✗ |
| revert | 回滚提交 | 视情况 | ✗ |

#### Scenario: deps 类型
- **WHEN** 提交更新依赖版本
- **THEN** 使用 `deps:` 前缀，触发 patch 版本更新，进入 CHANGELOG

#### Scenario: feat 类型
- **WHEN** 提交添加新功能
- **THEN** 使用 `feat:` 前缀，触发 minor 版本更新

#### Scenario: fix 类型
- **WHEN** 提交修复 Bug
- **THEN** 使用 `fix:` 前缀，触发 patch 版本更新

#### Scenario: docs 类型
- **WHEN** 提交仅修改文档
- **THEN** 使用 `docs:` 前缀，不触发版本更新

### Requirement: Releasable Units 定义

系统 SHALL 明确定义哪些提交类型会进入 CHANGELOG（releasable units）。

#### Scenario: releasable units 进入 CHANGELOG
- **WHEN** 提交类型为 `feat`、`fix` 或 `deps`
- **THEN** 该提交会出现在 CHANGELOG 中

#### Scenario: 非 releasable units 不进入 CHANGELOG
- **WHEN** 提交类型为 `docs`、`style`、`refactor`、`test`、`ci`、`chore` 等
- **THEN** 该提交不会出现在 CHANGELOG 中

### Requirement: 单提交多变更支持

系统 SHALL 支持在单个提交中使用 footer 形式表示多个变更。

#### Scenario: 单提交包含多个变更
- **WHEN** 一个提交需要包含多个 feat/fix 变更
- **THEN** 可以在提交消息底部添加多个变更条目

#### Scenario: 单提交多变更格式
- **WHEN** 用户编写包含多个变更的提交
- **THEN** 格式为：
  ```
  feat: 主变更描述

  fix(scope): 修复描述
  feat(scope): 功能描述
  ```

### Requirement: Squash-Merge 最佳实践

项目文档 SHALL 推荐使用 squash-merge 合并 Pull Request。

#### Scenario: 推荐 squash-merge
- **WHEN** 合并 PR 到 main 分支
- **THEN** 推荐使用 squash-merge 保持历史线性

#### Scenario: squash-merge 好处说明
- **WHEN** 用户阅读提交规范文档
- **THEN** 包含 squash-merge 的好处说明：
  - 按合并日期排序，历史清晰
  - 便于 git bisect 追踪问题
  - 避免 PR 内的临时提交污染 main

### Requirement: Breaking Change 标记

包含破坏性变更的提交 SHALL 在 footer 中标记 `BREAKING CHANGE:`。

#### Scenario: Breaking Change 格式
- **WHEN** 提交包含破坏性变更
- **THEN** 消息包含 `BREAKING CHANGE:` 描述，触发 major 版本更新

#### Scenario: Breaking Change 示例
- **WHEN** 用户提交破坏性变更
- **THEN** 格式为：
  ```
  feat: redesign API

  BREAKING CHANGE: 完全重构了 API 接口，旧接口不再兼容
  ```

### Requirement: 中文描述

提交消息的 description 部分 SHOULD 使用中文描述。

#### Scenario: 中文描述
- **WHEN** 用户编写提交描述
- **THEN** 推荐使用中文，如 `feat: 添加用户登录功能`

### Requirement: 描述长度限制

提交消息的 description 部分 SHALL 不超过 50 个字符。

#### Scenario: 描述过长被拒绝
- **WHEN** description 超过 50 个字符
- **THEN** commit 被 hook 拒绝并提示缩短描述
