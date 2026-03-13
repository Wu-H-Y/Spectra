# SPECTRA 项目知识库

## 定位

- 本文件只保留「导航与本仓特例」。
- 项目只支持 Windows, MacOS, Linux, Android, IOS
- flutter 应用测试优先升级使用测试框架测试，其次可以后台启用应用使用 dart mcp 进行测试
- 当每次修改大量代码完成任务后必须先行提交代码

## 快速入口

| 任务 | 位置 | 说明 |
|------|------|------|
| Flutter 入口 | `lib/main.dart` | 启动与依赖初始化 |
| Rust 入口 | `rust/Cargo.toml` | workspace 与 crate 边界 |
| Web Editor 入口 | `web-editor/src/main.tsx` | React 挂载与初始化 |
| CI 门禁 | `.github/workflows/ci.yml` | lint / analyze / test / build |
| 根脚本 | `package.json` | 聚合命令与质量门禁入口 |

## 技能路由

- `lib/`、`test/`：优先 Flutter 相关技能。
- `rust/`：优先 `rust-router`。
- `web-editor/`：优先 `react-web-editor-guide`。
- UI/UX 与主题任务：补充 `frontend-design`、`ui-ux-pro-max`、`theme-factory`。

## Rust 子域补充

- Rust 编译错误按错误码路由：
  - `E0382/E0597` → `m01-ownership`
  - `E0499/E0502/E0596` → `m03-mutability`
  - `E0277/E0308` → `m04-zero-cost`
- FFI / `unsafe` / 裸指针问题：补充 `unsafe-checker`。
- Rust 验收以 `cargo clippy` 为准，不以 `cargo check` 作为完成标准。
- Rust 格式化使用 `cargo +nightly fmt`。
- 与 Flutter 桥接联调时，优先核对 `flutter_rust_bridge.yaml` 与 `rust_builder/`。

## 本仓硬约束

- 注释与文档必须使用中文。
- UI 字符串必须走 i18n，禁止硬编码。
- 新增依赖优先命令：`flutter pub add` / `cargo add` / `bun add`。
- 禁止直接编辑生成文件：`*.g.dart`、`*.freezed.dart`、`lib/l10n/generated/**`。
- 禁止将 `research_tmp/` 作为业务规范来源。
- 变更后不得跳过静态检查（Flutter analyze / Rust clippy / Web oxlint）。

## 边界与参考

- `rust_builder/` 仅在桥接或构建问题时修改。
- 协议约束：`docs/api-contract-v1.md`、`docs/ws-protocol-v1.md`。
- 提交规范：`docs/COMMIT_CONVENTION.md`。
- 平台支持与手动测试说明：`README.md`。

## 常用命令

- 统一查看 `package.json` 的 `scripts` 作为命令入口。
