# Spec: Lint Staged

增量代码检查能力，只对暂存的文件执行格式化和 lint，自动重新暂存修改后的文件。

## ADDED Requirements

### Requirement: Staged files detection

lint-staged SHALL 只检测暂存区（staged）的文件，不包括未暂存的修改。

#### Scenario: Only staged files are processed
- **WHEN** 开发者修改了 5 个文件但只暂存了 2 个
- **THEN** lint-staged 只处理这 2 个暂存的文件
- **AND** 未暂存的 3 个文件不受影响

#### Scenario: Deleted files are skipped
- **WHEN** 开发者暂存了一个已删除的文件
- **THEN** lint-staged 跳过该文件
- **AND** 不会报错

### Requirement: Dart file processing

lint-staged SHALL 对暂存的 `.dart` 文件执行格式化和分析。

#### Scenario: Dart files are formatted
- **WHEN** 开发者暂存了未格式化的 `.dart` 文件
- **THEN** lint-staged 执行 `dart format --fix`
- **AND** 文件被格式化

#### Scenario: Dart files are analyzed
- **WHEN** 开发者暂存了 `.dart` 文件
- **THEN** lint-staged 执行 `flutter analyze`
- **AND** 如果有分析错误，提交被阻止

#### Scenario: Generated Dart files are excluded
- **WHEN** 开发者暂存了 `.g.dart` 或 `.freezed.dart` 文件
- **THEN** lint-staged 跳过这些文件
- **AND** 不执行格式化和分析

#### Scenario: No Dart files in commit
- **WHEN** 开发者只暂存了非 `.dart` 文件
- **THEN** lint-staged 跳过 Dart 检查
- **AND** 继续处理其他文件类型

### Requirement: Frontend file processing

lint-staged SHALL 对暂存的前端文件执行格式化和 lint。

#### Scenario: TypeScript files are linted
- **WHEN** 开发者暂存了 `.ts` 或 `.tsx` 文件
- **THEN** lint-staged 执行 `oxlint --fix`
- **AND** 执行 `oxfmt` 格式化

#### Scenario: Other frontend files are formatted
- **WHEN** 开发者暂存了 `.json`、`.css`、`.md` 等文件
- **THEN** lint-staged 执行 `oxfmt` 格式化

### Requirement: Auto restaging

lint-staged SHALL 自动重新暂存格式化后的文件。

#### Scenario: Files are automatically restaged
- **WHEN** lint-staged 格式化了暂存的文件
- **THEN** 格式化后的内容自动添加到暂存区
- **AND** 提交包含格式化后的版本

#### Scenario: Multiple files are restaged
- **WHEN** lint-staged 格式化了多个暂存文件
- **THEN** 所有格式化后的文件都被重新暂存

### Requirement: Configuration file structure

`.lintstagedrc.json` SHALL 定义按文件类型分组的命令。

#### Scenario: Configuration format
- **WHEN** 查看 `.lintstagedrc.json` 文件
- **THEN** 包含 `*.dart` 的命令配置
- **AND** 包含 `web-editor/**/*.{ts,tsx}` 的命令配置
- **AND** 包含排除生成文件的规则
