# 贡献指南

感谢你对 Spectra 项目的兴趣！本文档将帮助你了解如何为项目做出贡献。

## 目录

- [行为准则](#行为准则)
- [开发环境搭建](#开发环境搭建)
- [如何贡献](#如何贡献)
- [提交流程](#提交流程)
- [Pull Request 规范](#pull-request-规范)
- [代码规范](#代码规范)

## 行为准则

请确保你的贡献符合开源精神，尊重所有参与者。

## 开发环境搭建

### 1. 安装 Flutter SDK

如果你还没有安装 Flutter，请按照 [Flutter 官方文档](https://docs.flutter.dev/get-started/install) 进行安装。

验证安装：
```bash
flutter doctor
```

### 2. Fork 并 Clone 项目

1. 点击 GitHub 页面右上角的 "Fork" 按钮
2. Clone 你 Fork 的仓库：
   ```bash
   git clone https://github.com/<你的用户名>/spectra.git
   cd spectra
   ```

### 3. 安装依赖

```bash
flutter pub get
```

### 4. 安装 Git Hooks

本项目使用 [Husky](https://typicode.github.io/husky/) + [lint-staged](https://github.com/lint-staged/lint-staged) 来强制执行代码质量和提交规范。

#### 安装 Bun

```bash
# macOS/Linux
curl -fsSL https://bun.sh/install | bash

# Windows (使用 Scoop)
scoop install bun
```

#### 安装依赖

```bash
# 安装 Node.js 依赖（包含 Husky）
bun install
```

安装完成后，每次 commit 时会自动：
- 格式化暂存的代码
- 运行 lint 检查
- 验证提交消息格式是否符合 Conventional Commits

跳过检查（不推荐）：`git commit --no-verify`

### 5. 运行项目

```bash
flutter run
```

## 如何贡献

### 报告 Bug

如果你发现了 Bug，请通过 [GitHub Issues](../../issues) 提交报告。提交前请：
- 搜索是否已有相关 Issue
- 使用 Bug 报告模板填写详细信息

### 提出新功能

欢迎提出新功能建议！请：
- 通过 [GitHub Issues](../../issues) 提交
- 使用功能请求模板描述你的想法
- 说明该功能的使用场景

### 提交代码

1. **创建分支**
   ```bash
   git checkout -b feat/你的功能名称
   # 或
   git checkout -b fix/你要修复的问题
   ```

2. **编写代码**
   - 遵循代码规范
   - 添加必要的测试
   - 确保代码通过 `flutter analyze`

3. **提交代码**
   ```bash
   git add .
   git commit -m "feat: 添加新功能描述"
   ```

4. **推送并创建 PR**
   ```bash
   git push origin feat/你的功能名称
   ```
   然后在 GitHub 上创建 Pull Request

## 提交流程

### 分支命名规范

| 前缀 | 用途 | 示例 |
|------|------|------|
| `feat/` | 新功能 | `feat/add-dark-mode` |
| `fix/` | Bug 修复 | `fix/login-crash` |
| `docs/` | 文档更新 | `docs/update-readme` |
| `refactor/` | 重构 | `refactor/auth-module` |
| `test/` | 测试 | `test/unit-tests` |
| `chore/` | 其他 | `chore/update-deps` |

### 提交消息规范

本项目采用 [Conventional Commits](https://www.conventionalcommits.org/) 规范。

**格式：**
```
<type>(<scope>): <description>
```

**类型：**
| 类型 | 说明 | 版本影响 |
|------|------|----------|
| `feat` | 新功能 | minor |
| `fix` | Bug 修复 | patch |
| `docs` | 文档更新 | - |
| `style` | 代码格式 | - |
| `refactor` | 重构 | - |
| `perf` | 性能优化 | patch |
| `test` | 测试 | - |
| `build` | 构建/依赖 | patch |
| `ci` | CI 配置 | - |
| `chore` | 其他杂项 | - |

**示例：**
```
feat: 添加用户登录功能
fix(auth): 修复登录验证失败的问题
docs: 更新安装文档
feat(ui): 添加深色模式支持

BREAKING CHANGE: 重新设计了 API 接口
```

更多详情请参阅 [提交规范文档](../docs/COMMIT_CONVENTION.md)。

## Pull Request 规范

### PR 标题

PR 标题应遵循与提交消息相同的格式：
```
<type>(<scope>): <description>
```

### PR 描述

请使用提供的 PR 模板，包含：
- 变更描述
- 相关 Issue 编号
- 测试说明
- 截图（如适用）

### 检查清单

提交 PR 前，请确保：
- [ ] 代码通过 `flutter analyze`
- [ ] 代码通过 `flutter test`
- [ ] 提交消息符合 Conventional Commits 规范
- [ ] 已添加必要的文档
- [ ] 已添加必要的测试

### Review 流程

1. 提交 PR
2. 等待 CI 检查通过
3. 等待维护者 Review
4. 根据 Review 意见修改（如有需要）
5. 合并到 main 分支

## 代码规范

- 遵循 [Effective Dart](https://dart.dev/guides/language/effective-dart) 规范
- 使用 `flutter analyze` 检查代码
- 使用 `dart format .` 格式化代码

## 需要帮助？

如果你有任何问题，可以：
- 在 [GitHub Discussions](../../discussions) 中提问
- 在 Issue 中留言

感谢你的贡献！
