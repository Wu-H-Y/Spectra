# Implementation Tasks

## Phase 0: Rust FFI 基础设施 (1 周)

### 0.1 项目配置 (flutter_rust_bridge)
- [x] 安装 `flutter_rust_bridge_codegen` CLI
- [x] 添加 `flutter_rust_bridge` Dart 依赖
- [x] 创建 `rust/` 目录结构 (FRB 标准结构)
- [x] 创建 `flutter_rust_bridge.yaml` 配置文件
- [x] 配置 `Cargo.toml` 依赖 (flutter_rust_bridge, jieba-rs, etc.)

### 0.2 FRB 代码生成
- [x] 创建 `rust/src/api/` 目录
- [x] 创建 `rust/src/api/mod.rs` 模块入口
- [x] 创建 `rust/src/api/text_processor.rs` 中文处理 API
- [x] 创建 `rust/src/api/similarity.rs` 相似度计算 API
- [x] 运行 `flutter_rust_bridge_codegen generate` 生成绑定
- [x] 验证生成的 Dart 代码 (`lib/core/rust/`)

### 0.3 中文处理 API (Rust + FRB)
- [x] 实现 `segment(text: String) -> Vec<String>` (jieba-rs 分词)
- [x] 实现 `to_simplified(text: String) -> String` (ferrous-opencc 繁简转换)
- [x] 实现 `to_traditional(text: String) -> String`
- [x] 实现 `number_to_chinese(number: i32) -> String`

### 0.4 相似度算法 API (Rust + FRB)
- [x] 实现 `jaccard(a: String, b: String) -> f64` (基于分词)
- [x] 实现 `levenshtein(a: String, b: String) -> f64`
- [x] 实现 `normalize_title(title: String) -> String` (繁简统一 + 元数据去除)
- [x] 实现 `fuzzy_search_score(query: String, target: String) -> f64`
- [x] 编写 Rust 单元测试
- [x] 编写 Dart 集成测试

---

## Phase 1: Core Models (1-2 周)

### 1.1 Rule Models
- [x] 定义 `CrawlerRule` 新模型 (freezed)
- [x] 定义 `PipelineNode` 模型
- [x] 定义 `NetworkConfig` 模型
- [x] 定义 `AggregationConfig` 模型
- [x] 定义生命周期模型: `ExploreConfig`, `SearchConfig`, `DetailConfig`, `TocConfig`, `ContentConfig`
- [x] 运行 build_runner 生成代码

### 1.2 相似度算法 (✅ 已迁移到 Rust FFI)
- [x] ~~实现 `JaccardSimilarity` 类~~ (已删除，使用 Rust FFI)
- [x] ~~实现 `LevenshteinDistance` 类~~ (已删除，使用 Rust FFI)
- [x] ~~实现 `TitleNormalizer` 类~~ (已删除，使用 Rust FFI)
- [x] 添加 textdistance Rust 依赖
- [x] 实现 `sorensen_dice(a, b)` (词组序列匹配)
- [x] 实现 `levenshtein_tokens(a, b)` (词组编辑距离)
- [x] 更新 `fuzzy_search_score` 算法: `sorensen_dice * 0.4 + levenshtein_tokens * 0.4 + levenshtein * 0.2`
- [x] 清除旧 Dart 实现
- [x] 清除旧测试文件

---

## Phase 2: Pipeline Executor (2 周)

### 2.0 Isolate Worker 架构
- [x] 添加 `squadron` 和 `squadron_builder` 依赖
- [x] 创建 `CrawlerService` 服务类 (@SquadronService)
- [x] 创建 `SimilarityService` 服务类 (@SquadronService)
- [x] 运行 build_runner 生成 Worker 和 WorkerPool 代码
- [x] 实现 `CrawlerExecutor` Worker Pool 管理
- [x] 编写 Worker 生命周期测试

### 2.1 Node Parsers
- [x] 实现 `parsePipeline()` 函数
- [x] 实现节点类型识别
- [x] 实现参数解析
- [x] 编写解析器测试

### 2.2 Node Handlers
- [x] 实现 CSS 选择器处理器
- [x] 实现 XPath 选择器处理器
- [x] 实现 JSONPath 处理器
- [x] 实现 Regex 处理器
- [x] 实现 JavaScript 执行器
- [x] 实现提取节点处理器 (@text, @attr, @html)
- [x] 实现变换节点处理器 (@trim, @replace, @url)
- [x] 实现聚合节点处理器 (@first, @join)

