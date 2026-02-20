## 1. 规范文档更新

- [x] 1.1 更新 CLAUDE.md，添加中文文档和注释规范说明
- [x] 1.2 在 docs/ 目录创建或更新文档规范文件

## 2. 核心模块注释迁移 (lib/core/)

- [x] 2.1 迁移 lib/core/constants/ 目录的代码注释为中文
- [x] 2.2 迁移 lib/core/database/ 目录的代码注释为中文
- [x] 2.3 迁移 lib/core/router/ 目录的代码注释为中文
- [x] 2.4 迁移 lib/core/theme/ 目录的代码注释为中文
- [x] 2.5 迁移 lib/core/crawler/ 目录的代码注释为中文
- [x] 2.6 迁移 lib/core/utils/ 目录的代码注释为中文
- [x] 2.7 运行 `flutter analyze` 确保核心模块无问题

## 3. 功能模块注释迁移 (lib/features/)

- [x] 3.1 迁移 lib/features/ 下所有功能模块的代码注释为中文
- [x] 3.2 运行 `flutter analyze` 确保功能模块无问题

## 4. 共享模块注释迁移 (lib/shared/)

- [x] 4.1 迁移 lib/shared/providers/ 目录的代码注释为中文
- [x] 4.2 迁移 lib/shared/widgets/ 目录的代码注释为中文
- [x] 4.3 运行 `flutter analyze` 确保共享模块无问题

## 5. 根目录和入口文件注释迁移

- [x] 5.1 迁移 lib/main.dart 的代码注释为中文
- [x] 5.2 迁移 lib/app.dart 的代码注释为中文
- [x] 5.3 迁移 lib/l10n/ 相关文件的代码注释为中文

## 6. 日志输出中文化

- [x] 6.1 检索并迁移 lib/core/ 目录下的日志输出为中文
- [x] 6.2 检索并迁移 lib/features/ 目录下的日志输出为中文
- [x] 6.3 检索并迁移 lib/shared/ 目录下的日志输出为中文
- [x] 6.4 运行 `flutter analyze` 确保日志迁移后无问题

## 7. UI 文本硬编码检查与修复

- [x] 7.1 扫描代码库中 UI 硬编码文本（Text 组件中的字符串字面量）
- [x] 7.2 将硬编码文本迁移到国际化系统（更新 ARB 文件）
- [x] 7.3 修复代码中的硬编码文本引用
- [x] 7.4 运行 `flutter analyze` 确保 UI 文本迁移后无问题

## 8. 错误国际化架构实现

- [x] 8.1 在 `lib/core/errors/` 创建 `AppFailure` 强类型错误定义（使用 freezed）
- [x] 8.2 为 `AppFailure` 添加 `freezed` 注解并运行 `build_runner` 生成代码
- [x] 8.3 创建 `AppFailureDisplay` 扩展方法，实现错误到本地化的映射
- [x] 8.4 在 ARB 文件中添加错误相关的本地化字符串（`error_*` 前缀）
- [x] 8.5 创建 `ExceptionMapper` 工具类，将异常映射为 `AppFailure`
- [x] 8.6 创建错误国际化使用文档（架构已就绪，供未来开发使用）
- [x] 8.7 确保日志记录保留原始错误信息（给开发者），用户界面展示本地化文案
- [x] 8.8 运行 `flutter analyze` 确保错误国际化实现后无问题

## 9. 项目文档中文化

- [x] 9.1 确保 README.md 使用中文
- [x] 9.2 确保 docs/ 目录下所有文档使用中文
- [x] 9.3 更新 CHANGELOG.md（如需要）

## 10. 最终验证

- [x] 10.1 运行 `flutter analyze` 确保整个项目无静态分析问题
- [x] 10.2 运行 `dart format .` 格式化代码
- [x] 10.3 确认所有 ARB 文件键名一致
- [x] 10.4 验证错误国际化流程：架构已就绪，开发者可在新代码中使用
