# Task 12 Validate Endpoint

- `flutter analyze --fatal-infos lib/core/server/routes/rules_routes.dart`
  - Result: analyzer reports no issues.
- `flutter test test/rules_api_crud_test.dart`
  - Result: both CRUD and new `/api/rules/validate` tests pass (the latter verifies `fixtures/ir_v1_invalid_edge.json` returns `400` with `UNKNOWN_NODE` → `graph.edges[1].from.nodeId`).
