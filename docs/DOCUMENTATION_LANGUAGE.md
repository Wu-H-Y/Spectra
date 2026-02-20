# 文档语言规范

本文档定义了 Spectra 项目中所有形式的文档和注释的语言标准。

## 概述

为了保持项目的一致性和可维护性，项目采用统一的中文文档和注释规范。

## 代码注释

### 规则

所有 Dart 源代码中的注释**必须使用中文**，包括：

- 文件头注释
- 类/枚举/扩展注释
- 方法/函数注释
- 字段/参数注释
- 行内注释

### 示例

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
    // 验证参数
    if (userId.isEmpty) {
      throw ArgumentError('用户ID不能为空');
    }
    
    // 查询用户
    final user = await _repository.findById(userId);
    
    return user;
  }
}
```

## 日志输出

### 规则

所有日志输出**必须使用中文**，包括：

- debug 日志
- info 日志
- warning 日志
- error 日志

### 示例

```dart
// 正确 ✓
talker.debug('开始初始化服务');
talker.info('用户登录成功: ${user.name}');
talker.warning('配置文件不存在，使用默认配置');
talker.error('网络请求失败: $e');

// 错误 ✗
talker.info('User logged in: ${user.name}');
talker.error('Network request failed: $e');
```

## UI 文本

### 规则

UI 上显示的文本**必须通过国际化系统访问**，禁止硬编码。

### 访问方式

```dart
// 方式一：使用 S.current（推荐，简洁）
Text(S.current.loginButton)

// 方式二：使用 AppLocalizations（需要 context）
Text(AppLocalizations.of(context)!.welcomeMessage)
```

### 新增文本流程

1. 在 `lib/l10n/app_zh.arb` 添加中文翻译
2. 在 `lib/l10n/app_en.arb` 添加英文翻译
3. 运行代码生成：`flutter gen-l10n` 或 `dart run build_runner build`
4. 在代码中使用生成的键

### 禁止示例

```dart
// 错误 ✗ - 硬编码中文
Text('登录')

// 错误 ✗ - 硬编码英文
Text('Login')

// 错误 ✗ - 硬编码字符串变量
final buttonText = '登录';
Text(buttonText)
```

## OpenSpec 文档

### 规则

所有 OpenSpec 变更文档**必须使用中文**：

| 文件 | 说明 |
|------|------|
| `proposal.md` | 变更提案 |
| `design.md` | 技术设计 |
| `specs/**/*.md` | 规格文档 |
| `tasks.md` | 任务清单 |

## 项目文档

### 规则

以下文档**必须使用中文**：

- `README.md` - 项目说明
- `CLAUDE.md` - Claude Code 指引
- `CHANGELOG.md` - 变更日志
- `docs/` 目录下的所有文档

## 例外情况

以下情况**不强制使用中文**：

1. **第三方库代码** - 不修改第三方库或生成代码中的注释
2. **测试断言消息** - 测试代码中的断言消息可保留英文或中文
3. **技术术语** - 技术术语可保留英文原文，例如：
   - API、HTTP、JSON、XML
   - Git、Commit、Branch、Merge
   - Flutter、Dart、Riverpod

## 检查清单

提交代码前，请确认：

- [ ] 所有新增注释使用中文
- [ ] 所有日志输出使用中文
- [ ] UI 文本通过国际化系统访问
- [ ] ARB 文件中英文键名一致
- [ ] 文档使用中文编写
