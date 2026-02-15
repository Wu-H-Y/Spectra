## Context

当前项目使用 release-please-action 自动管理版本和 CHANGELOG。经过分析，主要问题是：

1. **版本号策略**：从 `1.0.0` 开始但从未正式发布
2. **标签阻塞**：之前失败的 Release PR 遗留了 `autorelease:pending` 标签（已清理）
3. **文档未对齐**：提交规范与 release-please 的 releasable units 定义不一致

release-please 的自动触发机制本身是合理的：
- 只有 `feat/fix/deps` 类型才会创建 Release PR
- `chore/docs/refactor` 等类型不会触发

## Goals / Non-Goals

**Goals:**
- 重置版本号为 0.1.0 表示开发阶段
- 对齐提交规范与 release-please 要求
- 确保发布流程正常工作

**Non-Goals:**
- 不修改 release-please 的触发机制（保持自动触发）
- 不修改构建产物的平台支持
- 不修改 CI 工作流

## Decisions

### 1. 版本号起点

**决定**: 从 `0.1.0` 开始

**理由**:
- `0.x.x` 表示 API 不稳定，符合开发阶段
- `1.0.0` 预留给正式稳定版本
- 语义化版本规范推荐在初始开发阶段使用 `0.x.x`

### 2. 提交规范对齐 release-please

**决定**: 更新 `docs/COMMIT_CONVENTION.md` 与 release-please 要求对齐

**需要添加的内容**:

1. **新增 `deps` 类型**
   - 用于依赖更新
   - 是 releasable unit，触发 patch 版本更新

2. **明确 Releasable Units**
   ```
   进入 CHANGELOG 的类型:
   - feat     → minor 版本
   - fix      → patch 版本
   - deps     → patch 版本
   - feat! / fix! 等 → major 版本 (breaking change)

   不进入 CHANGELOG 的类型:
   - docs, style, refactor, test, ci, chore, revert
   ```

3. **单提交多变更的 footer 写法**
   ```bash
   feat: 添加 v4 UUID 支持

   fix(utils): unicode 不再抛出异常
   feat(utils): 更新 encode 支持 unicode
   ```

4. **Squash-Merge 最佳实践**
   - 推荐使用 squash-merge 合并 PR
   - 保持 main 分支历史线性
   - 便于追踪和回滚

## Risks / Trade-offs

| 风险 | 缓解措施 |
|------|----------|
| 提交规范变更需团队适应 | 在 CONTRIBUTING.md 中明确说明，git_hooks 自动验证 |
| 开发期间可能不想频繁发布 | 使用 `chore` 类型避免触发 Release PR |
