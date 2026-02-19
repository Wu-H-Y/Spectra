# Tasks: Migrate Git Hooks to Husky + OXC

## 1. 根目录 Husky + lint-staged 设置

- [x] 1.1 创建根目录 `package.json`，包含 husky、lint-staged、commitlint 依赖
- [x] 1.2 安装依赖：运行 `bun install`
- [x] 1.3 初始化 Husky：运行 `bun run prepare`，验证 `.husky/` 目录创建
- [x] 1.4 创建 `.husky/pre-commit` 钩子脚本，调用 lint-staged
- [x] 1.5 创建 `.husky/commit-msg` 钩子脚本，调用 commitlint
- [x] 1.6 创建 `.lintstagedrc.json` 配置文件
- [x] 1.7 创建 `commitlint.config.js` 配置文件
- [x] 1.8 更新 `.gitignore`，忽略 `node_modules/` 和 `bun.lock`

## 2. 前端项目 OXC 迁移

- [x] 2.1 安装 oxlint：`cd web-editor && bun add -D oxlint`
- [x] 2.2 安装 oxfmt：`cd web-editor && bun add -D oxfmt`
- [x] 2.3 创建 `web-editor/.oxlintrc.json` 配置文件
- [x] 2.4 创建 `web-editor/.oxfmtrc.json` 配置文件
- [x] 2.5 更新 `web-editor/package.json` 的 scripts，添加 lint/fmt 命令
- [x] 2.6 运行 `bun run lint` 检查现有代码，记录问题
- [x] 2.7 修复 oxlint 报告的问题
- [x] 2.8 运行 `bun run fmt:check` 检查格式差异
- [x] 2.9 运行 `bun run fmt` 格式化所有代码
- [x] 2.10 移除 ESLint 相关依赖（eslint, @eslint/js, eslint-plugin-\*）
- [x] 2.11 删除 `web-editor/eslint.config.js`
- [x] 2.12 验证前端项目正常工作：`bun run lint && bun run build`

## 3. 清理旧的 git_hooks 配置

- [x] 3.1 从 `pubspec.yaml` 移除 `git_hooks: ^1.0.2` 依赖
- [x] 3.2 运行 `flutter pub get` 更新依赖
- [x] 3.3 删除 `git_hooks.dart` 文件
- [x] 3.4 清理 `.git/hooks/` 中的旧钩子脚本

## 4. 验证和文档更新

- [x] 4.1 测试 Dart 文件提交：修改 `.dart` 文件，验证格式化和分析
- [x] 4.2 测试前端文件提交：修改 `.tsx` 文件，验证 oxlint 和 oxfmt
- [x] 4.3 测试提交信息验证：使用无效格式，验证被阻止
- [x] 4.4 测试 `--no-verify` 跳过钩子功能
- [x] 4.5 更新 `README.md`，添加 Bun 环境安装说明
- [x] 4.6 更新 `.github/CONTRIBUTING.md`（如存在），更新开发环境要求
- [x] 4.7 提交所有变更，使用符合规范的提交信息

## 5. 可选优化

- [x] 5.1 启用 oxfmt 的 `experimentalSortImports` 功能
- [x] 5.2 配置 oxlint 启用 `suspicious` 类别规则
- [x] 5.3 添加 VS Code 推荐扩展配置（OXC 扩展）
