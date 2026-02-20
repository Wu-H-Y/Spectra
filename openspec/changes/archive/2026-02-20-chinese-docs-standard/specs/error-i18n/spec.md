# Error Internationalization Specification

## Overview

本规范定义了错误国际化的最佳实践，核心原则是**永远不要把后端的原始错误信息或代码里的异常字符串直接展示给用户**。日志看原始堆栈，用户看本地化文案。

实现错误国际化分为三个步骤：**定义（Define） -> 映射（Map） -> 展示（Display）**。

---

## ADDED Requirements

### Requirement: 强类型错误定义

系统必须使用强类型对象定义业务层面的错误，禁止在代码中直接使用 `String` 类型的错误。

#### Scenario: 使用 sealed class 定义错误

- **WHEN** 定义应用级错误类型
- **THEN** 必须使用 `sealed class` 或 `freezed` 创建强类型错误对象
- **AND** 必须覆盖所有业务场景的错误类型

#### Scenario: 网络类错误定义

- **WHEN** 定义网络相关错误
- **THEN** 应定义如 `networkUnreachable`、`connectionTimeout`、`serverError` 等具体类型

#### Scenario: 业务类错误定义

- **WHEN** 定义业务逻辑错误
- **THEN** 应定义如 `unauthorized`、`forbidden`、`notFound`、`invalidInput` 等具体类型

#### Scenario: 带参数的错误定义

- **WHEN** 错误需要携带上下文信息
- **THEN** 错误类型应支持参数（如 `weakPassword(minLength: 8)`）

#### Scenario: 未知错误保留原始信息

- **WHEN** 发生无法分类的错误
- **THEN** 应保留原始错误用于日志记录
- **BUT** 原始错误信息不得直接展示给用户

**示例:**

```dart
// domain/failures.dart
@freezed
sealed class AppFailure with _$AppFailure {
  // 网络类错误
  const factory AppFailure.networkUnreachable() = _NetworkUnreachable;
  
  // 业务类错误
  const factory AppFailure.unauthorized() = _Unauthorized;
  
  // 带参数的错误
  const factory AppFailure.weakPassword({required int minLength}) = _WeakPassword;
  
  // 未知错误（原始错误用于日志，不展示给用户）
  const factory AppFailure.unknown(Object? originalError) = _Unknown;
}
```

---

### Requirement: 错误到本地化的映射层

系统必须建立一个映射层，将强类型错误转换为本地化的用户友好文案。

#### Scenario: 扩展方法实现映射

- **WHEN** 需要将错误转换为用户可见的文案
- **THEN** 应使用扩展方法（Extension）实现错误到本地化的映射
- **AND** 必须使用 `switch` 表达式进行模式匹配，确保所有错误类型都被处理

#### Scenario: 网络错误映射

- **WHEN** 发生网络错误
- **THEN** 应映射为对应的本地化文案（如 `errorNetworkCheckInternet`）

#### Scenario: 带参数错误映射

- **WHEN** 映射带参数的错误
- **THEN** 应将参数传递给本地化字符串（如 `errorPasswordTooShort(len)`）

#### Scenario: 未知错误映射

- **WHEN** 映射未知错误
- **THEN** 应返回通用的友好文案（如 `errorGenericUnknown`）
- **AND** 不得将原始错误信息展示给用户

**示例:**

```dart
// extensions/failure_display_extension.dart
extension AppFailureDisplay on AppFailure {
  String localizedMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return switch (this) {
      _NetworkUnreachable() => l10n.errorNetworkCheckInternet,
      _Unauthorized()       => l10n.errorAuthLoginAgain,
      _WeakPassword(minLength: final len) => l10n.errorPasswordTooShort(len),
      _Unknown()            => l10n.errorGenericUnknown,
    };
  }
}
```

---

### Requirement: UI 层统一错误展示

UI 层必须统一调用错误映射方法，禁止直接展示后端返回的原始错误信息。

#### Scenario: 展示错误给用户

