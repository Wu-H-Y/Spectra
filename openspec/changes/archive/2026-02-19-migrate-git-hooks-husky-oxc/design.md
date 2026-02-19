# Design: Migrate Git Hooks to Husky + OXC

## Context

### 当前状态

```
spectra/
├── git_hooks.dart              # Dart 实现的 git hooks
├── pubspec.yaml                # 包含 git_hooks 依赖
└── web-editor/
    ├── eslint.config.js        # ESLint 配置
    └── package.json            # 前端依赖
```

**现有流程**:
```
git commit
    │
    ▼
┌─────────────────┐
│ git_hooks.dart  │
│  ├─ preCommit() │──▶ flutter analyze (全量)
│  └─ commitMsg() │──▶ Conventional Commits 验证
└─────────────────┘
```

**问题**:
1. 无增量检查，每次都运行全量 `flutter analyze`
2. 无自动格式化和重新暂存
3. 前端项目 (web-editor) 完全独立，无统一管理

### 约束

- 项目使用 **Bun** 作为 Node.js 包管理器
- 保持与现有 Conventional Commits 规范的兼容性
- 不影响 CI/CD 流程 (GitHub Actions)

### 利益相关者

- 开发者: 需要安装 Bun/Node.js 环境
- CI 系统: 需要更新 CI 配置以安装新依赖

## Goals / Non-Goals

**Goals:**
1. 实现增量代码检查，只处理暂存的文件
2. 自动格式化代码并重新暂存
3. 统一管理 Flutter 和 React 项目的代码质量检查
4. 将前端从 ESLint + Prettier 迁移到 OXC (oxlint + oxfmt)
5. 保持 Conventional Commits 验证

**Non-Goals:**
1. 不修改 CI/CD 流程中的检查逻辑
2. 不添加新的 lint 规则（保持与现有规则一致）
3. 不处理 pre-push 钩子（保持简洁）

## Decisions

### Decision 1: 使用 Husky 管理钩子

**选择**: Husky v9

**备选方案**:
| 方案 | 优点 | 缺点 |
|------|------|------|
| Husky | 生态成熟，与 lint-staged 完美集成，社区支持广泛 | 需要 Node.js |
| Lefthook | Go 原生，性能更好 | Bun 生态支持较弱 |
| simple-git-hooks | 轻量 | 功能较少 |

**理由**:
- Husky 是 JavaScript 生态的标准选择
- 与 lint-staged、commitlint 无缝集成
- Bun 完全支持 npm 包

### Decision 2: 使用 lint-staged 实现增量检查

**选择**: lint-staged v15

**理由**:
- 只处理暂存的文件，大幅提升性能
- 自动重新暂存格式化后的文件
- 支持按文件类型配置不同命令

### Decision 3: 前端使用 OXC 替代 ESLint + Prettier

**选择**: oxlint + oxfmt

**备选方案**:
| 方案 | 性能 | 兼容性 | 成熟度 |
|------|------|--------|--------|
| OXC | 50-100x ESLint | 95% Prettier | Alpha/Beta |
| Biome | 30x ESLint | 90% Prettier | Stable |
| ESLint + Prettier | 基准 | 100% | Stable |

**理由**:
- OXC 是当前性能最优的选择
- oxlint 有 677+ 内置规则，覆盖大部分 ESLint 规则
- oxfmt 与 Prettier 高度兼容
- 内置 import 排序、Tailwind CSS 类排序等功能

**风险**: oxfmt 仍在 Alpha 阶段，可能有格式化差异

### Decision 4: 配置文件结构

```
spectra/
├── package.json              # 根目录: husky, lint-staged, commitlint
├── .husky/
│   ├── pre-commit           # 调用 lint-staged
│   └── commit-msg           # 调用 commitlint
├── .lintstagedrc.json       # lint-staged 配置
├── commitlint.config.js     # 提交信息验证
└── web-editor/
    ├── .oxlintrc.json       # oxlint 配置
    └── .oxfmtrc.json        # oxfmt 配置
```

