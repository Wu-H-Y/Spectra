# Git 贡献指南

## Why

Spectra 是一个面向国内用户的纯中文开源 Flutter 项目，需要接受外部贡献者参与开发。目前项目缺乏规范的 Git 工作流文档和自动化工具，这会导致：

- 提交消息格式混乱，难以自动生成 CHANGELOG
- 分支管理不规范，容易产生冲突
- 发布流程不清晰，版本管理混乱
- 外部贡献者不清楚如何正确参与项目

建立完整的 Git 最佳实践体系，可以提升项目质量、降低协作成本、实现自动化发布。

## What Changes

### 新增文档

- **CONTRIBUTING.md**: 主贡献指南，包含开发环境搭建、提交流程、PR 规范
- **docs/BRANCHING.md**: 分支规则文档，定义分支命名、保护规则、合并策略
- **docs/COMMIT_CONVENTION.md**: 提交消息规范，基于 Conventional Commits
- **docs/RELEASE.md**: 发布指南，说明版本管理和发布流程

### 新增配置文件

- **git_hooks.dart**: Git hooks 配置 (commit-msg + pre-commit)，使用纯 Dart 实现
- **.github/workflows/ci.yml**: CI 工作流，验证 PR 的代码质量
- **.github/workflows/release-please.yml**: 自动管理 Release PR
- **.github/workflows/release.yml**: 全平台构建和 GitHub Release 发布

### 新增模板

- **.github/PULL_REQUEST_TEMPLATE.md**: PR 模板
- **.github/ISSUE_TEMPLATE/bug_report.yml**: Bug 报告模板
- **.github/ISSUE_TEMPLATE/feature_request.yml**: 功能请求模板

### 自动生成

- **CHANGELOG.md**: 由 release-please 根据提交记录自动生成

## Capabilities

### New Capabilities

- **git-hooks**: 本地 Git hooks 验证系统，强制 Conventional Commits 格式，运行代码分析
- **branch-protection**: 分支保护规则，定义 main 分支保护、分支命名规范、PR 合并流程
- **commit-convention**: 提交消息规范，基于 Conventional Commits，包含中文类型说明
- **release-workflow**: 发布工作流，使用 release-please 自动管理版本和 CHANGELOG，支持全平台构建
- **contribution-guide**: 贡献指南系统，包含完整的开发者入门文档和模板

### Modified Capabilities

(无 - 这是新项目，没有需要修改的现有能力)

## Impact

### 依赖变更

- `pubspec.yaml`: 添加 `git_hooks` 作为 dev_dependency

### 受影响的开发者工作流

- 所有提交必须符合 Conventional Commits 格式
- 提交前自动运行 `flutter analyze`
- PR 必须通过 CI 检查才能合并
- 发布由维护者通过合并 Release PR 触发

### GitHub 配置

- main 分支需要设置保护规则 (需要 PR + review + CI 通过)
- 需要 GitHub Actions 权限

### 目标平台支持

- Android (APK)
- iOS (IPA, 无签名)
- Windows (EXE, 无签名)
- macOS (APP, 无签名)
- Linux (AppImage/DEB)
