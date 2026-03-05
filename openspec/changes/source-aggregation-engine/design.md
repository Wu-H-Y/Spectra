## Context

用户搜索 "复仇者联盟"，从 10 个数据源获取结果。传统 `title == target_title` 逻辑失败，因为：
- 空格差异："复仇者联盟" vs "复仇者联盟 HD"
- 繁简差异："復仇者聯盟" vs "复仇者联盟"
- 元数据附加："Naruto (2015)" vs "Naruto"

新的 `execute_lifecycle_phase()` API 已经简化了单规则的搜索执行。聚合引擎负责**跨规则**合并结果，这是不同的职责层次。

## Goals / Non-Goals

**Goals:**
- 使用新的 `execute_lifecycle_phase()` API 执行各规则的搜索
- 实现模糊匹配算法（Jaccard Index, Levenshtein Distance）
- 实现标题预处理流水线（繁简转换、去除噪声词）
- 通过 Rust FFI 暴露重量级计算，避免阻塞 Dart UI isolate

**Non-Goals:**
- 机器学习语义相似度（保留基于词元和编辑距离的字符串匹配）
- 替代 `execute_lifecycle_phase()` API

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│  Dart Search Service                                       │
│  ┌────────────────────────────────────────────────────────┐ │
│  │ 1. 并行调用多个规则的 execute_lifecycle_phase(search)  │ │
│  │ 2. 收集各规则的 SearchData                             │ │
│  │ 3. 传递给 SourceAggregationEngine                       │ │
│  └────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  SourceAggregationEngine                                   │
│  ┌────────────────────────────────────────────────────────┐ │
│  │ 1. 预处理标题（Rust FFI）                              │ │
│  │    - 繁简转换（ferrous-opencc）                        │ │
│  │    - 中文分词（jieba-rs）                              │ │
│  │    - 去除噪声词                                        │ │
│  │ 2. 计算相似度（Rust FFI）                              │ │
│  │    - Jaccard Index                                     │ │
│  │    - Levenshtein Distance                              │ │
│  │ 3. 合并相同内容                                        │ │
│  │ 4. 按权重排序                                          │ │
│  └────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Decisions

**1. 使用新 API 执行搜索**

- **决策**: 使用 `execute_lifecycle_phase(rule, LifecyclePhase.search, context)` 替代底层 HTTP 调用
- **理由**: 新 API 自动处理 HTTP + 解析 + 错误，简化 Dart 侧代码
- **实现**:
  ```dart
  final futures = rules.map((rule) => 
    rust.executeLifecyclePhase(rule, LifecyclePhase.search, context)
  );
  final results = await Future.wait(futures);
  final allItems = results.expand((r) => r.data?.asSearch()?.items ?? []);
  
  final merged = await aggregationEngine.merge(allItems);
  ```

**2. Rust FFI 相似度计算**

- **决策**: 使用 Rust `textdistance` crate 计算相似度
- **理由**: 中文分词和编辑距离计算在 Dart 侧性能差
- **实现**:
  ```rust
  // Rust 侧已有的 API
  pub fn jaccard(a: String, b: String) -> f64
  pub fn levenshtein(a: String, b: String) -> f64
  pub fn normalize_title(title: String) -> String
  ```

**3. 流式聚合**

- **决策**: 实现 `Stream<MergedResult>` 而非等待所有源
- **理由**: 提升用户体验，渐进式显示结果
- **实现**: 使用 Dart `Stream` 和 `StreamController`

## Risks / Trade-offs

**[Risk] 搜索响应时间慢**
- 等待 10 个源完成后再合并会破坏"渐进加载"体验
- **缓解**: 实现流式聚合，随慢速源的返回逐步更新结果

**[Risk] O(n²) 复杂度**
- 10 个源各返回 100 条结果 = 10000 次比较
- **缓解**: 
  - 使用 Rust FFI 加速计算
  - 预过滤：只比较可能相似的项（首字母、长度相近）
  - 并行化：使用 Dart isolates

**[Risk] 错误处理**
- 某些源失败不应影响整体聚合
- **缓解**: 每个规则的搜索独立执行，失败的源被忽略
