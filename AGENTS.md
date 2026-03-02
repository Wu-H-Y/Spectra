# SPECTRA 项目知识库

跨平台多媒体数据采集应用，架构包含 Flutter 主应用、Rust FFI 模块及 React Web 编辑器。

## 开发指南 (Skills)

**在特定目录下工作时，请务必先查阅并遵循对应的 Skill 指南：**

- **Flutter / Dart** (目录: `lib/`, `test/`): 使用 `flutter-dart-guide`
- **Rust / FFI** (目录: `rust/`): 使用 `rust-ffi-guide`
- **React / Web** (目录: `web-editor/`): 使用 `react-web-editor-guide`

## 依赖管理规范

1. **优先使用 add 命令**：添加依赖时应优先使用对应语言的 CLI 命令（如 `flutter pub add`, `cargo add`, `bun add`），以确保依赖关系的正确解析。
2. **手动修改例外**：仅在需要指定预览版（beta/rc/canary/preview）、Git 仓库依赖、本地 Path 依赖或处理复杂的版本冲突时，才允许手动编辑配置文件（`pubspec.yaml`, `Cargo.toml`, `package.json`）。

## 通用规则

- **Git Commit**: 严格遵循 `<type>(<scope>): <description>` 规范。
- **语言**: 所有代码注释及文档必须使用中文。
- **UI**: 严禁在 UI 逻辑中硬编码字符串，必须遵循对应平台的国际化方案。
- **文档**: 编写任何文档时禁止使用 Unicode 表情符号。
- **代码分析**: 修改代码后必须运行对应平台的分析工具（analyze/clippy/oxlint）。
