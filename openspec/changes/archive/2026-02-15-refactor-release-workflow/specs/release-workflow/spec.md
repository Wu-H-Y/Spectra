# 发布工作流规范

## MODIFIED Requirements

### Requirement: 版本号管理

版本号 SHALL 遵循语义化版本规范 (SemVer)，从 0.1.0 开始表示开发阶段。

#### Scenario: 开发阶段版本
- **WHEN** 项目处于开发阶段
- **THEN** 版本号为 `0.x.x` 格式

#### Scenario: 正式发布版本
- **WHEN** API 稳定后发布 1.0.0
- **THEN** 版本号格式为 `major.minor.patch`

#### Scenario: feat 触发 minor 更新
- **WHEN** Release PR 包含 `feat:` 类型的 commit
- **THEN** minor 版本号递增

#### Scenario: fix 触发 patch 更新
- **WHEN** Release PR 包含 `fix:` 类型的 commit
- **THEN** patch 版本号递增

#### Scenario: deps 触发 patch 更新
- **WHEN** Release PR 包含 `deps:` 类型的 commit
- **THEN** patch 版本号递增

#### Scenario: BREAKING CHANGE 触发 major 更新
- **WHEN** Release PR 包含 `BREAKING CHANGE:`
- **THEN** major 版本号递增

### Requirement: Release Please 自动化

系统 SHALL 使用 release-please 自动管理版本和 CHANGELOG，在检测到 releasable units 时自动创建 Release PR。

#### Scenario: 检测到 releasable units
- **WHEN** main 分支包含 `feat:`、`fix:` 或 `deps:` 类型的 commit
- **THEN** release-please 自动创建或更新 Release PR

#### Scenario: 无 releasable units
- **WHEN** main 分支只有 `chore:`、`docs:`、`refactor:` 等类型的 commit
- **THEN** 不会创建 Release PR

#### Scenario: Release PR 内容
- **WHEN** Release PR 被创建
- **THEN** 包含版本号更新、CHANGELOG 更新、变更摘要

### Requirement: 手动触发发布

发布 SHALL 由维护者通过合并 Release PR 触发。

#### Scenario: 累积变更
- **WHEN** 多个 releasable commits 合并到 main
- **THEN** release-please 累积所有变更到单个 Release PR

#### Scenario: 合并触发发布
- **WHEN** 维护者合并 Release PR
- **THEN** 自动创建 Git tag 并触发构建工作流

### Requirement: 全平台构建

发布工作流 SHALL 构建所有目标平台的安装包。

#### Scenario: Android 构建
- **WHEN** 发布触发
- **THEN** 生成 APK 和 AAB 文件

#### Scenario: iOS 构建
- **WHEN** 发布触发
- **THEN** 生成无签名的 IPA 文件

#### Scenario: Web 构建
- **WHEN** 发布触发
- **THEN** 生成 Web 静态文件

#### Scenario: Windows 构建
- **WHEN** 发布触发
- **THEN** 生成无签名的 EXE 文件

#### Scenario: macOS 构建
- **WHEN** 发布触发
- **THEN** 生成无签名的 APP 文件

#### Scenario: Linux 构建
- **WHEN** 发布触发
- **THEN** 生成 AppImage 和 DEB 文件

### Requirement: GitHub Release 创建

系统 SHALL 自动创建 GitHub Release 并上传所有安装包。

#### Scenario: Release 创建
- **WHEN** tag 被创建
- **THEN** 创建对应的 GitHub Release

#### Scenario: Release 内容
- **WHEN** Release 被创建
- **THEN** 包含版本标题、CHANGELOG 摘要、所有平台安装包

### Requirement: CHANGELOG 自动生成

CHANGELOG.md SHALL 由 release-please 根据提交记录自动生成。

#### Scenario: CHANGELOG 更新
- **WHEN** Release PR 被合并
- **THEN** CHANGELOG.md 自动更新新增版本的变更记录

#### Scenario: 变更分类
- **WHEN** CHANGELOG 生成
- **THEN** 按 feat、fix、deps 类型分组显示变更
