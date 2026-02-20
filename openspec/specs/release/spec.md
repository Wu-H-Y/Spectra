# 发布工作流规范

## 版本管理

### Requirement: 语义化版本

- **开发阶段**: `0.x.x`
- **正式发布**: `major.minor.patch`

### Requirement: 版本更新规则

| 提交类型 | 版本影响 |
|----------|----------|
| `feat:` | minor |
| `fix:` | patch |
| `deps:` | patch |
| `BREAKING CHANGE:` | major |

---

## Release Please 自动化

### Requirement: 自动检测 releasable units

- `feat:`, `fix:`, `deps:` 类型的 commit 触发 Release PR
- `chore:`, `docs:`, `refactor:` 等类型不触发

### Requirement: Release PR 内容

- 版本号更新
- CHANGELOG 更新
- 变更摘要

### Requirement: 累积变更

多个 releasable commits 累积到单个 Release PR。

---

## 发布触发

### Requirement: 手动触发

维护者通过合并 Release PR 触发发布。

### Requirement: 自动处理

- 创建 Git tag
- 触发构建工作流
- 创建 GitHub Release

---

## 全平台构建

### Requirement: 构建产物

| 平台 | 产物 |
|------|------|
| Android | APK, AAB |
| iOS | IPA (无签名) |
| Windows | EXE (无签名) |
| macOS | APP (无签名) |
| Linux | AppImage, DEB |

---

## CHANGELOG

### Requirement: 自动生成

由 release-please 根据提交记录生成。

### Requirement: 变更分类

按类型分组：
- Features (feat)
- Bug Fixes (fix)
- Dependencies (deps)
