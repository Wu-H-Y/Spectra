## Context

Spectra 项目目前存在中英文混用的问题：
- 代码注释部分使用中文，部分使用英文
- 日志输出主要使用英文
- UI 文本已通过国际化系统管理，但缺乏硬编码禁止规范
- OpenSpec 文档使用英文

本项目基于 Flutter/Dart 开发，使用 gen_l10n 进行国际化，使用 talker 进行日志记录。

## Goals / Non-Goals

**Goals:**

1. 建立统一的中文文档和注释规范
2. 确保所有日志输出使用中文，便于调试和问题排查
3. 强化 UI 文本国际化规范，禁止硬编码
4. 迁移现有英文注释和日志到中文
5. 所有 OpenSpec 文档使用中文

**Non-Goals:**

1. 不修改第三方库或生成代码中的注释
2. 不修改测试代码中的断言消息（测试消息可保留英文）
3. 不涉及代码逻辑或功能的修改

## Decisions

### D1: 注释语言规范

**决定**: 所有 Dart 源代码中的注释必须使用中文

**格式要求**:
```dart
/// 用户服务
/// 
/// 提供用户相关的业务逻辑处理。
class UserService {
  /// 当前登录用户
  User? currentUser;
  
  /// 获取用户信息
  /// 
  /// [userId] 用户唯一标识
  /// 返回用户信息，如果用户不存在则返回 null
  Future<User?> getUser(String userId) async {
    // 实现逻辑...
  }
}
```

**备选方案**:
- 保持中英文混用 → 拒绝：不一致，维护困难
- 全部使用英文 → 拒绝：不符合团队主要语言习惯

### D2: 日志语言规范

**决定**: 所有日志输出必须使用中文

**格式要求**:
```dart
// 正确 ✓
talker.info('用户登录成功: ${user.name}');
talker.error('网络请求失败: $e');

// 错误 ✗
talker.info('User logged in: ${user.name}');
talker.error('Network request failed: $e');
```

**备选方案**:
- 日志使用英文便于国际协作 → 拒绝：当前团队以中文为主，中文日志更便于调试

### D3: UI 文本国际化强制规范

**决定**: UI 上显示的所有文本必须通过国际化系统访问，禁止硬编码

**格式要求**:
```dart
// 正确 ✓
Text(S.current.loginButton)
Text(AppLocalizations.of(context)!.welcomeMessage)

// 错误 ✗
Text('登录')
Text('Login')
```

**备选方案**:
- 允许中文硬编码（仅中文用户）→ 拒绝：违背国际化原则，不利于未来扩展

### D4: OpenSpec 文档语言

**决定**: 所有 OpenSpec 变更文档必须使用中文

**包括**:
- proposal.md
- design.md
- specs/**/*.md
- tasks.md

### D5: 错误国际化架构

**决定**: 采用「定义 -> 映射 -> 展示」三步架构实现错误国际化

**架构设计**:

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   定义层        │     │   映射层        │     │   展示层        │
│  (Define)       │────▶│   (Map)         │────▶│  (Display)      │
└─────────────────┘     └─────────────────┘     └─────────────────┘
│                       │                       │
▼                       ▼                       ▼
sealed class        Extension on              UI 调用
AppFailure          AppFailure               failure.localizedMessage(context)
```

**核心原则**:
1. **日志看原始堆栈，用户看本地化文案**
2. **后端原始错误信息或代码异常字符串不得直接展示给用户**

**错误类型体系**:
```dart
@freezed
sealed class AppFailure with _$AppFailure {
  // 网络类
  const factory AppFailure.networkUnreachable() = _NetworkUnreachable;
  
  // 业务类
  const factory AppFailure.unauthorized() = _Unauthorized;
  
  // 带参数
  const factory AppFailure.weakPassword({required int minLength}) = _WeakPassword;
  
  // 未知错误（保留原始信息用于日志，不展示给用户）
  const factory AppFailure.unknown(Object? originalError) = _Unknown;
}
```

**映射层实现**:
```dart
extension AppFailureDisplay on AppFailure {
  String localizedMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      _NetworkUnreachable() => l10n.errorNetworkCheckInternet,
      _WeakPassword(minLength: final len) => l10n.errorPasswordTooShort(len),
      _Unknown() => l10n.errorGenericUnknown,
      // ...
    };
  }
}
```

**备选方案**:
- 直接展示后端 message → 拒绝：后端消息通常不是用户友好的，且不支持多语言
- 使用字符串错误码 → 拒绝：类型不安全，容易遗漏错误处理

## Risks / Trade-offs

**R1: 迁移工作量**
- 风险: 现有代码库较大，全面迁移需要大量时间
- 缓解: 分批迁移，优先处理核心模块

**R2: 代码审查负担**
- 风险: 需要在 PR 审查中额外检查注释语言
- 缓解: 可考虑添加 lint 规则进行自动化检查（长期）

**R3: 国际化键名管理**
- 风险: ARB 文件可能变得庞大难以管理
- 缓解: 按功能模块组织键名，使用前缀分组（如 `home_`, `settings_`）
