# Spec: Commitlint

提交信息验证，强制执行 Conventional Commits 规范。

## ADDED Requirements

### Requirement: Commitlint installation

项目根目录 SHALL 安装 commitlint 依赖。

#### Scenario: Commitlint in package.json
- **WHEN** 查看根目录 `package.json`
- **THEN** `devDependencies` 包含 `@commitlint/cli`
- **AND** `devDependencies` 包含 `@commitlint/config-conventional`

### Requirement: Commitlint configuration

项目 SHALL 使用 `commitlint.config.js` 配置文件。

#### Scenario: Config file exists
- **WHEN** 查看根目录 `commitlint.config.js`
- **THEN** 文件存在
- **AND** 导出有效的配置对象

#### Scenario: Config extends conventional
- **WHEN** 查看 `commitlint.config.js`
- **THEN** 配置 extends `@commitlint/config-conventional`

### Requirement: Conventional Commits validation

commitlint SHALL 验证提交信息符合 Conventional Commits 规范。

#### Scenario: Valid type without scope
- **WHEN** 提交信息为 `feat: 添加新功能`
- **THEN** commitlint 验证通过
- **AND** 返回退出码 0

#### Scenario: Valid type with scope
- **WHEN** 提交信息为 `feat(auth): 添加登录功能`
- **THEN** commitlint 验证通过

#### Scenario: All valid types accepted
- **WHEN** 提交信息使用以下类型之一
  - `feat`, `fix`, `deps`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`
- **THEN** commitlint 验证通过

#### Scenario: Invalid type rejected
- **WHEN** 提交信息为 `add: 新功能`
- **THEN** commitlint 验证失败
- **AND** 显示错误信息说明有效类型

#### Scenario: Missing colon rejected
- **WHEN** 提交信息为 `feat 新功能`（缺少冒号）
- **THEN** commitlint 验证失败

#### Scenario: Empty description rejected
- **WHEN** 提交信息为 `feat:`（缺少描述）
- **THEN** commitlint 验证失败

### Requirement: Description length validation

commitlint SHALL 限制描述长度不超过 50 字符。

#### Scenario: Description under limit
- **WHEN** 提交信息描述长度 ≤ 50 字符
- **THEN** commitlint 验证通过

#### Scenario: Description over limit
- **WHEN** 提交信息描述长度 > 50 字符
- **THEN** commitlint 显示警告或错误

### Requirement: Error message clarity

commitlint SHALL 提供清晰的错误信息。

#### Scenario: Helpful error message
- **WHEN** 提交信息格式无效
- **THEN** 错误信息包含正确的格式示例
- **AND** 列出所有有效的类型

### Requirement: Integration with commit-msg hook

commitlint SHALL 通过 Husky 的 commit-msg 钩子自动执行。

#### Scenario: Automatic validation
- **WHEN** 开发者执行 `git commit`
- **THEN** commit-msg 钩子自动调用 commitlint
- **AND** 读取 `COMMIT_EDITMSG` 文件进行验证

#### Scenario: Commit blocked on failure
- **WHEN** commitlint 验证失败
- **THEN** 提交被阻止
- **AND** 开发者需要修改提交信息后重试
