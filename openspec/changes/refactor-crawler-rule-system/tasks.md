# Implementation Tasks

## Phase 0: Rust FFI 基础设施 (已完成)

### 0.1 项目配置 (flutter_rust_bridge)
- [x] 安装 `flutter_rust_bridge_codegen` CLI
- [x] 添加 `flutter_rust_bridge` Dart 依赖
- [x] 创建 `rust/` 目录结构 (FRB 标准结构)
- [x] 创建 `flutter_rust_bridge.yaml` 配置文件
- [x] 配置 `Cargo.toml` 依赖

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

## Phase 1: Core Models (已完成)

### 1.1 Rule Models
- [x] 定义 `CrawlerRule` 新模型 (freezed)
- [x] 定义 `PipelineNode` 模型
- [x] 定义 `NetworkConfig` 模型
- [x] 定义 `AggregationConfig` 模型
- [x] 定义生命周期模型: `ExploreConfig`, `SearchConfig`, `DetailConfig`, `TocConfig`, `ContentConfig`
- [x] 运行 build_runner 生成代码

### 1.2 相似度算法 (已迁移到 Rust FFI)
- [x] 添加 textdistance Rust 依赖
- [x] 实现 `sorensen_dice(a, b)` (词组序列匹配)
- [x] 实现 `levenshtein_tokens(a, b)` (词组编辑距离)
- [x] 更新 `fuzzy_search_score` 算法
- [x] 清除旧 Dart 实现

---

## Phase 2: Pipeline Executor (已完成)

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

## Phase 3: Rust HTTP Client (wreq) (待实施)

### 3.1 wreq 集成
- [ ] 添加 wreq 和 wreq-util Rust 依赖
- [ ] 配置 BoringSSL 编译环境
- [ ] 实现 `BrowserEmulation` 枚举映射
- [ ] 实现 `HttpRequest` 结构体
- [ ] 实现 `HttpResponse` 结构体
- [ ] 编写 wreq 集成测试

### 3.2 HTTP Client API (Rust FFI)
- [ ] 创建 `rust/src/api/http_client.rs`
- [ ] 实现 `fetch(request: HttpRequest) -> HttpResponse`
- [ ] 实现 TLS 指纹配置 (Chrome/Firefox/Safari)
- [ ] 实现代理支持
- [ ] 实现 Cookie 提取
- [ ] 运行 FRB 代码生成

### 3.3 Dart HTTP Strategy
- [ ] 创建 `HttpStrategy` 类 (调用 Rust FFI)
- [ ] 实现请求构建
- [ ] 实现响应处理
- [ ] 实现错误处理
- [ ] 实现回退检测

### 3.4 编译配置
- [ ] 配置 Linux 编译依赖 (cmake, perl, pkg-config)
- [ ] 配置 Windows 编译依赖 (VS Build Tools, NASM)
- [ ] 配置 macOS 编译依赖 (Xcode CLI Tools)
- [ ] 启用 `prefix-symbols` feature (避免符号冲突)

---

## Phase 4: WebView Interactive (待实施)

### 4.1 WebView Abstraction Layer
- [ ] 定义 `WebViewStrategy` 抽象接口
- [ ] 实现 `InAppWebViewStrategy` (flutter_inappwebview)
- [ ] 实现 `OfficialWebViewStrategy` (webview_flutter)
- [ ] 实现策略选择器

### 4.2 WebView Interactive Strategy
- [ ] 实现 `WebViewInteractiveStrategy` 类
- [ ] 实现成功检测逻辑
- [ ] 实现 Cookie 同步
- [ ] 实现超时处理

### 4.3 Session Management
- [ ] 实现 `SessionManager` 类
- [ ] 实现 `CookieStorage` 接口
- [ ] 实现 `AuthStateStorage` 接口
- [ ] 实现 Cookie 在 Rust HTTP 和 WebView 之间的同步

---

## Phase 5: Source Aggregation (待实施)

### 5.1 Search Query Validation
- [ ] 实现搜索词长度验证 (最小 2 字)
- [ ] 实现搜索词预处理 (繁简统一、空白处理)
- [ ] 实现错误提示国际化

### 5.2 Search Strategy
- [ ] 实现 `ExactSearchStrategy` (全字匹配)
- [ ] 实现 `FuzzySearchStrategy` (分词多次搜索)
- [ ] 实现分词搜索结果合并算法
- [ ] 实现搜索策略自动切换

### 5.3 Source Filtering
- [ ] 实现 `SourceFilter` 模型
- [ ] 实现按媒体类型过滤 (视频/音乐/小说/漫画/图片)
- [ ] 实现按源分组过滤
- [ ] 实现指定源 ID 过滤
- [ ] 实现全部源聚合

