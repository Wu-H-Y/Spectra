# Git 贡献指南 - 实施任务

## 1. Git Hooks 配置

- [x] 1.1 在 pubspec.yaml 添加 git_hooks 依赖
- [x] 1.2 创建 git_hooks.dart 配置文件
- [x] 1.3 实现 commit-msg hook (Conventional Commits 验证)
- [x] 1.4 实现 pre-commit hook (flutter analyze)
- [x] 1.5 添加中文错误提示信息
- [ ] 1.6 测试 hooks 功能 (需要手动运行: dart run git_hooks create git_hooks.dart)

## 2. GitHub Actions CI 工作流

- [x] 2.1 创建 .github/workflows/ci.yml
- [x] 2.2 配置 flutter analyze 任务
- [x] 2.3 配置 flutter test 任务
- [x] 2.4 配置多平台构建检查 (Android, iOS, Web, Windows, macOS, Linux)

## 3. Release Please 自动化

- [x] 3.1 创建 .github/workflows/release-please.yml
- [x] 3.2 配置 release-please-action
- [x] 3.3 设置 Dart 语言支持
- [ ] 3.4 测试 Release PR 自动创建 (需要推送到 GitHub 后验证)

## 4. Release 构建工作流

- [x] 4.1 创建 .github/workflows/release.yml
- [x] 4.2 配置 tag 触发条件
- [x] 4.3 配置 Android 构建 (APK + AAB)
- [x] 4.4 配置 iOS 构建 (无签名 IPA)
- [x] 4.5 配置 Web 构建
- [x] 4.6 配置 Windows 构建 (无签名)
- [x] 4.7 配置 macOS 构建 (无签名)
- [x] 4.8 配置 Linux 构建 (AppImage + DEB)
- [x] 4.9 配置 GitHub Release 创建和制品上传

## 5. 贡献指南文档

- [x] 5.1 创建 .github/CONTRIBUTING.md 主贡献指南
- [x] 5.2 编写开发环境搭建指南
- [x] 5.3 编写 Fork 和 PR 流程说明
- [x] 5.4 编写 git_hooks 安装说明

## 6. 分支规则文档

- [x] 6.1 创建 docs/BRANCHING.md
- [x] 6.2 编写分支命名规范
- [x] 6.3 编写 main 分支保护规则
- [x] 6.4 编写 PR 合并流程
- [x] 6.5 编写 Fork 工作流说明

## 7. 提交规范文档

- [x] 7.1 创建 docs/COMMIT_CONVENTION.md
- [x] 7.2 编写 Conventional Commits 格式说明
- [x] 7.3 编写类型定义和版本影响对照表
- [x] 7.4 编写 Breaking Change 标记说明
- [x] 7.5 提供提交消息示例

## 8. 发布指南文档

- [x] 8.1 创建 docs/RELEASE.md
- [x] 8.2 编写发布触发流程
- [x] 8.3 编写版本号规则说明
- [x] 8.4 编写发布检查清单

## 9. GitHub 模板

- [x] 9.1 创建 .github/PULL_REQUEST_TEMPLATE.md
- [x] 9.2 创建 .github/ISSUE_TEMPLATE/bug_report.yml
- [x] 9.3 创建 .github/ISSUE_TEMPLATE/feature_request.yml

## 10. 初始化 CHANGELOG

- [x] 10.1 创建 CHANGELOG.md 初始文件

## 11. GitHub 仓库配置 (需要手动在 GitHub 网页配置)

> **注意**: 以下任务需要在 GitHub 仓库设置中手动配置：
>
> 1. 进入仓库 Settings → Branches
> 2. 点击 "Add branch protection rule"
> 3. 配置 main 分支保护规则：
>    - ✅ Require a pull request before merging
>    - ✅ Require approvals (至少 1 个)
>    - ✅ Require status checks to pass before merging
>    - ✅ Require branches to be up to date before merging
>    - 选择需要的 status checks: analyze, test
>    - ✅ Do not allow bypassing the above settings
> 4. 进入 Settings → Actions → General
> 5. 配置 Actions 权限：
>    - ✅ Allow all actions and reusable workflows
>    - 或根据需要限制为 "Actions created by GitHub" + "Allow actions created by verified creators"

- [x] 11.1 配置 main 分支保护规则
- [x] 11.2 启用必须通过 PR 才能合并
- [x] 11.3 启用必须通过 CI 检查
- [x] 11.4 配置 GitHub Actions 权限
