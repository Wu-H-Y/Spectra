# web-editor Registry 集成规范

## components.json 配置

### Requirement: 配置文件

项目根目录必须包含 `components.json` 配置文件。

```json
{
  "$schema": "https://ui.shadcn.com/schema/components.json",
  "style": "new-york",
  "rsc": false,
  "tsx": true,
  "tailwind": {
    "config": "tailwind.config.ts",
    "css": "src/index.css",
    "baseColor": "slate",
    "cssVariables": true
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils",
    "ui": "@/components/ui"
  }
}
```

#### Scenario: CLI 识别
- **WHEN** 运行 `npx shadcn add button`
- **THEN** CLI 根据 components.json 确定安装位置

---

### Requirement: 社区 Registry 配置

在 `components.json` 中注册社区 registry。

```json
{
  "registries": {
    "plate": "https://platejs.org/r",
    "magicui": "https://magicui.design/r"
  }
}
```

#### Scenario: 社区组件安装
- **WHEN** 运行 `npx shadcn add @magicui/animated-beam`
- **THEN** 从注册的 magicui registry 下载组件

---

## 社区组件使用

### Requirement: 组件来源验证

仅使用官方或高星社区 registry。

#### Scenario: 安全安装
- **WHEN** 安装社区组件
- **THEN** 检查 registry 的 stars 和维护状态

---

### Requirement: 依赖兼容性

安装前检查组件与 Tailwind CSS v4 的兼容性。

#### Scenario: 版本检查
- **WHEN** 安装需要 Tailwind v3 的组件
- **THEN** 警告版本不兼容

---

### Requirement: 代码审查

社区组件代码必须在安装后进行审查。

#### Scenario: 代码检查
- **WHEN** 安装社区组件后
- **THEN** 检查是否存在安全风险或不符合项目规范的代码

---

## 推荐组件

### Requirement: 富文本编辑

需要高级文本编辑功能时，使用 `@plate/ui`。

#### Scenario: JSON 编辑增强
- **WHEN** 需要富文本规则编辑
- **THEN** 安装 `npx shadcn add @plate/ui`

---

### Requirement: 动画效果

需要高质量动画时，使用 `@magicui` 或 `@motion-primitives`。

#### Scenario: 规则流程可视化
- **WHEN** 展示规则处理流程
- **THEN** 使用 `@magicui/animated-beam` 连接动画

---

### Requirement: AI 界面

需要 AI 辅助功能时，使用 `@prompt-kit`。

#### Scenario: AI 助手集成
- **WHEN** 添加规则编写助手
- **THEN** 使用 `@prompt-kit/chat` 组件
