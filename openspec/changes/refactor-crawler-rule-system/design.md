# Refactor Crawler Rule System - Technical Design

## Context

### 背景

基于对以下项目的深入研究：

1. **Legado (阅读)** - 小说聚合器
   - 使用 Jaccard Similarity 进行章节匹配，阈值 0.96
   - 搜索窗口 ±10 章节优化性能
   - 两阶段匹配: 相似度 → 章节号回退

2. **TachiyomiSY** - 漫画聚合器
   - 手动源合并，用户配置优先级
   - `MergedMangaReference` 追踪每个源的引用
   - 并发获取 (Semaphore 限制 5 个)

3. **n8n / Node-RED** - 工作流引擎
   - 声明式节点定义 (displayName, inputs, outputs, properties)
   - connections 分离存储，与 nodes 解耦
   - JSON Schema 验证节点配置

4. **playwright-stealth / puppeteer-extra-plugin-stealth**
   - 修补 ~20 个 headless 检测点
   - 包括 navigator.webdriver, Chrome runtime, 权限 API 等

5. **FlareSolverr**
   - 使用 Selenium + Chrome 绕过 Cloudflare
   - 等待 challenge 解决后同步 Cookie

 6. **flutter_rust_bridge** - Rust FFI 代码生成
    - 自动生成双向绑定 (Dart ↔ Rust)
    - 支持高级类型和 async/await
    - 同时支持原生和 Web 平台 (WASM)

### 约束

- **Flutter 跨平台**: Android, iOS, Windows, macOS, Linux
- **freezed 强制**: 所有数据模型使用 freezed
- **Pipeline 可序列化**: 支持字符串数组格式和 React Flow 格式
- **向后兼容**: 尽量保留现有选择器实现
- **Rust FFI**: 使用 flutter_rust_bridge 集成 Rust 模块

---

## Goals / Non-Goals

### Goals

1. **设计 Pipeline DSL** - 字符串数组格式，支持可视化映射
2. **实现完整生命周期** - Explore, Search, Detail, TOC, Content 五阶段
3. **实现多网络策略** - http, webview_headless, webview_interact
4. **实现反爬配置** - TLS 指纹, 浏览器指纹, 验证码处理
5. **实现多源聚合** - Jaccard/Levenshtein 相似度匹配
6. **重构可视化编辑器** - React Flow 节点流编辑

### Non-Goals

- 不实现分布式采集
- 不实现规则市场
- 不实现增量采集
- 不自动求解复杂验证码 (仅对接第三方服务)

---

## Decisions

### Decision 1: Pipeline DSL 语法

**选择**: 字符串数组格式，支持多种节点类型

```json
{
  "title": ["@css:.video-title", "@text", "@trim"],
  "cover": ["@css:img.cover", "@attr:src", "@url"],
  "playUrl": ["@js: window.__playinfo__.dash.video[0].url"]
}
```

**节点类型**:

| 类型 | 语法 | 用途 |
|------|------|------|
| CSS 选择器 | `@css:selector` | HTML 元素选择 |
| XPath 选择器 | `@xpath:expr` | 复杂结构选择 |
| JSONPath | `@jsonpath:expr` | JSON 数据提取 |
| 正则表达式 | `@regex:pattern` | 文本匹配提取 |
| JavaScript | `@js:code` | 自定义逻辑 (val 变量为输入) |
| 属性提取 | `@attr:name` | 获取元素属性 |
| 文本提取 | `@text` | 获取元素文本 |
| HTML 提取 | `@html` | 获取内部 HTML |
| URL 规范化 | `@url` | 补全相对 URL |
| 去除空白 | `@trim` | 去除首尾空白 |
| 字符串替换 | `@replace:from→to` | 替换字符串 |
| 取第一个 | `@first` | 取数组第一个 |
| 连接数组 | `@join:sep` | 用分隔符连接 |

**理由**:
- 字符串格式易于存储和传输
- 每个操作是原子节点，适合可视化
- 可解析为类型安全的对象执行

**备选方案**:
- 纯对象格式: 类型安全但不够直观
- 函数式 DSL: 过于复杂

### Decision 2: 生命周期模型

**选择**: 五阶段模型

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           Rule Lifecycle                                 │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌─────────┐                                                             │
│  │ EXPLORE │  发现页 / 分类浏览                                          │
│  │         │  - menus: 分类/筛选菜单定义                                 │
│  │         │  - request: 动态 URL ({{category}}, {{page}})               │
│  │         │  - parse: 列表项 + 分页                                     │
│  └────┬────┘                                                             │
│       │                                                                  │
│       ▼                                                                  │
│  ┌─────────┐                                                             │
│  │ SEARCH  │  关键词搜索                                                 │
│  │         │  - request: {{key}} 变量                                    │
│  │         │  - parse: 搜索结果列表                                      │
│  └────┬────┘                                                             │
│       │                                                                  │
│       ▼                                                                  │
│  ┌─────────┐                                                             │
│  │ DETAIL  │  详情页 (作品信息)                                          │
│  │         │  - request: {{id}} 从上游传入                               │
│  │         │  - parse: 标准化字段 (title, author, description...)        │
│  └────┬────┘                                                             │
│       │                                                                  │
│       ▼                                                                  │
│  ┌─────────┐                                                             │
│  │   TOC   │  目录 / 章节列表                                            │
│  │         │  - parse: 章节列表 + 分页                                    │
│  │         │  - sort: reverse (逆序修正)                                 │
│  └────┬────┘                                                             │
│       │                                                                  │
│       ▼                                                                  │
│  ┌─────────┐                                                             │
│  │ CONTENT │  正文 / 播放                                                │
│  │         │  - strategy: parse | sniff                                  │
│  │         │  - parse: 按媒体类型 (text, images, mediaUrl)               │
│  │         │  - sniff: 正则匹配 + 排除                                   │
│  └─────────┘                                                             │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

**数据流**:

```
Explore/Search ──▶ ListItem[] ──▶ Detail (via item.id) ──▶ DetailItem
                                          │
                                          ▼
                                      TOC (via item.id) ──▶ Chapter[]
                                          │
                                          ▼
                                    Content (via chapter.id) ──▶ Content
```

**理由**:
- 覆盖主流内容网站的结构
- 每阶段独立，可缓存
- 支持部分规则 (只有 Search，或只有 Detail)

### Decision 3: 网络策略

