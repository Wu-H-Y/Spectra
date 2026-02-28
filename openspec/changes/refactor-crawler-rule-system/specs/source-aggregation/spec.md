# Source Aggregation

## Overview

多源聚合模块负责将来自不同爬虫规则的搜索结果合并、去重，并按权重自动优选最佳来源。

**架构说明**: 相似度计算使用 Rust FFI 实现 (textdistance 库)，在 Rust 层完成高性能的 Jaccard/Levenshtein 相似度计算。

## Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        Aggregation Pipeline                              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌──────────┐   ┌──────────┐   ┌──────────┐                            │
│  │ Source A │   │ Source B │   │ Source C │                            │
│  │ Rule 1   │   │ Rule 2   │   │ Rule 3   │                            │
│  └────┬─────┘   └────┬─────┘   └────┬─────┘                            │
│       │              │              │                                   │
│       ▼              ▼              ▼                                   │
│  ┌─────────────────────────────────────────────────────┐                │
│  │                 Search Results                       │                │
│  │  [Item A1, Item A2, ...] [Item B1, ...] [Item C1]   │                │
│  └────────────────────────┬────────────────────────────┘                │
│                           │                                              │
│                           ▼                                              │
│  ┌─────────────────────────────────────────────────────┐                │
│  │              1. Normalization                        │                │
│  │  - Title: lowercase, remove metadata, trim          │                │
│  │  - Author: standardize separators                   │                │
│  └────────────────────────┬────────────────────────────┘                │
│                           │                                              │
│                           ▼                                              │
│  ┌─────────────────────────────────────────────────────┐                │
│  │              2. Similarity Matching                  │                │
│  │  - Calculate Jaccard / Levenshtein similarity       │                │
│  │  - Group by combined threshold                      │                │
│  └────────────────────────┬────────────────────────────┘                │
│                           │                                              │
│                           ▼                                              │
│  ┌─────────────────────────────────────────────────────┐                │
│  │              3. Merge & Prioritize                   │                │
│  │  - Merge matched items                               │                │
│  │  - Sort by source weight + connect rate              │                │
│  └────────────────────────┬────────────────────────────┘                │
│                           │                                              │
│                           ▼                                              │
│  ┌─────────────────────────────────────────────────────┐                │
│  │              4. Output                               │                │
│  │  [MergedItem { sources: [A, B], primary: A }]       │                │
│  └─────────────────────────────────────────────────────┘                │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

## Models

### Aggregation Config

```dart
@freezed
class AggregationConfig with _$AggregationConfig {
  const factory AggregationConfig({
    /// 是否启用聚合
    @Default(true) bool enabled,
    
    /// 源权重 (0-100)
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
    @Default(_defaultDimensions) List<MatchingDimension> dimensions,
    
    /// 综合阈值
    @Default(0.85) double combinedThreshold,
  }) = _MatchingConfig;
}

const _defaultDimensions = [
  MatchingDimension(field: 'title', matchType: MatchType.fuzzy, weight: 1.0, threshold: 0.96),
  MatchingDimension(field: 'author', matchType: MatchType.fuzzy, weight: 0.8, threshold: 0.90),
];
```

### Matching Dimension

```dart
@freezed
class MatchingDimension with _$MatchingDimension {
  const factory MatchingDimension({
    /// 字段名
    required String field,
    
    /// 匹配类型
    @Default(MatchType.fuzzy) MatchType matchType,
    
    /// 权重 (0-1)
    @Default(1.0) double weight,
    
    /// 相似度阈值 (fuzzy)
    @Default(0.96) double threshold,
    
    /// 标准化配置
    NormalizationConfig? normalize,
  }) = _MatchingDimension;
}

enum MatchType {
  /// 精确匹配
  exact,
  
  /// 模糊匹配
  fuzzy,
  
  /// 标准化后精确匹配
  normalized,
}
```

### Normalization Config

```dart
@freezed
class NormalizationConfig with _$NormalizationConfig {
  const factory NormalizationConfig({
    /// 转小写
    @Default(true) bool lowercase,
    
    /// 去除标点
    @Default(true) bool trimPunctuation,
    
    /// 去除空白
    @Default(true) bool trimWhitespace,
    
    /// 繁体转简体
    @Default(true) bool traditionalToSimplified,
    
    /// 全角转半角
    @Default(true) bool fullWidthToHalfWidth,
    
    /// 去除元数据模式
    @Default(true) bool removeMetadata,
    
    /// 自定义替换
    List<ReplacementRule>? replacements,
  }) = _NormalizationConfig;
}

@freezed
class ReplacementRule with _$ReplacementRule {
  const factory ReplacementRule({
    required String pattern,
    @Default('') String replacement,
  }) = _ReplacementRule;
}
```

