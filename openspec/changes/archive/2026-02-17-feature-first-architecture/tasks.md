# Feature-First Architecture Tasks

## 1. 依赖配置

- [x] 1.1 添加 Riverpod 依赖到 pubspec.yaml (flutter_riverpod, riverpod_annotation)
- [x] 1.2 添加 go_router 依赖到 pubspec.yaml
- [x] 1.3 添加 Drift 依赖到 pubspec.yaml (drift, drift_flutter)
- [x] 1.4 添加 Hive CE 依赖到 pubspec.yaml (hive_ce, hive_ce_flutter)
- [x] 1.5 添加本地化依赖到 pubspec.yaml (flutter_localizations, intl)
- [x] 1.6 添加 dev 依赖到 pubspec.yaml (build_runner, riverpod_generator, go_router_builder, drift_dev, hive_ce_generator)
- [x] 1.7 运行 `flutter pub get` 安装依赖
- [x] 1.8 运行 `flutter pub upgrade` 更新所有依赖到最新兼容版本（包括主版本、次版本和补丁版本）
- [x] 1.9 验证依赖版本兼容性，检查 pubspec.lock 确认版本正确

## 2. 目录结构创建

- [x] 2.1 创建 core/ 目录结构 (database/, router/, theme/, constants/, utils/)
- [x] 2.2 创建 shared/ 目录结构 (widgets/, providers/)
- [x] 2.3 创建 features/ 目录结构
- [x] 2.4 创建 features/home/ 模块 (data/, domain/, presentation/)
- [x] 2.5 创建 l10n/ 目录

## 3. 主题系统迁移

- [x] 3.1 将 lib/theme/ 迁移到 lib/core/theme/
- [x] 3.2 创建 lib/core/theme/theme.dart 导出文件
- [x] 3.3 添加 AppSpacing 设计令牌类
- [x] 3.4 添加 AppDurations 动画时长令牌类
- [x] 3.5 添加 AppBreakpoints 响应式断点类
- [x] 3.6 更新所有主题相关导入路径

## 4. Riverpod 状态管理集成

- [x] 4.1 创建 build.yaml 配置文件 (如需要)
- [x] 4.2 创建 lib/shared/providers/theme_mode_provider.dart
- [x] 4.3 创建 lib/shared/providers/locale_provider.dart
- [x] 4.4 运行 build_runner 生成 Provider 代码
- [x] 4.5 验证生成的 .g.dart 文件

## 5. go_router 路由集成

- [x] 5.1 创建 lib/core/router/app_router.dart
- [x] 5.2 定义 HomeRoute 类型安全路由
- [x] 5.3 定义 SettingsRoute 类型安全路由
- [x] 5.4 创建 routerProvider Riverpod provider
- [x] 5.5 创建 NotFoundPage 错误页面
- [x] 5.6 运行 build_runner 生成路由代码
- [x] 5.7 验证生成的路由代码

## 6. Hive CE 配置

- [x] 6.1 创建 HiveService 初始化服务
- [x] 6.2 创建 settings Box 定义
- [x] 6.3 创建 SettingsBox 数据模型 (带 @GenerateAdapters 注解)
- [x] 6.4 实现 settings provider 与 Hive 集成
- [x] 6.5 运行 build_runner 生成 Hive adapter 代码
- [x] 6.6 验证 Hive 初始化流程

## 7. Drift 数据库配置

- [x] 7.1 创建 lib/core/database/drift/app_database.dart
- [x] 7.2 定义 crawl_rules 表结构
- [x] 7.3 配置 drift_flutter 数据库连接
- [x] 7.4 运行 build_runner 生成数据库代码
- [x] 7.5 验证数据库初始化流程

## 8. 本地化集成

- [x] 8.1 配置 l10n.yaml 文件
- [x] 8.2 创建 lib/l10n/app_en.arb 英文翻译文件
- [x] 8.3 创建 lib/l10n/app_zh.arb 中文翻译文件
- [x] 8.4 运行 `flutter gen-l10n` 生成本地化代码
- [x] 8.5 验证 AppLocalizations 类可用

## 9. 应用入口重构

- [x] 9.1 重构 main.dart 使用 ProviderScope 包裹
- [x] 9.2 将 MaterialApp 改为 MaterialApp.router
- [x] 9.3 集成 go_router (routerConfig)
- [x] 9.4 集成本地化 (localizationsDelegates, supportedLocales)
- [x] 9.5 集成 themeModeProvider
- [x] 9.6 更新 _initializeHeavyTasks 包含服务初始化

## 10. 首页迁移

- [x] 10.1 迁移 home_page.dart 到 lib/features/home/presentation/pages/
- [x] 10.2 重构 HomePage 为 ConsumerWidget
- [x] 10.3 使用 ref.watch 访问 providers
- [x] 10.4 更新导航使用类型安全路由
- [x] 10.5 应用本地化字符串到欢迎文本
- [x] 10.6 删除旧的 lib/pages/ 目录

## 11. 验证与清理

- [x] 11.1 运行 `dart run build_runner build --delete-conflicting-outputs` 确保所有代码生成成功
- [x] 11.2 运行 `flutter analyze` 确保无分析错误
- [x] 11.3 运行 `flutter build <platform>` 确保构建成功
- [x] 11.4 手动测试应用启动和基础导航
- [x] 11.5 清理不再使用的旧代码和目录
- [x] 11.6 更新 .gitignore 排除生成的文件 (如需要)
