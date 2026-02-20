# Localization Specification (Delta)

## ADDED Requirements

### Requirement: 禁止 UI 文本硬编码

所有在 UI 上显示的文本必须通过国际化系统访问，禁止在代码中直接硬编码文本字符串。

#### Scenario: Text 组件文本

- **WHEN** 使用 Text 组件显示文本
- **THEN** 文本内容必须通过 `S.current.xxx` 或 `AppLocalizations.of(context)!.xxx` 获取

#### Scenario: 按钮文本

- **WHEN** 设置按钮、浮动按钮等组件的文本
- **THEN** 文本内容必须通过国际化系统获取

#### Scenario: 对话框文本

- **WHEN** 显示对话框、Snackbar、Toast 等提示信息
- **THEN** 所有用户可见的文本必须通过国际化系统获取

#### Scenario: 错误提示文本

- **WHEN** 显示错误提示或验证消息
- **THEN** 错误消息必须通过国际化系统获取

---

### Requirement: 新增翻译同步更新

当添加新的 UI 文本时，必须同步更新所有支持的语言文件。

#### Scenario: 添加中文翻译

- **WHEN** 添加新的 UI 文本键
- **THEN** 必须在 `lib/l10n/app_zh.arb` 中添加对应的中文翻译

#### Scenario: 添加英文翻译

- **WHEN** 添加新的 UI 文本键
- **THEN** 必须在 `lib/l10n/app_en.arb` 中添加对应的英文翻译

#### Scenario: 翻译完整性检查

- **WHEN** 提交代码前
- **THEN** 应确保所有语言文件的键保持一致

---

### Requirement: 国际化键名规范

国际化键名应遵循统一的命名规范，便于管理和查找。

#### Scenario: 键名前缀分组

- **WHEN** 命名国际化键
- **THEN** 应使用功能模块作为前缀（如 `home_`、`settings_`、`common_`）

#### Scenario: 键名语义化

- **WHEN** 命名国际化键
- **THEN** 键名应能清晰表达文本用途（如 `login_button` 而非 `text1`）

#### Scenario: 通用文本复用

- **WHEN** 存在相同含义的文本
- **THEN** 应复用现有的国际化键，避免重复定义