### 5.4 Similarity Matching
- [ ] 实现 `SourceMerger` 类 (调用 Rust FFI)
- [ ] 实现多维度匹配 (标题 + 作者)
- [ ] 实现综合相似度计算
- [ ] 实现结果按相似度排序

### 5.5 Chapter Deduplication
- [ ] 实现 `ChapterDeduplicator` 类
- [ ] 实现搜索窗口优化 (+-10 章节)
- [ ] 实现章节号回退匹配

### 5.6 Source Router
- [ ] 实现 `SourceRouter` 类
- [ ] 实现权重计算
- [ ] 实现连通率追踪

---

## Phase 6: Visual Rule Editor (待实施)

### 6.1 React Flow Setup
- [ ] 初始化 React Flow 项目结构
- [ ] 实现自定义节点类型
- [ ] 实现节点面板 (NodePalette)
- [ ] 实现拖拽添加节点

### 6.2 Pipeline Serialization
- [ ] 实现 `serializeToPipeline()` 函数
- [ ] 实现 `parseFromPipeline()` 函数
- [ ] 实现实时同步

### 6.3 WebView Preview
- [ ] 实现 `WebViewPanel` 组件
- [ ] 实现 WebSocket 连接
- [ ] 实现元素拾取触发

### 6.4 Output Panel
- [ ] 实现 `ResultPreview` 组件
- [ ] 实现 JSON/Tree 视图切换
- [ ] 实现复制功能

### 6.5 Tab Pages
- [ ] 实现 Metadata 表单
- [ ] 实现 Network 配置表单
- [ ] 实现 Explore/Search 配置
- [ ] 实现 Detail/TOC/Content 配置

---

## Phase 7: Integration & Testing (待实施)

### 7.1 Sample Rules
- [ ] 编写视频网站规则 (Bilibili)
- [ ] 编写小说网站规则 (起点)
- [ ] 编写漫画网站规则
- [ ] 编写音乐网站规则

### 7.2 End-to-End Testing
- [ ] 测试 Pipeline 执行
- [ ] 测试 TLS 指纹伪装
- [ ] 测试多源聚合
- [ ] 测试可视化编辑器

### 7.3 Documentation
- [ ] 更新 AGENTS.md
- [ ] 编写规则编写指南
- [ ] 编写 API 文档

---

## Phase 8: Code Cleanup (待实施)

### 8.1 验证清理
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
| flutter_inappwebview | ^6.2.0-beta.3 | WebView 用户交互 |
| webview_flutter | ^4.13.1 | WebView 备选引擎 |
| flutter_rust_bridge | ^2.11.1 | Rust FFI 代码生成 |
| squadron | latest | Isolate 并行执行器 |
| squadron_builder | latest | Squadron 代码生成 |

### Rust (flutter_rust_bridge)

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_rust_bridge | 2.11.1 | FRB Rust 运行时 |
| wreq | 6.0.0-rc.28 | HTTP 客户端 (TLS/HTTP2 指纹) |
| wreq-util | 3.0.0-rc.10 | 设备模拟配置 |
| jieba-rs | 0.8.x | 中文分词 |
| chinese-number | 0.7.x | 数字转中文 |
| ferrous-opencc | 0.3.x | 繁简体转换 |
| textdistance | 1.1.x | 相似度计算 |
| regex | 1.x | 标题标准化 |

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

## Build Requirements

### Linux

```bash
sudo apt-get install build-essential cmake perl pkg-config libclang-dev musl-tools
```

### Windows

- Visual Studio Build Tools 2022
- CMake
- NASM (choco install nasm -y)

### macOS

- Xcode Command Line Tools
- CMake

### iOS (交叉编译)

```bash
# 添加 iOS 目标
rustup target add aarch64-apple-ios aarch64-apple-ios-sim

# 编译 (需要 Xcode)
cargo build --target aarch64-apple-ios --release
cargo build --target aarch64-apple-ios-sim --release
```

**iOS 注意事项**:
- Debug 模式需要设置 `opt-level = 1` 避免栈溢出
- Xcode 16.4+ 需要更新 bindgen 到最新版本

### 编译命令

```bash
# 启用 prefix-symbols 避免符号冲突
cargo build --release --features prefix-symbols
```

### Cargo.toml 配置

```toml
# 避免 Debug 模式栈溢出 (iOS/Windows)
[profile.dev]
opt-level = 1
```

---

## Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| wreq 编译复杂 | 高 | 参考 wreq CI 配置，提供预编译脚本 |
| BoringSSL 符号冲突 | 中 | 使用 prefix-symbols feature |
| TLS 指纹被检测 | 中 | 定期更新 wreq-util 设备配置 |
| React Flow 学习曲线 | 低 | 参考官方示例 |

---

## Notes

- 所有模型必须使用 freezed
- 所有测试必须通过
- 代码必须通过 `flutter analyze --fatal-infos`
- Git hooks 必须全部通过
- HTTP 请求统一由 Rust wreq 处理