- **WHEN** 需要在 UI 上展示错误
- **THEN** 必须调用 `failure.localizedMessage(context)` 获取本地化文案
- **AND** 不得直接使用 `e.toString()` 或后端返回的 `message` 字段

#### Scenario: 错误日志记录

- **WHEN** 发生错误
- **THEN** 必须使用日志系统记录原始错误信息（给开发者看）
- **AND** 日志使用中文，可包含原始异常堆栈

#### Scenario: 对话框错误展示

- **WHEN** 使用对话框展示错误
- **THEN** 标题和内容都必须通过映射方法获取本地化文案

**示例:**

```dart
// 正确做法
try {
  final result = await repository.fetchData();
} on AppFailure catch (failure) {
  // 1. 日志记录（给开发者）
  logger.e('获取数据失败: $failure');
  
  // 2. 展示给用户（国际化）
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(failure.localizedTitle(context)),
      content: Text(failure.localizedMessage(context)),
    ),
  );
}
```

---

### Requirement: 后端错误码映射

当后端返回错误码时，必须在 Data 层将错误码转换为前端的强类型错误。

#### Scenario: HTTP 错误响应处理

- **WHEN** 后端返回非成功响应
- **THEN** 必须在 Repository 层将错误码映射为 `AppFailure` 类型
- **AND** 禁止将后端 `message` 直接传递给 UI 层

#### Scenario: 已知错误码映射

- **WHEN** 后端返回已知错误码（如 `10401`）
- **THEN** 必须映射为对应的 `AppFailure` 类型（如 `AppFailure.invalidCode()`）

#### Scenario: 未知错误码处理

- **WHEN** 后端返回未知错误码
- **THEN** 应映射为 `AppFailure.unknown()`
- **AND** 保留原始响应信息用于调试

**示例:**

```dart
// repository.dart
Future<Result<Data, AppFailure>> fetchData() async {
  try {
    final response = await api.getData();
    return Right(response.toModel());
  } on DioException catch (e) {
    final code = e.response?.data['code'];
    
    final failure = switch (code) {
      10401 => const AppFailure.invalidCode(),
      10402 => const AppFailure.userBlocked(),
      _     => AppFailure.unknown(e),
    };
    
    return Left(failure);
  }
}
```

---

### Requirement: 例外情况 - 后端已国际化的消息

仅当后端已根据 `Accept-Language` 返回对应语言的文案时，才允许直接展示后端消息。

#### Scenario: 后端国际化消息

- **WHEN** 后端已经根据请求头返回了对应语言的文案
- **THEN** 可以定义 `AppFailure.serverSideMessage(String message)` 类型
- **AND** 在映射时直接返回该字符串

#### Scenario: 后端未国际化

- **WHEN** 后端仅返回英文或固定语言的消息
- **THEN** 禁止直接展示后端消息
- **AND** 必须使用错误码映射为本地化文案

---

### Requirement: 国际化库推荐

项目应使用类型安全的国际化库，确保错误码有代码补全和编译时检查。

#### Scenario: 使用 slang 库

- **WHEN** 项目需要更灵活的国际化方案
- **THEN** 推荐使用 `slang` 库
- **AND** 可在 Widget 树外获取翻译（适合 Bloc/ViewModel）

#### Scenario: 使用官方 gen_l10n

- **WHEN** 项目使用 Flutter 官方国际化方案
- **THEN** 必须通过 `AppLocalizations.of(context)!.xxx` 访问翻译
- **AND** 配合 VSCode 插件实现代码补全

---

## Summary: 错误处理三原则

1. **日志 (Log)**: 记录 `e.toString()` 或 `stackTrace`，给开发者看，不需要国际化
2. **定义 (Failure)**: 使用 `sealed class` 将错误抽象为类型（如 `NetworkError`, `WeakPassword`）
3. **映射 (Extension)**: 写一个 `extension`，输入是 `Failure`，通过 `switch` 匹配，输出是 `l10n.xxx`
4. **展示 (UI)**: 界面只负责调用 `failure.localizedMessage(context)`
