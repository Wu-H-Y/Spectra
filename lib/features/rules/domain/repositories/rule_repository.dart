import 'package:fpdart/fpdart.dart';
import 'package:spectra/core/functional/failures.dart';
import 'package:spectra/features/rules/domain/entities/rule.dart';

/// 规则仓库接口。
abstract class RuleRepository {
  /// 获取全部规则。
  Future<List<Rule>> getAllRules();

  /// 按规则 ID 获取规则。
  Future<Rule?> getRuleById(String id);

  /// 从本地文件导入规则。
  Future<Either<Failure, Rule>> importRuleFromFile(String filePath);

  /// 从远程 URL 导入规则。
  Future<Either<Failure, Rule>> importRuleFromUrl(String url);

  /// 校验规则 JSON。
  Future<Either<Failure, void>> validateRule(String ruleJson);
}
