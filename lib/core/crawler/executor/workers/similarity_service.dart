/// 相似度计算 Worker Service
///
/// 使用 Squadron 在独立 Isolate 中执行相似度计算，
/// 调用 Rust FFI 实现 (jieba-rs 分词 + textdistance 算法)
library;

import 'dart:async';

import 'package:spectra/core/crawler/executor/workers/similarity_service.activator.g.dart';
import 'package:spectra/core/rust/api/similarity.dart' as rust_api;
import 'package:squadron/squadron.dart';

part 'similarity_service.worker.g.dart';

/// 相似度计算服务
///
/// 封装 Rust FFI 相似度算法，在独立线程执行以避免阻塞 UI
@SquadronService(
  baseUrl: '~/workers',
)
base class SimilarityService {
  /// 计算 Jaccard 相似度
  ///
  /// 基于中文分词计算两个字符串的 Jaccard 相似度
  ///
  /// [a] 第一个字符串
  /// [b] 第二个字符串
  ///
  /// 返回相似度值 (0.0 ~ 1.0)
  @SquadronMethod()
  FutureOr<double> jaccard(String a, String b) {
    return rust_api.jaccard(a: a, b: b);
  }

  /// 计算 Levenshtein 相似度
  ///
  /// 使用 textdistance 库计算编辑距离相似度
  ///
  /// [a] 第一个字符串
  /// [b] 第二个字符串
  ///
  /// 返回相似度值 (0.0 ~ 1.0)
  @SquadronMethod()
  FutureOr<double> levenshtein(String a, String b) {
    return rust_api.levenshtein(a: a, b: b);
  }

  /// 计算 Sørensen-Dice 相似度
  ///
  /// 基于中文分词计算词组序列的 Sørensen-Dice 相似度
  /// 比 Jaccard 更强调共同元素
  ///
  /// [a] 第一个字符串
  /// [b] 第二个字符串
  ///
  /// 返回相似度值 (0.0 ~ 1.0)
  @SquadronMethod()
  FutureOr<double> sorensenDice(String a, String b) {
    return rust_api.sorensenDice(a: a, b: b);
  }

  /// 计算词组序列的 Levenshtein 相似度
  ///
  /// 基于中文分词后计算词组序列的编辑距离相似度
  /// 对词序敏感，适合标题匹配
  ///
  /// [a] 第一个字符串
  /// [b] 第二个字符串
  ///
  /// 返回相似度值 (0.0 ~ 1.0)
  @SquadronMethod()
  FutureOr<double> levenshteinTokens(String a, String b) {
    return rust_api.levenshteinTokens(a: a, b: b);
  }

  /// 标题标准化
  ///
  /// 统一标题格式：
  /// 1. 繁体转简体
  /// 2. 去除元数据模式
  /// 3. 转小写
  /// 4. 合并空白
  ///
  /// [title] 原始标题
  ///
  /// 返回标准化后的标题
  @SquadronMethod()
  FutureOr<String> normalizeTitle(String title) {
    return rust_api.normalizeTitle(title: title);
  }

  /// 模糊搜索评分
  ///
  /// 综合计算搜索词与目标标题的相似度
  /// 算法: sorensen_dice * 0.4 + levenshtein_tokens * 0.4 + levenshtein * 0.2
  ///
  /// [query] 搜索词
  /// [target] 目标标题
  ///
  /// 返回综合相似度分数 (0.0 ~ 1.0)
  @SquadronMethod()
  FutureOr<double> fuzzySearchScore(String query, String target) {
    return rust_api.fuzzySearchScore(query: query, target: target);
  }

  /// 批量计算 Jaccard 相似度
  ///
  /// 用于多源聚合时批量计算相似度
  ///
  /// [query] 查询字符串
  /// [targets] 目标字符串列表
  ///
  /// 返回相似度列表 (与 targets 一一对应)
  @SquadronMethod()
  FutureOr<List<double>> batchJaccard(String query, List<String> targets) {
    return Future.wait(
      targets.map((t) => rust_api.jaccard(a: query, b: t)),
    );
  }

  /// 批量计算模糊搜索评分
  ///
  /// 用于多源聚合时批量计算综合相似度
  ///
  /// [query] 查询字符串
  /// [targets] 目标字符串列表
  ///
  /// 返回相似度列表 (与 targets 一一对应)
  @SquadronMethod()
  FutureOr<List<double>> batchFuzzySearchScore(
    String query,
    List<String> targets,
  ) {
    return Future.wait(
      targets.map((t) => rust_api.fuzzySearchScore(query: query, target: t)),
    );
  }
}
