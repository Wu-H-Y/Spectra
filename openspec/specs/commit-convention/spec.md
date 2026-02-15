# 提交消息规范

## ADDED Requirements

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

| 类型 | 说明 | 版本影响 |
|------|------|----------|
| feat | 新功能 | minor |
| fix | Bug 修复 | patch |
| docs | 文档更新 | 无 |
| style | 代码格式 | 无 |
| refactor | 重构 | 无 |
| perf | 性能优化 | patch |
| test | 测试相关 | 无 |
| build | 构建/依赖 | patch |
| ci | CI 配置 | 无 |
| chore | 其他杂项 | 无 |
| revert | 回滚提交 | 视情况 |

#### Scenario: feat 类型
- **WHEN** 提交添加新功能
- **THEN** 使用 `feat:` 前缀，触发 minor 版本更新

#### Scenario: fix 类型
- **WHEN** 提交修复 Bug
- **THEN** 使用 `fix:` 前缀，触发 patch 版本更新

#### Scenario: docs 类型
- **WHEN** 提交仅修改文档
- **THEN** 使用 `docs:` 前缀，不触发版本更新

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
