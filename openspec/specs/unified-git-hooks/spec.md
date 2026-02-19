# Spec: Unified Git Hooks

统一的 Git 钩子管理系统，使用 Husky 管理 pre-commit 和 commit-msg 钩子，支持 Dart 和前端项目的统一检查。

## ADDED Requirements

### Requirement: Husky installation

系统 SHALL 在运行 `bun run prepare` 后自动初始化 Husky 并创建 `.husky/` 目录。

#### Scenario: Fresh installation
- **WHEN** 开发者在新克隆的项目中运行 `bun install && bun run prepare`
- **THEN** 系统创建 `.husky/` 目录
- **AND** 创建 `.husky/pre-commit` 钩子文件
- **AND** 创建 `.husky/commit-msg` 钩子文件

#### Scenario: Husky already installed
- **WHEN** 开发者再次运行 `bun run prepare`
- **THEN** Husky 检测到已安装状态
- **AND** 不会覆盖现有钩子配置

### Requirement: Pre-commit hook execution

系统 SHALL 在每次 `git commit` 前自动执行 lint-staged 检查。

#### Scenario: Successful pre-commit
- **WHEN** 开发者执行 `git commit -m "feat: 新功能"`
- **THEN** 系统执行 `.husky/pre-commit` 脚本
- **AND** lint-staged 检查暂存的文件
- **AND** 如果检查通过，提交继续

#### Scenario: Pre-commit check fails
- **WHEN** 开发者执行 `git commit` 且 lint-staged 检查失败
- **THEN** 系统阻止提交
- **AND** 显示错误信息

#### Scenario: Skip pre-commit with --no-verify
- **WHEN** 开发者执行 `git commit --no-verify -m "feat: 新功能"`
- **THEN** 系统跳过 pre-commit 钩子
- **AND** 提交正常完成

### Requirement: Commit-msg hook execution

系统 SHALL 在每次 `git commit` 后验证提交信息格式。

#### Scenario: Valid commit message
- **WHEN** 开发者使用符合 Conventional Commits 的提交信息
- **THEN** 系统允许提交
- **AND** 提交成功完成

#### Scenario: Invalid commit message
- **WHEN** 开发者使用不符合 Conventional Commits 的提交信息
- **THEN** 系统阻止提交
- **AND** 显示正确的格式说明

#### Scenario: Skip commit-msg with --no-verify
- **WHEN** 开发者执行 `git commit --no-verify -m "invalid message"`
- **THEN** 系统跳过 commit-msg 钩子
- **AND** 提交正常完成

### Requirement: Root package.json structure

根目录 `package.json` SHALL 包含以下配置：

#### Scenario: Package.json scripts
- **WHEN** 查看 `package.json` 的 scripts 部分
- **THEN** 包含 `prepare: "husky"` 脚本
- **AND** 包含 `lint:dart` 脚本
- **AND** 包含 `lint:web` 脚本

#### Scenario: Package.json devDependencies
- **WHEN** 查看 `package.json` 的 devDependencies 部分
- **THEN** 包含 `husky` 依赖
- **AND** 包含 `lint-staged` 依赖
- **AND** 包含 `@commitlint/cli` 依赖
- **AND** 包含 `@commitlint/config-conventional` 依赖
