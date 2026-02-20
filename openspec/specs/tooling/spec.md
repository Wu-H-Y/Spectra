# 开发工具链规范

## Git Hooks (Husky)

### Requirement: pre-commit 钩子

执行 lint-staged 检查暂存文件。

#### Scenario: 检查通过
- **WHEN** `git commit` 且 lint-staged 通过
- **THEN** 提交继续

#### Scenario: 检查失败
- **WHEN** lint-staged 失败
- **THEN** 阻止提交，显示错误

#### Scenario: 跳过检查
- **WHEN** `git commit --no-verify`
- **THEN** 跳过钩子

### Requirement: commit-msg 钩子

验证提交信息符合 Conventional Commits。

---

## lint-staged

### Requirement: 只处理暂存文件

```json
{
  "*.dart": ["dart format --fix", "flutter analyze"],
  "web-editor/**/*.{ts,tsx}": ["oxlint --fix", "oxfmt"],
  "*.{json,css,md}": ["oxfmt"]
}
```

### Requirement: 排除生成文件

- `*.g.dart`
- `*.freezed.dart`

### Requirement: 自动重新暂存

格式化后的文件自动添加到暂存区。

---

## Commitlint

### Requirement: 提交类型

| 类型 | 说明 | 版本影响 |
|------|------|----------|
| feat | 新功能 | minor |
| fix | Bug 修复 | patch |
| deps | 依赖更新 | patch |
| docs | 文档 | 无 |
| refactor | 重构 | 无 |
| test | 测试 | 无 |
| chore | 其他 | 无 |

### Requirement: 格式验证

```
<type>(<scope>): <description>
```

#### Scenario: 有效格式
- `feat: 添加新功能`
- `feat(auth): 添加登录功能`

#### Scenario: 无效格式
- `add: 新功能` (无效类型)
- `feat 新功能` (缺少冒号)

### Requirement: 描述长度

不超过 50 个字符。

---

## OXC (前端项目)

### Requirement: 使用 Oxlint 替代 ESLint

```json
{
  "scripts": {
    "lint": "oxlint",
    "lint:fix": "oxlint --fix"
  }
}
```

### Requirement: 使用 Oxfmt 替代 Prettier

```json
{
  "scripts": {
    "fmt": "oxfmt",
    "fmt:check": "oxfmt --check"
  }
}
```

### Requirement: 性能优势

- Oxlint 比 ESLint 快 10x+
- Oxfmt 比 Prettier 快 10x+

---

## 配置文件

| 文件 | 用途 |
|------|------|
| `.husky/pre-commit` | 提交前检查 |
| `.husky/commit-msg` | 提交信息验证 |
| `.lintstagedrc.json` | lint-staged 配置 |
| `commitlint.config.js` | commitlint 配置 |
| `.oxlintrc.json` | oxlint 配置 |
| `.oxfmtrc.json` | oxfmt 配置 |
