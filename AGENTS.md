# SPECTRA 项目知识库

**生成时间:** 2026-03-06 11:11:08 (Asia/Shanghai)
**分支:** `feature/architecture`
**基线提交:** `b40e4e2`

## OVERVIEW

跨平台多媒体数据采集应用，主栈为 Flutter（`lib/`）+ Rust FFI（`rust/`）+ React Web 编辑器（`web-editor/`）。

## STRUCTURE

```text
Spectra/
├── lib/             # Flutter 主应用
├── rust/            # Rust workspace + FFI 逻辑
├── web-editor/      # React + TypeScript 规则编辑器
├── .agents/         # 本地技能仓（SKILL.md 与规则）
├── docs/            # 协议与规范文档
├── test/            # Flutter 单测
├── integration_test/# Flutter 集成测试
└── rust_builder/    # Flutter-Rust 构建胶水层（非业务域）
```

## WHERE TO LOOK

| 任务 | 位置 | 说明 |
|------|------|------|
| Flutter 入口 | `lib/main.dart` | 应用启动与依赖初始化 |
| Rust workspace 定义 | `rust/Cargo.toml` | crate 拆分、成员与版本策略 |
| Web Editor 入口 | `web-editor/src/main.tsx` | React 挂载与全局初始化 |
| 仓库质量门禁 | `.github/workflows/ci.yml` | analyze/test/build 平台矩阵 |
| 根脚本命令 | `package.json` | lint/format/build:web 聚合命令 |

## SKILLS 路由总则

- `lib/`、`test/` 工作默认先读 `flutter` 相关技能。
- `rust/` 工作默认先读 `rust-router` 做 Rust 问题路由。
- `web-editor/` 工作默认先读 `react-web-editor-guide`。
- 需要查找技能时，先读 `.agents/AGENTS.md` 的「发现/创建流程」，优先使用 `find-skills` 与 `skill-creator`。
- 涉及 UI/UX 设计与主题系统时，优先补充：`frontend-design`、`ui-ux-pro-max`、`theme-factory`。

## CONVENTIONS

- 注释与文档必须使用中文。
- UI 逻辑严禁硬编码字符串，必须走平台 i18n 方案。
- 文档禁止使用 Unicode 表情符号。
- 依赖新增优先使用命令：`flutter pub add` / `cargo add` / `bun add`。
- 仅在预览版、Git 依赖、Path 依赖或复杂冲突时手改依赖清单。

## ANTI-PATTERNS

- 禁止直接编辑生成文件：`*.g.dart`、`*.freezed.dart`、`lib/l10n/generated/**`。
- 禁止把 `research_tmp/` 内容当作业务代码规范来源。
- 禁止跳过变更后的静态检查（Flutter analyze / Rust clippy / Web oxlint）。

## COMMANDS

```bash
# 根目录常用命令
flutter pub get
bun install
cd web-editor && bun install

bun run lint
bun run format
bun run build:web
```

## NOTES

- `rust_builder/` 是 Flutter-Rust 构建胶水层，默认只在桥接/构建问题时修改。
- 协议约束以 `docs/api-contract-v1.md` 与 `docs/ws-protocol-v1.md` 为准。

<!-- BEGIN BEADS INTEGRATION -->
## Issue Tracking with bd (beads)

**IMPORTANT**: This project uses **bd (beads)** for ALL issue tracking. Do NOT use markdown TODOs, task lists, or other tracking methods.

### Why bd?

- Dependency-aware: Track blockers and relationships between issues
- Git-friendly: Dolt-powered version control with native sync
- Agent-optimized: JSON output, ready work detection, discovered-from links
- Prevents duplicate tracking systems and confusion

### Quick Start

**Agent / Skill 约定：**

- 进入 beads 工作流前，优先使用 plugin skill：`beads:beads`。
- 对于需要跨会话、带依赖、或需要持久化上下文的工作，优先使用 beads，而不是会话内临时 todo。
- 当前仓库的 beads 配置以仓库内 `.beads/config.yaml` 为准，不允许把用户目录（如 `C:\Users\...`）写入 repo 配置。
- 当前仓库推荐的 repo-local beads 配置为：

```yaml
issue-prefix: "Spectra"
sync.branch: "beads-metadata"
sync.mode: "dolt-native"
repos:
  primary: "."
```

**Check for ready work:**

```bash
bd ready --json
```

**Create new issues:**

```bash
bd create "Issue title" --description="Detailed context" -t bug|feature|task -p 0-4 --json
bd create "Issue title" --description="What this issue is about" -p 1 --deps discovered-from:bd-123 --json
```

**Claim and update:**

```bash
bd update <id> --claim --json
bd update bd-42 --priority 1 --json
bd update <id> --status closed --json
```

**Complete work:**

```bash
bd update <id> --status closed --json
```

### Issue Types

- `bug` - Something broken
- `feature` - New functionality
- `task` - Work item (tests, docs, refactoring)
- `epic` - Large feature with subtasks
- `chore` - Maintenance (dependencies, tooling)

### Priorities

- `0` - Critical (security, data loss, broken builds)
- `1` - High (major features, important bugs)
- `2` - Medium (default, nice-to-have)
- `3` - Low (polish, optimization)
- `4` - Backlog (future ideas)

### Workflow for AI Agents

1. **Check ready work**: `bd ready` shows unblocked issues
2. **Claim your task atomically**: `bd update <id> --claim`
3. **Work on it**: Implement, test, document
4. **Discover new work?** Create linked issue:
   - `bd create "Found bug" --description="Details about what was found" -p 1 --deps discovered-from:<parent-id>`
5. **Complete**: `bd update <id> --status closed --json`

### Repo-specific Notes

- 当前仓库已验证：`bd create`、`bd show`、`bd list`、`bd update --claim`、`bd update --status closed` 可正常使用。
- 当前仓库中 `bd close <id>` 存在 ID 解析异常；在修复前，统一使用 `bd update <id> --status closed --json` 作为关闭 issue 的替代命令。
- 若 beads 行为异常，优先检查是否误用了 contributor/planning 路由，或是否把用户本地路径写入了 `.beads/config.yaml`。

### Auto-Sync

bd automatically syncs via Dolt:

- Each write auto-commits to Dolt history
- Use `bd dolt push`/`bd dolt pull` for remote sync
- No manual export/import needed!

### Important Rules

- ✅ Use bd for ALL task tracking
- ✅ Always use `--json` flag for programmatic use
- ✅ Link discovered work with `discovered-from` dependencies
- ✅ Check `bd ready` before asking "what should I work on?"
- ❌ Do NOT create markdown TODO lists
- ❌ Do NOT use external issue trackers
- ❌ Do NOT duplicate tracking systems

For more details, see README.md and docs/QUICKSTART.md.

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd sync
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds

<!-- END BEADS INTEGRATION -->
