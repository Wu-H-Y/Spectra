# Proposal: Migrate Git Hooks to Husky + OXC

## Why

当前项目使用 Dart 的 `git_hooks` 包管理 Git 钩子，存在以下问题：
1. **每次提交都运行全量分析** - 即使没有修改 `.dart` 文件也会触发 `flutter analyze`，浪费时间
2. **缺少增量处理** - 无法只处理暂存的文件，缺少格式化后自动重新暂存的功能
3. **前端项目无法统一管理** - `web-editor/` 使用 ESLint + Prettier，与主项目分离，无法共享钩子配置
4. **性能瓶颈** - `git_hooks` 包功能有限，无法利用现代工具的并行处理能力

现在迁移的好处：
- OXC (oxlint + oxfmt) 比 ESLint 快 **50-100x**，比 Prettier 快 **30x**
- lint-staged 只处理暂存文件，格式化后自动重新暂存
- 统一管理 Flutter 和 React 项目的代码质量检查

## What Changes

### 根目录新增
- **`package.json`** - 根目录包管理，包含 husky、lint-staged、commitlint
- **`.husky/`** - Husky 钩子目录 (pre-commit, commit-msg)
- **`.lintstagedrc.json`** - lint-staged 配置，区分 Dart 和前端文件
- **`commitlint.config.js`** - Conventional Commits 验证配置

### web-editor/ 前端迁移
- **移除**: ESLint (`eslint.config.js`)、相关依赖
- **移除**: Prettier（如有）
- **新增**: `.oxlintrc.json` - oxlint 配置
- **新增**: `.oxfmtrc.json` - oxfmt 配置
- **修改**: `package.json` - 替换 lint/format 脚本

### 移除旧配置
- **移除**: `git_hooks.dart`
- **移除**: `pubspec.yaml` 中的 `git_hooks` 依赖
- **移除**: `.git/hooks/` 中的旧钩子脚本

### **BREAKING** 变更
- 开发者需要安装 Node.js/Bun 环境
- 原有的 `dart run git_hooks create` 命令不再有效
- 提交前会自动格式化并重新暂存文件

## Capabilities

### New Capabilities

- **`unified-git-hooks`**: 统一的 Git 钩子管理系统，使用 Husky 管理 pre-commit 和 commit-msg 钩子，支持 Dart 和前端项目的统一检查

- **`lint-staged`**: 增量代码检查能力，只对暂存的文件执行格式化和 lint，自动重新暂存修改后的文件

- **`oxc-lint-format`**: 前端项目使用 OXC (oxlint + oxfmt) 替代 ESLint + Prettier，提供更快的代码检查和格式化

- **`commitlint`**: 提交信息验证，强制执行 Conventional Commits 规范

### Modified Capabilities

无。现有功能保持不变，仅改变实现方式。

## Impact

### 依赖变更

**根目录新增** (`package.json`):
```json
{
  "devDependencies": {
    "@commitlint/cli": "^19.0.0",
    "@commitlint/config-conventional": "^19.0.0",
    "husky": "^9.0.0",
    "lint-staged": "^15.0.0"
  }
}
```

**web-editor/ 变更**:
- 移除: `eslint`, `@eslint/js`, `eslint-plugin-react-hooks`, `eslint-plugin-react-refresh`, `typescript-eslint`
- 新增: `oxlint`, `oxfmt`

**pubspec.yaml 移除**:
- `git_hooks: ^1.0.2`

### 文件变更清单

| 文件 | 操作 |
|------|------|
| `package.json` | 新建 |
| `.husky/pre-commit` | 新建 |
| `.husky/commit-msg` | 新建 |
| `.lintstagedrc.json` | 新建 |
| `commitlint.config.js` | 新建 |
| `web-editor/.oxlintrc.json` | 新建 |
| `web-editor/.oxfmtrc.json` | 新建 |
| `web-editor/eslint.config.js` | 删除 |
| `web-editor/package.json` | 修改 |
| `git_hooks.dart` | 删除 |
| `pubspec.yaml` | 修改 |
| `.gitignore` | 修改 (忽略 .husky 相关) |

### 开发者工作流变更

**之前**:
```bash
flutter pub get
dart pub global activate git_hooks
dart run git_hooks create git_hooks.dart
```

**之后**:
```bash
bun install  # 或 npm install
bun run prepare  # 初始化 husky
```

### 性能预期

| 操作 | 之前 | 之后 | 提升 |
|------|------|------|------|
| 前端 lint (全量) | ~5s (ESLint) | ~100ms (oxlint) | 50x |
| 前端 format (全量) | ~3s (Prettier) | ~100ms (oxfmt) | 30x |
| Dart 检查 (增量) | 全量 analyze | 只分析暂存文件 | 视变更量 |
| 提交检查 | 固定耗时 | 仅处理变更文件 | 显著 |
