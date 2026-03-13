import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/database/drift/app_database.dart';
import 'package:spectra/core/functional/failures.dart';
import 'package:spectra/features/rules/data/datasources/local/rules_dao.dart';
import 'package:spectra/features/rules/data/models/rule_model.dart';
import 'package:spectra/features/rules/data/repositories/rule_repository_impl.dart';
import 'package:spectra/features/rules/domain/entities/rule.dart';
import 'package:spectra/features/rules/domain/repositories/rule_repository.dart';
import 'package:spectra/shared/providers/talker_provider.dart';

part 'rules_provider.freezed.dart';

/// 规则模块数据库 Provider。
final rulesDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

/// RulesDao Provider。
final rulesDaoProvider = Provider<RulesDao>((ref) {
  return RulesDao(ref.watch(rulesDatabaseProvider));
});

/// 规则仓库 Provider。
final ruleRepositoryProvider = Provider<RuleRepository>((ref) {
  return RuleRepositoryImpl(rulesDao: ref.watch(rulesDaoProvider));
});

/// 规则列表 Provider。
final rulesListProvider = StreamProvider<List<Rule>>((ref) {
  final dao = ref.watch(rulesDaoProvider);
  return dao.watchRules().map(
    (rows) => rows.map(RuleModel.fromDatabase).toList(growable: false),
  );
});

/// 规则导入状态。
@freezed
sealed class RulesImportState with _$RulesImportState {
  /// 创建规则导入状态。
  const factory RulesImportState({
    @Default(false) bool isImporting,
    Failure? failure,
  }) = _RulesImportState;
}

/// 规则导入控制器 Provider。
final NotifierProvider<RulesImportNotifier, RulesImportState>
rulesImportProvider = NotifierProvider<RulesImportNotifier, RulesImportState>(
  RulesImportNotifier.new,
);

/// 规则导入控制器。
class RulesImportNotifier extends Notifier<RulesImportState> {
  @override
  RulesImportState build() {
    return const RulesImportState();
  }

  /// 导入规则文件。
  Future<Either<Failure, Rule>> importRuleFromFile(String filePath) async {
    if (state.isImporting) {
      return left(const ValidationFailure('规则正在导入中，请稍后重试'));
    }

    state = state.copyWith(isImporting: true, failure: null);
    final talker = ref.read(talkerProvider);

    try {
      final repository = ref.read(ruleRepositoryProvider);
      final result = await repository.importRuleFromFile(filePath);
      return result.match(
        (failure) {
          talker.debug('规则导入失败: ${failure.message}');
          state = state.copyWith(isImporting: false, failure: failure);
          return left(failure);
        },
        (rule) {
          talker.debug('规则导入成功: ${rule.id}');
          ref.invalidate(rulesListProvider);
          state = state.copyWith(isImporting: false, failure: null);
          return right(rule);
        },
      );
    } on Exception catch (error, stackTrace) {
      final failure = failureFromException(error, stackTrace);
      talker.debug('规则导入异常: ${failure.message}');
      state = state.copyWith(isImporting: false, failure: failure);
      return left(failure);
    }
  }

  /// 通过 URL 导入规则。
  Future<Either<Failure, Rule>> importRuleFromUrl(String url) async {
    if (state.isImporting) {
      return left(const ValidationFailure('规则正在导入中，请稍后重试'));
    }

    state = state.copyWith(isImporting: true, failure: null);
    final talker = ref.read(talkerProvider);

    try {
      final repository = ref.read(ruleRepositoryProvider);
      final result = await repository.importRuleFromUrl(url);
      return result.match(
        (failure) {
          talker.debug('规则 URL 导入失败: ${failure.message}');
          state = state.copyWith(isImporting: false, failure: failure);
          return left(failure);
        },
        (rule) {
          talker.debug('规则 URL 导入成功: ${rule.id}');
          ref.invalidate(rulesListProvider);
          state = state.copyWith(isImporting: false, failure: null);
          return right(rule);
        },
      );
    } on Exception catch (error, stackTrace) {
      final failure = failureFromException(error, stackTrace);
      talker.debug('规则 URL 导入异常: ${failure.message}');
      state = state.copyWith(isImporting: false, failure: failure);
      return left(failure);
    }
  }
}