### Merged Item

```dart
@freezed
class MergedItem with _$MergedItem {
  const factory MergedItem({
    /// 标准化后的标识
    required StandardIdentity identity,
    
    /// 所有来源的原始数据
    required List<SourceItem> sources,
    
    /// 主来源 (权重最高/连接最好)
    required String primarySourceId,
    
    /// 合并后的展示数据
    required Map<String, dynamic> data,
    
    /// 匹配置信度
    required double confidence,
  }) = _MergedItem;
}

@freezed
class SourceItem with _$SourceItem {
  const factory SourceItem({
    /// 来源规则 ID
    required String sourceId,
    
    /// 来源 URL
    required String url,
    
    /// 原始数据
    required Map<String, dynamic> rawData,
    
    /// 权重
    required int weight,
    
    /// 历史连通率
    double? connectRate,
    
    /// 平均响应时间 (ms)
    int? avgResponseTime,
  }) = _SourceItem;
}

@freezed
class StandardIdentity with _$StandardIdentity {
  const factory StandardIdentity({
    /// 标准化标题
    required String titleNorm,
    
    /// 标准化作者
    String? authorNorm,
    
    /// 年份 (可选辅助)
    int? year,
  }) = _StandardIdentity;
}
```

## Algorithms

### 1. Title Normalization

```dart
class TitleNormalizer {
  static final _metadataPatterns = [
    RegExp(r'\([^)]*\)'),      // (2024) (HD)
    RegExp(r'【[^】]*】'),      // 【推荐】
    RegExp(r'\[[^\]]*\]'),     // [完本]
    RegExp(r'《[^》]*》'),      // 《书名》
    RegExp(r'<[^>]*>'),        // <转载>
    RegExp(r'第\s*\d+\s*章'),  // 第123章
    RegExp(r'Chapter\s*\d+'),  // Chapter 123
  ];
  
  String normalize(String title, NormalizationConfig config) {
    var result = title;
    
    // 1. 去除元数据
    if (config.removeMetadata) {
      for (final pattern in _metadataPatterns) {
        result = result.replaceAll(pattern, '');
      }
    }
    
    // 2. 繁体转简体
    if (config.traditionalToSimplified) {
      result = ChineseConverter.toSimplified(result);
    }
    
    // 3. 全角转半角
    if (config.fullWidthToHalfWidth) {
      result = _fullWidthToHalfWidth(result);
    }
    
    // 4. 转小写
    if (config.lowercase) {
      result = result.toLowerCase();
    }
    
    // 5. 去除标点
    if (config.trimPunctuation) {
      result = result.replaceAll(RegExp(r'[^\w\s\u4e00-\u9fa5]'), '');
    }
    
    // 6. 去除空白
    if (config.trimWhitespace) {
      result = result.replaceAll(RegExp(r'\s+'), ' ').trim();
    }
    
    // 7. 自定义替换
    if (config.replacements != null) {
      for (final rule in config.replacements!) {
        result = result.replaceAll(RegExp(rule.pattern), rule.replacement);
      }
    }
    
    return result;
  }
}
```

### 2. 相似度计算 (Rust FFI 实现 - 2026-02-22 更新)

> **注意**: 相似度计算已迁移到 Rust FFI 实现，使用 jieba-rs 进行中文分词，
> textdistance 库进行相似度计算。
> 详见 `lib/core/crawler/executor/workers/similarity_service.dart`

**可用算法**:
- **Jaccard**: 词集匹配，对词序不敏感
- **Levenshtein**: 字符级编辑距离，使用 textdistance 库
- **Sørensen-Dice**: 词组序列匹配，比 Jaccard 更强调共同元素
- **Levenshtein-Tokens**: 词组序列编辑距离，对词序敏感

**综合评分算法**: `sorensen_dice * 0.4 + levenshtein_tokens * 0.4 + levenshtein * 0.2`

~~### 2. Jaccard Similarity (旧实现已删除)~~

```dart
class JaccardSimilarity {
  /// 计算 Jaccard 相似度
  /// 返回值: 0.0 - 1.0
  double calculate(String a, String b) {
    final tokensA = _tokenize(a);
    final tokensB = _tokenize(b);
    
    if (tokensA.isEmpty && tokensB.isEmpty) return 1.0;
    if (tokensA.isEmpty || tokensB.isEmpty) return 0.0;
    
    final intersection = tokensA.intersection(tokensB).length;
    final union = tokensA.union(tokensB).length;
    
    return union > 0 ? intersection / union : 0.0;
  }
  
  Set<String> _tokenize(String text) {
    return text
        .toLowerCase()
        .split(RegExp(r'[\s\-_:/]+'))
        .where((t) => t.isNotEmpty)
        .toSet();
  }
}
```

