## Why

当前 release-please 配置存在以下问题：

1. **版本号策略不合理**：从 `1.0.0` 开始但从未正式发布，且 `0.x.x` 更适合开发阶段
2. **autorelease 标签未清理**：之前失败的 Release PR 遗留了 `autorelease:pending` 标签，阻塞后续发布
3. **提交规范未对齐**：`docs/COMMIT_CONVENTION.md` 与 release-please 的 releasable units 定义不一致

需要调整版本号策略并对齐提交规范，确保发布流程正常工作。

## What Changes

- **修改** 版本号从 `1.0.0` 重置为 `0.1.0`，表示开发阶段
- **清理** 遗留的 `autorelease:pending` 标签（已完成）
- **更新** 提交消息规范文档，与 release-please 对齐：
  - 新增 `deps` 类型（依赖更新，触发 patch 版本）
  - 明确 releasable units 定义（哪些类型进入 CHANGELOG）
  - 补充单提交多变更的 footer 写法
  - 添加 squash-merge 最佳实践说明

## Capabilities

### Modified Capabilities

- `release-workflow`: 修改版本号策略从 1.0.0 起始改为 0.1.0 起始
- `commit-convention`: 更新提交消息规范，添加 `deps` 类型，明确 releasable units，补充单提交多变更写法

## Impact

- **配置文件**:
  - `.release-please-manifest.json` → 版本号从 `1.0.0` 改为 `0.1.0`
- **文档**:
  - `docs/COMMIT_CONVENTION.md` → 对齐 release-please 要求
  - `docs/RELEASE.md` → 更新版本号策略说明
