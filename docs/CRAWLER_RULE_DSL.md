# 爬虫规则 DSL 文档

## 概述

Spectra 爬虫规则系统使用 JSON 格式的 DSL（领域特定语言）来定义如何从网站提取数据。

## 规则结构

```json
{
  "id": "unique-rule-id",
  "name": "规则名称",
  "description": "规则描述",
  "mediaType": "video",
  "version": "1.0",
  "author": "作者",
  "tags": ["标签1", "标签2"],
  "enabled": true,
  "match": { ... },
  "request": { ... },
  "extract": { ... },
  "beforeActions": [ ... ],
  "afterActions": [ ... ],
  "detection": { ... }
}
```

## 字段说明

### 基础字段

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `id` | string | 是 | 规则唯一标识 |
| `name` | string | 是 | 规则名称 |
| `description` | string | 否 | 规则描述 |
| `mediaType` | enum | 是 | 媒体类型 |
| `version` | string | 否 | 规则版本 |
| `author` | string | 否 | 作者 |
| `tags` | string[] | 否 | 标签列表 |
| `enabled` | boolean | 否 | 是否启用（默认 true） |

### 媒体类型 (mediaType)

- `video` - 视频
- `music` - 音乐
- `novel` - 小说
- `comic` - 漫画
- `image` - 图片
- `audio` - 音频
- `rss` - RSS
- `generic` - 通用

## URL 匹配配置 (match)

```json
{
  "match": {
    "pattern": "example.com/video/\\d+",
    "type": "regex",
    "fullUrl": true,
    "includePatterns": ["*.example.com/*"],
    "excludePatterns": ["*.example.com/admin/*"]
  }
}
```

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `pattern` | string | 是 | URL 匹配模式 |
| `type` | enum | 否 | 模式类型：`regex`（默认）或 `glob` |
| `fullUrl` | boolean | 否 | 是否匹配完整 URL（默认 true） |
| `includePatterns` | string[] | 否 | 额外包含的模式 |
| `excludePatterns` | string[] | 否 | 排除的模式 |

### Glob 模式示例

```
*/video/*         # 匹配任何包含 /video/ 的路径
*.example.com/*   # 匹配 example.com 的任何子域名
```

## 请求配置 (request)

