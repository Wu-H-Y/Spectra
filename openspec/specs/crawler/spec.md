# 爬虫系统规范

## 媒体数据模型

### Requirement: 内容模型层级

使用 freezed 定义不可变模型：

```
BaseContent (基础)
├── VideoContent (视频)
├── ComicContent (漫画)
├── NovelContent (小说)
├── MusicContent (音乐)
└── ImageContent (图片)
```

#### Scenario: 模型不可变性
- **WHEN** 内容模型实例创建
- **THEN** 所有字段不可变，使用 freezed 生成

---

### Requirement: BaseContent 共享字段

| 字段 | 类型 | 必需 | 说明 |
|------|------|------|------|
| id | String | ✓ | 唯一标识 |
| title | String | ✓ | 标题 |
| cover | String? | | 封面URL |
| description | String? | | 描述 |
| author | Author? | | 作者信息 |
| tags | List<String>? | | 标签列表 |
| source | ContentSource | ✓ | 来源信息 |

---

### Requirement: 内容来源模型

| 字段 | 类型 | 必需 | 说明 |
|------|------|------|------|
| ruleId | String | ✓ | 爬虫规则ID |
| siteName | String | ✓ | 来源站点 |
| originalUrl | String | ✓ | 原始URL |
| crawledAt | DateTime | ✓ | 采集时间 |

---

### Requirement: 类型特定字段

**VideoContent**: duration, playUrl, qualities, chapters, subtitles, status

**ComicContent**: chapters, readDirection, chapterCount, status

**NovelContent**: chapters, wordCount, chapterCount, status

**MusicContent**: audioUrl, duration, artist, album, lyrics

**ImageContent**: images, isAlbum, resolution

---

## 规则执行引擎

### Requirement: 选择器引擎

支持多种选择器类型：

| 类型 | 用途 | 示例 |
|------|------|------|
| css | CSS选择器 | `.video-title` |
| xpath | XPath表达式 | `//h1[@class='title']` |
| regex | 正则表达式 | `data-id="(\d+)"` |
| jsonpath | JSONPath | `$.data.items[*]` |
| js | JavaScript表达式 | `document.title` |

#### Scenario: 选择器回退
- **WHEN** 主选择器匹配失败
- **THEN** 按顺序尝试备选选择器

---

### Requirement: 数据提取

**列表提取**: 从容器元素提取多个项目

**详情提取**: 跟随链接提取详情页数据

**内容提取**: 提取媒体特定内容（视频URL、章节内容等）

---

### Requirement: 数据转换

支持链式转换：`trim` → `number` → `date` → `url` → `regex` → `replace`

#### Scenario: 转换链
- **WHEN** 配置多个转换
- **THEN** 按配置顺序依次应用

---

### Requirement: 分页处理

| 类型 | 说明 |
|------|------|
| URL分页 | 跟随下一页链接 |
| 点击分页 | 点击"加载更多"按钮 |
| 无限滚动 | 滚动到底部加载 |

#### Scenario: 分页限制
- **WHEN** 配置 maxPages
- **THEN** 达到限制后停止

---

## 反爬处理

### Requirement: 动作序列

| 动作 | 说明 |
|------|------|
| wait | 等待时长或元素 |
| click | 点击元素 |
| scroll | 滚动页面 |
| fill | 填充表单 |
| script | 执行JS |
| condition | 条件分支 |
| loop | 循环执行 |

---

### Requirement: 验证码检测

检测类型：reCAPTCHA、hCaptcha、Cloudflare Turnstile

#### Scenario: 验证码处理
- **WHEN** 检测到验证码
- **THEN** 暂停执行并通知用户

---

### Requirement: 请求控制

**限速检测**: HTTP 429/503 状态码

**请求节流**: 最小间隔 + 随机抖动

**代理支持**: HTTP/HTTPS/SOCKS5，支持轮换

---

### Requirement: 浏览器指纹

可配置：User-Agent、Viewport、Timezone、Language

---

## 执行状态

### Requirement: 状态追踪

- 当前处理的URL
- 已提取项目数
- 遇到的错误
- 进度百分比

#### Scenario: 进度报告
- **WHEN** 执行进行中
- **THEN** 通过回调/流报告进度
