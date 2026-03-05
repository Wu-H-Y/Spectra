# Task 6 证据：Dart JSON 反序列化

## 执行命令

在仓库根目录运行：

```bash
flutter test
```

## 结果摘要

- 新增测试 `test/rules_ir_json_test.dart`：读取 `fixtures/ir_v1_min.json` 并通过 `jsonDecode` 解析，断言 `irVersion/metadata/graph` 等关键字段存在。
- `flutter test` 退出码 0。