**选择**: 三种策略，按需选择

```dart
enum NetworkStrategy {
  /// 纯 HTTP 请求，无浏览器
  http,
  
  /// 无头浏览器，自动处理 JS
  webviewHeadless,
  
  /// 交互式浏览器，需要用户操作 (登录、验证码)
  webviewInteract,
}
```

**策略选择逻辑**:

```dart
NetworkStrategy selectStrategy(CrawlerRule rule, DetectionResult detection) {
  // 1. 规则明确指定
  if (rule.network.strategy != null) {
    return rule.network.strategy!;
  }
  
  // 2. 检测到需要浏览器
  if (detection.requiresBrowser) {
    return detection.requiresUserInteraction 
        ? NetworkStrategy.webviewInteract 
        : NetworkStrategy.webviewHeadless;
  }
  
  // 3. 默认 HTTP
  return NetworkStrategy.http;
}
```

**理由**:
- HTTP 最快，但容易被检测
- webview_headless 能处理大部分 JS 渲染
- webview_interact 处理登录、复杂验证码

### Decision 4: 反爬配置

**选择**: 分层配置，声明式

```dart
@freezed
class NetworkConfig with _$NetworkConfig {
  const factory NetworkConfig({
    /// 网络策略
    @Default(NetworkStrategy.http) NetworkStrategy strategy,
    
    /// 超时时间 (ms)
    @Default(15000) int timeout,
    
    /// 默认请求头
    Map<String, String>? defaultHeaders,
    
    /// TLS 指纹配置
    TlsFingerprint? tlsFingerprint,
    
    /// 浏览器指纹配置
    BrowserFingerprint? browserFingerprint,
    
    /// 请求拦截器
    Interceptors? interceptors,
    
    /// 代理配置
    ProxyConfig? proxy,
    
    /// Cookie 管理
    CookieConfig? cookies,
  }) = _NetworkConfig;
}

@freezed
class Interceptors with _$Interceptors {
  const factory Interceptors({
    /// 请求前拦截
    List<Interceptor>? onBeforeRequest,
    
    /// 失败回退
    FallbackConfig? onFallback,
  }) = _Interceptors;
}

@freezed
class FallbackConfig with _$FallbackConfig {
  const factory FallbackConfig({
    /// 触发条件
    required List<TriggerCondition> trigger,
    
    /// 回退动作
    @Default(FallbackAction.webviewSolve) FallbackAction action,
    
    /// 解决超时 (ms)
    @Default(15000) int solveTimeout,
    
    /// 是否同步 Cookie
    @Default(true) bool syncCookies,
  }) = _FallbackConfig;
}
```

**TLS 指纹配置**:

```dart
@freezed
class TlsFingerprint with _$TlsFingerprint {
  const factory TlsFingerprint({
    /// 模拟的浏览器类型
    @Default(BrowserType.chrome) BrowserType browser,
    
    /// TLS 版本
    @Default('1.3') String tlsVersion,
    
    /// 是否使用 curl-impersonate
    @Default(true) bool useImpersonate,
  }) = _TlsFingerprint;
}

enum BrowserType {
  chrome110,
  chrome120,
  firefox110,
  safari156,
  edge101,
}
```

**浏览器指纹配置**:

```dart
@freezed
class BrowserFingerprint with _$BrowserFingerprint {
  const factory BrowserFingerprint({
    /// 禁用 webdriver 标志
    @Default(true) bool hideWebdriver,
    
    /// 模拟 Chrome runtime
    @Default(true) bool mockChromeRuntime,
    
    /// 模拟权限 API
    @Default(true) bool mockPermissions,
    
    /// 随机化 canvas 指纹
    @Default(false) bool randomizeCanvas,
    
    /// 模拟真实插件列表
    @Default(true) bool mockPlugins,
    
    /// User Agent
    String? userAgent,
    
    /// 视口大小
    Viewport? viewport,
  }) = _BrowserFingerprint;
}
```

**理由**:
- 分层配置，按需启用
- 声明式，易于序列化和验证
- 参考了 playwright-stealth 的修补点

### Decision 5: 验证码处理

**选择**: 检测 + 第三方服务求解

```dart
@freezed
class CaptchaConfig with _$CaptchaConfig {
  const factory CaptchaConfig({
    /// 验证码检测配置
    required CaptchaDetection detection,
    
    /// 求解服务配置
    CaptchaSolver? solver,
  }) = _CaptchaConfig;
}

@freezed
class CaptchaDetection with _$CaptchaDetection {
  const factory CaptchaDetection({
    /// 检测 reCAPTCHA
    @Default(true) bool detectRecaptcha,
    
    /// 检测 hCaptcha
    @Default(true) bool detectHcaptcha,
    
    /// 检测 Cloudflare Turnstile
    @Default(true) bool detectTurnstile,
    
    /// 检测通用图片验证码
    @Default(true) bool detectGeneric,
    
    /// 检测滑块验证码
    @Default(true) bool detectSlider,
  }) = _CaptchaDetection;
}

@freezed
class CaptchaSolver with _$CaptchaSolver {
  const factory CaptchaSolver({
    /// 服务类型
    required CaptchaService service,
    
    /// API Key
    required String apiKey,
    
    /// 超时时间 (ms)
    @Default(60000) int timeout,
    
    /// 是否自动求解
    @Default(false) bool autoSolve,
  }) = _CaptchaSolver;
}

enum CaptchaService {
  twoCaptcha,
  antiCaptcha,
  capSolver,
  deathByCaptcha,
}
```

**支持的验证码类型**:
- reCAPTCHA v2/v3
- hCaptcha
- Cloudflare Turnstile
- 滑块验证码
- 图片验证码

### Decision 6: 多源聚合

**选择**: 两阶段匹配 (相似度 + 回退) + 搜索策略

#### 6.1 搜索词验证

```dart
/// 搜索请求模型
@freezed
class SearchRequest with _$SearchRequest {
  const factory SearchRequest({
    /// 搜索关键词 (最小 2 字)
    required String query,
    
    /// 搜索策略
    @Default(SearchStrategy.auto) SearchStrategy strategy,
    
    /// 源过滤配置
    @Default(SourceFilter.all()) SourceFilter filter,
    
    /// 最大结果数
    @Default(50) int limit,
  }) = _SearchRequest;
  
  const SearchRequest._();
  
  /// 验证搜索词
  bool get isValid => query.trim().length >= 2;
  
  /// 预处理后的搜索词
  String get normalizedQuery => query.trim();
}

/// 搜索策略
enum SearchStrategy {
  /// 自动选择 (短词全字，长词模糊)
  auto,
  
  /// 全字匹配
  exact,
  
  /// 模糊匹配 (分词多次搜索)
  fuzzy,
}
```

