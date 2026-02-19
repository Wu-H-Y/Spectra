# Spec: OXC Lint Format

前端项目使用 OXC (oxlint + oxfmt) 替代 ESLint + Prettier，提供更快的代码检查和格式化。

## ADDED Requirements

### Requirement: Oxlint installation

web-editor 项目 SHALL 安装 oxlint 作为开发依赖。

#### Scenario: Oxlint in package.json
- **WHEN** 查看 `web-editor/package.json`
- **THEN** `devDependencies` 包含 `oxlint`

#### Scenario: Oxlint scripts
- **WHEN** 查看 `web-editor/package.json` 的 scripts
- **THEN** 包含 `lint` 脚本调用 `oxlint`
- **AND** 包含 `lint:fix` 脚本调用 `oxlint --fix`

### Requirement: Oxfmt installation

web-editor 项目 SHALL 安装 oxfmt 作为开发依赖。

#### Scenario: Oxfmt in package.json
- **WHEN** 查看 `web-editor/package.json`
- **THEN** `devDependencies` 包含 `oxfmt`

#### Scenario: Oxfmt scripts
- **WHEN** 查看 `web-editor/package.json` 的 scripts
- **THEN** 包含 `fmt` 脚本调用 `oxfmt`
- **AND** 包含 `fmt:check` 脚本调用 `oxfmt --check`

### Requirement: Oxlint configuration

web-editor SHALL 使用 `.oxlintrc.json` 配置文件。

#### Scenario: Oxlint config file exists
- **WHEN** 查看 `web-editor/.oxlintrc.json`
- **THEN** 文件存在且为有效 JSON

#### Scenario: Oxlint default categories
- **WHEN** 运行 `oxlint` 检查代码
- **THEN** 默认启用 `correctness` 类别规则
- **AND** 检测到错误时返回非零退出码

#### Scenario: Oxlint TypeScript support
- **WHEN** 检查 TypeScript 代码
- **THEN** oxlint 正确解析 `.ts` 和 `.tsx` 文件
- **AND** 应用 TypeScript 相关规则

#### Scenario: Oxlint React support
- **WHEN** 检查 React 组件
- **THEN** oxlint 应用 React 插件规则
- **AND** 检测 hooks 使用问题

### Requirement: Oxfmt configuration

web-editor SHALL 使用 `.oxfmtrc.json` 配置文件。

#### Scenario: Oxfmt config file exists
- **WHEN** 查看 `web-editor/.oxfmtrc.json`
- **THEN** 文件存在且为有效 JSON

#### Scenario: Oxfmt format options
- **WHEN** 运行 `oxfmt` 格式化代码
- **THEN** 使用配置的 `printWidth`（默认 100）
- **AND** 使用配置的 `tabWidth`（默认 2）
- **AND** 使用配置的 `semi`（默认 true）
- **AND** 使用配置的 `singleQuote`（默认 false）

#### Scenario: Oxfmt import sorting
- **WHEN** 代码包含 import 语句
- **THEN** oxfmt 自动排序 import（如启用 `experimentalSortImports`）

### Requirement: ESLint removal

web-editor SHALL 移除 ESLint 相关依赖和配置。

#### Scenario: ESLint dependencies removed
- **WHEN** 查看 `web-editor/package.json`
- **THEN** `devDependencies` 不包含 `eslint`
- **AND** `devDependencies` 不包含 `@eslint/js`
- **AND** `devDependencies` 不包含 `eslint-plugin-*`

#### Scenario: ESLint config removed
- **WHEN** 查看 `web-editor/` 目录
- **THEN** `eslint.config.js` 文件不存在

### Requirement: Performance improvement

OXC 工具 SHALL 比 ESLint + Prettier 有显著性能提升。

#### Scenario: Oxlint performance
- **WHEN** 对相同代码库运行 lint 检查
- **THEN** oxlint 执行时间少于 ESLint 的 1/10

#### Scenario: Oxfmt performance
- **WHEN** 对相同代码库运行格式化
- **THEN** oxfmt 执行时间少于 Prettier 的 1/10
