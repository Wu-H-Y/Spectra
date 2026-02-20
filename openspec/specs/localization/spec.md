# 国际化规范

## ARB 文件结构

### Requirement: 文件位置和命名

- **位置**: `lib/l10n/`
- **命名**: `app_<locale>.arb`（如 `app_zh.arb`, `app_en.arb`）

### Requirement: 支持语言

- **中文 (Simplified)**: `app_zh.arb`
- **英文**: `app_en.arb`
- **默认**: 系统语言或英文

---

## 使用规范

### Requirement: 禁止 UI 文本硬编码

所有 UI 文本必须通过国际化系统获取。

```dart
// ✅ 正确
Text(S.current.loginButton)
Text(AppLocalizations.of(context)!.welcomeMessage)

// ❌ 错误
Text('登录')
Text('Login')
```

#### Scenario: Text 组件
- **WHEN** 使用 Text 组件显示文本
- **THEN** 通过 `S.current.xxx` 或 `AppLocalizations.of(context)!.xxx` 获取

#### Scenario: 按钮/对话框文本
- **WHEN** 设置按钮、对话框、Snackbar 文本
- **THEN** 必须通过国际化系统获取

### Requirement: 同步更新所有语言文件

添加新 UI 文本时，必须同步更新所有语言文件。

#### Scenario: 添加新翻译键
- **WHEN** 添加新 UI 文本键
- **THEN** 在 `app_zh.arb` 和 `app_en.arb` 中添加对应翻译

### Requirement: 键名规范

- **前缀分组**: 使用功能模块前缀（`home_`, `settings_`, `common_`）
- **语义化**: 键名清晰表达用途（如 `login_button` 而非 `text1`）
- **复用**: 相同含义文本复用现有键

---

## 错误国际化

### Requirement: 强类型错误定义

使用 sealed class 定义业务错误，不直接使用 String。

```dart
@freezed
sealed class AppFailure with _$AppFailure {
  const factory AppFailure.networkUnreachable() = _NetworkUnreachable;
  const factory AppFailure.unauthorized() = _Unauthorized;
  const factory AppFailure.weakPassword({required int minLength}) = _WeakPassword;
  const factory AppFailure.unknown(Object? originalError) = _Unknown;
}
```

### Requirement: 错误到本地化的映射层

```dart
extension AppFailureDisplay on AppFailure {
  String localizedMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      _NetworkUnreachable() => l10n.errorNetworkCheckInternet,
      _Unauthorized() => l10n.errorAuthLoginAgain,
      _WeakPassword(minLength: final len) => l10n.errorPasswordTooShort(len),
      _Unknown() => l10n.errorGenericUnknown,
    };
  }
}
```

### Requirement: UI 层统一错误展示

```dart
// ✅ 正确
try {
  final result = await repository.fetchData();
} on AppFailure catch (failure) {
  logger.e('获取数据失败: $failure');  // 日志（中文，含原始信息）
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(failure.localizedMessage(context)),  // UI（国际化）
    ),
  );
}
```

#### Scenario: 错误三原则
1. **日志 (Log)**: 记录原始堆栈，给开发者看，不需要国际化
2. **定义 (Failure)**: 使用 sealed class 抽象错误类型
3. **映射 (Extension)**: 通过 switch 匹配，输出 `l10n.xxx`

### Requirement: 后端错误码映射

在 Data 层将后端错误码转换为强类型错误。

```dart
Future<Either<Failure, Data>> fetchData() async {
  try {
    final response = await api.getData();
    return Right(response.toModel());
  } on DioException catch (e) {
    final failure = switch (e.response?.data['code']) {
      10401 => const AppFailure.invalidCode(),
      10402 => const AppFailure.userBlocked(),
      _ => AppFailure.unknown(e),
    };
    return Left(failure);
  }
}
```

---

## 文档语言

### Requirement: 代码注释使用中文

```dart
/// 用户服务
/// 
/// 提供用户相关的业务逻辑处理。
class UserService {
  /// 当前登录用户
  User? currentUser;
}
```

### Requirement: 日志输出使用中文

```dart
talker.info('用户登录成功: ${user.name}');
talker.error('网络请求失败: $e');
```

### Requirement: OpenSpec 文档使用中文

- `proposal.md`
- `design.md`
- `specs/**/*.md`
- `tasks.md`

### Requirement: 例外情况

以下情况不强制使用中文：
- 第三方库或生成代码中的注释
- 测试代码中的断言消息
- 技术术语（如 API、HTTP、JSON）