#### 6.2 搜索策略实现

```dart
/// 搜索策略抽象
abstract class SearchStrategy {
  /// 执行搜索
  Future<List<SearchResult>> search(
    String query,
    List<CrawlerRule> sources,
  );
}

/// 全字匹配策略
class ExactSearchStrategy implements SearchStrategy {
  final NativeSimilarity _similarity;
  
  @override
  Future<List<SearchResult>> search(String query, List<CrawlerRule> sources) async {
    final results = <SearchResult>[];
    final normalizedQuery = _similarity.normalizeTitle(query);
    
    for (final source in sources) {
      final items = await _fetchFromSource(source, query);
      for (final item in items) {
        final normalizedTitle = _similarity.normalizeTitle(item.title);
        final score = normalizedQuery == normalizedTitle 
            ? 1.0 
            : _similarity.jaccard(normalizedQuery, normalizedTitle);
        
        results.add(SearchResult(item: item, source: source, score: score));
      }
    }
    
    return results..sort((a, b) => b.score.compareTo(a.score));
  }
}

/// 模糊匹配策略 (分词多次搜索)
class FuzzySearchStrategy implements SearchStrategy {
  final NativeSimilarity _similarity;
  
  @override
  Future<List<SearchResult>> search(String query, List<CrawlerRule> sources) async {
    // 1. 分词
    final tokens = _similarity.segment(query);
    
    // 2. 每个分词单独搜索
    final tokenResults = <String, List<SearchResult>>{};
    for (final token in tokens) {
      tokenResults[token] = await _searchWithToken(token, sources);
    }
    
    // 3. 合并结果并计算综合评分
    final mergedResults = _mergeTokenResults(tokenResults, query);
    
    // 4. 按相似度排序
    mergedResults.sort((a, b) => b.score.compareTo(a.score));
    
    return mergedResults;
  }
  
  List<SearchResult> _mergeTokenResults(
    Map<String, List<SearchResult>> tokenResults,
    String originalQuery,
  ) {
    final itemScores = <String, List<double>>{};
    
    // 收集每个结果在各分词搜索中的得分
    for (final entry in tokenResults.entries) {
      for (final result in entry.value) {
        final key = '${result.source.id}:${result.item.id}';
        itemScores.putIfAbsent(key, () => []).add(result.score);
      }
    }
    
    // 计算综合得分: 加权平均 + 全词匹配加成
    final merged = <SearchResult>[];
    for (final entry in itemScores.entries) {
      final avgScore = entry.value.reduce((a, b) => a + b) / entry.value.length;
      final coverage = entry.value.length / tokenResults.length;
      
      // 综合评分 = 平均分 * 覆盖率 + 全词匹配加成
      final fullMatchScore = _similarity.jaccard(
        _similarity.normalizeTitle(originalQuery),
        _similarity.normalizeTitle(/* item title */),
      );
      
      final finalScore = avgScore * 0.5 + coverage * 0.3 + fullMatchScore * 0.2;
      // ...
    }
    
    return merged;
  }
}
```

#### 6.3 源过滤配置

```dart
/// 源过滤配置
@freezed
class SourceFilter with _$SourceFilter {
  const factory SourceFilter({
    /// 过滤模式
    required SourceFilterMode mode,
    
    /// 媒体类型 (mode == byMediaType)
    MediaType? mediaType,
    
    /// 源分组 ID (mode == byGroup)
    String? groupId,
    
    /// 指定源 ID 列表 (mode == bySourceIds)
    List<String>? sourceIds,
  }) = _SourceFilter;
  
  const SourceFilter._();
  
  /// 全部源
  factory SourceFilter.all() => const SourceFilter(mode: SourceFilterMode.all);
  
  /// 按媒体类型
  factory SourceFilter.byMediaType(MediaType type) => 
      SourceFilter(mode: SourceFilterMode.byMediaType, mediaType: type);
  
  /// 按源分组
  factory SourceFilter.byGroup(String groupId) => 
      SourceFilter(mode: SourceFilterMode.byGroup, groupId: groupId);
  
  /// 指定源
  factory SourceFilter.bySourceIds(List<String> ids) => 
      SourceFilter(mode: SourceFilterMode.bySourceIds, sourceIds: ids);
}

/// 源过滤模式
enum SourceFilterMode {
  /// 全部源
  all,
  
  /// 按媒体类型
  byMediaType,
  
  /// 按源分组
  byGroup,
  
  /// 指定源 ID
  bySourceIds,
}
```

#### 6.4 聚合配置模型

```dart
@freezed
class AggregationConfig with _$AggregationConfig {
  const factory AggregationConfig({
    /// 是否启用聚合
    @Default(true) bool enabled,
    
    /// 源权重 (用于自动优选)
    @Default(50) int weight,
    
    /// 匹配配置
    required MatchingConfig matching,
  }) = _AggregationConfig;
}

@freezed
class MatchingConfig with _$MatchingConfig {
  const factory MatchingConfig({
    /// 匹配策略
    @Default(MatchingStrategy.fuzzy) MatchingStrategy strategy,
    
    /// 匹配维度
    required List<MatchingDimension> dimensions,
    
    /// 综合阈值
    @Default(0.85) double combinedThreshold,
  }) = _MatchingConfig;
}

@freezed
class MatchingDimension with _$MatchingDimension {
  const factory MatchingDimension({
    /// 字段名
    required String field,
    
    /// 匹配类型
    @Default(MatchType.fuzzy) MatchType matchType,
    
    /// 权重
    @Default(1.0) double weight,
    
    /// 相似度阈值 (fuzzy 类型)
    @Default(0.96) double threshold,
    
    /// 标准化配置
    NormalizationConfig? normalize,
  }) = _MatchingDimension;
}

enum MatchingStrategy {
  /// 精确匹配
  exact,
  
  /// 模糊匹配
  fuzzy,
  
  /// 自定义 JS 表达式
  custom,
}

enum MatchType {
  /// 精确匹配
  exact,
  
  /// 模糊匹配 (Jaccard/Levenshtein)
  fuzzy,
  
  /// 标准化后匹配
  normalized,
}
```