### 2.3 Lifecycle Executor
- [x] 实现 `ExploreExecutor`
- [x] 实现 `SearchExecutor`
- [x] 实现 `DetailExecutor`
- [x] 实现 `TocExecutor`
- [x] 实现 `ContentExecutor` (含 sniff 策略)
- [x] 实现变量插值 `{{host}}`, `{{key}}`, `{{page}}`

---

## Phase 3: Network Strategies (2 周)

### 3.1 HTTP Strategy
- [ ] 实现 `HttpStrategy` 类
- [ ] 实现 TLS 指纹配置 (curl-impersonate 集成)
- [ ] 实现请求拦截器
- [ ] 实现失败回退

### 3.2 WebView Abstraction Layer
- [ ] 定义 `WebViewStrategy` 抽象接口
- [ ] 实现 `InAppWebViewStrategy` (flutter_inappwebview)
- [ ] 实现 `OfficialWebViewStrategy` (webview_flutter)
- [ ] 实现策略选择器
- [ ] 实现 HeadlessInAppWebView 封装

### 3.3 WebView Strategies
- [ ] 实现 `WebViewHeadlessStrategy` (桌面端)
- [ ] 实现 `WebViewInteractStrategy`
- [ ] 实现浏览器指纹注入脚本
- [ ] 实现 Cookie 同步
- [ ] 实现请求拦截 (仅 InAppWebView)

### 3.4 Captcha Handling
- [ ] 实现验证码检测
- [ ] 实现 2Captcha 服务集成
- [ ] 实现 CapSolver 服务集成
- [ ] 实现滑块验证码检测

### 3.5 Proxy Support
- [ ] 实现代理配置模型
- [ ] 实现代理轮换
- [ ] 实现失败切换

---

## Phase 4: Source Aggregation (1 周)

### 4.1 Search Query Validation
- [ ] 实现搜索词长度验证 (最小 2 字)
- [ ] 实现搜索词预处理 (繁简统一、空白处理)
- [ ] 实现错误提示国际化

### 4.2 Search Strategy
- [ ] 实现 `ExactSearchStrategy` (全字匹配)
- [ ] 实现 `FuzzySearchStrategy` (分词多次搜索)
- [ ] 实现分词搜索结果合并算法
- [ ] 实现搜索策略自动切换

### 4.3 Source Filtering
- [ ] 实现 `SourceFilter` 模型
- [ ] 实现按媒体类型过滤 (视频/音乐/小说/漫画/图片)
- [ ] 实现按源分组过滤
- [ ] 实现指定源 ID 过滤
- [ ] 实现全部源聚合

### 4.4 Similarity Matching
- [ ] 实现 `SourceMerger` 类 (调用 Rust FFI)
- [ ] 实现多维度匹配 (标题 + 作者)
- [ ] 实现综合相似度计算
- [ ] 实现结果按相似度排序

### 4.5 Chapter Deduplication
- [ ] 实现 `ChapterDeduplicator` 类
- [ ] 实现搜索窗口优化 (±10 章节)
- [ ] 实现章节号回退匹配

### 4.6 Source Router
- [ ] 实现 `SourceRouter` 类
- [ ] 实现权重计算
- [ ] 实现连通率追踪

---

## Phase 5: Visual Rule Editor (3 周)

### 5.1 React Flow Setup
- [ ] 初始化 React Flow 项目结构
- [ ] 实现自定义节点类型
- [ ] 实现节点面板 (NodePalette)
- [ ] 实现拖拽添加节点

### 5.2 Pipeline Serialization
- [ ] 实现 `serializeToPipeline()` 函数
- [ ] 实现 `parseFromPipeline()` 函数
- [ ] 实现实时同步

### 5.3 WebView Preview
- [ ] 实现 `WebViewPanel` 组件
- [ ] 实现 WebSocket 连接
- [ ] 实现元素拾取触发

### 5.4 Output Panel
- [ ] 实现 `ResultPreview` 组件
- [ ] 实现 JSON/Tree 视图切换
- [ ] 实现复制功能

### 5.5 Tab Pages
- [ ] 实现 Metadata 表单
- [ ] 实现 Network 配置表单
- [ ] 实现 Explore/Search 配置
- [ ] 实现 Detail/TOC/Content 配置

---

## Phase 6: Integration & Testing (1 周)

