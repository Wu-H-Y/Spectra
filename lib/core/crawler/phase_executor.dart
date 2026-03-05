import 'package:spectra/core/rust/api/lifecycle_executor.dart';
import 'package:spectra/core/rust/domain/phase.dart';
import 'package:spectra/core/rust/domain/rule/crawler_rule.dart';

/// 生命周期阶段执行服务。
///
/// 统一封装 Rust 侧 `executeLifecyclePhase`，避免业务层直接拼装阶段上下文。
class PhaseExecutor {
  /// 执行搜索阶段。
  Future<PhaseResult> executeSearch({
    required CrawlerRule rule,
    required String keyword,
    int page = 1,
    Map<String, String>? vars,
  }) {
    return executeLifecyclePhase(
      rule: rule,
      phase: LifecyclePhase.search,
      context: PhaseContext(
        keyword: keyword,
        page: page,
        vars: vars,
      ),
    );
  }

  /// 执行详情阶段。
  Future<PhaseResult> executeDetail({
    required CrawlerRule rule,
    required String url,
    Map<String, String>? vars,
  }) {
    return executeLifecyclePhase(
      rule: rule,
      phase: LifecyclePhase.detail,
      context: PhaseContext(
        url: url,
        vars: vars,
      ),
    );
  }

  /// 执行目录阶段。
  Future<PhaseResult> executeToc({
    required CrawlerRule rule,
    required String url,
    Map<String, String>? vars,
  }) {
    return executeLifecyclePhase(
      rule: rule,
      phase: LifecyclePhase.toc,
      context: PhaseContext(
        url: url,
        vars: vars,
      ),
    );
  }

  /// 执行内容阶段。
  Future<PhaseResult> executeContent({
    required CrawlerRule rule,
    required String url,
    Map<String, String>? vars,
  }) {
    return executeLifecyclePhase(
      rule: rule,
      phase: LifecyclePhase.content,
      context: PhaseContext(
        url: url,
        vars: vars,
      ),
    );
  }
}