**标题标准化 (Rust 实现)**:

```rust
// rust/src/normalizer.rs

use std::ffi::{CStr, CString, c_char};
use std::sync::OnceLock;
use ferrous_opencc::{OpenCC, config::BuiltinConfig};

static OPENCC_T2S: OnceLock<OpenCC> = OnceLock::new();

fn get_opencc() -> &'static OpenCC {
    OPENCC_T2S.get_or_init(|| OpenCC::from_config(BuiltinConfig::T2s).unwrap())
}

const METADATA_PATTERNS: &[&str] = &[
    r"\([^)]*\)",      // (2024) (HD)
    r"【[^】]*】",      // 【推荐】
    r"\[[^\]]*\]",     // [完本]
    r"《[^》]*》",      // 《书名》
    r"<[^>]*>",        // <转载>
    r"第\s*\d+\s*章",  // 第123章
    r"Chapter\s*\d+",  // Chapter 123
];

#[unsafe(no_mangle)]
pub extern "C" fn title_normalize(input: *const c_char, input_len: usize) -> *mut c_char {
    let bytes = unsafe { std::slice::from_raw_parts(input as *const u8, input_len) };
    let text = std::str::from_utf8(bytes).unwrap_or("");
    
    // 1. 繁体转简体
    let simplified = get_opencc().convert(text);
    
    // 2. 去除元数据模式
    let mut result = simplified;
    for pattern in METADATA_PATTERNS {
        let re = regex::Regex::new(pattern).unwrap();
        result = re.replace_all(&result, "").to_string();
    }
    
    // 3. 统一格式
    result = result.to_lowercase();
    result = regex::Regex::new(r"\s+").unwrap().replace_all(&result, " ").to_string();
    result = result.trim().to_string();
    
    CString::new(result).unwrap().into_raw()
}
```

**相似度计算 (Rust FFI 实现)**:

```rust
// rust/src/similarity.rs

use std::ffi::{CStr, CString, c_char};
use std::sync::OnceLock;
use jieba_rs::Jieba;

static JIEBA: OnceLock<Jieba> = OnceLock::new();

fn get_jieba() -> &'static Jieba {
    JIEBA.get_or_init(Jieba::new)
}

/// Jaccard 相似度 (基于 jieba 分词)
/// 返回值: 0.0 ~ 1.0
#[unsafe(no_mangle)]
pub extern "C" fn jaccard_similarity(
    a: *const c_char,
    a_len: usize,
    b: *const c_char,
    b_len: usize,
) -> f64 {
    let a_bytes = unsafe { std::slice::from_raw_parts(a as *const u8, a_len) };
    let b_bytes = unsafe { std::slice::from_raw_parts(b as *const u8, b_len) };
    let a_str = std::str::from_utf8(a_bytes).unwrap_or("");
    let b_str = std::str::from_utf8(b_bytes).unwrap_or("");
    
    let jieba = get_jieba();
    let tokens_a: std::collections::HashSet<&str> = jieba.cut(a_str, false).into_iter().collect();
    let tokens_b: std::collections::HashSet<&str> = jieba.cut(b_str, false).into_iter().collect();
    
    let intersection = tokens_a.intersection(&tokens_b).count();
    let union = tokens_a.union(&tokens_b).count();
    
    if union == 0 { return 0.0; }
    intersection as f64 / union as f64
}

/// Levenshtein 距离 (编辑距离)
/// 返回值: 0.0 ~ 1.0 (归一化相似度)
#[unsafe(no_mangle)]
pub extern "C" fn levenshtein_similarity(
    a: *const c_char,
    a_len: usize,
    b: *const c_char,
    b_len: usize,
) -> f64 {
    // ... 实现
}

/// 标题标准化 (繁简统一 + 去除元数据)
/// 返回的字符串需要调用者释放
#[unsafe(no_mangle)]
pub extern "C" fn title_normalize(
    input: *const c_char,
    input_len: usize,
) -> *mut c_char {
    // 1. 繁简统一 (调用 ferrous-opencc)
    // 2. 去除元数据模式
    // 3. 返回规范化字符串
}

/// 模糊搜索评分
/// 返回综合相似度分数 (0.0 ~ 1.0)
/// 
/// # Arguments
/// * `query` - 搜索词
/// * `target` - 目标标题
/// 
/// # Algorithm
/// 1. 对 query 和 target 进行分词
/// 2. 计算 Jaccard 相似度
/// 3. 计算 Levenshtein 相似度
/// 4. 综合评分 = jaccard * 0.6 + levenshtein * 0.4
#[unsafe(no_mangle)]
pub extern "C" fn fuzzy_search_score(
    query: *const c_char,
    query_len: usize,
    target: *const c_char,
    target_len: usize,
) -> f64 {
    // 实现分词 + 综合评分
}
```

**Dart 封装**:

```dart
class NativeSimilarity {
  /// Jaccard 相似度 (基于中文分词)
  static double jaccard(String a, String b) {
    final aPtr = a.toNativeUtf8();
    final bPtr = b.toNativeUtf8();
    try {
      return _bindings.jaccard_similarity(
        aPtr.cast(), a.length,
        bPtr.cast(), b.length,
      );
    } finally {
      calloc.free(aPtr);
      calloc.free(bPtr);
    }
  }
  
  /// Levenshtein 相似度
  static double levenshtein(String a, String b) { /* ... */ }
  
  /// 标题标准化
  static String normalizeTitle(String title) { /* ... */ }
  
  /// 模糊搜索评分
  /// 用于聚合搜索结果排序
  static double fuzzySearchScore(String query, String target) {
    final queryPtr = query.toNativeUtf8();
    final targetPtr = target.toNativeUtf8();
    try {
      return _bindings.fuzzy_search_score(
        queryPtr.cast(), query.length,
        targetPtr.cast(), target.length,
      );
    } finally {
      calloc.free(queryPtr);
      calloc.free(targetPtr);
    }
  }
  
  /// 分词
  static List<String> segment(String text) { /* ... */ }
}
```

**理由**:
- Rust 实现比纯 Dart 快 5-10 倍
- jieba-rs 分词比 Dart 实现更准确
- 复用 Rust 生态，减少维护成本
- 原有 Dart 实现作为临时方案，Phase 7 清理时删除

### Decision 7: 媒体嗅探

