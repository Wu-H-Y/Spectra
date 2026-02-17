# Feature-First Architecture Design

## Context

Spectra 是一款跨平台多媒体数据采集应用（视频、音乐、小说、漫画、图片），支持自定义爬虫规则。当前项目处于早期阶段，仅有基础的主题系统和单一首页。

### 当前状态
- `lib/pages/home/home_page.dart` - 单一页面
- `lib/theme/` - FlexColorScheme + Google Fonts 主题
- `lib/main.dart` - 简单 MaterialApp 入口
- 无状态管理、无路由系统、无数据持久化、无本地化

### 约束条件
- 跨平台：Android、iOS、Windows、macOS、Linux
- Dart SDK: ^3.11.0
- 需要支持代码生成 (build_runner)

## Goals / Non-Goals

**Goals:**
- 建立可扩展的 Feature-First Clean Architecture 架构
- 集成 Riverpod 3.0 状态管理，支持代码生成
- 集成 go_router 路由系统，支持类型安全导航
- 集成 Drift + Hive CE 双层存储方案
- 集成 gen_l10n 本地化系统
- 保持现有主题系统兼容

**Non-Goals:**
- 不实现具体业务功能（视频/音乐采集等）
- 不涉及网络层设计（后续变更处理）
- 不涉及爬虫规则引擎设计（后续变更处理）
- 不涉及云同步功能

## Decisions

### 1. 架构模式：Feature-First Clean Architecture

**选择**: Feature-First + 三层分离 (data/domain/presentation)

**结构**:
```
lib/
├── core/                    # 共享基础设施
│   ├── database/           # Drift + Hive 配置
│   ├── router/             # go_router 配置
│   ├── theme/              # 主题系统
│   ├── constants/          # 常量
│   └── utils/              # 工具函数
│
├── shared/                  # 共享组件
│   ├── widgets/            # 通用组件
│   └── providers/          # 全局 Provider
│
├── features/               # 功能模块
│   └── <feature>/
│       ├── data/           # 数据源、仓库实现
│       ├── domain/         # 实体、用例、仓库接口
│       └── presentation/   # Provider、页面、组件
│
├── l10n/                   # 本地化文件
└── main.dart
```

**替代方案**:
- Layer-First (按技术层分目录): 不选，功能增加后文件分散难维护
- 纯 Clean Architecture: 不选，对小团队过于复杂

**理由**: Feature-First 让每个功能模块自包含，便于并行开发、代码审查和未来可能的模块化拆分。

---

### 2. 状态管理：Riverpod 3.0 + 代码生成

**选择**: flutter_riverpod + riverpod_annotation + riverpod_generator

**Provider 类型约定**:
```dart
// 使用 @riverpod 注解生成 Provider
@riverpod
class ThemeMode extends _$ThemeMode {
  @override
  ThemeModeEnum build() => ThemeModeEnum.dark;

  void toggle() => state = state.toggle();
}
```

**替代方案**:
- Signals Dart: 更简单，但生态不如 Riverpod 成熟
- BLoC: 样板代码多，学习曲线陡峭

**理由**: Riverpod 3.0 提供编译时安全、无 BuildContext 依赖、优秀的代码生成支持，是 2026 年 Flutter 状态管理的最佳选择。

---

### 3. 路由：go_router + go_router_builder

**选择**: go_router + go_router_builder 类型安全路由

**路由结构**:
```dart
@TypedGoRoute<HomeRoute>(path: '/')
@TypedGoRoute<SettingsRoute>(path: '/settings')
@TypedGoRoute<VideoRoute>(path: '/video')
// ... 其他功能路由
final GoRouter appRouter = GoRouter(
  routes: $appRoutes,
  errorBuilder: (context, state) => const NotFoundPage(),
);
```

**替代方案**:
- auto_route: 功能更全，但 go_router 官方支持更好
- Navigator 2.0: 需要更多样板代码

**理由**: go_router 是 Flutter 官方推荐，go_router_builder 提供类型安全，与 Riverpod 集成良好。

---

### 4. 数据库：Drift (SQLite) + Hive CE

**选择**: 双层存储策略

**Drift 负责** (关系型数据):
| 表名 | 用途 | 特点 |
|------|------|------|
| `crawl_rules` | 爬虫规则 | 需要全文搜索 |
| `contents` | 采集内容 | 大量数据，分页查询 |
| `download_tasks` | 下载任务 | 频繁状态更新 |
| `collections` | 收藏/历史 | 关联查询 |

