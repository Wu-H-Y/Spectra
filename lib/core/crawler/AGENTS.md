# Crawler 爬虫规则引擎

基于规则的内容提取爬虫模块，支持多种选择器类型和灵活的数据提取。

## STRUCTURE

```
crawler/
├── crawler.dart           # 模块入口 (barrel export)
├── executor/              # 规则执行器
│   ├── executor.dart      # 执行器入口
│   ├── execution_state.dart   # 执行状态模型
│   ├── extractors.dart    # 数据提取逻辑
│   ├── pagination_handler.dart  # 分页处理
│   ├── rule_parser.dart   # 规则解析
│   ├── transform_pipeline.dart  # 数据转换管道
│   └── anti_crawl.dart    # 反爬处理
├── models/                # 规则模型 (freezed + json_serializable)
│   ├── models.dart        # 模型入口
│   ├── crawler_rule.dart  # 核心规则定义
│   ├── selector.dart      # 选择器配置
│   ├── selector_type.dart # 选择器类型枚举
│   ├── field_mapping.dart # 字段映射
│   ├── extract_config.dart # 提取配置
│   ├── request_config.dart # 请求配置
│   ├── pagination_config.dart # 分页配置
│   ├── action.dart        # 动作定义
│   ├── detection_config.dart # 检测配置
│   ├── match_config.dart  # 匹配配置
│   └── transform.dart     # 数据转换
└── selector/              # 选择器引擎
    ├── selector.dart      # 选择器入口
    ├── selector_engine.dart # 主引擎 (支持回退)
    ├── css_selector.dart  # CSS 选择器
    ├── xpath_selector.dart # XPath 选择器
    ├── jsonpath_selector.dart # JSONPath 选择器
    ├── regex_selector.dart # 正则选择器
    └── js_selector.dart   # JavaScript 选择器
```

## WHERE TO LOOK

| Task | Location |
|------|----------|
| 添加新的选择器类型 | `selector/` + `models/selector_type.dart` |
| 修改规则执行逻辑 | `executor/executor.dart`, `executor/extractors.dart` |
| 添加数据转换 | `executor/transform_pipeline.dart`, `models/transform.dart` |
| 处理分页 | `executor/pagination_handler.dart`, `models/pagination_config.dart` |
| 反爬处理 | `executor/anti_crawl.dart` |

## SELECTOR TYPES

| 类型 | 用途 | 示例 |
|------|------|------|
| `css` | HTML 元素选择 | `.title`, `div.content > p` |
| `xpath` | XML/HTML 路径 | `//div[@class="title"]/text()` |
| `jsonpath` | JSON 数据 | `$.data.items[*].name` |
| `regex` | 正则匹配 | `data-id="(\d+)"` |
| `js` | JavaScript 执行 | `document.title` |

## KEY CONCEPTS

### Selector Fallback

选择器支持回退机制，主选择器失败时自动尝试备选：

```dart
Selector(
  type: SelectorType.css,
  expression: '.title',
  fallbacks: [
    Selector(type: SelectorType.xpath, expression: '//h1'),
    Selector(type: SelectorType.regex, expression: r'<title>(.*?)</title>'),
  ],
)
```

### Transform Pipeline

数据转换管道支持链式处理：

```dart
Transform(
  type: TransformType.replace,
  args: {'pattern': '\\s+', 'replacement': ' '},
)
```

### Execution Flow

```
CrawlerRule
  → RequestConfig (HTTP 请求)
  → ExtractConfig (选择器提取)
  → TransformPipeline (数据转换)
  → FieldMapping (字段映射)
  → PaginationConfig (分页处理)
```

## ANTI-PATTERNS

| 禁止 | 替代方案 |
|------|---------|
| 直接解析 HTML 字符串 | 使用 `SelectorEngine.evaluate()` |
| 硬编码选择器表达式 | 通过 `CrawlerRule` 配置 |
| 在选择器中处理异常 | 让 `SelectorException` 向上传播 |
