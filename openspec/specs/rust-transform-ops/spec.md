# Rust 转换算子规范

## 目的

在 Rust 侧提供高性能、可组合的数据转换算子，供爬虫规则执行引擎通过 FFI 调用。

## 需求

### Requirement: 字符串操作

系统 MUST 在 Rust 侧提供高性能字符串转换函数，包括 `trim`、`replace`、`lower`、`upper`。

#### Scenario: 去除首尾空白
- **WHEN** 通过 `@trim` 处理包含前后空白的字符串
- **THEN** 返回被清理后的字符串

---

### Requirement: URL 操作

系统 MUST 使用 `url` crate 提供原生 URL 拼接能力。

#### Scenario: 拼接基础 URL
- **WHEN** 处理一个 base URL 与相对路径
- **THEN** 返回有效的绝对 URL 字符串
