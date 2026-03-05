## Why

用户搜索时，Spectra 会查询所有已安装的规则/数据源，返回碎片化结果，相同内容在不同来源重复出现。需要统一的聚合引擎，智能合并来自不同来源的相同内容，并为播放或阅读选择最佳来源。

## What Changes

- **聚合引擎**: 使用 Jaccard/Levenshtein 相似度合并相同搜索结果（基于标题、作者、类型）
- **搜索策略**: 支持多种搜索模式： `ExactSearchStrategy` (全文匹配) vs `FuzzySearchStrategy` (分词搜索)
- **API 适配**: 使用新的 `execute_lifecycle_phase()` API 简化调用
- **章节去重**: 合并不同提供者的章节时处理 off-by-one 错误

## Capabilities

### New Capabilities

- `source-aggregation-engine`: 将 N 个分散的搜索列表合并为统一列表，优先使用最高质量的源

### Modified Capabilities

- `crawler-rule-executor`: 使用新的 `execute_lifecycle_phase()` API 执行搜索阶段

## Impact

- 创建 `lib/core/aggregation/` 模块
- 使用 Rust FFI 计算文本相似度（性能优先）
- 影响 `SearchPage` UI 层，显示合并后的源表示而非独立网站结果
- 简化规则执行逻辑（使用新 API）
