# 架构规范

## 项目结构

```
lib/
├── core/                    # 共享基础设施
│   ├── constants/          # 常量定义
│   ├── database/           # 数据库 (Drift + Hive)
│   ├── router/             # 路由配置 (go_router)
│   ├── theme/              # 主题系统
│   ├── crawler/            # 爬虫规则引擎
│   └── utils/              # 工具类
├── features/               # 功能模块
│   └── <feature>/
│       ├── data/           # 数据层
│       ├── domain/         # 领域层
│       └── presentation/   # 表示层
├── shared/                 # 跨功能共享组件
└── l10n/                   # 国际化
```

### Requirement: Feature-First Clean Architecture

每个功能模块采用三层架构：

- **data/**: datasources, models, repositories (实现)
- **domain/**: entities, repositories (接口), usecases
- **presentation/**: providers, pages, widgets

#### Scenario: 功能模块目录结构
- **WHEN** 创建新功能模块
- **THEN** 目录结构为 `features/<name>/data/`, `features/<name>/domain/`, `features/<name>/presentation/`

#### Scenario: 命名规范
- **WHEN** 命名功能目录
- **THEN** 使用 kebab-case（如 `download-manager/`）

---

## 数据库策略

### Requirement: 双数据库策略

- **Drift (SQLite)**: 关系型数据（爬虫规则、内容、任务、收藏）
- **Hive CE**: 键值存储（用户设置、缓存、凭证）

#### Scenario: 关系型数据存储
- **WHEN** 存储爬虫规则、内容、任务
- **THEN** 使用 Drift SQLite 数据库

#### Scenario: 键值数据存储
- **WHEN** 存储用户设置、缓存、凭证
- **THEN** 使用 Hive CE boxes

### Requirement: Repository 模式

数据访问通过 Repository 抽象。

#### Scenario: Repository 接口定义
- **WHEN** 功能需要数据访问
- **THEN** 在 domain 层定义 Repository 接口

#### Scenario: Repository 实现
- **WHEN** 实现数据访问
- **THEN** 在 data 层提供具体实现

### Requirement: 数据库迁移支持

支持数据库 schema 迁移。

#### Scenario: Schema 版本升级
- **WHEN** 数据库 schema 变更
- **THEN** 迁移代码处理版本升级

#### Scenario: 数据保留
- **WHEN** 迁移执行
- **THEN** 现有用户数据保留

---

## 代码生成

### Requirement: 生成代码放置

生成代码使用 `.g.dart` 后缀，与源文件共存。

#### Scenario: Riverpod 生成
- **WHEN** riverpod_generator 运行
- **THEN** `<name>.g.dart` 生成在源文件旁

#### Scenario: 排除分析
- **WHEN** 生成文件存在
- **THEN** 分析配置排除 `*.g.dart`, `*.freezed.dart`
