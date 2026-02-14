# 发布指南

本文档描述 Spectra 项目的版本管理和发布流程。

## 版本号规则

Spectra 遵循 [语义化版本](https://semver.org/lang/zh-CN/) 规范。

### 格式

```
major.minor.patch+build
```

### 组成部分

- **major**: 主版本号，不兼容的 API 变更时递增
- **minor**: 次版本号，向下兼容的功能新增时递增
- **patch**: 修订号，向下兼容的问题修复时递增
- **build**: 构建号，每次发布自动递增

### 示例

```
1.0.0+1   → 首次发布
1.0.1+2   → 修复 Bug
1.1.0+3   → 新增功能
2.0.0+4   → 破坏性变更
```

## 版本更新规则

| 提交类型 | 版本更新 | 示例 |
|----------|----------|------|
| `feat` | minor +1 | 1.0.0 → 1.1.0 |
| `fix` | patch +1 | 1.0.0 → 1.0.1 |
| `perf` | patch +1 | 1.0.0 → 1.0.1 |
| `build` | patch +1 | 1.0.0 → 1.0.1 |
| `BREAKING CHANGE` | major +1 | 1.0.0 → 2.0.0 |
| 其他类型 | 无更新 | - |

## 发布流程

Spectra 使用 **release-please** 自动管理版本和发布。

### 流程概览

```
┌──────────────────────────────────────────────────────────────────┐
│                       发布流程                                    │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│   1. 开发阶段                                                     │
│   ──────────                                                     │
│   正常开发 → 提交符合规范的 commit → 合并到 main                   │
│                                                                  │
│                      ┌─────────────────────────────┐             │
│                      │  main 分支                  │             │
│                      │  ├── feat: 添加功能 A       │             │
│                      │  ├── fix: 修复问题 B        │             │
│                      │  └── docs: 更新文档         │             │
│                      └─────────────────────────────┘             │
│                                 │                                │
│                                 ▼                                │
│   2. Release PR 自动创建                                         │
│   ────────────────────                                           │
│   release-please 自动创建/更新 Release PR                        │
│                                                                  │
│                      ┌─────────────────────────────┐             │
│                      │  Release PR                 │             │
│                      │  • 更新版本号: 1.0.0→1.1.0   │             │
│                      │  • 更新 CHANGELOG           │             │
│                      │  • 变更摘要                  │             │
│                      └─────────────────────────────┘             │
│                                 │                                │
│                                 ▼                                │
│   3. 手动触发发布                                                 │
│   ────────────────                                               │
│   维护者审查并合并 Release PR                                     │
│                                                                  │
│                                 │                                │
│                                 ▼                                │
│   4. 自动发布                                                     │
│   ──────────                                                     │
│   • 创建 Git tag (v1.1.0)                                        │
│   • 触发全平台构建                                                │
│   • 创建 GitHub Release                                          │
│   • 上传所有平台安装包                                            │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

### 详细步骤

#### 1. 日常开发

正常开发，提交符合 Conventional Commits 规范的代码：

```bash
git commit -m "feat: 添加用户设置页面"
git commit -m "fix: 修复设置保存失败问题"
```

#### 2. 合并到 main

通过 Pull Request 将代码合并到 main 分支。

#### 3. 等待 Release PR

release-please 会自动创建或更新 Release PR，包含：
- 版本号更新
- CHANGELOG 更新
- 变更摘要

#### 4. 审查 Release PR

在合并前，检查：
- 版本号是否正确
- CHANGELOG 是否完整
- 变更摘要是否准确

#### 5. 合并 Release PR

合并后自动触发：
- 创建 Git tag
- 触发 release.yml 工作流
- 构建所有平台
- 创建 GitHub Release

## 发布检查清单

合并 Release PR 前，请确认：

### 代码质量
- [ ] 所有 CI 检查通过
- [ ] 代码通过 `flutter analyze`
- [ ] 测试通过 `flutter test`
- [ ] 无未解决的 Issue

### 版本管理
- [ ] 版本号正确
- [ ] CHANGELOG 完整
- [ ] Breaking Changes 已说明

### 文档
- [ ] README.md 已更新 (如有需要)
- [ ] 迁移指南已提供 (如有 Breaking Changes)

### 发布后
- [ ] 验证 GitHub Release 已创建
- [ ] 验证所有平台安装包已上传
- [ ] 验证 Release Notes 正确

## 发布平台

Spectra 发布到 GitHub Release，支持以下平台：

| 平台 | 文件格式 | 说明 |
|------|----------|------|
| Android | APK, AAB | 通用版本 |
| iOS | IPA | 无签名版本 |
| Web | ZIP | 静态文件 |
| Windows | ZIP | 无签名版本 |
| macOS | ZIP | 无签名版本 |
| Linux | ZIP | AppImage/DEB |

### 安装说明

#### Android
1. 下载 APK 文件
2. 允许安装未知来源应用
3. 安装 APK

#### iOS
1. 下载 IPA 文件
2. 使用 AltStore 或其他工具安装
3. 注意：无签名版本需要自行签名

#### Windows
1. 下载 ZIP 文件
2. 解压到任意目录
3. 运行 `spectra.exe`
4. 可能会遇到 SmartScreen 警告，选择"仍要运行"

#### macOS
1. 下载 ZIP 文件
2. 解压
3. 右键点击 `spectra.app`，选择"打开"
4. 如果提示"无法验证开发者"，在系统偏好设置中允许

#### Linux
1. 下载 ZIP 文件
2. 解压
3. 运行 `./spectra`
4. 如需桌面集成，自行创建 .desktop 文件

## 回滚发布

如果发布的版本有严重问题：

1. 在 GitHub Release 页面删除该版本
2. 删除对应的 Git tag：
   ```bash
   git tag -d v1.1.0
   git push origin :refs/tags/v1.1.0
   ```
3. 回滚代码或发布修复版本

## 热修复流程

紧急 Bug 修复的快速流程：

```bash
# 1. 从 main 创建 hotfix 分支
git checkout -b fix/critical-bug main

# 2. 修复问题
git commit -m "fix: 修复关键问题"

# 3. 创建 PR 并合并
# ...

# 4. release-please 会自动处理
# 如果需要立即发布，可以手动触发
```

## 手动发布 (紧急情况)

如果自动化流程失败，可以手动发布：

```bash
# 1. 更新版本号
# 编辑 pubspec.yaml 中的 version

# 2. 更新 CHANGELOG
# 手动添加版本记录

# 3. 创建 tag
git tag -a v1.1.0 -m "Release v1.1.0"
git push origin v1.1.0

# 4. 这会触发 release.yml 工作流
```

## 发布频率建议

- **功能更新**: 积累 3-5 个 feat 后发布
- **Bug 修复**: 有重要修复时及时发布
- **安全更新**: 立即发布

不建议：
- 每个 commit 都发布
- 长时间不发布
