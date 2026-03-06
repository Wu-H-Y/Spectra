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

- `lib/`、`test/` 工作默认先读 `flutter-dart-guide`。
- `rust/` 工作默认先读 `rust-ffi-guide`，并以 `rust-router` 做 Rust 问题路由。
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
