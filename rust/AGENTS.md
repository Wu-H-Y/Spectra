# rust/ 目录知识库

## OVERVIEW

Rust workspace，承载规则 IR、规则校验、引擎、I/O 与 FFI，最终为 Flutter 提供本地能力。

## STRUCTURE

```text
rust/
├── Cargo.toml               # workspace 与成员定义
├── src/lib.rs               # spectra_native 根 crate
└── crates/
    ├── rules_ir/            # IR 与 TS 导出模型
    ├── rules_validate/      # 规则校验
    ├── rules_engine/        # 执行引擎（预留）
    ├── io_http/             # HTTP I/O（预留）
    └── ffi/                 # FFI 桥接（预留）
```

## SKILLS 路由

- Rust 任务默认先用 `rust-router` 进行意图路由。
- 编译错误优先按错误码路由：`E0382/E0597`→`m01-ownership`，`E0499/E0502/E0596`→`m03-mutability`，`E0277/E0308`→`m04-zero-cost`。
- FFI / `unsafe` / 裸指针问题强制联动 `unsafe-checker`。
- 领域词 + 并发/错误并存时，执行双技能加载（例如 `m07-concurrency` + `domain-web`）。

## 动态技能工作流

- 优先用 `find-skills` 搜索已有能力，再决定是否自建技能。
- Rust 依赖技能同步优先流程：`/sync-crate-skills`。
- 单 crate 更新流程：`/update-crate-skill <crate>`。
- 若命令不可用，降级为 `rust-skill-creator` 的 inline 模式（docs.rs 抓取 + 本地生成）。
- 创建通用技能时，使用 `skill-creator`，并把触发词写完整（避免 under-trigger）。

## CONVENTIONS

- 新增依赖优先 `cargo add <crate>`。
- 注释与文档保持中文。
- 默认使用仓库根目录 `package.json` 脚本执行 Rust 质量门禁。
- Rust 代码检查只能使用 `cargo clippy`，禁止使用 `cargo check` 作为验收依据。
- Rust 代码格式化必须使用 `cargo +nightly fmt`，禁止使用 `cargo fmt`。
- 变更完成后至少执行 `cargo clippy --all-targets --all-features -- -D warnings`。
- FFI 暴露 API 使用稳定边界与明确错误返回，避免隐式 panic 泄漏。

## ANTI-PATTERNS

- 禁止通过 `as any`、`@ts-ignore` 等方式掩盖跨语言边界错误（TS 绑定端同样适用）。
- 禁止在 `unsafe` 代码块缺失 `SAFETY` 说明。
- 禁止直接编辑生成产物或构建输出（如 `target/`、自动导出的绑定文件）。

## COMMANDS

```bash
# 推荐：在仓库根目录执行
bun run lint:rust
bun run format:rust

# 需要测试时
cd rust && cargo test --workspace
```

## NOTES

- crate 级规则见 `rust/crates/AGENTS.md` 与各子目录 AGENTS。
- 与 Flutter 桥接联调时，优先核对 `flutter_rust_bridge.yaml` 与 `rust_builder/`。