**选择**: 正则匹配 + 网络监听

```dart
@freezed
class SniffConfig with _$SniffConfig {
  const factory SniffConfig({
    /// 匹配正则
    required List<String> matchRegex,
    
    /// 排除正则
    List<String>? excludeRegex,
    
    /// 超时时间 (ms)
    @Default(15000) int timeout,
    
    /// 后处理脚本
    String? script,
  }) = _SniffConfig;
}
```

**示例配置**:

```json
{
  "sniff": {
    "matchRegex": [
      ".*\\.m3u8.*",
      ".*\\.mp4.*",
      ".*\\.mp3.*"
    ],
    "excludeRegex": [
      ".*(ad|ads|adv|advertisement|tracker|analytics).*"
    ],
    "timeout": 15000,
    "script": "@js: if(url.includes('cdn')) return url; else return extractReal(url);"
  }
}
```

**理由**:
- 视频网站通常不直接暴露播放 URL
- 嗅探能捕获 WebView 中的网络请求
- 正则匹配灵活，可适应不同 CDN

### Decision 8: WebView 引擎选择

**选择**: 双引擎支持，以 flutter_inappwebview 为主，webview_flutter 为备选

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         WebView 策略架构                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                    WebViewStrategy (抽象层)                           │  │
│  ├───────────────────────────────────────────────────────────────────────┤  │
│  │  abstract class WebViewStrategy {                                     │  │
│  │    Future<void> loadUrl(String url);                                  │  │
│  │    Future<String?> evaluateJs(String script);                         │  │
│  │    Future<void> runHeadless(String url);                              │  │
│  │    Stream<NetworkRequest> interceptRequests();                        │  │
│  │    Future<void> setCookies(List<Cookie> cookies);                    │  │
│  │    Future<void> setProxy(ProxyConfig? proxy);                        │  │
│  │  }                                                                    │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                           │                                                  │
│               ┌───────────┴───────────┐                                     │
│               ▼                       ▼                                     │
│  ┌─────────────────────────┐  ┌─────────────────────────┐                   │
│  │ InAppWebViewStrategy    │  │ OfficialWebViewStrategy  │                   │
│  │ (flutter_inappwebview)  │  │ (webview_flutter)        │                   │
│  ├─────────────────────────┤  ├─────────────────────────┤                   │
│  │ ✅ 全平台 (含桌面)      │  │ ✅ 官方维护              │                   │
│  │ ✅ Headless 模式        │  │ ✅ Web 平台 (iframe)     │                   │
│  │ ✅ 请求拦截             │  │ ✅ 移动端稳定            │                   │
│  │ ✅ 代理支持             │  │ ❌ 无 Headless           │                   │
│  │ ✅ Cookie 完整控制      │  │ ❌ 无桌面支持            │                   │
│  └─────────────────────────┘  └─────────────────────────┘                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

**平台支持对比**:

| 平台 | webview_flutter | flutter_inappwebview 6.2.0-beta.3 |
|------|:---------------:|:---------------------------------:|
| Android | ✅ | ✅ |
| iOS | ✅ | ✅ |
| Windows | ❌ | ✅ (beta) |
| macOS | ❌ | ✅ (beta) |
| Linux | ❌ | ✅ (beta) |
| Web | ✅ (iframe) | ✅ (beta) |
| **Headless** | ❌ | ✅ |
| **请求拦截** | ❌ | ✅ |
| **代理** | ❌ | ✅ |

**默认策略选择**:

```dart
WebViewStrategy selectStrategy() {
  // Web 平台只能用官方 WebView
  if (kIsWeb) return OfficialWebViewStrategy();
  
  // 需要 Headless 或请求拦截 → InAppWebView
  if (config.requiresHeadless || config.requiresInterception) {
    return InAppWebViewStrategy();
  }
  
  // 桌面平台 → InAppWebView
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    return InAppWebViewStrategy();
  }
  
  // 其他情况 → InAppWebView (功能更全)
  return InAppWebViewStrategy();
}
```

**理由**:
- 项目已计划使用 flutter_inappwebview (preview_page.dart 注释)
- flutter_inappwebview 6.2.0-beta.3 新增 Linux 支持，实现全平台覆盖
- Headless 模式是爬虫反爬的核心能力
- 保留 webview_flutter 作为备选，应对官方维护优势
- 抽象层设计允许未来切换或混合使用

**备选方案**:
- 仅使用 webview_flutter: 无法满足桌面端和 Headless 需求
- 仅使用 flutter_inappwebview: Web 平台支持不稳定

### Decision 9: HTTP 服务器

**选择**: 继续使用 relic (已有)

项目已使用 `relic: ^1.0.0` 作为 HTTP 服务器，位于 `lib/core/server/`。

现有实现:
- ✅ RelicServer + Riverpod Provider
- ✅ WebSocket 支持
- ✅ CORS 中间件
- ✅ 静态文件服务 (assets/editor/)
- ✅ 规则 CRUD API

无需变更，直接复用现有架构。

### Decision 10: 可视化编辑器架构

**选择**: React Flow + 三栏布局

```
┌──────────────────────────────────────────────────────────────────────────┐
│                           Rule Editor                                     │
├──────────────────────────────────────────────────────────────────────────┤
│  [Rule Name] [Media Type] [Save] [Validate] [Export]                     │
├──────────────────────────────────────────────────────────────────────────┤
│  [Metadata] [Network] [Explore] [Search] [Detail] [TOC] [Content]        │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  ┌─────────────┐   ┌─────────────────────────┐   ┌──────────────────┐   │
│  │  Preview    │   │     Pipeline Editor     │   │   Output Panel   │   │
│  │  (WebView)  │   │     (React Flow)        │   │   (JSON/Result)  │   │
│  │             │   │                         │   │                  │   │
│  │ ┌─────────┐ │   │  ┌───┐   ┌───┐   ┌───┐ │   │  title: "..."    │   │
│  │ │Target   │ │   │  │@css│──▶│@txt│──▶│Out│ │   │  author: "..."   │   │
│  │ │Page     │ │   │  └───┘   └───┘   └───┘ │   │  cover: "..."    │   │
│  │ │         │ │   │                         │   │                  │   │
│  │ │ Click   │ │   │  ┌───┐   ┌───┐   ┌───┐ │   │  ✓ 15 items      │   │
│  │ │ element │─┼──▶│  │@css│──▶│@url│──▶│Out│ │   │                  │   │
│  │ │ to      │ │   │  └───┘   └───┘   └───┘ │   │  [Copy JSON]     │   │
│  │ │ pick    │ │   │                         │   │                  │   │
│  │ └─────────┘ │   │  [Node Palette]         │   │                  │   │
│  │             │   │  选择器 | 变换 | 输出   │   │                  │   │
│  └─────────────┘   └─────────────────────────┘   └──────────────────┘   │
│                                                                           │
└──────────────────────────────────────────────────────────────────────────┘
```

