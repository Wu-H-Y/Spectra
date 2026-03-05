## 1. Rust NLP 支持（已存在）

- [ ] 1.1 在 `Cargo.toml` 添加 `jieba-rs`, `ferrous-opencc`, `textdistance`（可能已存在）
- [ ] 1.2 在 `rust/src/api/text_processor.rs` 暴露 `segment` 和 `to_simplified`（可能已存在）
- [ ] 1.3 在 `rust/src/api/similarity.rs` 暴露 `jaccard` 和 `levenshtein`（可能已存在）
- [ ] 1.4 运行 `cargo check` 验证 Rust 依赖

## 2. Dart 聚合引擎实现

- [ ] 2.1 在 `lib/core/aggregation/` 创建 `source_aggregation_engine.dart`
- [ ] 2.2 实现 `TitleNormalizer`：
  - 调用 Rust FFI `normalize_title()`（繁简转换 + 去噪声）
  - 缓存标准化结果避免重复计算
- [ ] 2.3 实现 `SimilarityCalculator`：
  - 调用 Rust FFI `jaccard()` 和 `levenshtein()`
  - 综合评分算法（加权组合）
- [ ] 2.4 实现 `SourceMerger`：
  - 接收多个规则的搜索结果（`List<SearchItem>`）
  - 计算所有项的相似度矩阵
  - 合并相似项（阈值判断）
  - 按权重排序（`rule.aggregation.weight`）
- [ ] 2.5 实现 `Stream<MergedResult>`：
  - 使用 `StreamController`
  - 随源返回逐步更新结果

## 3. 搜索服务集成

- [ ] 3.1 更新 `SearchService`：
  - 使用 `execute_lifecycle_phase()` 替代底层 API
  - 并行执行多个规则的搜索
  - 将结果传递给 `SourceAggregationEngine`
- [ ] 3.2 实现错误处理：
  - 某些源失败不影响整体
  - 记录失败源（用于调试）
- [ ] 3.3 运行 `flutter analyze` 确保 Dart 代码质量

## 4. UI 集成

- [ ] 4.1 重构 `SearchPage`：
  - 消费 `Stream<MergedResult>` 而非 `Future<List>`
  - 显示加载状态
- [ ] 4.2 更新 `SearchItemCard`：
  - 显示聚合源数量（如 `[6 Sources]`）
  - 显示最佳源标识
- [ ] 4.3 实现渐进式更新：
  - 新结果到达时平滑添加到列表
  - 避免列表跳动

## 5. 性能优化

- [ ] 5.1 实现预过滤：
  - 只比较可能相似的项（首字符、长度范围）
  - 减少不必要的相似度计算
- [ ] 5.2 实现缓存：
  - 缓存标准化标题
  - 缓存相似度计算结果
- [ ] 5.3 性能测试：
  - 测试 10 源 × 100 项的聚合时间
  - 确保不超过 3 秒

## 6. 测试与验证

- [ ] 6.1 编写单元测试：
  - `TitleNormalizer` 测试
  - `SimilarityCalculator` 测试
  - `SourceMerger` 测试
- [ ] 6.2 编写集成测试：
  - 模拟多源搜索场景
  - 验证合并逻辑
- [ ] 6.3 真实场景测试：
  - 搜索真实内容（如 "火影忍者"）
  - 验证多源聚合效果
- [ ] 6.4 运行 `flutter analyze` 确保无错误
