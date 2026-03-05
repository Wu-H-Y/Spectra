# Learnings

（追加记录，不覆盖。）

- 2026-03-05: 汇总 Cargo 工作区重构指导（集中继承 workspace.package/workspace.dependencies、通过 resolver=2 控制构建边界、保持特性加法性并利用 pub(in)/pub(crate) 约束模块暴露、避免除 dev-dependencies 以外的循环依赖）。