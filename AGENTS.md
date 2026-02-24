# SPECTRA 项目知识库

跨平台多媒体数据采集应用，通过自定义爬虫规则系统实现视频/音乐/小说/漫画/图片的采集。

**Stack**: Flutter 3.x / Dart 3.11+ / Material 3 / Riverpod 3.x / fpdart 1.x

---

## COMMANDS

```bash
# 单文件命令 (优先使用)
flutter analyze lib/path/to/file.dart    # 单文件分析
dart format lib/path/to/file.dart        # 单文件格式化
flutter test test/path/to/file_test.dart # 单文件测试

# 代码生成 (修改 @freezed/@riverpod/@TypedGoRoute 后必须运行)
dart run build_runner build --delete-conflicting-outputs

# 全量检查 (CI 使用)
flutter analyze --fatal-infos && flutter test
```

**Git Hooks**: 提交时自动运行 lint 和格式化，禁止 `--no-verify`。

---

## DO / DON'T

| Do                                 | Don't                       |
| ----------------------------------- | --------------------------- |
| `talker.debug('消息')`              | `print()` / `debugPrint()`  |
| `Text(S.current.loginButton)`       | `Text('登录')`              |
| `failure.localizedMessage(context)` | `e.toString()` 给用户看     |
| `Either<Failure, T>` 业务返回       | 抛异常处理业务错误          |
| `sealed class` 错误类型             | `String` 类型错误           |
| 顶层调用 Hooks                      | `if`/`for`/嵌套函数中调用   |
| `const` 构造函数                    | 省略 `const`                |
| `ListView.builder` 长列表           | `Column([...])` 长列表      |
| 私有 Widget 类                      | 私有 helper 方法返回 Widget |

---

## PROJECT STRUCTURE

```
lib/
├── core/           # 核心基础设施 (crawler/database/errors/functional/router/server/theme)
├── features/       # 功能模块 (Clean Architecture: data/domain/presentation)
├── l10n/           # 国际化 (主语言: zh)
├── shared/         # 共享模块 (全局 Providers)
└── main.dart
```

**定位**: 路由 `lib/core/router/` | 全局状态 `lib/shared/providers/` | 爬虫 `lib/core/crawler/`

---

## CODE STYLE

| 类型      | 格式       | 示例             |
| --------- | ---------- | ---------------- |
| 文件      | snake_case | `home_page.dart` |
| 类        | PascalCase | `HomePage`       |
| 变量/函数 | camelCase  | `userName`       |
| 目录      | kebab-case | `video/`         |

- **行宽**: 80 字符
- **注释**: 中文
- **Lint**: `flutter_lints` + `very_good_analysis`

---

## ERROR HANDLING

**原则**: 日志看原始堆栈，用户看本地化文案。

```dart
  // [DO] 业务层返回 Either
Future<Either<Failure, User>> getUser(String id) async {
  try {
    return Right(await api.fetchUser(id));
  } catch (e) {
    return Left(NetworkFailure(e.toString()));
  }
}

  // [DO] UI 层 pattern matching
either.fold(
  (failure) => showError(failure.localizedMessage(context)),
  (user) => showUser(user),
);
```

---

## STATE MANAGEMENT

```dart
@riverpod
class ThemeMode extends _$ThemeMode {
  @override
  AppThemeMode build() => AppThemeMode.dark;

  Future<void> setMode(AppThemeMode mode) async {
    state = mode;
    await _persist(mode);
  }
}

// 使用: ref.watch(themeModeProvider)
```

---

## LEARNING FROM MISTAKES

| 错误模式                 | 正确做法                       |
| ------------------------ | ------------------------------ |
| Widget 中直接 HTTP 请求  | 通过 Repository 层             |
| 忘记国际化               | 所有 UI 文本走 `S.current.xxx` |
| `late` 强制解包          | `?` 安全访问或默认值           |
| Provider 命名不一致      | `XxxProvider` / `xxxProvider`  |
| 测试无 `group()`         | `group('Feature', () { ... })` |
| 忘记 `part 'xxx.g.dart'` | 注解类需 part 声明             |
| 猜测包 API               | 先查 pub.dev 文档              |

**每次修复后思考是否添加到此表。**

---

## MCP TOOLS (优先使用)

| 操作   | MCP 工具              |
| ------ | --------------------- |
| 格式化 | `dart_dart_format`    |
| 修复   | `dart_dart_fix`       |
| 分析   | `dart_analyze_files`  |
| 测试   | `dart_run_tests`      |
| 依赖   | `dart_pub`            |
| 搜索包 | `dart_pub_dev_search` |

---

## PACKAGE DOCUMENTATION

不熟悉的包或版本，**先查官方文档，不要猜测 API**:

| 来源             | 链接格式                                               |
| ---------------- | ------------------------------------------------------ |
| pub.dev 包详情   | `https://pub.dev/packages/<package_name>`              |
| pub.dev API 文档 | `https://pub.dev/documentation/<package_name>/latest/` |
| context7 MCP     | `resolve-library-id` → `query-docs`                    |

**示例**:

- riverpod: https://pub.dev/packages/riverpod
- riverpod API: https://pub.dev/documentation/riverpod/latest/
- fpdart: https://pub.dev/packages/fpdart
- go_router: https://pub.dev/documentation/go_router/latest/

---

## COMMIT

```
<type>(<scope>): <description>
```

| 类型       | 说明     |
| ---------- | -------- |
| `feat`     | 新功能   |
| `fix`      | Bug 修复 |
| `deps`     | 依赖更新 |
| `refactor` | 重构     |
| `test`     | 测试     |
| `chore`    | 其他     |

**示例**: `feat(crawler): 添加 XPath 选择器节点`

---

## TESTING

```dart
void main() {
  group('FeatureName', () {
    test('should do something', () {
      // Arrange → Act → Assert
    });
  });
}
```

- 单元/Widget: `package:test` / `package:flutter_test`
- Mock: 优先 fakes/stubs

---

## PERMISSIONS

**允许**: 读文件 | 单文件 analyze/format/test | `flutter pub get`

**需询问**: 装新包 | `git push` | 删除文件 | 全项目构建 | 修改 pubspec/CI

---

## WHEN STUCK

1. 提具体问题或建议方案
2. **不猜测 API**，先查文档:
   - pub.dev: `https://pub.dev/packages/<name>`
   - API 文档: `https://pub.dev/documentation/<name>/latest/`
   - context7 MCP: `resolve-library-id` → `query-docs`
3. 用 `// TODO(xxx):` 标记草稿
4. 不确认不重构
5. 编写任何文档一定不使用Unicode表情符号