```json
{
  "request": {
    "method": "GET",
    "headers": {
      "User-Agent": "Mozilla/5.0 ...",
      "Referer": "https://example.com"
    },
    "cookies": {
      "session": "xxx"
    },
    "query": {
      "page": "1"
    },
    "timeoutMs": 30000,
    "followRedirects": true,
    "maxRedirects": 5,
    "userAgent": "custom-user-agent",
    "mobileUserAgent": false
  }
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| `method` | string | HTTP 方法（GET/POST） |
| `headers` | object | 请求头 |
| `cookies` | object | Cookie |
| `query` | object | URL 查询参数 |
| `body` | string | 请求体 |
| `timeoutMs` | number | 超时时间（毫秒） |
| `followRedirects` | boolean | 是否跟随重定向 |
| `maxRedirects` | number | 最大重定向次数 |
| `userAgent` | string | 自定义 User-Agent |
| `mobileUserAgent` | boolean | 使用移动端 User-Agent |
| `referer` | string | Referer 头 |

## 选择器 (Selector)

选择器用于定位页面元素。

```json
{
  "type": "css",
  "expression": ".video-title",
  "attribute": "href",
  "fallbacks": [
    { "type": "css", "expression": "h1" }
  ],
  "firstOnly": true
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| `type` | enum | 选择器类型 |
| `expression` | string | 选择器表达式 |
| `attribute` | string | 要提取的属性 |
| `fallbacks` | Selector[] | 备用选择器 |
| `firstOnly` | boolean | 仅提取第一个匹配 |

### 选择器类型

| 类型 | 说明 | 示例 |
|------|------|------|
| `css` | CSS 选择器 | `.title`, `#content`, `div.item > a` |
| `xpath` | XPath 表达式 | `//div[@class="title"]` |
| `regex` | 正则表达式 | `video_id=(\d+)` |
| `jsonpath` | JSONPath | `$.data.items[*]` |
| `js` | JavaScript 表达式 | `__playinfo__.dash.video[0].url` |

## 字段映射 (FieldMapping)

定义如何从页面提取字段值。

```json
{
  "field": "title",
  "selector": {
    "type": "css",
    "expression": "h1.video-title"
  },
  "defaultValue": "未知标题",
  "transforms": [
    { "type": "trim" },
    { "type": "number" }
  ],
  "required": true
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| `field` | string | 字段名 |
| `selector` | Selector | 选择器 |
| `defaultValue` | string | 默认值 |
| `transforms` | Transform[] | 数据转换 |
| `required` | boolean | 是否必填 |

## 数据转换 (Transform)

```json
{
  "type": "regex",
  "params": { "pattern": "\\d+" }
}
```

### 转换类型

| 类型 | 说明 | 参数 |
|------|------|------|
| `trim` | 移除首尾空白 | - |
| `number` | 解析为数字 | - |
| `date` | 解析为日期 | 格式字符串 |
| `url` | 规范化 URL | 基础 URL |
| `regex` | 正则提取/替换 | `{pattern, replacement}` |
| `replace` | 字符串替换 | `{find, replace}` |
| `lowercase` | 转小写 | - |
| `uppercase` | 转大写 | - |
| `substring` | 子字符串 | `{start, end}` |
| `split` | 分割 | 分隔符 |
| `join` | 连接 | 分隔符 |
| `map` | 值映射 | 映射字典 |
| `parseJson` | 解析 JSON | - |
| `formatNumber` | 格式化数字 | - |

## 提取配置 (extract)

### 列表提取 (list)

```json
{
  "extract": {
    "list": {
      "container": {
        "type": "css",
        "expression": ".video-list"
      },
      "items": [
        { "field": "title", "selector": { "type": "css", "expression": ".title" } },
        { "field": "url", "selector": { "type": "css", "expression": "a", "attribute": "href" } }
      ],
      "pagination": {
        "type": "url",
        "urlTemplate": "/page/{page}",
        "maxPages": 10
      }
    }
  }
}
```

### 详情提取 (detail)

```json
{
  "extract": {
    "detail": {
      "urlFromList": {
        "type": "css",
        "expression": "a",
        "attribute": "href"
      },
      "items": [
        { "field": "title", "selector": { "type": "css", "expression": "h1" } },
        { "field": "description", "selector": { "type": "css", "expression": ".desc" } }
      ],
      "chapters": {
        "container": { "type": "css", "expression": ".chapter-list" },
        "items": [
          { "field": "title", "selector": { "type": "css", "expression": "a" } },
          { "field": "url", "selector": { "type": "css", "expression": "a", "attribute": "href" } }
        ],
        "reverseOrder": false
      }
    }
  }
}
```

### 内容提取 (content)

```json
{
  "extract": {
    "content": {
      "video": {
        "playUrl": { "type": "css", "expression": "video source", "attribute": "src" },
        "jsExtract": "__playinfo__"
      },
      "comic": {
        "images": { "type": "css", "expression": ".page img", "attribute": "src" }
      },
      "novel": {
        "content": { "type": "css", "expression": ".chapter-content" }
      },
      "music": {
        "audioUrl": { "type": "jsonpath", "expression": "$.data.url" },
        "lyrics": { "type": "css", "expression": ".lyrics" }
      }
    }
  }
}
```

## 分页配置 (pagination)

### URL 分页

```json
{
  "type": "url",
  "urlTemplate": "/list/page/{page}",
  "maxPages": 10,
  "delayMs": 1000
}
```

### 点击分页

```json
{
  "type": "click",
  "clickSelector": { "type": "css", "expression": ".next-page" },
  "maxPages": 5,
  "delayMs": 1000
}
```

### 无限滚动

```json
{
  "type": "infiniteScroll",
  "scrollContainer": { "type": "css", "expression": ".content" },
  "maxPages": 10,
  "waitAfterLoadMs": 2000
}
```

## 动作序列 (actions)

### 前置动作 (beforeActions)

在提取数据前执行的动作。

### 后置动作 (afterActions)

在提取数据后执行的动作。

### 动作类型

#### 等待 (wait)

```json
{ "type": "wait", "params": { "durationMs": 1000 } }
```

#### 点击 (click)

```json
{ "type": "click", "params": { "selector": ".button", "selectorType": "css" } }
```

#### 滚动 (scroll)

```json
{ "type": "scroll", "params": { "direction": "down", "distance": 500 } }
```

#### 填充 (fill)

```json
{ "type": "fill", "params": { "selector": "input", "value": "搜索内容" } }
```

#### 脚本 (script)

```json
{ "type": "script", "params": { "code": "window.scrollTo(0, document.body.scrollHeight)" } }
```

#### 条件 (condition)

```json
{
  "type": "condition",
  "params": {
    "condition": { "type": "exists", "selector": ".captcha" },
    "thenActions": [
      { "type": "wait", "params": { "durationMs": 5000 } }
    ],
    "elseActions": []
  }
}
```

#### 循环 (loop)

```json
{
  "type": "loop",
  "params": {
    "maxIterations": 10,
    "condition": { "type": "exists", "selector": ".load-more" },
    "actions": [
      { "type": "click", "params": { "selector": ".load-more" } },
      { "type": "wait", "params": { "durationMs": 1000 } }
    ]
  }
}
```

## 检测配置 (detection)

```json
{
  "detection": {
    "captcha": {
      "detectRecaptcha": true,
      "detectHcaptcha": true,
      "detectGeneric": true,
      "solverApiKey": "xxx",
      "solverService": "2captcha"
    },
    "rateLimit": {
      "statusCodes": [429, 503],
      "textPatterns": ["rate limit", "too many requests"],
      "minDelayMs": 1000,
      "maxDelayMs": 5000,
      "exponentialBackoff": true
    },
    "login": {
      "detectLoginPage": true,
      "loginSelectors": ["input[type='password']", ".login-form"],
      "pauseOnLogin": true
    },
    "detectCloudflare": true,
    "autoRetry": true,
    "maxRetries": 3
  }
}
```

## 完整示例

```json
{
  "id": "example-video-rule",
  "name": "示例视频规则",
  "description": "这是一个示例视频采集规则",
  "mediaType": "video",
  "version": "1.0",
  "author": "Spectra",
  "tags": ["视频", "示例"],
  "enabled": true,
  "match": {
    "pattern": "example.com/video/",
    "type": "regex",
    "fullUrl": true
  },
  "request": {
    "method": "GET",
    "headers": {
      "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
    },
    "timeoutMs": 30000
  },
  "extract": {
    "list": {
      "container": { "type": "css", "expression": ".video-list" },
      "items": [
        { "field": "title", "selector": { "type": "css", "expression": ".title" } },
        { "field": "cover", "selector": { "type": "css", "expression": "img", "attribute": "src" } },
        { "field": "url", "selector": { "type": "css", "expression": "a", "attribute": "href" } }
      ],
      "pagination": {
        "type": "url",
        "urlTemplate": "/page/{page}",
        "maxPages": 10
      }
    },
    "detail": {
      "items": [
        { "field": "title", "selector": { "type": "css", "expression": "h1" } },
        { "field": "description", "selector": { "type": "css", "expression": ".desc" } },
        { 
          "field": "playCount", 
          "selector": { "type": "css", "expression": ".views" },
          "transforms": [{ "type": "number" }]
        }
      ]
    },
    "content": {
      "video": {
        "playUrl": { "type": "css", "expression": "video source", "attribute": "src" }
      }
    }
  },
  "detection": {
    "detectCloudflare": true,
    "autoRetry": true,
    "maxRetries": 3
  }
}
```
