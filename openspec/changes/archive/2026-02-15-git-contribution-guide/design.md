# Git 贡献指南 - 技术设计

## Context

### 项目背景

- **项目类型**: 个人开源 Flutter 应用，接受外部贡献者
- **目标用户**: 国内用户，纯中文项目
- **目标平台**: Android, iOS, Windows, macOS, Linux
- **发布方式**: GitHub Release (无代码签名)
- **CI/CD**: GitHub Actions

### 当前状态

- 新项目，使用 Flutter 默认模板
- 无现有 Git 工作流文档
- 无自动化发布流程

### 约束条件

- 保持纯 Dart 环境，不引入 Node.js 依赖
- 提交规范必须是严格的，有即时反馈
- 发布节奏为累积后手动触发

## Goals / Non-Goals

**Goals:**

- 建立完整的 Git 贡献工作流文档体系
- 实现本地 Git hooks 强制提交规范
- 实现自动化 CI 验证
- 实现 release-please 自动版本管理
- 支持全平台构建和 GitHub Release 发布

**Non-Goals:**

- 不涉及应用商店发布 (Google Play, App Store)
- 不涉及代码签名
- 不涉及 Firebase App Distribution 等测试分发平台
- 不引入 Node.js 生态工具 (husky, commitlint)

## Decisions

### 1. 分支策略: GitHub Flow

**选择**: GitHub Flow (简化版)

**理由**:

- 对外部贡献者友好 (Fork → PR → Done)
- 适合持续部署场景
- 流程简单，文档清晰

**替代方案**:

- GitFlow: 太复杂，对开源贡献者不友好
- Trunk-Based: 需要更强的测试基础设施

**实现**:

```
main (受保护)
  ↑
  └── feature/xxx, fix/xxx, docs/xxx (Fork → PR → Squash Merge)
```

### 2. Git Hooks: git_hooks (纯 Dart)

**选择**: [git_hooks](https://github.com/xuzhongpeng/git_hooks) 包

**理由**:

- 纯 Dart 实现，与 Flutter 项目无缝集成
- 支持中文文档
- 支持所有常用 hooks

**替代方案**:

- husky + commitlint: 需要 Node.js
- GitHub Actions 仅验证: 反馈慢，非即时

**实现**:

```dart
// git_hooks.dart
Map<Git, UserBackFun> params = {
  Git.commitMsg: commitMsg,   // Conventional Commits 验证
  Git.preCommit: preCommit,   // flutter analyze
};
```

### 3. 提交规范: Conventional Commits (中文版)

**选择**: Conventional Commits 规范，类型说明使用中文

**格式**:

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

**类型映射**:
| 类型 | 中文说明 | 版本影响 |
|------|----------|----------|
| feat | 新功能 | minor |
| fix | Bug 修复 | patch |
| docs | 文档更新 | - |
| style | 代码格式 | - |
| refactor | 重构 | - |
| perf | 性能优化 | patch |
| test | 测试 | - |
| build | 构建/依赖 | patch |
| ci | CI 配置 | - |
| chore | 其他杂项 | - |

**BREAKING CHANGE**: 触发 major 版本更新

### 4. 版本管理: release-please

**选择**: Google release-please GitHub Action

**理由**:

- 无需本地 Node.js
- 自动创建 Release PR
- 自动更新版本号和 CHANGELOG
- 支持多种语言

**替代方案**:

- standard-version: 需要 Node.js
- semantic-release: 配置复杂，更适合 pub.dev 包

**工作流**:

```
1. 正常开发，合并 PR 到 main
2. release-please 自动更新 Release PR
3. 维护者合并 Release PR (手动触发)
4. 自动: 更新 pubspec.yaml + CHANGELOG.md + 创建 tag
5. tag 触发 release.yml 构建全平台
```

### 5. CI 工作流设计

**ci.yml** (PR/Push 触发):

```yaml
jobs:
  analyze:
    - flutter pub get
    - flutter analyze
  test:
    - flutter test
  build-check:
    - flutter build apk --debug
    - flutter build ios --no-codesign --debug
    - flutter build windows
    - flutter build macos
    - flutter build linux
```

**release.yml** (Tag 触发):

```yaml
jobs:
  build-android:
    - flutter build apk --release
    - flutter build appbundle --release
  build-ios:
    - flutter build ios --release --no-codesign
  build-windows:
    - flutter build windows --release
  build-macos:
    - flutter build macos --release
  build-linux:
    - flutter build linux --release
  release:
    needs: [build-*]
    - 创建 GitHub Release
    - 上传所有制品
```

### 6. 版本号管理

**格式**: `major.minor.patch+build`

**策略**:

- `major.minor.patch`: 由 release-please 根据 commits 自动决定
- `build number`: 使用 GitHub Actions run number

**release-please 配置**:

```json
{
  "release-type": "dart",
  "packages": {
    ".": {
      "release-type": "dart"
    }
  }
}
```

## Risks / Trade-offs

### 风险 1: 外部贡献者不熟悉 Conventional Commits

**风险**: 贡献者可能不了解提交规范，导致 PR 被拒绝

**缓解措施**:

- 详细的 CONTRIBUTING.md 文档
- PR 模板中提醒规范
- commit-msg hook 提供友好的错误提示
- 维护者可以在 squash merge 时修正提交消息

### 风险 2: git_hooks 需要手动安装

**风险**: 贡献者 clone 项目后可能忘记安装 git hooks

**缓解措施**:

- CONTRIBUTING.md 中明确说明安装步骤
- CI 中仍然验证提交消息格式 (双重保障)
- 考虑使用 `pub get` 的 post-install hook 自动安装

### 风险 3: iOS 和 macOS 构建需要 macOS runner

**风险**: GitHub Actions macOS runner 资源有限，可能排队

**缓解措施**:

- 接受等待时间 (免费资源)
- 如果需要，未来可考虑自托管 runner

### 风险 4: 无代码签名的桌面应用

**风险**: Windows/macOS 用户安装时可能收到警告

**缓解措施**:

- 在 Release notes 中说明
- 提供安装指南文档
- 未来可根据需求添加代码签名

## Migration Plan

### 部署步骤

1. **添加依赖**: 在 `pubspec.yaml` 添加 `git_hooks`
2. **创建配置文件**: `git_hooks.dart`
3. **安装 hooks**: 运行 `dart run git_hooks create`
4. **创建文档**: CONTRIBUTING.md, docs/BRANCHING.md, docs/COMMIT_CONVENTION.md, docs/RELEASE.md
5. **创建 GitHub Actions**: .github/workflows/\*.yml
6. **创建模板**: PR 模板, Issue 模板
7. **配置分支保护**: 在 GitHub 仓库设置中启用

### 首次发布流程

1. 完成上述部署步骤
2. 正常开发几个功能
3. 合并 release-please 创建的 Release PR
4. 验证 GitHub Release 正确创建

### 回滚策略

- Git hooks: 删除 `.git/hooks/` 中的相关文件
- GitHub Actions: 删除 `.github/workflows/` 中的文件
- 文档: 可以保留或删除

## Open Questions

(无 - 所有技术决策已在探索阶段确定)