### 3. Levenshtein Distance

```dart
class LevenshteinDistance {
  /// 计算编辑距离
  int distance(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;
    
    // 空间优化: 只用两行
    var prev = List.generate(b.length + 1, (i) => i);
    var curr = List.filled(b.length + 1, 0);
    
    for (var i = 1; i <= a.length; i++) {
      curr[0] = i;
      for (var j = 1; j <= b.length; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        curr[j] = [
          prev[j] + 1,     // 删除
          curr[j - 1] + 1, // 插入
          prev[j - 1] + cost, // 替换
        ].reduce(min);
      }
      final temp = prev;
      prev = curr;
      curr = temp;
    }
    
    return prev[b.length];
  }
  
  /// 计算相似度 (0.0 - 1.0)
  double similarity(String a, String b) {
    if (a == b) return 1.0;
    if (a.isEmpty || b.isEmpty) return 0.0;
    
    final dist = distance(a, b);
    final maxLen = max(a.length, b.length);
    
    return 1.0 - (dist / maxLen);
  }
}
```

### 4. Source Merger

```dart
class SourceMerger {
  final JaccardSimilarity _jaccard = JaccardSimilarity();
  final LevenshteinDistance _levenshtein = LevenshteinDistance();
  final TitleNormalizer _normalizer = TitleNormalizer();
  
  /// 合并多个源的结果
  List<MergedItem> merge(
    Map<String, List<Map<String, dynamic>>> sourceResults,
    AggregationConfig config,
  ) {
    final allItems = <_ItemWithSource>[];
    
    // 收集所有项目
    for (final entry in sourceResults.entries) {
      for (final item in entry.value) {
        allItems.add(_ItemWithSource(
          sourceId: entry.key,
          data: item,
          identity: _createIdentity(item, config.matching),
        ));
      }
    }
    
    // 按相似度分组
    final groups = <List<_ItemWithSource>>[];
    final used = <int>{};
    
    for (var i = 0; i < allItems.length; i++) {
      if (used.contains(i)) continue;
      
      final group = <_ItemWithSource>[allItems[i]];
      used.add(i);
      
      for (var j = i + 1; j < allItems.length; j++) {
        if (used.contains(j)) continue;
        
        final similarity = _calculateSimilarity(
          allItems[i].identity,
          allItems[j].identity,
          config.matching,
        );
        
        if (similarity >= config.matching.combinedThreshold) {
          group.add(allItems[j]);
          used.add(j);
        }
      }
      
      groups.add(group);
    }
    
    // 转换为 MergedItem
    return groups.map((group) => _createMergedItem(group, config)).toList();
  }
  
  double _calculateSimilarity(
    StandardIdentity a,
    StandardIdentity b,
    MatchingConfig config,
  ) {
    var totalWeight = 0.0;
    var weightedScore = 0.0;
    
    for (final dim in config.dimensions) {
      final valueA = _getFieldValue(a, dim.field);
      final valueB = _getFieldValue(b, dim.field);
      
      if (valueA == null || valueB == null) continue;
      
      final score = switch (dim.matchType) {
        MatchType.exact => valueA == valueB ? 1.0 : 0.0,
        MatchType.normalized => _jaccard.calculate(valueA, valueB),
        MatchType.fuzzy => _calculateFuzzyScore(valueA, valueB, dim.threshold),
      };
      
      weightedScore += score * dim.weight;
      totalWeight += dim.weight;
    }
    
    return totalWeight > 0 ? weightedScore / totalWeight : 0.0;
  }
  
  double _calculateFuzzyScore(String a, String b, double threshold) {
    // 先用 Jaccard (快速)
    final jaccardScore = _jaccard.calculate(a, b);
    if (jaccardScore >= threshold) return jaccardScore;
    
    // Jaccard 不够，用 Levenshtein (更精确)
    final levenshteinScore = _levenshtein.similarity(a, b);
    return max(jaccardScore, levenshteinScore);
  }
}
```

### 5. Source Router

