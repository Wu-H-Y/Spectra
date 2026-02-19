# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Spectra 是一款跨平台多媒体数据采集应用，支持视频、音乐、小说、漫画、图片的采集，通过自定义爬虫规则系统实现灵活的数据提取。

**技术栈**: Flutter 3.x / Dart 3.x / Material 3

**平台**: Android, iOS, Windows, macOS, Linux

## Development Commands

```bash
# 安装依赖
flutter pub get

# 运行应用 (使用 MCP dart 工具优先)
flutter run

# 代码生成 (修改注解类后必须运行)
dart run build_runner build --delete-conflicting-outputs

# 静态分析
flutter analyze

# 格式化代码
dart format .

# 运行测试
flutter test

# 运行单个测试文件
flutter test test/path/to/test.dart

# 构建发布版本
flutter build <platform> --release  # platform: apk, ios, windows, macos, linux
```

## Architecture: Feature-First Clean Architecture

项目采用 Feature-First Clean Architecture 架构，按功能模块组织代码。

```
lib/
├── core/                    # 共享基础设施
│   ├── constants/          # 常量定义
│   ├── database/           # 数据库 (Drift + Hive)
│   │   ├── drift/          # 关系型数据 (SQLite)
│   │   └── hive/           # 键值存储
│   ├── router/             # 路由配置 (go_router)
│   ├── theme/              # 主题系统 (设计令牌架构)
│   ├── crawler/            # 爬虫规则引擎
│   └── utils/              # 工具类
├── features/               # 功能模块
│   └── <feature>/
│       ├── data/           # 数据层: datasources, models, repositories
│       ├── domain/         # 领域层: entities, repositories (接口), usecases
│       └── presentation/   # 表示层: providers, pages, widgets
├── shared/                 # 跨功能共享组件
│   ├── providers/          # 全局 Providers
│   └── widgets/            # 通用 Widgets
└── l10n/                   # 国际化 (ARB 格式)
    ├── app_en.arb          # 英文翻译
    ├── app_zh.arb          # 中文翻译
    └── generated/          # 生成的本地化类
```

## Key Technologies & Patterns

### State Management: Riverpod

- 使用 `flutter_riverpod` + `riverpod_generator` 进行代码生成
- Provider 定义使用 `@riverpod` 注解，继承 `_$ClassName`
- 全局 Providers 放在 `lib/shared/providers/`
- 功能特定 Providers 放在 `lib/features/<feature>/presentation/providers/`

```dart
@riverpod
class Example extends _$Example {
  @override
  String build() => 'initial';
}
```

### Routing: go_router

- 使用 `@TypedGoRoute` 注解定义类型安全路由
- 路由通过 Riverpod Provider 暴露: `ref.watch(routerProvider)`
- 导航使用: `context.push(const HomeRoute())`

### Database: Dual Strategy

- **Drift** (SQLite): 关系型数据，用于爬虫规则、内容、任务等
- **Hive CE**: 键值存储，用于用户设置、缓存、凭证等
- 两者都使用 `build_runner` 生成代码

### Localization: gen_l10n

- ARB 文件位于 `lib/l10n/app_<locale>.arb`
- 使用 `AppLocalizations.of(context)!.stringKey` 访问翻译
- 支持中文和英文

### Code Generation

项目广泛使用代码生成:

- `riverpod_generator`: Provider 生成
- `go_router_builder`: 路由生成
- `drift_dev`: 数据库代码生成
- `hive_ce_generator`: Hive 适配器生成
- `freezed`: 不可变数据类
- `json_serializable`: JSON 序列化

**修改任何带注解的文件后，必须运行 build_runner。**

## Coding Standards

### Naming Conventions

- **文件**: snake_case (`home_page.dart`)
- **类**: PascalCase (`HomePage`)
- **变量/函数**: camelCase (`userName`)
- **常量**: camelCase (`defaultTimeout`)
- **目录**: kebab-case 或小写 (`video/`, `download-manager/`)

### Line Length: 80 characters

### Lint Configuration

- 使用 `flutter_lints` + `very_good_analysis`
- 生成的代码 (`*.g.dart`, `*.freezed.dart`) 已排除分析

## Commit Convention

遵循 Conventional Commits 规范，使用中文描述:

```
<type>(<scope>): <description>
```

**类型**:
| 类型 | 说明 | 版本影响 |
|------|------|----------|
| `feat` | 新功能 | minor |
| `fix` | Bug 修复 | patch |
| `deps` | 依赖更新 | patch |
| `docs` | 文档 | 无 |
| `refactor` | 重构 | 无 |
| `test` | 测试 | 无 |
| `chore` | 其他 | 无 |

**示例**: `feat(crawler): 添加 XPath 选择器节点`

详见 `docs/COMMIT_CONVENTION.md`

## MCP Tools Preference

优先使用 MCP 工具而非 shell 命令。

### Dart MCP 工具

- `dart_format`: 代码格式化
- `dart_fix`: 自动修复代码问题
- `analyze_files`: 静态分析
- `run_tests`: 运行测试
- `pub`: 包管理

## Library Documentation Lookup

当使用库或包不熟悉时，**优先查询官方文档**获取准确用法:

1. **context7 MCP**: 使用 `resolve-library-id` 和 `query-docs` 查询库文档
2. **pub.dev**: 使用 `pub_dev_search` 搜索包信息
3. **网页爬取**: 使用 `web_reader` 或 `fetch` MCP 工具获取:
   - GitHub README.md
   - 官方文档网站
   - API 参考文档
4. **Dart doc**: 查看本地或在线 API 文档

**不要猜测 API 用法，先查文档再实现。**

## Feature Development Workflow

1. 在 `lib/features/<feature>/` 下创建模块结构
2. 定义领域层: entities 和 repository 接口
3. 实现数据层: models 和 repository 实现
4. 创建 Providers: 使用 `@riverpod` 注解
5. 构建 UI: pages 和 widgets
6. 添加路由: 使用 `@TypedGoRoute`
7. 添加国际化: 更新 ARB 文件
8. 运行代码生成: `dart run build_runner build`
9. 运行分析: `flutter analyze`
10. 提交代码: 遵循 Conventional Commits
