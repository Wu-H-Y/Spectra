# SPECTRA 项目知识库

**Generated:** 2026-02-21
**Commit:** 8d1f27c
**Branch:** feature/architecture

## OVERVIEW

跨平台多媒体数据采集应用，通过自定义爬虫规则系统实现视频/音乐/小说/漫画/图片的采集。

**Stack**: Flutter 3.x / Dart 3.x / Material 3 / Riverpod 3.x / fpdart 1.x / relic 1.x

## WHERE TO LOOK

| Task | Location | Notes |
|------|----------|-------|
| 添加新功能 | `lib/features/<feature>/` | Clean Architecture: data/domain/presentation |
| 修改路由 | `lib/core/router/app_router.dart` | 使用 `@TypedGoRoute` 注解 |
| 全局状态 | `lib/shared/providers/` | Riverpod providers |
| 爬虫规则 | `lib/core/crawler/` | 详见 `lib/core/crawler/AGENTS.md` |
| 主题定制 | `lib/core/theme/tokens/` | 设计令牌架构 |
| 数据库 | `lib/core/database/` | Drift (SQLite) + Hive CE |
| HTTP 服务 | `lib/core/server/` | relic 服务器 |
| 国际化 | `lib/l10n/intl_*.arb` | 主语言: zh |
| 错误处理 | `lib/core/errors/`, `lib/core/functional/` | sealed class + fpdart |
| Web 编辑器 | `web-editor/` | React + TypeScript + Vite |

## COMMANDS

```bash
# 开发
flutter pub get                    # 安装依赖
flutter run                        # 运行应用
bun install                        # 初始化 Git Hooks

# 代码生成 (修改注解类后必须运行)
dart run build_runner build --delete-conflicting-outputs

# 质量检查
flutter analyze --fatal-infos      # 静态分析 (CI 使用 --fatal-infos)
dart format .                      # 格式化
flutter test                       # 测试

# 构建
flutter build <platform> --release # platform: apk, ios, windows, macos, linux
```

**重要**: Git Hooks 必须 全部通过，禁止使用 `--no-verify` 跳过。

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

## ANTI-PATTERNS (禁止模式)

| 禁止 | 替代方案 | 原因 |
|------|---------|------|
| `print()` / `debugPrint()` / `log()` | `talker.debug()` / `talker.info()` | 统一日志系统 |
| `Text('登录')` | `Text(S.current.loginButton)` | UI 文本必须国际化 |
| 在 `if`/`for`/嵌套函数中调用 Hooks | 顶层无条件调用 | Hooks 规则 |
| `e.toString()` 展示给用户 | `failure.localizedMessage(context)` | 错误国际化 |
| 直接使用 `String` 类型错误 | `sealed class AppFailure` | 类型安全错误处理 |

## UNIQUE STYLES (项目特有)

### 函数式错误处理

使用 fpdart 的 `Either<Failure, T>` 替代异常：

```dart
// 业务逻辑返回 Either
Future<Either<Failure, User>> getUser(String id);

// UI 层使用 EitherBuilder
EitherBuilder<User>(
  either: userEither,
  data: (user) => UserCard(user: user),
  error: (failure) => FailureWidget(failure: failure),
)
```

### 双数据库策略

- **Drift (SQLite)**: 关系型数据 — 爬虫规则、内容、任务
- **Hive CE**: 键值存储 — 用户设置、缓存、凭证

### Documentation Language

项目采用统一的中文文档和注释规范：

- 代码注释/日志输出**必须使用中文**
- UI 文本**必须通过国际化系统访问** (`S.current.xxx`)
- 例外：第三方库注释、测试断言、技术术语

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
3. **网页爬取**: 使用 `fetch` MCP 工具获取官方文档
4. **shadcn-ui**: 优先使用mcp工具和[llms.txt](https://ui.shadcn.com/llms.txt)获取相关文档

**不要猜测 API 用法，先查文档再实现。**
