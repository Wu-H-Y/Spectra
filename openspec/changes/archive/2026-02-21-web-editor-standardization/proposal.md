# Web Editor 深度规范化与优化

## Why

当前 web-editor 项目存在以下问题：
1. **国际化实现不规范**：翻译文本内联在 `i18n/index.ts` 中，违反了外部化翻译文件的最佳实践，难以维护和扩展
2. **组件架构未完全遵循 shadcn/ui 最佳实践**：缺乏一致的组合模式、可访问性标准和主题定制能力
3. **缺少 Vercel React 性能优化指南**：未应用服务端组件思维、流式渲染优化等现代 React 最佳实践
4. **技术栈版本更新**：现有 spec 仍引用 React 18，实际已使用 React 19

现在进行深度规范化，可以：
- 提升代码可维护性和团队协作效率
- 确保组件一致性和可访问性

## What Changes

### 国际化重构
- **BREAKING**: 将内联翻译对象迁移到独立 JSON/TS 文件
- 采用 namespace 分组（`common`, `rules`, `preview`, `errors`）
- 添加类型安全的翻译键提示

### 组件架构标准化
- 遵循 shadcn/ui 设计原则：Composition > Configuration
- 所有组件支持 `className` 透传和 `ref` 转发
- 实现一致的变体系统（使用 `cva` - class-variance-authority）
- 确保完整的可访问性（ARIA 属性、键盘导航）

### 性能优化
- 应用 Vercel React 最佳实践：
  - 组件懒加载和代码分割
  - 避免不必要的重渲染（`useMemo`, `useCallback`）
  - 状态下沉，减少 Context 范围
- 优化构建配置（Tree-shaking、Chunk 策略）

### 开发者体验
- 完善组件文档和 Storybook（可选）
- 统一代码风格和 lint 规则

### shadcn 生态集成
- 利用 **shadcn Registry Directory** (131+ 社区注册表) 扩展组件能力：
  - `@plate` - AI 驱动的富文本编辑器
  - `@magicui` / `@motion-primitives` - 高质量动画组件
  - `@prompt-kit` - AI 界面组件
  - `@better-upload` - 文件上传组件
- 配置 `components.json` 支持社区注册表
- 参考 `registry.json` 模式，为项目特定组件建立内部注册表

## Capabilities

### New Capabilities
- `web-editor-i18n-externalization`: 外部化国际化文件系统，支持 JSON/TS 格式，namespace 分组，类型安全
- `web-editor-component-patterns`: 基于 shadcn/ui 的组件开发规范，包括组合模式、变体系统、可访问性要求
- `web-editor-registry-integration`: shadcn 社区注册表集成，利用 131+ 社区组件库扩展能力

### Modified Capabilities
- `web-editor`: 更新技术栈版本（React 18 → 19），增加组件架构和性能优化要求
- `localization`: 增加 web-editor 的国际化文件格式规范（JSON/TS 外部文件）

## Impact

### 代码变更
- `web-editor/src/i18n/`: 重构为多文件结构
- `web-editor/src/components/`: 标准化所有组件
- `web-editor/src/lib/`: 添加工具函数和类型定义

### API/接口变更
- 翻译键结构变化（需要更新所有 `t()` 调用）
- 组件 props 接口标准化

### 依赖变更
- 无新增核心依赖（已有 shadcn、cva、i18next）
- 可能需要 `i18next-http-backend` 用于异步加载翻译
- 可选社区组件依赖（按需引入）：
  - `@plate/ui` - 富文本编辑
  - `@magicui` - 动画效果
  - `@prompt-kit` - AI 界面

### 构建变更
- 更新 Vite 配置以支持代码分割优化
- 添加翻译文件的构建处理

### 风险评估
- **低风险**: 组件标准化为渐进式改进
- **中风险**: 国际化迁移需要更新所有翻译调用点
- **缓解措施**: 提供迁移脚本，保留向后兼容过渡期
