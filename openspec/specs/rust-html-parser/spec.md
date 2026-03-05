# Rust HTML 解析规范

## 目的

在爬虫规则执行过程中，将 HTML 解析与选择器求值下沉到 Rust 侧实现，以降低 Dart VM 的 GC 压力并提升大 DOM/高并发场景下的性能与稳定性。

## 需求

### Requirement: 原生 HTML 解析

系统 MUST 在 Rust 环境中使用 `rlibxml2` 解析 HTML 文档，并通过 FFI 返回可复用的文档引用以供后续查询。

#### Scenario: 解析 HTML 文档
- **WHEN** 向 Rust FFI 传入原始 HTML 字符串
- **THEN** 返回可被原生查询的结构化文档引用

---

### Requirement: XPath 提取

系统 MUST 使用 `rlibxml2` 引擎支持 XPath 1.0 语法，对已解析的 HTML 文档进行查询。

#### Scenario: 通过 XPath 提取文本
- **WHEN** 执行一个指向文本节点的 XPath 查询
- **THEN** 返回匹配到的字符串数组

---

### Requirement: CSS 选择器提取

系统 MUST 在 Rust 侧使用 `scraper` 库支持 CSS 选择器语法，对 HTML 文档进行查询。

#### Scenario: 通过 CSS 提取元素
- **WHEN** 执行一个 CSS 选择器查询
- **THEN** 返回匹配到的元素或字符串数组

---

### Requirement: 正则提取

系统 MUST 使用 Rust `regex` crate 对字符串进行正则匹配与提取。

#### Scenario: 通过 Regex 提取捕获组
- **WHEN** 提供包含捕获组的有效正则表达式
- **THEN** 返回捕获到的字符串结果

---

### Requirement: JSONPath 提取

系统 MUST 使用 `jsonpath-rust` crate 支持对 JSON 字符串执行 JSONPath 查询并提取数据。

#### Scenario: 通过 JSONPath 提取数据
- **WHEN** 提供 JSON 字符串与有效 JSONPath 表达式
- **THEN** 返回匹配到的 JSON 值（以字符串形式）
