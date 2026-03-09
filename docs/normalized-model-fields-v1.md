# NormalizedModel 字段参考 v1

本文对应 `rust/src/rules_ir/normalized_model.rs`，用于说明固定模板输出 `NormalizedModel` 的顶层阶段字段与各阶段重要子字段。规则作者在编写 `mapToModel`、声明 `normalizedOutputs`、调试 `payloadPreview` 时，应以本文字段名为准。

## 1. 顶层结构

`NormalizedModel` 当前顶层字段如下：

- `search?: SearchModel`
- `detail?: DetailModel`
- `toc?: TocModel`
- `content?: ContentModel`
- `media?: MediaExtension`

顶层对象允许只填某一个阶段，也允许在同一对象中同时包含多个阶段。

## 2. Search 阶段

### 2.1 `SearchModel`

- `items: SearchItem[]`

### 2.2 `SearchItem`

- `title: string`
- `url: string`
- `cover?: string`
- `author?: string`

说明：

- `items` 默认可为空数组。
- `url` 在 Rust 结构中是字符串，但语义上应为可访问链接。

示例：

```json
{
  "search": {
    "items": [
      {
        "title": "示例标题",
        "url": "https://example.com/detail/1",
        "cover": "https://example.com/cover.jpg",
        "author": "作者甲"
      }
    ]
  }
}
```

## 3. Detail 阶段

### 3.1 `DetailModel`

- `title: string`
- `cover?: string`
- `author?: string`
- `description?: string`
- `tags: string[]`

说明：

- `tags` 默认可为空数组。
- `title` 是详情阶段最核心字段，通常由 `mapToModel target=detail` 强制要求。

示例：

```json
{
  "detail": {
    "title": "详情标题",
    "cover": "https://example.com/detail.jpg",
    "author": "作者乙",
    "description": "详情简介",
    "tags": ["连载", "热门"]
  }
}
```

## 4. Toc 阶段

### 4.1 `TocModel`

- `chapters: ChapterItem[]`

### 4.2 `ChapterItem`

- `title: string`
- `url?: string`

说明：

- `chapters` 默认可为空数组。
- `url` 为可选，适合已抓到标题但尚未补齐跳转地址的场景。

示例：

```json
{
  "toc": {
    "chapters": [
      {
        "title": "第一章",
        "url": "https://example.com/chapter/1"
      }
    ]
  }
}
```

## 5. Content 阶段

### 5.1 `ContentModel`

- `contentTextHtml?: string`
- `contentTextPlain?: string`
- `mediaAssets: MediaAsset[]`

当前代码中，`mapToModel target=content` 会兼容以下输入字段别名：

- `contentTextHtml` 或 `content_text_html`
- `contentTextPlain` 或 `content_text_plain`
- `mediaAssets` 或 `media_assets`

### 5.2 `MediaAsset`

- `mediaType: MediaType`
- `url: string`
- `title?: string`
- `cover?: string`

### 5.3 `MediaType`

- `video`
- `music`
- `novel`
- `comic`
- `image`

说明：

- `mediaAssets` 默认可为空数组。
- `contentTextHtml` 与 `contentTextPlain` 都是可选，允许只提供其中一种。

示例：

```json
{
  "content": {
    "contentTextHtml": "<p>正文</p>",
    "contentTextPlain": "正文",
    "mediaAssets": [
      {
        "mediaType": "video",
        "url": "https://example.com/video.mp4",
        "title": "正片",
        "cover": "https://example.com/video-cover.jpg"
      }
    ]
  }
}
```

## 6. Media 扩展阶段

### 6.1 `MediaExtension`

- `video?: MediaSpec`
- `music?: MediaSpec`
- `novel?: MediaSpec`
- `comic?: MediaSpec`
- `image?: MediaSpec`

### 6.2 `MediaSpec`

- `extra: Record<string, string>`

说明：

- `media` 不是基础四个抓取阶段之一，而是附加扩展信息容器。
- `extra` 适合放附加规格字段，例如分辨率、码率、页数、格式等。

示例：

```json
{
  "media": {
    "video": {
      "extra": {
        "resolution": "1080p"
      }
    }
  }
}
```

## 7. 与 IR 和调试协议的关系

- 端口类型声明中，`DataType.type = "normalizedModel"` 表示该端口承载 `NormalizedModel`。
- `RuleEnvelope.normalizedOutputs` 中的目标端口，通常应输出 `NormalizedModel`。
- WebSocket `port_emit.payloadPreview` 中若看到 `search`、`detail`、`toc`、`content`、`media` 顶层字段，可直接按本文件对照解析。
- 在 `MapToModel` 节点调试时，建议同时关注事件里的 `nodeId`、`seq` 与输出端口名。

## 8. 关联文档

- `docs/rules-ir-v1.md`
- `docs/rules-node-library-v1.md`
- `docs/ws-protocol-v1.md`
