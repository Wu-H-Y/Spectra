# 分支规则

本文档描述 Spectra 项目的分支策略和管理规则。

## 分支策略概述

Spectra 采用 **GitHub Flow** (简化版) 分支策略：

```
main (受保护)
  ↑
  └── feat/xxx, fix/xxx, docs/xxx (Fork → PR → Squash Merge)
```

## 分支类型

### main 分支

- **唯一**的长期分支
- 永远处于可部署状态
- 受保护，禁止直接推送
- 所有代码变更必须通过 Pull Request 合并

### 功能分支

从 main 分支创建，用于开发新功能或修复问题。

## 分支命名规范

| 前缀 | 用途 | 示例 |
|------|------|------|
| `feat/` | 新功能开发 | `feat/add-dark-mode` |
| `fix/` | Bug 修复 | `fix/login-crash` |
| `docs/` | 文档更新 | `docs/update-api-guide` |
| `refactor/` | 代码重构 | `refactor/auth-module` |
| `test/` | 测试相关 | `test/add-unit-tests` |
| `chore/` | 其他杂项 | `chore/update-dependencies` |
| `perf/` | 性能优化 | `perf/optimize-list-rendering` |

### 命名规则

1. 使用小写字母
2. 使用连字符 `-` 分隔单词
3. 描述简洁明了
4. 使用英文

**好的示例：**
- `feat/add-user-profile`
- `fix/ios-camera-crash`
- `docs/update-installation-guide`

**不好的示例：**
- `feature` (太模糊)
- `fix-bug` (太模糊)
- `my-branch` (无意义)
- `添加功能` (应使用英文)

## main 分支保护规则

以下规则在 GitHub 仓库设置中启用：

### 必须通过 Pull Request

- 禁止直接推送到 main 分支
- 所有变更必须通过 Pull Request

### 必须通过 CI 检查

Pull Request 必须通过以下检查才能合并：
- `analyze` - 代码分析
- `test` - 单元测试
- `build-*` - 各平台构建检查

### 必须有 Review 通过

- 至少需要 1 个 Reviewer 批准
- 由项目维护者审核

### Squash Merge

合并时使用 Squash Merge：
- 将 PR 的所有 commits 压缩为一个
- 保持 main 分支历史整洁
- 便于追踪变更

## Pull Request 流程

### 1. 创建分支

```bash
# 确保在最新的 main 上
git checkout main
git pull origin main

# 创建新分支
git checkout -b feat/your-feature
```

### 2. 开发并提交

```bash
# 编写代码...
git add .
git commit -m "feat: 添加新功能"
git push origin feat/your-feature
```

### 3. 创建 Pull Request

1. 访问 GitHub 仓库页面
2. 点击 "Compare & pull request"
3. 填写 PR 标题和描述
4. 等待 CI 检查和 Review

### 4. 合并

- CI 检查通过
- Review 通过
- 维护者执行 Squash Merge

## Fork 工作流 (外部贡献者)

外部贡献者通过 Fork 方式参与贡献：

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  Original Repo  │     │   Your Fork     │     │  Your Local     │
│    (upstream)   │     │    (origin)     │     │                 │
│                 │     │                 │     │                 │
│     main        │◄────│     main        │◄────│     main        │
│       ▲         │     │       ▲         │     │       ▲         │
│       │         │     │       │         │     │       │         │
│       │ PR      │     │       │ push    │     │       │ commit  │
│       │         │     │       │         │     │       │         │
│       │         │     │  feat/xxx       │◄────│  feat/xxx       │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

### 步骤

1. **Fork 项目**
   - 点击 GitHub 页面右上角的 "Fork"

2. **Clone 你的 Fork**
   ```bash
   git clone https://github.com/<你的用户名>/spectra.git
   cd spectra
   ```

3. **添加上游仓库**
   ```bash
   git remote add upstream https://github.com/<原作者>/spectra.git
   ```

4. **同步最新代码**
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

5. **创建功能分支**
   ```bash
   git checkout -b feat/your-feature
   ```

6. **开发并推送**
   ```bash
   git add .
   git commit -m "feat: 添加新功能"
   git push origin feat/your-feature
   ```

7. **创建 Pull Request**
   - 在你的 Fork 页面点击 "Create pull request"
   - 目标仓库选择上游仓库的 main 分支

## 冲突解决

如果你的分支与 main 有冲突：

```bash
# 获取最新代码
git fetch upstream

# 合并 main 到你的分支
git checkout feat/your-feature
git merge upstream/main

# 解决冲突
# ...

# 推送解决冲突后的代码
git push origin feat/your-feature
```

## 分支清理

合并后的分支应及时删除：

- GitHub 会在合并后提示删除
- 本地分支可以手动删除：
  ```bash
  git branch -d feat/your-feature
  ```
