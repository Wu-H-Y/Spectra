# Rust JavaScript 执行规范

## 目的

为爬虫规则中的动态字符串变换提供隔离的 JavaScript 执行环境，并支持注入上下文变量。

## 需求

### Requirement: JavaScript 执行上下文

系统 MUST 通过 `rquickjs` 引擎提供隔离的 JavaScript 执行环境，用于执行基于字符串变量 `val` 的动态变换。

#### Scenario: 执行基础 JavaScript
- **WHEN** 提供一个操作字符串变量 `val` 的有效 JavaScript 片段
- **THEN** 安全执行并返回变换后的字符串

---

### Requirement: 上下文变量注入

JavaScript 执行环境 MUST 支持注入上下文变量（例如 `vars.host`），使脚本可以访问外部请求状态。

#### Scenario: 注入 vars 上下文
- **WHEN** 将上下文变量序列化并注入执行上下文
- **THEN** 脚本可通过 `vars` 对象访问这些变量
