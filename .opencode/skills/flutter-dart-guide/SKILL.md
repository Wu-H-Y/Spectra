---
name: flutter-dart-guide
description: 指导 Flutter 和 Dart 代码的编写、分析、测试和依赖管理。当你在 lib/ 目录下工作或处理 Flutter 相关任务时，请参考此 Skill。
---

# Flutter & Dart 开发指南

## COMMANDS

```bash
# 单文件开发辅助
flutter analyze lib/path/to/file.dart
dart format lib/path/to/file.dart
flutter test test/path/to/file_test.dart

# 代码生成
dart run build_runner build --delete-conflicting-outputs
```

## DEPENDENCIES

- 优先使用 `flutter pub add <package>` 或 `dart pub add <package>`。
- 只有在需要指定 alpha/beta/rc 版本或特定 Git/Path 依赖时，才手动修改 `pubspec.yaml`。

## DO / DON'T

- 使用 `talker.debug()` 替代 `print()`。
- 所有 UI 文本必须通过 `S.current.xxx` 实现国际化。
- 业务逻辑返回 `Either<Failure, T>`，严禁抛出异常。
- 顶层调用 Hooks，严禁在 `if`/`for` 中嵌套。

## LINT & STYLE

- **行宽**: 限制在 80 字符。
- **文档**: 所有公共成员必须有文档注释 (`///`)。
- **捕获**: `catch` 必须配合 `on Exception`，不要裸捕。

## ERROR HANDLING & STATE

- 返回 `Either` 处理业务错误。
- 使用 `Riverpod` 管理状态，Provider 命名遵循 `xxxProvider` 规范。
