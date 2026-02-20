# 贡献规范

## 文档结构

| 文件 | 用途 |
|------|------|
| `CONTRIBUTING.md` | 贡献指南主文档 |
| `docs/BRANCHING.md` | 分支规则 |
| `docs/COMMIT_CONVENTION.md` | 提交规范 |
| `docs/RELEASE.md` | 发布指南 |
| `.github/PULL_REQUEST_TEMPLATE.md` | PR 模板 |
| `.github/ISSUE_TEMPLATE/bug_report.md` | Bug 报告模板 |
| `.github/ISSUE_TEMPLATE/feature_request.md` | 功能请求模板 |

---

## 分支保护

### Requirement: main 分支保护

- 禁止直接推送
- 必须通过 PR 合并
- PR 必须通过 CI 检查

### Requirement: 分支命名规范

| 前缀 | 用途 |
|------|------|
| `feat/` | 新功能 |
| `fix/` | Bug 修复 |
| `docs/` | 文档更新 |
| `refactor/` | 代码重构 |
| `test/` | 测试相关 |
| `chore/` | 其他杂项 |

#### Scenario: 有效分支名
- `feat/add-login`
- `fix/crash-bug`

### Requirement: Squash Merge

合并到 main 使用 Squash Merge，保持历史线性。

---

## 提交规范

### Requirement: Conventional Commits

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Requirement: Releasable Units

以下类型会进入 CHANGELOG：
- `feat`: minor 版本更新
- `fix`: patch 版本更新
- `deps`: patch 版本更新

其他类型（docs, refactor, test, chore 等）不触发版本更新。

### Requirement: Breaking Change

包含 `BREAKING CHANGE:` 触发 major 版本更新。

```
feat: 重新设计 API

BREAKING CHANGE: 完全重构了 API 接口
```

### Requirement: 中文描述

提交描述使用中文。

```
feat: 添加用户登录功能
fix(auth): 修复登录超时问题
```

---

## PR 规范

### Requirement: PR 模板内容

- 变更描述
- 检查清单
- 提交规范提醒

### Requirement: CI 检查

- 代码格式化
- 静态分析
- 测试通过

### Requirement: Squash Merge 推荐

- 按合并日期排序，历史清晰
- 便于 git bisect 追踪问题
- 避免 PR 内临时提交污染 main

---

## Fork 工作流

外部贡献者通过 Fork 方式参与：

1. Fork 项目
2. 创建功能分支
3. 提交 PR

---

## 开发环境

### Requirement: Flutter 安装

CONTRIBUTING.md 包含 Flutter SDK 安装指引。

### Requirement: 依赖安装

```bash
flutter pub get
bun install  # 安装 Git Hooks 依赖
bun run prepare  # 初始化 Husky
```