**节点类型**:

```typescript
// 节点定义
interface PipelineNode {
  id: string;
  type: 'selector' | 'transform' | 'output' | 'input';
  position: { x: number; y: number };
  data: {
    operator: string;  // @css, @text, @trim, etc.
    expression?: string;
    config?: Record<string, unknown>;
  };
}

// 序列化为 Pipeline
function serializePipeline(nodes: PipelineNode[], edges: Edge[]): string[] {
  // 按拓扑排序，返回字符串数组
  // ["@css:.title", "@text", "@trim"]
}
```

**元素拾取**:

```typescript
// 注入到 WebView 的脚本
const pickerScript = `
  document.addEventListener('click', (e) => {
    if (window.__pickerMode) {
      e.preventDefault();
      e.stopPropagation();
      
      const element = e.target;
      const selector = generateOptimalSelector(element);
      
      window.__sendToEditor({
        type: 'element_selected',
        selector: selector.css,
        xpath: selector.xpath,
        text: element.textContent,
        tagName: element.tagName
      });
    }
  }, true);
  
  function generateOptimalSelector(el) {
    // 1. 优先使用 id
    if (el.id) return { css: '#' + el.id, xpath: '//*[@id="' + el.id + '"]' };
    
    // 2. 使用语义化 class
    const semanticClasses = [...el.classList].filter(c => 
      !/^(col|row|flex|grid|p-|m-|w-|h-)/.test(c)
    );
    if (semanticClasses.length > 0) {
      return { css: el.tagName.toLowerCase() + '.' + semanticClasses[0], ... };
    }
    
    // 3. 回退到路径
    // ...
  }
`;
```

**理由**:
- React Flow 是最成熟的节点编辑库
- 三栏布局直观展示完整工作流
- 元素拾取降低学习门槛

### Decision 11: Rust FFI 中文处理模块

**选择**: 使用 flutter_rust_bridge 集成 Rust 库处理中文文本

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    Flutter Rust Bridge 架构                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                    Dart API Layer (自动生成)                          │  │
│  ├───────────────────────────────────────────────────────────────────────┤  │
│  │  // lib/src/rust/api/text_processor.dart (FRB 自动生成)               │  │
│  │  Future<List<String>> segment({required String text});               │  │
│  │  Future<String> toSimplified({required String text});                │  │
│  │  Future<String> toTraditional({required String text});               │  │
│  │  Future<String> numberToChinese({required int number});              │  │
│  │                                                                       │  │
│  │  // lib/src/rust/api/similarity.dart (FRB 自动生成)                   │  │
│  │  Future<double> jaccard({required String a, required String b});     │  │
│  │  Future<double> levenshtein({required String a, required String b}); │  │
│  │  Future<String> normalizeTitle({required String title});             │  │
│  │  Future<double> fuzzySearchScore({                                   │  │
│  │    required String query,                                            │  │
│  │    required String target,                                           │  │
│  │  });                                                                  │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                           │                                                  │
│                           ▼                                                  │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                    FRB Runtime (自动生成)                             │  │
│  ├───────────────────────────────────────────────────────────────────────┤  │
│  │  // frb_generated.dart - 自动生成的框架代码                           │  │
│  │  class RustLib {                                                      │  │
│  │    static Future<void> init();  // 初始化 FFI                        │  │
│  │  }                                                                     │  │
│  │                                                                        │  │
│  │  // frb_generated.io.dart - 原生平台 (dart:ffi)                       │  │
│  │  // frb_generated.web.dart - Web 平台 (dart:js_interop + WASM)        │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                           │                                                  │
│                           ▼                                                  │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                    Rust Native Layer (用户编写)                       │  │
│  ├───────────────────────────────────────────────────────────────────────┤  │
│  │  // rust/src/api/text_processor.rs                                    │  │
│  │  use flutter_rust_bridge::frb;                                        │  │
│  │                                                                        │  │
│  │  #[frb]                                                                │  │
│  │  pub async fn segment(text: String) -> Vec<String> {                  │  │
│  │      // jieba-rs 分词实现                                              │  │
│  │  }                                                                     │  │
│  │                                                                        │  │
│  │  #[frb]                                                                │  │
│  │  pub async fn to_simplified(text: String) -> String {                 │  │
│  │      // ferrous-opencc 繁简转换                                        │  │
│  │  }                                                                     │  │
│  │                                                                        │  │
│  │  // rust/src/api/similarity.rs                                        │  │
│  │  #[frb]                                                                │  │
│  │  pub async fn jaccard(a: String, b: String) -> f64 {                  │  │
│  │      // 基于 jieba 分词的 Jaccard 相似度                               │  │
│  │  }                                                                     │  │
│  │                                                                        │  │
│  │  #[frb]                                                                │  │
│  │  pub async fn normalize_title(title: String) -> String {              │  │
│  │      // 繁简统一 + 元数据去除                                          │  │
│  │  }                                                                     │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

**项目结构**:

```
spectra/
├── rust/                              # Rust 模块 (flutter_rust_bridge)
│   ├── Cargo.toml                     # Rust 依赖配置
│   └── src/
│       ├── lib.rs                     # 库入口
│       ├── frb_generated.rs           # FRB 自动生成
│       └── api/                       # 用户编写的 API
│           ├── mod.rs                 # API 模块入口
│           ├── text_processor.rs      # 中文处理 (分词、繁简转换)
│           └── similarity.rs          # 相似度计算 (Jaccard, Levenshtein)
│
├── lib/src/rust/                      # FRB 自动生成的 Dart 代码
│   ├── api/                           # Dart API (自动生成)
│   │   ├── text_processor.dart
│   │   └── similarity.dart
│   ├── frb_generated.dart             # FRB 框架 (自动生成)
│   ├── frb_generated.io.dart          # 原生平台绑定 (自动生成)
│   └── frb_generated.web.dart         # Web 平台绑定 (自动生成)
│
├── flutter_rust_bridge.yaml           # FRB 配置
└── pubspec.yaml
```

