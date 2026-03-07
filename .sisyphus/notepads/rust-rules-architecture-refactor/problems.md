# Problems

- （追加记录，不覆盖。）
- 2026-03-05: 当前任务未留下需要后续处理的遗留问题。
- 2026-03-06: Task 9 当前未留下新的未解决问题；后续仅需在 Task 10 中消费既有 `NormalizedModel` 三端类型，不应回写本任务模型定义。
- 2026-03-06: Task 9 自动扫描收口后未留下新的未解决问题；后续若扩展更多 `rules_ir` 模块进入 FRB 扫描，需要先逐个确认第三方模块是否含 FRB 2.11.1 尚未支持的类型形态。
- 2026-03-06: Task 9 当前未留下新的阻塞问题；Task 10 只需消费 `lib/core/rust/third_party/rules_ir/normalized_model.dart` 这组 FRB 生成模型，不应再恢复任何手写 Dart `NormalizedModel`。
- 2026-03-06: 本次纠偏后未新增未解决遗留；后续若再次运行 `build_runner` 覆盖全仓库生成物，需要注意仓库级 `field_rename: snake` 仍不适合直接作用于 `lib/core/rust/api.dart`。
- 2026-03-07: Task 9 本次复核后未新增未解决问题；后续任务只需消费已稳定的 `mediaAssets` 默认值语义，不应再手动放宽或分叉 Dart 侧 `ContentModel`。
- 2026-03-07: Task 11 当前未留下新的阻塞问题；后续任务若要把 `/api/rules/:id` 的公开 `id` 从 Drift 主键演进为独立业务 ID，需要先补 schema 字段与迁移，再调整现有 CRUD 返回结构。
- 2026-03-07: Task 10 本轮架构清理未留下新的未解决问题；后续任务应继续只消费根 `crate::api` 暴露的 `validateRule/executeRule` 绑定，不要重新恢复 `crates/ffi` 手写门面。
- 2026-03-07: 单 crate finishing pass 未留下新的未解决问题；后续任务应继续消费 `lib/core/rust/api.dart` 兼容导出与 `lib/core/rust/rules_ir/normalized_model.dart` 生成模型，不要恢复 `rust/src/api`、`rust/crates/*` 或 `third_party/rules_ir/**`。
- 2026-03-07: Task 9 本轮二次复核未新增未解决问题；后续任务只需继续消费当前 `rust/src/rules_ir/normalized_model.rs` 为真源的生成结果，不要再依据旧 evidence 恢复历史路径或旧生成链。
