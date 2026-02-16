# 提交消息规范

本项目采用 [Conventional Commits](https://www.conventionalcommits.org/) 规范。本文档详细说明如何编写符合规范的提交消息。

## 格式

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### 组成部分

- **type** (必需): 提交类型，决定版本号如何更新
- **scope** (可选): 影响范围，用括号包裹
- **description** (必需): 简短描述，不超过 50 个字符
- **body** (可选): 详细描述
- **footer** (可选): 元数据，如 BREAKING CHANGE

## 提交类型

| 类型       | 说明                        | 版本影响 | Releasable |
| ---------- | --------------------------- | -------- | :--------: |
| `feat`     | 新功能                      | minor    |     ✓      |
| `fix`      | Bug 修复                    | patch    |     ✓      |
| `deps`     | 依赖更新                    | patch    |     ✓      |
| `docs`     | 文档更新                    | 无       |     ✗      |
| `style`    | 代码格式 (不影响逻辑)       | 无       |     ✗      |
| `refactor` | 重构 (不是新功能也不是修复) | 无       |     ✗      |
| `perf`     | 性能优化                    | 无       |     ✗      |
| `test`     | 添加/修改测试               | 无       |     ✗      |
| `build`    | 构建系统变更                | 无       |     ✗      |
| `ci`       | CI 配置变更                 | 无       |     ✗      |
| `chore`    | 其他不修改 src 的变更       | 无       |     ✗      |
| `revert`   | 回滚之前的提交              | 视情况   |     ✗      |

> **Releasable** 列表示该类型是否会被 release-please 识别并纳入 CHANGELOG。

### 类型详解

#### feat - 新功能

添加新的功能特性。

```bash
feat: 添加用户登录功能
feat(ui): 添加深色模式支持
feat(api): 添加用户头像上传接口
```

#### fix - Bug 修复

修复现有功能的问题。

```bash
fix: 修复登录页面崩溃问题
fix(auth): 修复 token 过期后未自动刷新
fix(ios): 修复 iOS 15 下的兼容性问题
```

#### deps - 依赖更新

更新项目依赖。

```bash
deps: 升级 Flutter SDK 到 3.19
deps: 更新 http 包到最新版本
deps(deps): 修复安全漏洞 CVE-2024-xxxx
```

#### docs - 文档更新

仅修改文档，不涉及代码逻辑。

```bash
docs: 更新 README 安装说明
docs(api): 补充 API 接口文档
docs: 修正 CONTRIBUTING.md 中的拼写错误
```

#### style - 代码格式

不影响代码逻辑的格式调整。

```bash
style: 格式化代码
style: 统一缩进为 2 空格
style: 移除多余空行
```

#### refactor - 重构

既不是新功能也不是修复的代码变更。

```bash
refactor: 重构用户模块
refactor(utils): 提取公共方法到工具类
refactor: 优化代码结构
```

#### perf - 性能优化

提升性能的代码变更。

```bash
perf: 优化列表渲染性能
perf(db): 优化数据库查询
perf: 减少不必要的重绘
```

#### test - 测试

添加或修改测试。

```bash
test: 添加用户模块单元测试
test(auth): 补充登录功能测试用例
test: 修复失败的测试
```

#### build - 构建

构建系统或外部依赖变更。

```bash
build: 升级 Flutter 版本到 3.16
build(deps): 更新依赖包版本
build: 配置构建脚本
```

#### ci - CI 配置

持续集成配置变更。

```bash
ci: 添加 GitHub Actions 工作流
ci: 配置代码覆盖率报告
ci: 修复 CI 构建失败
```

#### chore - 其他

其他不修改 src 或测试的变更。

```bash
chore: 更新 .gitignore
chore: 清理无用代码
chore: 添加项目配置文件
```

#### revert - 回滚

回滚之前的提交。

```bash
revert: 回滚 "feat: 添加用户登录功能"

This reverts commit abc123def456...
```

## Scope (影响范围)

Scope 用于说明提交影响的范围，是可选的。

### 常见的 Scope

- **模块名**: `auth`, `user`, `home`, `settings`
- **平台名**: `ios`, `android`, `windows`, `macos`, `linux`
- **层级名**: `ui`, `api`, `db`, `utils`
- **文件名**: 当只修改单个文件时使用

### 示例

```bash
feat(auth): 添加第三方登录支持
fix(ios): 修复 iOS 15 崩溃问题
refactor(ui): 重构主题系统
docs(README): 更新安装说明
```

## Breaking Changes (破坏性变更)

当提交包含破坏性变更时，需要在 footer 中添加 `BREAKING CHANGE:` 说明，或在类型后加 `!`。

### 格式

```bash
feat: 重新设计 API 接口

BREAKING CHANGE: 完全重构了 API 接口，旧接口不再兼容。
请查看迁移指南更新你的代码。
```

### 版本影响

包含 `BREAKING CHANGE` 的提交会触发 **major** 版本更新 (0.1.0 → 1.0.0 或 1.0.0 → 2.0.0)。

### 示例

```bash
feat!: 重构配置系统

BREAKING CHANGE: 配置文件格式已变更，旧配置文件不再兼容。
迁移方法：
1. 删除旧的 config.json
2. 运行 `spectra init` 重新生成配置
```

```bash
refactor(auth)!: 移除旧版认证 API

BREAKING CHANGE: `/api/v1/auth` 接口已移除，请使用 `/api/v2/auth`
```

## Releasable Units (可发布单元)

本项目使用 [release-please](https://github.com/googleapis/release-please) 自动管理版本和 CHANGELOG。只有特定类型的提交会被识别为 "releasable units" 并纳入 CHANGELOG。

### 进入 CHANGELOG 的类型

| 类型                       | 版本影响 | CHANGELOG 分组     |
| -------------------------- | -------- | ------------------ |
| `feat`                     | minor    | Features           |
| `fix`                      | patch    | Bug Fixes          |
| `deps`                     | patch    | Dependencies       |
| `feat!` / `fix!` / `deps!` | major    | ⚠ Breaking Changes |

### 不进入 CHANGELOG 的类型

以下类型**不会**触发版本更新或出现在 CHANGELOG 中：

- `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

### 开发期间控制发布节奏

如果开发期间不想触发 Release PR，可以使用非 releasable 类型：

```bash
# 这些不会触发 Release PR
chore: 重构内部实现
refactor: 优化代码结构
docs: 更新文档
```

如果想发布新功能或修复，使用 releasable 类型：

```bash
# 这些会触发 Release PR
feat: 添加新功能
fix: 修复 Bug
deps: 更新依赖
```

## 单提交多变更

当一个提交需要包含多个独立的变更时，可以使用 footer 形式添加额外的变更条目：

```bash
feat: 添加 v4 UUID 支持

这是主要变更的描述。

fix(utils): unicode 不再抛出异常
feat(utils): 更新 encode 支持 unicode
```

上面的提交会在 CHANGELOG 中生成三条记录：

1. `feat: 添加 v4 UUID 支持` → Features
2. `fix(utils): unicode 不再抛出异常` → Bug Fixes
3. `feat(utils): 更新 encode 支持 unicode` → Features

> **注意**: 额外的变更条目必须添加在提交消息的底部。

## 描述规范

### 长度限制

- 描述不超过 **50 个字符**
- Body 每行不超过 **72 个字符**

### 语言

推荐使用**中文**描述，更符合项目定位。

### 时态

使用**祈使句**，描述"做了什么"而不是"做了..."。

**好的示例：**

- `feat: 添加用户登录功能` (添加)
- `fix: 修复页面崩溃问题` (修复)

**不好的示例：**

- `feat: 添加了用户登录功能` (使用了"了")
- `fix: 修复了页面崩溃` (使用了"了")

## 完整示例

### 简单提交

```bash
feat: 添加用户登录功能
```

```bash
fix(auth): 修复 token 过期后未自动刷新
```

### 带 Scope 的提交

```bash
feat(ui): 添加深色模式支持
```

```bash
fix(ios): 修复 iOS 15 下的键盘遮挡问题
```

### 带 Body 的提交

```bash
feat: 添加用户头像上传功能

- 支持从相册选择图片
- 支持拍照上传
- 自动压缩图片大小
- 限制文件格式为 jpg/png
```

### 带 Breaking Change 的提交

```bash
refactor(api)!: 重构用户 API 接口

将 REST API 迁移到 GraphQL，提升数据查询效率。

BREAKING CHANGE: 所有 REST API 端点已废弃，请使用新的 GraphQL 接口。
迁移指南: https://docs.example.com/migration
```

### 关联 Issue

```bash
feat: 添加用户注册功能

Closes #123
```

```bash
fix: 修复登录超时问题

Fixes #456
Related #123
```

## Git Hooks 验证

本项目使用 `git_hooks` 在提交时自动验证消息格式。

### 验证规则

1. 必须以有效类型开头
2. 类型后可选跟 `(scope)`
3. 必须有 `: ` (冒号+空格)
4. 描述不能为空，不超过 50 字符

### 验证失败

如果提交消息格式不正确，Git hooks 会拒绝提交并显示中文错误提示：

```
❌ 提交消息格式错误！

格式: <type>(<scope>): <description>

类型 (type):
  feat      新功能
  fix       Bug 修复
  ...
```

## 最佳实践

1. **频繁提交**: 小步快跑，每个提交只做一件事
2. **原子性**: 每个提交应该是独立完整的
3. **清晰描述**: 让别人一看就知道做了什么
4. **遵循规范**: 保持提交历史的一致性
5. **及时推送**: 避免本地积累太多未推送的提交
6. **使用 Squash-Merge**: 合并 PR 时推荐使用 squash-merge

## Squash-Merge 最佳实践

本项目**强烈推荐**使用 squash-merge 方式合并 Pull Request。

### 为什么使用 Squash-Merge

| 优势               | 说明                                                      |
| ------------------ | --------------------------------------------------------- |
| **线性历史**       | main 分支历史按合并日期排序，清晰易读                     |
| **便于追踪**       | `git bisect` 可以快速定位引入问题的变更                   |
| **CHANGELOG 友好** | PR 内的临时提交（如 "fix typo"、"wip"）不会进入 CHANGELOG |
| **原子性回滚**     | 如需回滚，整个 PR 作为一个单元回滚                        |

### PR 合并流程

1. PR 作者在分支中随意提交（可以包含 "wip"、"fix typo" 等）
2. PR 审查通过后，维护者在合并时选择 **Squash and merge**
3. 编辑 squash commit 消息，确保符合 Conventional Commits 规范
4. 合并后，release-please 会根据这个 squash commit 消息生成 CHANGELOG

### 示例

```
PR #123: 添加用户登录功能

PR 内的提交:
├── feat: 添加登录页面 UI
├── fix: 修复表单验证
├── wip: 测试中
├── fix: 修复拼写错误
└── feat: 添加登录 API 集成

Squash 后的 commit:
feat(auth): 添加用户登录功能

- 支持用户名/密码登录
- 支持记住登录状态
- 添加表单验证
```

### GitHub 设置建议

建议在仓库设置中启用 squash-merge：

1. 进入 Settings → General → Pull Requests
2. 勾选 "Allow squash merging"
3. 选择 "Default to PR title and description for squash commit messages"