**理由**:
- 根目录统一管理所有钩子
- 前端配置独立，便于单独调整
- 使用 JSON 配置文件，支持 `$schema` 自动补全

### Decision 5: Dart 检查命令

**选择**: 使用原生命令组合

```bash
# 格式化
dart format --fix <files>

# 修复
dart fix --apply <files>

# 分析
flutter analyze <files>
```

**注意**: `dart fix --apply` 不支持文件列表参数，需运行在项目根目录

**最终 Dart 检查流程**:
```bash
# 只做格式化和分析
dart format --fix <files> && flutter analyze
```

## Risks / Trade-offs

### Risk 1: 开发者需要安装 Bun/Node.js

**风险**: 部分 Dart/Flutter 开发者可能没有 Node.js 环境

**缓解措施**:
- 在 README.md 中明确说明环境要求
- 提供 `bun install` 的详细安装指南
- macOS/Linux 可使用 Homebrew: `brew install bun`
- Windows 可使用 Scoop: `scoop install bun`

### Risk 2: oxfmt 仍在 Alpha 阶段

**风险**: 格式化结果可能与 Prettier 有细微差异

**缓解措施**:
- 首次运行时对比格式化差异
- 如遇问题，可临时降级到 Prettier
- 关注 OXC 发布更新

### Risk 3: 迁移期间的兼容性

**风险**: 迁移过程中可能导致部分开发者无法提交

**缓解措施**:
- 分阶段迁移：
  1. 先添加 Husky + lint-staged（保留 git_hooks）
  2. 测试通过后移除 git_hooks
  3. 最后迁移前端到 OXC
- 提供回滚指南

### Risk 4: CI 环境变化

**风险**: CI 需要安装 Node.js/Bun 依赖

**缓解措施**:
- GitHub Actions 已支持 Node.js，只需添加 `bun install` 步骤
- CI 中的检查仍使用完整命令（非 lint-staged）

## Migration Plan

### Phase 1: 准备阶段

1. 创建根目录 `package.json`
2. 安装依赖：`bun add -D husky lint-staged @commitlint/cli @commitlint/config-conventional`
3. 初始化 Husky：`bun run prepare`
4. 创建配置文件

### Phase 2: 测试 Husky

1. 保留现有 `git_hooks.dart`
2. 新增 Husky 钩子（并行运行）
3. 验证两个系统都能正常工作
4. 确认无问题后禁用 `git_hooks.dart`

### Phase 3: 前端迁移

1. 安装 OXC：`cd web-editor && bun add -D oxlint oxfmt`
2. 创建 `.oxlintrc.json` 和 `.oxfmtrc.json`
3. 运行 `oxlint` 检查现有代码
4. 修复 lint 问题
5. 运行 `oxfmt --check` 检查格式
6. 格式化代码：`oxfmt`
7. 移除 ESLint 相关依赖

### Phase 4: 清理

1. 移除 `git_hooks.dart`
2. 移除 `pubspec.yaml` 中的 `git_hooks` 依赖
3. 更新 `README.md` 开发指南
4. 更新 `.gitignore`

### Rollback Plan

如需回滚：

```bash
# 1. 恢复 git_hooks
git checkout HEAD -- git_hooks.dart pubspec.yaml
flutter pub get

# 2. 重新创建钩子
dart run git_hooks create git_hooks.dart

# 3. 移除 Husky
rm -rf .husky package.json bun.lock
cd web-editor && git checkout HEAD -- package.json eslint.config.js
```

## Open Questions

1. **是否需要 pre-push 钩子？**
   - 当前设计不包含 pre-push
   - 如果需要运行测试，可在 CI 中进行
   - 建议：暂不添加，保持提交速度快

2. **oxlint 是否需要启用更多规则类别？**
   - 默认启用 `correctness`
   - 可考虑启用 `suspicious` 或 `pedantic`
   - 建议：先使用默认配置，后续根据需要调整

3. **是否需要 import 排序？**
   - oxfmt 内置支持 `experimentalSortImports`
   - 建议：启用此功能，保持代码整洁
