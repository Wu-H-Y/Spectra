## ADDED Requirements

### Requirement: web-editor 国际化文件格式

web-editor 项目（React）使用独立的国际化文件格式，与 Flutter ARB 格式分离。

- **位置**: `web-editor/src/i18n/locales/<locale>/*.json`
- **格式**: JSON 文件
- **Namespace**: 按功能模块分组（common, rules, preview, errors）

#### Scenario: 翻译文件加载
- **WHEN** 应用启动
- **THEN** 根据当前语言加载对应 locale 下的所有 JSON 文件

#### Scenario: Namespace 访问
- **WHEN** 组件调用 `t('common:save')`
- **THEN** 返回 `locales/<locale>/common.json` 中的 `save` 键值

---

### Requirement: 翻译键类型安全

使用 TypeScript 生成翻译键类型，确保编译时检查。

#### Scenario: 无效键名检查
- **WHEN** 使用不存在的翻译键
- **THEN** TypeScript 编译报错

#### Scenario: 类型提示
- **WHEN** 输入 `t('common:')` 
- **THEN** IDE 自动补全 common namespace 下的所有键
