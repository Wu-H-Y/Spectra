---
name: git-commit-and-push
description: 在 Spectra 仓库中执行“检查改动 → 生成符合 Conventional Commits 的提交消息 → 提交 → 推送”全流程。只要用户提到“提交当前更改”“commit 并 push”“推送分支”“按规范提交”等语义，就应优先启用本技能，即使用户没有明确提到 Conventional Commits。
---

# Git 提交并推送（Spectra）

用于在本仓库安全完成一次标准提交与推送，并严格对齐 `docs/COMMIT_CONVENTION.md`。

## 先读这些文件

执行前先读取并遵循：

- `docs/COMMIT_CONVENTION.md`
- `commitlint.config.js`
- `.husky/commit-msg`
- `.husky/pre-commit`

原因：本仓库通过 Husky + commitlint 强制校验提交格式，先对齐约束可以减少失败重试。

## 标准执行流程

### 1) 收集上下文

按顺序执行：

```bash
git status --short
git diff
git diff --cached
git log -5 --oneline
```

目标：确认哪些文件将被提交、变更是否完整、提交消息风格是否与近期历史一致。

### 2) 选择并暂存文件

- 只暂存与用户需求直接相关的文件。
- 默认排除疑似敏感信息（如 `.env`、密钥、凭据导出）。
- 如用户要求提交敏感文件，明确风险后再执行。

```bash
git add <相关文件>
```

### 3) 生成提交消息（必须符合规范）

提交头格式：

```text
<type>(<scope>): <description>
```

规则：

- `type` 必须来自以下集合：
  - `feat` `fix` `deps` `docs` `style` `refactor` `perf` `test` `build` `ci` `chore` `revert`
- 若目标是触发发布流程，优先使用 `feat` / `fix` / `deps`（与 release-please 对齐）。
- `scope` 可选；仅在确有清晰影响范围时使用。
- `<description>` 不超过 50 个字符，使用中文祈使句，避免“添加了/修复了”。
- `<description>` 结尾不要使用句号 `.`。
- 需要破坏性变更时，使用 `!` 或 `BREAKING CHANGE:` footer。

优先表达“为什么改”，不是机械复述“改了什么文件”。

### 4) 执行提交

简单提交：

```bash
git commit -m "<type>(<scope>): <description>"
```

需要正文或 footer 时，使用多行消息：

```bash
git commit -m "<type>(<scope>): <description>" -m "<body>" -m "<footer>"
```

若钩子失败：

1. 根据失败输出修复问题（格式、lint、类型等）。
2. 重新 `git add` 受影响文件。
3. 重新执行 `git commit`。

### 5) 推送分支

先获取当前分支：

```bash
git branch --show-current
```

推送策略：

- 已配置上游分支：`git push`
- 未配置上游分支：`git push -u origin <branch>`

分支保护建议：

- 若当前分支是 `main`/`master`，先确认是否符合仓库分支策略，再执行推送。
- 默认优先在功能分支提交并推送（如 `feat/<topic>`）。

### 6) 提交后验证

```bash
git status
```

检查点：

- 工作区是否干净。
- 分支是否已成功推送到远端。

## 必做项（MUST DO）

- 提交前必须检查 `status + diff + log`。
- 提交消息必须符合 `docs/COMMIT_CONVENTION.md` 与 `commitlint.config.js`。
- 只提交与当前任务相关的改动，避免“顺手提交”无关文件。
- 推送后必须再次检查 `git status` 并回报结果。

## 禁止项（MUST NOT DO）

- 禁止使用 `--no-verify` 跳过钩子（除非用户明确要求）。
- 禁止空提交（`--allow-empty`）。
- 禁止默认执行 `git push --force` 或 `git push --force-with-lease`。
- 禁止在未确认风险时提交敏感文件。
- 禁止为凑格式编造不真实的提交说明。

## 正例 / 反例

正例：

- `feat(rules): 添加规则导入入口`
- `fix(web-editor): 修复节点连线丢失`
- `docs: 更新提交规范说明`

反例：

- `update code`
- `feat: 添加了新功能`
- `fix: this is a very very very very very very very long message`

## 输出模板

完成后按以下结构汇报：

```text
分支: <branch>
提交: <commit-hash>
消息: <commit-header>
推送: <成功/失败 + 关键输出>
状态: <git status 关键结论>
```