```dart
class SourceRouter {
  /// 选择最佳来源
  SourceItem selectBestSource(
    MergedItem item,
    RoutingStrategy strategy,
  ) {
    final sources = item.sources;
    
    return switch (strategy) {
      RoutingStrategy.highestWeight => sources.reduce(
        (a, b) => a.weight > b.weight ? a : b),
      
      RoutingStrategy.bestConnectRate => sources.reduce(
        (a, b) => (a.connectRate ?? 0) > (b.connectRate ?? 0) ? a : b),
      
      RoutingStrategy.fastestResponse => sources.reduce(
        (a, b) => (a.avgResponseTime ?? 999999) < (b.avgResponseTime ?? 999999) ? a : b),
      
      RoutingStrategy.balanced => _selectBalanced(sources),
    };
  }
  
  SourceItem _selectBalanced(List<SourceItem> sources) {
    // 综合考虑权重、连通率、响应时间
    return sources.reduce((a, b) {
      final scoreA = _calculateBalancedScore(a);
      final scoreB = _calculateBalancedScore(b);
      return scoreA > scoreB ? a : b;
    });
  }
  
  double _calculateBalancedScore(SourceItem item) {
    final weightScore = item.weight / 100;
    final connectScore = item.connectRate ?? 0.5;
    final responseScore = 1.0 - min((item.avgResponseTime ?? 1000) / 5000, 1.0);
    
    return weightScore * 0.4 + connectScore * 0.4 + responseScore * 0.2;
  }
}

enum RoutingStrategy {
  highestWeight,
  bestConnectRate,
  fastestResponse,
  balanced,
}
```

## Chapter Deduplication

章节级别的去重 (参考 Legado 实现)。

```dart
class ChapterDeduplicator {
  final JaccardSimilarity _jaccard = JaccardSimilarity();
  
  /// 相似度阈值
  static const double similarityThreshold = 0.96;
  
  /// 搜索窗口大小
  static const int searchWindow = 10;
  
  /// 查找匹配章节
  int findMatchingChapter(
    String oldChapterName,
    int oldIndex,
    int oldTotal,
    List<Chapter> newChapters,
  ) {
    final normalizedOld = _normalizeChapterName(oldChapterName);
    final newTotal = newChapters.length;
    
    // 计算预期位置
    final expectedIndex = (oldIndex * newTotal / oldTotal).round();
    
    // 搜索窗口
    final searchStart = max(0, expectedIndex - searchWindow);
    final searchEnd = min(newTotal - 1, expectedIndex + searchWindow);
    
    var bestScore = 0.0;
    var bestIndex = expectedIndex;
    
    // Stage 1: Jaccard 相似度
    for (var i = searchStart; i <= searchEnd; i++) {
      final normalizedNew = _normalizeChapterName(newChapters[i].title);
      final score = _jaccard.calculate(normalizedOld, normalizedNew);
      
      if (score > bestScore) {
        bestScore = score;
        bestIndex = i;
      }
    }
    
    // Stage 2: 章节号回退
    if (bestScore < similarityThreshold) {
      final oldChapterNum = _extractChapterNumber(oldChapterName);
      
      for (var i = searchStart; i <= searchEnd; i++) {
        final newChapterNum = _extractChapterNumber(newChapters[i].title);
        
        if (newChapterNum == oldChapterNum && oldChapterNum > 0) {
          return i;
        }
      }
    }
    
    return bestScore > similarityThreshold ? bestIndex : expectedIndex;
  }
  
  String _normalizeChapterName(String name) {
    return name
        .replaceAll(RegExp(r'第?\s*\d+\s*章?'), '')
        .replaceAll(RegExp(r'Chapter\s*\d+'), '')
        .trim()
        .toLowerCase();
  }
  
  int _extractChapterNumber(String name) {
    final match = RegExp(r'(\d+)').firstMatch(name);
    return match != null ? int.parse(match.group(1)!) : -1;
  }
}
```

## Performance Considerations

1. **搜索窗口**: 限制比较范围到 ±10，避免 O(n²)
2. **缓存标准化结果**: 相同字符串只标准化一次
3. **提前终止**: 完美匹配 (score == 1.0) 时立即返回
4. **并行处理**: 多个源的结果可以并行获取

## Configuration Example

```json
{
  "aggregation": {
    "enabled": true,
    "weight": 90,
    "matching": {
      "strategy": "fuzzy",
      "dimensions": [
        {
          "field": "title",
          "matchType": "fuzzy",
          "weight": 1.0,
          "threshold": 0.96,
          "normalize": {
            "lowercase": true,
            "trimPunctuation": true,
            "traditionalToSimplified": true
          }
        },
        {
          "field": "author",
          "matchType": "fuzzy",
          "weight": 0.8,
          "threshold": 0.90
        }
      ],
      "combinedThreshold": 0.85
    }
  }
}
```