### 6.1 Sample Rules
- [ ] 编写视频网站规则 (Bilibili)
- [ ] 编写小说网站规则 (起点)
- [ ] 编写漫画网站规则
- [ ] 编写音乐网站规则

### 6.2 End-to-End Testing
- [ ] 测试 Pipeline 执行
- [ ] 测试反爬绕过
- [ ] 测试多源聚合
- [ ] 测试可视化编辑器

### 6.3 Documentation
- [ ] 更新 AGENTS.md
- [ ] 编写规则编写指南
- [ ] 编写 API 文档
- [ ] 录制演示视频

---

## Phase 7: Code Cleanup (1 周)

### 7.1 迁移 v2 模型
- [x] 将 `models/v2/` 下的所有文件移动到 `models/`
- [x] 更新所有 import 路径
- [x] 删除 `models/v2/` 目录
- [x] 移除旧模型文件
- [x] 运行 `flutter analyze` 确保无错误

### 7.2 清理旧代码
- [x] 删除旧的 `Transform` 模型 (被 `PipelineNode` 替代)
- [x] 删除旧的 `Selector` 模型 (被新的 Pipeline DSL 替代)
- [x] 删除旧的 `ExtractConfig` 模型
- [x] 删除旧的 `RequestConfig` 模型
- [x] 删除旧的 `PaginationConfig` 模型
- [x] 删除旧的 Dart `JaccardSimilarity` 类 (被 Rust FFI 替代)
- [x] 删除旧的 Dart `LevenshteinDistance` 类 (被 Rust FFI 替代)
- [x] 删除旧的 Dart `TitleNormalizer` 类 (被 Rust FFI 替代)
- [x] 删除旧的 Dart 测试类 (被 Rust FFI 替代)
- [x] 更新 `models/models.dart` 导出

### 7.3 更新执行器
- [x] 更新 `executor/` 使用新的模型
- [x] 删除旧的 `transform_pipeline.dart`
- [x] 删除旧的 `rule_parser.dart`
- [x] 实现 `PipelineExecutor` 使用新模型

### 7.4 验证清理
- [ ] 运行 `flutter analyze --fatal-infos`
- [ ] 运行所有测试
- [ ] 验证功能无回归
- [ ] 更新 AGENTS.md

---

## Dependencies

### Dart/Flutter

| Package | Version | Purpose |
|---------|---------|---------|
| freezed | latest | 不可变模型 |
| freezed_annotation | latest | 模型注解 |
| json_serializable | latest | JSON 序列化 |
| build_runner | latest | 代码生成 |
| relic | ^1.0.0 | HTTP 服务器 (已有) |
| web_socket | any | WebSocket 客户端 (已有) |
| flutter_inappwebview | ^6.2.0-beta.3 | WebView 主力引擎 |
| webview_flutter | ^4.13.1 | WebView 备选引擎 |
| flutter_rust_bridge | ^2.0.0 | Rust FFI 代码生成 |
| squadron | latest | Isolate 并行执行器 |
| squadron_builder | latest | Squadron 代码生成 |

### Rust (flutter_rust_bridge)

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_rust_bridge | 2.x | FRB Rust 运行时 |
| jieba-rs | 0.8.x | 中文分词 + Jaccard 相似度 |
| chinese-number | 0.7.x | 数字转中文 |
| ferrous-opencc | 0.3.x | 繁简体转换 |
| regex | 1.10.x | 标题标准化正则匹配 |

### Dart (flutter_rust_bridge)

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_rust_bridge | 2.x | FRB Dart 运行时 |
| flutter_rust_bridge_codegen | 2.x (CLI) | FRB 代码生成器 |

### Web Editor

| Package | Version | Purpose |
|---------|---------|---------|
| react | 19.x | UI 框架 |
| @xyflow/react | 12.x | 节点流编辑 |
| zustand | 5.x | 状态管理 |
| @tanstack/react-query | 5.x | 数据请求 |
| tailwindcss | 4.x | 样式 |
| @monaco-editor/react | latest | 代码编辑 |

---

## Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| TLS 指纹实现复杂 | 高 | 使用 curl-impersonate / curl_cffi |
| 移动端 WebView 限制 | 中 | 提供后端代理选项 |
| 验证码服务成本 | 低 | 按需启用，默认关闭 |
| React Flow 学习曲线 | 低 | 参考官方示例 |

---

## Notes

- 所有模型必须使用 freezed
- 所有测试必须通过
- 代码必须通过 `flutter analyze --fatal-infos`
- Git hooks 必须全部通过
