# lib/ 目录知识库

## OVERVIEW

Flutter 主应用代码目录，包含路由、主题、服务端桥接、媒体模型与页面层。

## WHERE TO LOOK

| 任务 | 位置 | 说明 |
|------|------|------|
| 启动流程 | `lib/main.dart` | 应用入口与初始化 |
| 路由跳转 | `lib/core/router/app_router.dart` | `go_router` 路由定义 |
| 内置服务端 | `lib/core/server/**` | 本地 HTTP/WS 服务逻辑 |
| 核心模型 | `lib/core/media/models/**` | Freezed/JSON 媒体数据模型 |
| 设置页 | `lib/features/settings/presentation/pages/settings_page.dart` | UI 配置入口 |

## SKILLS

- 默认先读 `flutter-dart-guide`。
- 架构分层设计优先 `flutter-architecture`。
- 状态管理问题优先 `flutter-state-management`。
- 路由与导航问题优先 `flutter-routing-and-navigation`。
- 本地化与多语言优先 `flutter-localization`。
- 测试策略与测试实现优先 `flutter-testing`。
- 网络请求与 JSON 解析优先 `flutter-http-and-json`。
- 本地缓存与离线策略优先 `flutter-caching`。
- 数据库存储优先 `flutter-databases`。
- 并发与异步调度优先 `flutter-concurrency`。
- 性能优化与体积治理优先 `flutter-performance`、`flutter-app-size`。
- 布局实现与响应式优先 `flutter-layout`。
- 动画与交互效果优先 `flutter-animation`。
- 主题系统优先 `flutter-theming`，复杂主题方案补充 `theme-factory`。
- 无障碍适配优先 `flutter-accessibility`。
- 插件开发与平台视图优先 `flutter-plugins`、`flutter-platform-views`。
- 涉及 Rust FFI 边界时，联动 `rust-ffi-guide`。
- 涉及 Flutter 与原生双向通信时，补充 `flutter-native-interop`。
- 涉及复杂错误语义建模时，参考 `m06-error-handling`。
- 涉及 Flutter 端 UI 重构/视觉改版时，补充 `ui-ux-pro-max` 与 `frontend-design`。

## CONVENTIONS

- UI 文本必须走 i18n（`S.current.xxx`），禁止硬编码。
- 业务错误走 `Either<Failure, T>` 风格，不在业务流裸抛异常。
- 日志优先 `talker` 体系，不用 `print()`。
- 依赖新增使用 `flutter pub add <package>`。

## ANTI-PATTERNS

- 禁止修改 `*.g.dart`、`*.freezed.dart`、`lib/l10n/generated/**`。
- 禁止绕过 `flutter analyze` 与相关测试直接提交。
- 禁止在 Hook 场景下把 Hook 调用写进条件/循环分支。

## COMMANDS

```bash
flutter analyze lib
flutter test test
dart run build_runner build --delete-conflicting-outputs
dart format lib test
```

## NOTES

- `lib/core/server/**` 涉及协议时需对齐 `docs/api-contract-v1.md` 与 `docs/ws-protocol-v1.md`。
- 模型字段变更前先检查 `web-editor/src/types/**` 是否需要同步。
