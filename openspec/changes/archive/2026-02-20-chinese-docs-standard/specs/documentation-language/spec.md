# Documentation Language Specification

## ADDED Requirements

### Requirement: 代码注释使用中文

所有 Dart 源代码中的注释必须使用中文，包括文件头注释、类/枚举/扩展注释、方法/函数注释、字段/参数注释和行内注释。

#### Scenario: 类文档注释

- **WHEN** 为类添加文档注释
- **THEN** 注释内容必须使用中文

#### Scenario: 方法文档注释

- **WHEN** 为方法添加文档注释
- **THEN** 注释内容必须使用中文，包括参数和返回值说明

#### Scenario: 行内注释

- **WHEN** 在代码中添加单行或多行注释
- **THEN** 注释内容必须使用中文

---

### Requirement: 日志输出使用中文

所有日志输出必须使用中文，包括 debug、info、warning 和 error 级别的日志。

#### Scenario: info 级别日志

- **WHEN** 记录 info 级别日志
- **THEN** 日志消息必须使用中文

#### Scenario: error 级别日志

- **WHEN** 记录 error 级别日志
- **THEN** 日志消息必须使用中文，可包含英文技术术语

#### Scenario: debug 级别日志

- **WHEN** 记录 debug 级别日志
- **THEN** 日志消息必须使用中文

---

### Requirement: OpenSpec 文档使用中文

所有 OpenSpec 变更文档必须使用中文编写。

#### Scenario: proposal 文档

- **WHEN** 创建 proposal.md
- **THEN** 文档内容必须使用中文

#### Scenario: design 文档

- **WHEN** 创建 design.md
- **THEN** 文档内容必须使用中文

#### Scenario: specs 文档

- **WHEN** 创建 specs/**/*.md
- **THEN** 规格内容必须使用中文

#### Scenario: tasks 文档

- **WHEN** 创建 tasks.md
- **THEN** 任务描述必须使用中文

---

### Requirement: 项目文档使用中文

项目根目录和 docs 目录下的 Markdown 文档必须使用中文。

#### Scenario: README 文档

- **WHEN** 编写或更新 README.md
- **THEN** 文档内容必须使用中文

#### Scenario: CLAUDE 文档

- **WHEN** 编写或更新 CLAUDE.md
- **THEN** 文档内容必须使用中文

#### Scenario: docs 目录文档

- **WHEN** 在 docs/ 目录下创建或更新文档
- **THEN** 文档内容必须使用中文

---

### Requirement: 例外情况

以下情况不强制使用中文：

#### Scenario: 第三方库代码

- **WHEN** 代码属于第三方库或生成的代码
- **THEN** 不要求修改注释语言

#### Scenario: 测试断言消息

- **WHEN** 编写测试代码的断言消息
- **THEN** 可以使用英文或中文

#### Scenario: 技术术语

- **WHEN** 注释中包含技术术语或专有名词
- **THEN** 可以保留英文原文（如 API、HTTP、JSON）
