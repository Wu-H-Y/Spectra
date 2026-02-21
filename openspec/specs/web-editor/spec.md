# Web 规则编辑器规范

## 技术栈

### Requirement: 前端技术

| 技术 | 用途 |
|------|------|
| React 18 + TypeScript | UI框架 |
| Vite | 构建工具 |
| Tailwind CSS | 样式 |
| shadcn/ui | 组件库 |
| Monaco Editor | 代码编辑 |
| Zustand | 状态管理 |
| TanStack Query | API调用 |

#### Scenario: 构建输出
- **WHEN** 执行构建
- **THEN** 产物输出到 `assets/editor/`

---

## 规则管理

### Requirement: CRUD 操作

- 创建新规则（自动生成ID）
- 读取规则列表
- 更新现有规则
- 删除规则
- 复制规则
- 导入/导出 JSON

---

## 编辑功能

### Requirement: 表单编辑

提供表单化规则编辑：

- 规则元数据（名称、类型、版本）
- URL匹配配置
- 请求配置
- 字段映射（含选择器选择）
- 分页配置

#### Scenario: 表单验证
- **WHEN** 提交表单
- **THEN** 验证所有必填字段

---

### Requirement: JSON 编辑

- Monaco Editor 集成
- JSON Schema 验证
- 语法高亮
- 自动补全
- 保存时格式化

---

## 页面预览集成

### Requirement: Flutter WebView 预览

在 Flutter 应用中提供页面预览：

- 加载目标URL
- 支持登录和会话
- 支持滚动和交互

---

### Requirement: 元素选择模式

- 悬停高亮元素
- 点击生成 CSS 选择器
- 生成备选 XPath
- 通过 WebSocket 返回选择器数据

#### Scenario: 元素点击
- **WHEN** 用户点击元素
- **THEN** 返回选择器信息：
```json
{
  "type": "element_selected",
  "data": {
    "selector": ".video-title",
    "selectorType": "css",
    "xpath": "//h1[@class='video-title']",
    "text": "元素文本"
  }
}
```

---

### Requirement: 选择器测试

- 接收选择器并高亮匹配元素
- 显示匹配元素数量
- 支持跨平台（移动端全屏，桌面端面板）

---

## WebSocket 通信

### Requirement: 消息协议

| 消息类型 | 方向 | 说明 |
|----------|------|------|
| preview_open | → Flutter | 打开预览 |
| preview_select_mode | → Flutter | 进入选择模式 |
| preview_highlight | → Flutter | 高亮元素 |
| element_selected | ← Flutter | 元素选择结果 |

---

## 国际化

### Requirement: 多语言支持

支持语言：中文 (zh-CN)、英文 (en-US)

#### Scenario: 语言切换
- **WHEN** 用户切换语言
- **THEN** 所有UI文本更新