**Cargo.toml 配置**:

```toml
[package]
name = "spectra_native"
version = "0.1.0"
edition = "2021"

[lib]
crate-type = ["cdylib", "staticlib"]

[dependencies]
flutter_rust_bridge = "2.0"
jieba-rs = { version = "0.8", features = ["default-dict", "tfidf"] }
chinese-number = "0.7"
ferrous-opencc = "0.3"
regex = "1.10"
```

**flutter_rust_bridge.yaml 配置**:

```yaml
# FRB 配置文件
rust_input:
  - rust/src/api/**/*.rs

dart_output:
  - lib/src/rust

c_output:
  - rust/src/frb_generated.h
```

**Dart 使用示例**:

```dart
import 'package:spectra/src/rust/api/text_processor.dart';
import 'package:spectra/src/rust/api/similarity.dart';
import 'package:spectra/src/rust/frb_generated.dart';

Future<void> main() async {
  // 初始化 FRB
  await RustLib.init();
  
  // 中文分词
  final tokens = await segment(text: '你好世界');
  // ['你好', '世界']
  
  // 繁体转简体
  final simplified = await toSimplified(text: '繁體字');
  // '繁体字'
  
  // Jaccard 相似度
  final score = await jaccard(a: '标题A', b: '标题B');
  // 0.85
}
```

**使用场景**:

| 功能 | Rust 库 | 用途 |
|------|---------|------|
| 中文分词 | jieba-rs | 标题相似度计算前预处理、分词搜索 |
| 繁简转换 | ferrous-opencc | 统一文本格式用于匹配 |
| 数字转中文 | chinese-number | 章节号标准化 |
| Jaccard 相似度 | jieba-rs + 自定义 | 标题匹配 (阈值 0.96) |
| Levenshtein 相似度 | 自定义 | 短字符串匹配 (作者名) |
| 标题标准化 | ferrous-opencc + regex | 标题预处理 |
| 模糊搜索评分 | 综合算法 | 聚合搜索结果排序 |

**理由**:
- flutter_rust_bridge 提供自动代码生成，无需手动编写 FFI 绑定
- 支持高级类型 (String, Vec, async/await, Stream) 自动转换
- 同时支持原生平台 (dart:ffi) 和 Web 平台 (WASM)
- Rust 实现比纯 Dart 快 5-10 倍
- 可复用成熟的 Rust 中文处理生态

**备选方案**:
- native_toolchain_rust + ffigen: 需要手动处理类型转换和内存管理
- 纯 Dart 实现: 性能差，库不成熟
- 平台原生 API: 跨平台不一致
- HTTP 服务调用: 增加延迟和依赖

### Decision 12: Isolate 并行执行器

**选择**: 使用 Squadron (squadron + squadron_builder) 实现爬虫任务并行执行

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         Squadron 架构                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                    UI Thread (Main Isolate)                           │  │
│  ├───────────────────────────────────────────────────────────────────────┤  │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐       │  │
│  │  │ CrawlerService  │  │ ParserService   │  │ SimilaritySvc   │       │  │
│  │  │   (Proxy)       │  │   (Proxy)       │  │   (Proxy)       │       │  │
│  │  └────────┬────────┘  └────────┬────────┘  └────────┬────────┘       │  │
│  │           │                    │                    │                 │  │
│  │           └────────────────────┼────────────────────┘                 │  │
│  │                                │                                      │  │
│  │  ┌─────────────────────────────▼─────────────────────────────────┐   │  │
│  │  │                    WorkerPool Manager                          │   │  │
│  │  │  - 管理多个 Worker 实例                                         │   │  │
│  │  │  - 任务调度和负载均衡                                            │   │  │
│  │  │  - 错误恢复和重试                                               │   │  │
│  │  └─────────────────────────────────────────────────────────────────┘   │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                │                                             │
│              ┌─────────────────┼─────────────────┐                          │
│              ▼                 ▼                 ▼                          │
│  ┌───────────────┐  ┌───────────────┐  ┌───────────────┐                   │
│  │   Worker #1   │  │   Worker #2   │  │   Worker #N   │                   │
│  │  (Isolate)    │  │  (Isolate)    │  │  (Isolate)    │                   │
│  ├───────────────┤  ├───────────────┤  ├───────────────┤                   │
│  │ CrawlerService│  │ CrawlerService│  │ CrawlerService│                   │
│  │ - HTTP 请求   │  │ - HTTP 请求   │  │ - HTTP 请求   │                   │
│  │ - HTML 解析   │  │ - HTML 解析   │  │ - HTML 解析   │                   │
│  │ - 规则执行    │  │ - 规则执行    │  │ - 规则执行    │                   │
│  └───────────────┘  └───────────────┘  └───────────────┘                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

**服务定义**:

```dart
// lib/core/crawler/worker/crawler_service.dart

import 'package:squadron/squadron.dart';

part 'crawler_service.worker.g.dart';

@SquadronService(
  targetPlatform: TargetPlatform.vm,  // 原生平台使用 Isolate
)
base class CrawlerService {
  /// 执行爬虫规则
  @SquadronMethod()
  Future<ExecuteResult> executeRule(
    CrawlerRule rule,
    String phase,  // 'explore' | 'search' | 'detail' | 'toc' | 'content'
    Map<String, dynamic> variables,
  ) async {
    // 1. 解析 Pipeline
    // 2. 执行网络请求
    // 3. 执行选择器提取
    // 4. 返回结果
  }
  
  /// 执行搜索
  @SquadronMethod()
  Future<List<SearchResult>> search(
    String query,
    List<String> sourceIds,
    SearchStrategy strategy,
  ) async {
    // 并行搜索多个源
  }
  
  /// 批量执行 Pipeline
  @SquadronMethod()
  Stream<PipelineProgress> executeBatch(
    List<PipelineTask> tasks,
  ) async* {
    // 流式返回进度
  }
}

@SquadronService(targetPlatform: TargetPlatform.vm)
base class SimilarityService {
  /// 计算相似度
  @SquadronMethod()
  Future<double> jaccardSimilarity(String a, String b) async {
    return NativeSimilarity.jaccard(a, b);
  }
  
  /// 批量计算相似度
  @SquadronMethod()
  Future<List<SimilarityResult>> batchSimilarity(
    String query,
    List<String> targets,
  ) async {
    return [
      for (final target in targets)
        SimilarityResult(
          target: target,
          score: NativeSimilarity.fuzzySearchScore(query, target),
        ),
    ];
  }
}
```

