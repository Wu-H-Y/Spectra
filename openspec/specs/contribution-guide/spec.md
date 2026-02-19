# 贡献指南规范

## ADDED Requirements

### Requirement: CONTRIBUTING.md 主文档

项目 SHALL 提供完整的 CONTRIBUTING.md 贡献指南文档。

#### Scenario: 文档位置
- **WHEN** 贡献者访问项目
- **THEN** 可以在项目根目录找到 CONTRIBUTING.md

#### Scenario: 文档内容
- **WHEN** 贡献者阅读 CONTRIBUTING.md
- **THEN** 包含开发环境搭建、Fork 流程、提交规范、PR 规范

### Requirement: 分支规则文档

项目 SHALL 提供 docs/BRANCHING.md 分支规则文档。

#### Scenario: 分支规则说明
- **WHEN** 贡献者阅读 BRANCHING.md
- **THEN** 了解分支命名规范、main 分支保护规则、PR 合并流程

### Requirement: 提交规范文档

项目 SHALL 提供 docs/COMMIT_CONVENTION.md 提交规范文档。

#### Scenario: 提交格式说明
- **WHEN** 贡献者阅读 COMMIT_CONVENTION.md
- **THEN** 了解 Conventional Commits 格式、类型定义、示例

### Requirement: 发布指南文档

项目 SHALL 提供 docs/RELEASE.md 发布指南文档。

#### Scenario: 发布流程说明
- **WHEN** 维护者阅读 RELEASE.md
- **THEN** 了解如何触发发布、版本号规则、发布检查清单

### Requirement: PR 模板

项目 SHALL 提供 Pull Request 模板。

#### Scenario: PR 模板位置
- **WHEN** 贡献者创建 PR
- **THEN** 自动显示 PR 模板内容

#### Scenario: PR 模板内容
- **WHEN** PR 模板加载
- **THEN** 包含变更描述、检查清单、提交规范提醒

### Requirement: Bug 报告模板

项目 SHALL 提供 Bug 报告 Issue 模板。

#### Scenario: Bug 模板字段
- **WHEN** 用户创建 Bug 报告
- **THEN** 模板包含问题描述、复现步骤、预期行为、环境信息

### Requirement: 功能请求模板

项目 SHALL 提供功能请求 Issue 模板。

#### Scenario: 功能请求字段
- **WHEN** 用户提交功能请求
- **THEN** 模板包含功能描述、使用场景、期望行为

### Requirement: 中文文档

所有贡献指南文档 SHALL 使用中文编写。

#### Scenario: 中文界面
- **WHEN** 贡献者阅读任何指南文档
- **THEN** 内容为中文

### Requirement: 开发环境搭建指南

CONTRIBUTING.md SHALL 包含完整的开发环境搭建指南。

#### Scenario: Flutter 安装
- **WHEN** 新贡献者阅读文档
- **THEN** 包含 Flutter SDK 安装指引

#### Scenario: 依赖安装
- **WHEN** 新贡献者阅读文档
- **THEN** 包含 `flutter pub get` 命令说明
