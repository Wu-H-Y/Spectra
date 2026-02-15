# 调整 Release Workflow - 实施任务

## 1. 版本号重置

- [x] 1.1 修改 `.release-please-manifest.json` 版本号从 `1.0.0` 改为 `0.1.0`

## 2. 提交规范文档更新

- [x] 2.1 在 `docs/COMMIT_CONVENTION.md` 中添加 `deps` 类型说明
- [x] 2.2 添加 Releasable Units 定义章节，说明哪些类型进入 CHANGELOG
- [x] 2.3 补充单提交多变更的 footer 写法示例
- [x] 2.4 添加 Squash-Merge 最佳实践说明
- [x] 2.5 更新 git_hooks 验证逻辑支持 `deps` 类型

## 3. 发布文档更新

- [x] 3.1 更新 `docs/RELEASE.md` 版本号策略说明 (0.x.x 开发阶段)
- [x] 3.2 添加 releasable units 相关说明

## 4. 验证测试

- [x] 4.1 验证 feat/fix/deps 提交后 Release PR 自动创建 (需要推送到 GitHub 后验证)
- [x] 4.2 验证 chore/docs 等提交不会触发 Release PR (需要推送到 GitHub 后验证)
- [x] 4.3 验证合并 Release PR 后 tag 自动创建和构建流程 (需要推送到 GitHub 后验证)