**Hive CE 负责** (KV 存储):
| Box | 用途 |
|-----|------|
| `settings` | 用户配置 (主题、语言、下载路径) |
| `cache` | 临时缓存数据 |
| `credentials` | 登录凭证、API Key |

**替代方案**:
- 纯 Drift: 所有数据用 SQLite，但 KV 数据操作繁琐
- 纯 Hive CE: 简单，但缺乏全文搜索和复杂查询能力
- Isar: 性能好，但开发已放缓

**理由**: Drift 提供类型安全的 SQL 查询和响应式 Stream，适合复杂关系数据；Hive CE 读写极快，适合简单 KV 存储。两者互补。

---

### 5. 本地化：gen_l10n + ARB

**选择**: Flutter 官方 gen_l10n 工具 + ARB 文件格式

**结构**:
```
lib/l10n/
├── app_en.arb      # 英文翻译
├── app_zh.arb      # 中文翻译
└── app_localizations.dart  # 生成的类 (build_runner)
```

**替代方案**:
- slang: 类型安全，但非官方方案
- i69n: YAML 配置，但工具链不如 ARB 成熟

**理由**: ARB 是业界标准格式，与翻译平台 (Lokalise, Crowdin) 集成良好，Flutter 官方支持稳定。

---

### 6. 代码生成：build_runner 统一管理

**选择**: 单一 build_runner 管理所有代码生成

**生成的文件**:
| 工具 | 生成内容 |
|------|----------|
| riverpod_generator | `*.g.dart` (Provider) |
| drift_dev | `*.g.dart` (Database) |
| go_router_builder | `*.g.dart` (Routes) |
| hive_ce_generator | `*.g.dart` (Adapters) |
| gen_l10n | `*.dart` (Localizations) |

**命令**:
```bash
# 一次性生成
dart run build_runner build --delete-conflicting-outputs

# 持续监听
dart run build_runner watch --delete-conflicting-outputs
```

---

### 7. 入口集成：ProviderScope + GoRouter + Localization

**main.dart 结构**:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化
  await _initializeServices();

  runApp(
    ProviderScope(                    // Riverpod
      child: const SpectraApp(),
    ),
  );
}

class SpectraApp extends ConsumerWidget {
  const SpectraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      routerConfig: router,           // go_router
      localizationsDelegates: [       // gen_l10n
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('zh'),
      ],
      locale: locale,
      theme: SpectraTheme.light,
      darkTheme: SpectraTheme.dark,
      themeMode: ref.watch(themeModeProvider),
    );
  }
}
```

## Risks / Trade-offs

| 风险 | 影响 | 缓解措施 |
|------|------|----------|
| 代码生成时间过长 | 开发效率下降 | 使用 `watch` 模式增量生成；仅在 CI 执行完整构建 |
| Drift 学习曲线 | 开发延迟 | 先实现简单表，逐步增加复杂度；参考官方文档 |
| 多数据库一致性 | 数据不一致 | 明确数据边界；避免跨库事务；使用单一数据源原则 |
| go_router 维护模式 | 未来兼容性风险 | 稳定版本已足够成熟；关注社区动态 |
| 架构过度设计 | 开发效率下降 | 初期简化 domain 层，按需增加复杂度 |

## Migration Plan

### 阶段 1: 基础设施 (Phase 1)
1. 添加所有依赖到 pubspec.yaml
2. 创建目录结构
3. 迁移现有主题到 `lib/core/theme/`
4. 配置 Riverpod ProviderScope
5. 配置 go_router 基础路由
6. 配置 gen_l10n

### 阶段 2: 数据层 (Phase 2)
1. 配置 Hive CE Boxes
2. 定义 Drift 表结构
3. 实现基础 Repository

### 阶段 3: 迁移首页 (Phase 3)
1. 迁移 home_page.dart 到 `features/home/presentation/`
2. 重构为 Riverpod 状态管理
3. 集成本地化字符串

### 回滚策略
- 保留 `lib/pages/` 目录直到迁移完成
- 使用 Git 分支隔离变更
- 每个 Phase 完成后创建检查点

## Open Questions

1. **Drift 数据库版本迁移策略**: 需要定义 schema 变更时的迁移方案
2. **离线优先架构**: 是否需要支持完全离线使用？影响网络层设计
3. **模块化拆分**: 未来是否需要将 features 拆分为独立 package？