**Worker Pool 使用**:

```dart
// lib/core/crawler/crawler_executor.dart

class CrawlerExecutor {
  late final CrawlerServiceWorkerPool _crawlerPool;
  late final SimilarityServiceWorkerPool _similarityPool;
  
  Future<void> initialize() async {
    // 创建 Worker Pool (根据 CPU 核心数)
    final cores = Platform.numberOfProcessors;
    
    _crawlerPool = CrawlerServiceWorkerPool(
      concurrency: min(cores, 4),  // 最多 4 个并发
    );
    
    _similarityPool = SimilarityServiceWorkerPool(
      concurrency: 2,
    );
  }
  
  /// 执行单个爬虫任务
  Future<ExecuteResult> execute(CrawlerRule rule, String phase) async {
    return await _crawlerPool.executeRule(rule, phase, {});
  }
  
  /// 聚合搜索 (并行)
  Future<List<SearchResult>> aggregateSearch(
    String query,
    List<CrawlerRule> sources,
  ) async {
    // 并行搜索所有源
    final futures = sources.map((source) => 
      _crawlerPool.search(query, [source.id], SearchStrategy.fuzzy)
    );
    
    final results = await Future.wait(futures);
    
    // 合并结果并排序
    final allResults = results.expand((r) => r).toList();
    
    // 在 Worker 中计算相似度并排序
    final scoredResults = await _similarityPool.batchSimilarity(
      query,
      allResults.map((r) => r.title).toList(),
    );
    
    // 按相似度排序
    for (var i = 0; i < allResults.length; i++) {
      allResults[i].score = scoredResults[i].score;
    }
    allResults.sort((a, b) => b.score.compareTo(a.score));
    
    return allResults;
  }
  
  /// 关闭 Worker Pool
  Future<void> dispose() async {
    await _crawlerPool.stop();
    await _similarityPool.stop();
  }
}
```

**Cargo.toml 配置**:

```yaml
# pubspec.yaml
dependencies:
  squadron: ^7.4.0

dev_dependencies:
  squadron_builder: ^9.1.0
  build_runner: ^2.4.0
```

**代码生成**:

```bash
dart run build_runner build --delete-conflicting-outputs
```

**对比分析**:

| 特性 | isolate_channel | async_task | squadron ✅ |
|------|----------------|------------|-------------|
| Worker Pool | ❌ | ✅ | ✅ |
| 代码生成 | ❌ | ❌ | ✅ |
| 类型安全 | 手动 | 手动 | ✅ 自动 |
| Web 支持 | ❌ | ✅ | ✅ (含 WASM) |
| 注解驱动 | ❌ | ❌ | ✅ |
| 流式返回 | ❌ | ✅ | ✅ |
| 社区活跃度 | 30 likes | 106 likes | 210 likes |

**理由**:
- **最成熟**: 210 likes，活跃维护
- **类型安全**: 通过代码生成确保跨 Isolate 类型安全
- **跨平台最佳**: 原生 + Web + WASM 全支持
- **注解驱动**: 代码简洁，易于维护
- **Worker Pool**: 内置线程池管理，支持并发控制
- **流式返回**: 支持 Stream，适合进度报告

**备选方案**:
- async_task: 不支持代码生成，类型不安全
- isolate_channel: 不支持 Worker Pool，需要手动管理

---

## Risks / Trade-offs

### Risk 1: Pipeline 执行性能

**风险**: 每个节点都需要解析执行，可能有性能开销

**缓解**:
- 编译 Pipeline 为单个优化函数
- 缓存中间结果
- 并行执行独立字段

### Risk 2: WebView 兼容性

**风险**: 移动端 WebView 限制可能影响功能

**缓解**:
- 桌面端完整支持
- 移动端降级为 HTTP 策略
- 提供后端代理选项

### Risk 3: 反爬持续对抗

**风险**: 网站反爬策略持续更新

**缓解**:
- 模块化设计，易于更新指纹配置
- 社区贡献规则库
- 监控成功率，自动降级

### Risk 4: 聚合误匹配

**风险**: 模糊匹配可能导致错误合并

**缓解**:
- 提供手动拆分功能
- 记录匹配日志供审查
- 可调节阈值

### Risk 5: Rust FFI 跨平台构建

**风险**: Rust 代码需要为每个平台单独编译

**缓解**:
- flutter_rust_bridge 自动化构建
- CI/CD 预编译各平台二进制
- 提供纯 Dart 回退实现

---

## Migration Plan

### Phase 1: 核心模型重构 (1-2 周)

1. 定义新的规则模型 (freezed)
2. 定义 Pipeline 节点模型
3. 定义网络配置模型
4. 定义聚合配置模型
5. 实现标题标准化和相似度算法

### Phase 2: Pipeline 执行器 (2 周)

1. 实现节点解析器
2. 实现各类节点处理器
3. 实现生命周期执行器
4. 实现变量插值

### Phase 3: 网络策略 (2 周)

1. 实现 HTTP 策略 (含 TLS 指纹)
2. 实现 webview_headless 策略
3. 实现浏览器指纹配置
4. 实现验证码检测和求解

### Phase 4: 多源聚合 (1 周)

1. 实现源合并器
2. 实现章节去重
3. 实现源路由器

### Phase 5: 可视化编辑器 (3 周)

1. 实现 React Flow 编辑器
2. 实现节点面板
3. 实现 WebView 预览
4. 实现元素拾取
5. 实现实时预览
6. 实现 Pipeline 序列化

### Phase 6: 集成测试 (1 周)

1. 编写测试规则
2. 端到端测试
3. 性能优化
4. 文档完善

---

## Open Questions

1. **旧规则迁移**
   - 是否提供自动迁移脚本？
   - 旧规则格式保留多久？

2. **Pipeline 复杂度限制**
   - 是否限制节点数量？
   - 循环依赖如何检测？

3. **聚合策略扩展**
   - 是否支持自定义匹配算法？
   - 是否支持机器学习匹配？

4. **WebView 实现选择**
   - flutter_inappwebview vs 自建方案？
   - 是否需要支持第三方浏览器？
