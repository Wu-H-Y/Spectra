# Task 11 - Flutter server rules CRUD

## 完成时间

- 2026-03-07

## 变更范围

- `lib/core/server/server_provider.dart`
- `lib/core/server/routes/server_routes.dart`
- `lib/core/server/routes/rules_routes.dart`
- `lib/core/database/drift/app_database.dart`
- `test/rules_api_crud_test.dart`

## 实现说明

- 在 `server_provider.dart` 中注入单例 `AppDatabase`，挂载新的 `/api/rules` 路由，并为 server 生成最小 `serverToken`。
- 在 `server_routes.dart` 的 `GET /api/server/status` 响应中补充 `serverToken`，供 `/api/rules*` Bearer 鉴权使用。
- 新建 `rules_routes.dart`，集中实现 `GET /api/rules`、`GET /api/rules/:id`、`POST /api/rules`、`PUT /api/rules/:id`、`DELETE /api/rules/:id`。
- `POST` / `PUT` 只读取契约要求的 `{"rule": RuleEnvelope}`，同时支持最小可选字段 `displayConfig` 与 `enabled`；落库字段覆盖 `ruleId`、`name`、`description`、`irVersion`、`ruleEnvelopeJson`、`displayConfigJson`、`enabled`、`createdAt`、`updatedAt`。
- `GET /api/rules` 返回 `{ items, total }`，列表项使用 DB/IR 字段 `{ id, ruleId, name, irVersion, updatedAt }`。
- `GET /api/rules/:id` 当前返回 `{ id, ruleId, rule, displayConfig, enabled, createdAt, updatedAt }`；其中 `id` 使用 Drift 主键，`rule` 为解码后的 RuleEnvelope。这一结构已在测试中固定，便于后续 CRUD 任务继续消费。
- `PUT /api/rules/:id` 每次写入都会显式刷新 `updatedAt`。
- `DELETE /api/rules/:id` 返回 `{ id, deleted: true }`。

## 验证命令

```bash
flutter analyze lib/core/server lib/core/database
flutter test test/rules_api_crud_test.dart
```

## 验证结果

- `flutter analyze lib/core/server lib/core/database`：通过，无 issue。
- `test/rules_api_crud_test.dart`：通过，覆盖 `401 -> status -> create -> list -> get -> update -> delete -> list(empty)` 完整链路。
