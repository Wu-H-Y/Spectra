import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:spectra/core/functional/failures.dart';
import 'package:spectra/features/rules/data/datasources/local/rules_dao.dart';
import 'package:spectra/features/rules/data/models/rule_model.dart';
import 'package:spectra/features/rules/domain/entities/rule.dart';
import 'package:spectra/features/rules/domain/repositories/rule_repository.dart';
import 'package:spectra/features/rules/domain/validators/rule_validator.dart';

/// 规则 JSON 抓取函数。
typedef RuleJsonFetcher = Future<String> Function(Uri uri);

/// 规则仓库实现。
class RuleRepositoryImpl implements RuleRepository {
  /// 创建规则仓库实现。
  RuleRepositoryImpl({
    required RulesDao rulesDao,
    RuleValidator? validator,
    RuleJsonFetcher? fetchRuleJson,
  }) : _rulesDao = rulesDao,
       _validator = validator ?? const RuleValidator(),
       _fetchRuleJson = fetchRuleJson ?? _defaultFetchRuleJson;

  final RulesDao _rulesDao;
  final RuleValidator _validator;
  final RuleJsonFetcher _fetchRuleJson;

  static const _supportedExtensions = <String>{'.json', '.rule'};

  @override
  Future<List<Rule>> getAllRules() async {
    final rows = await _rulesDao.listRules();
    return rows.map(RuleModel.fromDatabase).toList(growable: false);
  }

  @override
  Future<Rule?> getRuleById(String id) async {
    final row = await _rulesDao.findByRuleId(id);
    if (row == null) {
      return null;
    }
    return RuleModel.fromDatabase(row);
  }

  @override
  Future<Either<Failure, Rule>> importRuleFromFile(String filePath) async {
    final extension = _resolveExtension(filePath);
    if (!_supportedExtensions.contains(extension)) {
      return left(const ValidationFailure('规则格式不正确，请检查文件内容'));
    }

    try {
      final file = File(filePath);
      if (!file.existsSync()) {
        return left(const ParseFailure('无法解析规则文件，请确认文件完整性'));
      }

      final rawJson = file.readAsStringSync();
      return _importRuleFromRawJson(rawJson);
    } on FormatException {
      return left(const ParseFailure('无法解析规则文件，请确认文件完整性'));
    } on Object catch (error, stackTrace) {
      return left(failureFromException(error, stackTrace));
    }
  }

  @override
  Future<Either<Failure, Rule>> importRuleFromUrl(String url) async {
    final uri = Uri.tryParse(url.trim());
    if (uri == null ||
        !uri.isAbsolute ||
        uri.host.isEmpty ||
        !(uri.scheme == 'http' || uri.scheme == 'https') ||
        _isForbiddenImportTarget(uri)) {
      return left(const ValidationFailure('规则 URL 不合法，请检查后重试'));
    }

    try {
      final rawJson = await _fetchRuleJson(uri);
      return _importRuleFromRawJson(rawJson);
    } on Object catch (error, stackTrace) {
      return left(failureFromException(error, stackTrace));
    }
  }

  bool _isForbiddenImportTarget(Uri uri) {
    final host = uri.host.trim().toLowerCase();
    if (host.isEmpty || host == 'localhost') {
      return true;
    }

    final address = InternetAddress.tryParse(host);
    return address?.isLoopback ?? false;
  }

  @override
  Future<Either<Failure, void>> validateRule(String ruleJson) async {
    try {
      final result = _validator.validateJsonString(ruleJson);
      if (result.isValid) {
        return right(null);
      }

      final versionError = result.errors.firstWhere(
        (error) => error.contains('规则版本'),
        orElse: () => '',
      );
      if (versionError.isNotEmpty) {
        return left(ValidationFailure(versionError));
      }

      final parseError = result.errors.firstWhere(
        (error) => error.contains('无法解析规则文件'),
        orElse: () => '',
      );
      if (parseError.isNotEmpty) {
        return left(ParseFailure(parseError));
      }

      final details = result.errors.join('\n');
      return left(ValidationFailure('规则格式不正确，请检查文件内容\n$details'));
    } on Object catch (error, stackTrace) {
      return left(failureFromException(error, stackTrace));
    }
  }

  String _resolveExtension(String filePath) {
    final fileName = filePath.toLowerCase();
    for (final ext in _supportedExtensions) {
      if (fileName.endsWith(ext)) {
        return ext;
      }
    }
    return '';
  }

  Future<Either<Failure, Rule>> _importRuleFromRawJson(String rawJson) async {
    final validation = await validateRule(rawJson);
    final validationFailure = validation.fold<Failure?>(identity, (_) => null);
    if (validationFailure != null) {
      return left(validationFailure);
    }

    final envelope = jsonDecode(rawJson) as Map<String, dynamic>;
    final rule = Rule.fromEnvelope(envelope);

    final id = await _rulesDao.upsertRule(
      ruleId: rule.metadata.ruleId,
      name: rule.metadata.name,
      description: rule.metadata.description,
      irVersion: rule.irVersion,
      ruleEnvelopeJson: rawJson,
      enabled: true,
    );

    final persistedRow = await _rulesDao.findById(id);
    if (persistedRow == null) {
      return left(const DatabaseFailure('规则保存失败，请稍后重试'));
    }

    return right(RuleModel.fromDatabase(persistedRow));
  }

  static Future<String> _defaultFetchRuleJson(Uri uri) async {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 15),
        validateStatus: (_) => true,
      ),
    );
    final response = await dio.get<String>(uri.toString());
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! >= 300) {
      throw HttpException(
        '规则下载失败，请稍后重试 (status=${response.statusCode})',
      );
    }

    final data = response.data;
    if (data == null || data.isEmpty) {
      throw const FormatException('无法解析规则文件，请确认文件完整性');
    }

    return data;
  }
}
