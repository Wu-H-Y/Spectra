# .agents/ 目录知识库

## OVERVIEW

本目录是仓库内技能库，承载技能元数据（`SKILL.md`）、规则与参考资料。

## WHERE TO LOOK

| 任务 | 位置 | 说明 |
|------|------|------|
| 技能发现入口 | `.agents/skills/find-skills/SKILL.md` | 搜索/安装技能流程 |
| 技能创建入口 | `.agents/skills/skill-creator/SKILL.md` | 通用技能创建与评测迭代 |
| Rust 路由入口 | `.agents/skills/rust-router/SKILL.md` | Rust 问题分层路由 |
| Rust 动态技能 | `.agents/skills/core-dynamic-skills/SKILL.md` | crate 技能同步与更新 |
| Rust 技能生成 | `.agents/skills/rust-skill-creator/SKILL.md` | docs.rs 到技能的生成流程 |
| UI 设计增强 | `.agents/skills/frontend-design/SKILL.md` | 前端视觉与交互设计基线 |
| UI/UX 数据库 | `.agents/skills/ui-ux-pro-max/SKILL.md` | 多风格设计系统与检索 |
| 主题方案工厂 | `.agents/skills/theme-factory/SKILL.md` | 配色/字体主题模板与定制 |

## 发现技能（find-skills）

```bash
npx skills find <query>
npx skills add <owner/repo@skill> -g -y
npx skills check
npx skills update
```

- 先按任务域收敛关键词（如 `rust ownership`、`react performance`）。
- 找到候选后给出安装命令与用途摘要。
- 若无可用技能，再进入创建流程。

## 创建技能（skill-creator）

```bash
npx skills init <skill-name>
```

- 先明确触发语句、输出格式、边界条件。
- `SKILL.md` 里必须写清楚「何时触发」与「不要做什么」。
- 为客观任务补 2-3 条评测提示词并迭代改写。

## UI/主题技能路由

- 页面视觉质量、动效、布局创新优先 `frontend-design`。
- 需要系统化 UI 方案（色板/字体/风格库）优先 `ui-ux-pro-max`。
- 需要快速套用或生成主题（配色 + 字体组合）优先 `theme-factory`。

## Rust 专项：动态技能与 crate 技能

- 优先执行 `/sync-crate-skills` 扫描 `Cargo.toml` 并补齐缺失 crate 技能。
- 单 crate 更新使用 `/update-crate-skill <crate>`。
- 需要从文档新建 Rust 技能时，优先用 `rust-skill-creator`。
- 若自动命令不可用，降级为 inline 流程：docs.rs 抓取 -> 生成 `SKILL.md` -> 生成 `references/`。

## CONVENTIONS

- 新技能命名保持小写短横线风格，触发词覆盖中英文常见问法。
- 技能正文保持可执行步骤，避免空泛原则。
- 规则文件优先写“可检查条件 + 反例 + 正例”。

## ANTI-PATTERNS

- 禁止创建仅有标题、无触发语义的空技能。
- 禁止把仓库私有实现细节写成对外通用技能默认值。
- 禁止跳过评测直接发布高风险自动化技能。
