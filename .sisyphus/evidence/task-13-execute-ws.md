# Task 13 - /api/rules/execute + WebSocket streaming

## 完成时间

- 2026-03-07

## 变更范围

- `lib/core/server/routes/rules_routes.dart`
- `lib/core/server/server_provider.dart`
- `test/rules_execute_ws_test.dart`

## 行为结论

- `POST /api/rules/execute` 复用 Bearer token 鉴权，当请求体携带 `rule` 与可选 `context`（`runId`、`traceId`、`channelCapacity`、`sessionId`、`previewSessionId`）时，会在缺省 `runId` 的场景下先生成稳定标识，然后异步调用 Rust `executeRule`，同步返回 `202`，正文固定为 `{ "runId": <runId>, "status": "accepted" }`。
- `server_provider.dart` 的 `/ws` 路径现支持 `auth`、`subscribe`、`unsubscribe`、`ping`，只有通过 `auth` 并成功订阅后才会收到 run 级 `node_event`。消息会写入 ring buffer，新的订阅可以回放同一 `runId` 的历史事件，保证 run 全生命周期可追溯。
- 运行时只会推送 `run_started(seq=1)` 与 `run_finished(seq=2, success=…)`，二者与 HTTP 响应中的 `runId` 保持一致，以 run 为粒度串联 HTTP 调度与 WebSocket 流水线。

## 验证命令

```bash
flutter analyze --fatal-infos lib/core/server test/rules_execute_ws_test.dart
flutter test test/rules_execute_ws_test.dart
```

## 验证结果

- `flutter analyze --fatal-infos lib/core/server test/rules_execute_ws_test.dart`：通过，无警告或错误。
- `flutter test test/rules_execute_ws_test.dart`：通过，构造真实 server，依次执行 `/api/server/status` 获取 `serverToken`，首个 WebSocket 完成 `connected` → `auth` → `subscribe(runId)`，随后向 `/api/rules/execute` 发送带 `runId` 的请求并断言收到 `202` 与 `{runId,status}`，同一连接收到 `run_started` 与 `run_finished`，第二个 WebSocket 在重新 `auth` 和 `subscribe` 后成功回放已缓冲的 `run_started` 与 `run_finished`，验证 auth、订阅、run 范围事件以及回放链路全部可用。

## 证明材料

- `test/rules_execute_ws_test.dart:14-140` 构建全流程集成测试，显式覆盖 `/api/server/status` 握手、WebSocket 鉴权与订阅、HTTP 执行触发 run 事件、后续连接对同一 `runId` 的缓冲回放，确保 run 范围事件在多客户端间一致。
- `lib/core/server/routes/rules_routes.dart:220-291` 展示 execute 请求如何发布 `run_started`、异步执行 FFI，并在完成后以同一 `runId` 发布 `run_finished`。
- `lib/core/server/server_provider.dart:196-407` 描述 WebSocket 认证、订阅过滤与 `_recentWsMessages` 回放策略，证明第二个连接能基于 runId 复用先前的缓冲事件。
