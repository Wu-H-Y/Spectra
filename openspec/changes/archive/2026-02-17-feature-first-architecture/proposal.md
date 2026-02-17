# Feature-First Architecture Proposal

## Why

Spectra 当前项目结构过于简单（仅单一 `pages` 目录），无法支撑多媒体采集应用的复杂需求。随着功能增加，代码组织将变得混乱，维护成本急剧上升。现在正是建立现代化架构的最佳时机，避免后期大规模重构。

## What Changes

### 项目架构重构
- **BREAKING** 采用 Feature-First Clean Architecture 架构模式
- 按功能模块组织代码（video、music、novel、comic、image、rule、download、settings）
- 每个功能模块包含 data/domain/presentation 三层

### 技术栈升级
- 引入 Riverpod 3.0 状态管理（替代当前无状态管理）
- 引入 go_router 路由系统（替代当前 MaterialApp 简单路由）
- 引入 Drift + Hive CE 数据存储方案（新增本地持久化能力）
- 引入 gen_l10n 本地化系统（支持中英双语）

### 代码生成基础设施
- 配置 build_runner 统一代码生成流程
- 支持 Riverpod、Drift、go_router、Hive 的代码生成

## Capabilities

### New Capabilities

- `state-management`: Riverpod 3.0 状态管理基础设施，支持响应式状态、依赖注入、代码生成
- `routing`: go_router 路由系统，支持声明式路由、Deep Link、类型安全导航
- `database`: Drift (SQLite ORM) + Hive CE (KV 存储) 双层数据存储方案
- `localization`: gen_l10n 本地化系统，支持中英双语、类型安全的翻译字符串
- `project-structure`: Feature-First Clean Architecture 目录结构规范

### Modified Capabilities

- `home-page`: 迁移到 features/home/ 目录，使用 Riverpod 状态管理
- `app-theme`: 扩展设计令牌系统（spacing、animation、breakpoints）

## Impact

### 代码影响
- 现有 `lib/pages/` 目录将迁移到 `lib/features/home/`
- 现有 `lib/theme/` 将移动到 `lib/core/theme/`
- `main.dart` 需要重构以集成新的基础设施

### 依赖变更
- 新增：flutter_riverpod、riverpod_annotation、go_router
- 新增：drift、drift_flutter、hive_ce、hive_ce_flutter
- 新增：flutter_localizations、intl
- 新增 (dev)：build_runner、riverpod_generator、go_router_builder、drift_dev、hive_ce_generator

### 数据存储策略
- **Drift**: 爬虫规则、采集内容、下载任务、收藏历史（需要复杂查询）
- **Hive CE**: 用户配置、缓存数据、临时凭证（简单 KV 存储）

### 构建流程
- 新增 `dart run build_runner build` 构建步骤
- CI/CD 需要更新以包含代码生成

## References

- [Feature-First Clean Architecture for Flutter](https://medium.com/@remy.baudet/feature-first-clean-architecture-for-flutter-246366e71c18)
- [Best Flutter State Management Libraries 2026](https://foresightmobile.com/blog/best-flutter-state-management)
- [Riverpod 3.0 Documentation](https://riverpod.dev/)
- [Drift Documentation](https://drift.simonbinder.eu/)
- [Hive CE on pub.dev](https://pub.dev/packages/hive_ce)
