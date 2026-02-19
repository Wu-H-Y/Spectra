# Logging Specification

## Overview

本规范定义了 Spectra 应用的日志系统架构，使用 Talker 作为核心日志框架，提供统一的日志记录、错误处理和调试能力。

## ADDED Requirements

### Requirement: Talker 日志框架集成

系统 SHALL 使用 Talker 作为统一的日志框架，提供控制台日志、历史记录和错误处理功能。

#### Scenario: Talker 实例初始化
- **WHEN** 应用启动
- **THEN** 系统 SHALL 通过 `createTalker()` 创建全局 Talker 实例
- **AND** Talker 实例 SHALL 配置日志历史记录（maxHistoryItems: 500）

#### Scenario: Talker Provider 注入
- **WHEN** 需要访问日志服务
- **THEN** 组件 SHALL 通过 `ref.read(talkerProvider)` 获取 Talker 实例
- **AND** Provider SHALL 位于 `lib/shared/providers/talker_provider.dart`

---

### Requirement: Riverpod 状态日志集成

系统 SHALL 使用 TalkerRiverpodObserver 监听 Riverpod Provider 的状态变化。

#### Scenario: ProviderScope 观察者配置
- **WHEN** 应用初始化 ProviderScope
- **THEN** ProviderScope SHALL 包含 TalkerRiverpodObserver
- **AND** Observer SHALL 连接到全局 Talker 实例

#### Scenario: Provider 状态变化日志
- **WHEN** Provider 状态发生变化（创建、更新、销毁、失败）
- **THEN** Talker SHALL 自动记录状态变化事件

---

### Requirement: 路由导航日志

系统 SHALL 使用 TalkerRouteObserver 记录应用内页面导航事件。

#### Scenario: GoRouter 观察者配置
- **WHEN** GoRouter 初始化
- **THEN** GoRouter SHALL 包含 TalkerRouteObserver
- **AND** Observer SHALL 连接到全局 Talker 实例

#### Scenario: 页面导航日志
- **WHEN** 用户在应用内导航
- **THEN** Talker SHALL 记录路由变化事件
- **AND** 日志 SHALL 包含源路由和目标路由信息

---

### Requirement: 日志级别规范

系统 SHALL 使用标准化的日志级别区分不同类型的日志消息。

| 级别 | 方法 | 用途 |
|------|------|------|
| debug | `talker.debug()` | 开发调试信息 |
| info | `talker.info()` | 一般操作信息 |
| warning | `talker.warning()` | 警告信息（非致命问题） |
| error | `talker.error()` | 错误信息（包含异常和堆栈） |
| critical | `talker.critical()` | 严重错误（应用可能无法继续） |

#### Scenario: HTTP 请求日志
- **WHEN** HTTP 服务器收到请求
- **THEN** 系统 SHALL 使用 `debug` 级别记录请求方法和路径
- **AND** 日志 SHALL 包含响应状态码和处理时间

#### Scenario: WebSocket 事件日志
- **WHEN** WebSocket 发生连接、消息或错误事件
- **THEN** 系统 SHALL 根据事件类型选择适当日志级别

#### Scenario: 异常和错误日志
- **WHEN** 捕获到异常或错误
- **THEN** 系统 SHALL 使用 `error()` 方法记录
- **AND** 日志 SHALL 包含异常对象和堆栈跟踪

---

### Requirement: 禁止直接使用 print

系统 SHALL 禁止在代码中直接使用 `print()` 语句进行日志输出。

#### Scenario: 日志替代
- **WHEN** 需要输出调试信息或状态
- **THEN** 代码 SHALL 使用 Talker 实例的日志方法
- **AND** 代码 SHALL NOT 使用 `print()`、`debugPrint()` 或 `log()`

#### Scenario: 异常处理中的日志
- **WHEN** 在 catch 块中处理异常
- **THEN** 代码 SHALL 使用 `talker.error(message, error, stackTrace)`
- **AND** 代码 SHALL NOT 使用 `print(e)` 或 `print(stackTrace)`

---

### Requirement: HTTP 服务器日志中间件

系统 SHALL 为 Shelf HTTP 服务器配置日志中间件，记录请求和错误。

#### Scenario: 请求日志中间件
- **WHEN** HTTP 请求到达服务器
- **THEN** 中间件 SHALL 记录请求方法、路径、状态码和响应时间

#### Scenario: 错误处理中间件
- **WHEN** 请求处理过程中发生异常
- **THEN** 中间件 SHALL 使用 Talker 记录错误详情
- **AND** 返回 500 Internal Server Error 响应

---

### Requirement: 日志查看界面

系统 SHALL 提供 TalkerScreen 组件用于在应用内查看日志历史。

#### Scenario: 日志界面入口
- **WHEN** 开发者或用户需要查看应用日志
- **THEN** 系统 SHALL 提供访问 TalkerScreen 的入口
- **AND** TalkerScreen SHALL 显示完整的日志历史

#### Scenario: 日志过滤和搜索
- **WHEN** 在 TalkerScreen 中查看日志
- **THEN** 用户 SHALL 能够按日志类型和级别过滤
- **AND** 用户 SHALL 能够搜索日志内容

---

## Implementation Reference

### 文件结构

```
lib/
├── shared/
│   └── providers/
│       └── talker_provider.dart    # Talker Provider 定义
├── core/
│   └── server/
│       ├── server_provider.dart     # HTTP 服务器（含日志中间件）
│       ├── middleware/
│       │   └── cors_middleware.dart # 错误处理中间件
│       └── handlers/
│           └── websocket_handler.dart # WebSocket 日志
└── main.dart                        # Talker 初始化和 Observer 配置
```

### 依赖版本

| 包 | 版本 |
|---|---|
| talker | ^5.1.13 |
| talker_flutter | ^5.1.13 |
| talker_riverpod_logger | ^5.1.13 |
| talker_dio_logger | ^5.1.13 |
