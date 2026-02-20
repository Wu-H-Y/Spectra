## Why

项目代码库中存在中英文注释混用的情况，缺乏统一的文档语言规范。这导致代码可读性不一致，增加了维护成本。建立统一的中文文档规范可以：
1. 提高团队协作效率，所有成员使用同一语言理解代码
2. 降低新成员上手门槛
3. 保持项目文档的一致性和专业性

## What Changes

- **新建文档规范**：建立全面的中文文档和注释规范
- **代码注释标准化**：所有 Dart 代码中的注释必须使用中文
  - 文件头注释
  - 类/枚举/扩展注释
  - 方法/函数注释
  - 字段/参数注释
  - 行内注释
- **日志输出标准化**：所有日志输出必须使用中文
  - debug 日志
  - info 日志
  - warning 日志
  - error 日志
- **UI 文本国际化**：UI 上显示的文本必须使用国际化，禁止硬编码
  - 必须通过 `AppLocalizations.of(context)!.xxx` 或 `S.current.xxx` 访问
  - 新增 UI 文本时必须同时更新 `lib/l10n/app_zh.arb` 和 `lib/l10n/app_en.arb`
- **OpenSpec 文档标准化**：所有变更文档必须使用中文
  - proposal.md
  - design.md
  - specs/**/*.md
  - tasks.md
- **其他文档标准化**：外部文档使用中文
  - CLAUDE.md
  - README.md
  - CHANGELOG.md
  - docs/ 目录下的文档
- **迁移现有代码**：将现有英文注释翻译为中文

## Capabilities

### New Capabilities

- `documentation-language`: 文档、代码注释和日志语言规范，定义所有形式的文档和日志必须使用中文，UI 文本必须国际化
- `error-i18n`: 错误国际化规范，定义错误类型系统、错误到本地化的映射机制，确保用户看到的是友好的本地化错误文案而非原始错误信息

### Modified Capabilities

- `localization`: 扩展现有国际化规范，明确 UI 文本必须通过国际化系统访问，禁止硬编码

## Impact

- **影响范围**：整个代码库的所有 Dart 文件和文档
- **需要修改的目录**：
  - `lib/` - 所有 Dart 源代码（注释、日志、UI 文本）
  - `openspec/changes/` - 变更文档
  - `openspec/specs/` - 规格文档
  - `docs/` - 项目文档
  - 根目录的 `.md` 文件
  - `lib/l10n/app_*.arb` - 国际化资源文件
- **无破坏性变更**：仅修改注释、日志和文档，不影响功能
- **依赖**：无新增依赖
