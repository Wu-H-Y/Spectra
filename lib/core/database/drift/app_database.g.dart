// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CrawlRulesTable extends CrawlRules
    with TableInfo<$CrawlRulesTable, CrawlRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CrawlRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<String> ruleId = GeneratedColumn<String>(
    'rule_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CrawlRuleType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<CrawlRuleType>($CrawlRulesTable.$convertertype);
  static const VerificationMeta _patternMeta = const VerificationMeta(
    'pattern',
  );
  @override
  late final GeneratedColumn<String> pattern = GeneratedColumn<String>(
    'pattern',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('1.0.0'),
  );
  static const VerificationMeta _configMeta = const VerificationMeta('config');
  @override
  late final GeneratedColumn<String> config = GeneratedColumn<String>(
    'config',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _globalConfigMeta = const VerificationMeta(
    'globalConfig',
  );
  @override
  late final GeneratedColumn<String> globalConfig = GeneratedColumn<String>(
    'global_config',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayConfigMeta = const VerificationMeta(
    'displayConfig',
  );
  @override
  late final GeneratedColumn<String> displayConfig = GeneratedColumn<String>(
    'display_config',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('user'),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _iconUrlMeta = const VerificationMeta(
    'iconUrl',
  );
  @override
  late final GeneratedColumn<String> iconUrl = GeneratedColumn<String>(
    'icon_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ruleId,
    name,
    description,
    type,
    pattern,
    version,
    config,
    globalConfig,
    displayConfig,
    source,
    enabled,
    iconUrl,
    author,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'crawl_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<CrawlRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('rule_id')) {
      context.handle(
        _ruleIdMeta,
        ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('pattern')) {
      context.handle(
        _patternMeta,
        pattern.isAcceptableOrUnknown(data['pattern']!, _patternMeta),
      );
    } else if (isInserting) {
      context.missing(_patternMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('config')) {
      context.handle(
        _configMeta,
        config.isAcceptableOrUnknown(data['config']!, _configMeta),
      );
    } else if (isInserting) {
      context.missing(_configMeta);
    }
    if (data.containsKey('global_config')) {
      context.handle(
        _globalConfigMeta,
        globalConfig.isAcceptableOrUnknown(
          data['global_config']!,
          _globalConfigMeta,
        ),
      );
    }
    if (data.containsKey('display_config')) {
      context.handle(
        _displayConfigMeta,
        displayConfig.isAcceptableOrUnknown(
          data['display_config']!,
          _displayConfigMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('icon_url')) {
      context.handle(
        _iconUrlMeta,
        iconUrl.isAcceptableOrUnknown(data['icon_url']!, _iconUrlMeta),
      );
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CrawlRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CrawlRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ruleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      type: $CrawlRulesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      pattern: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pattern'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version'],
      )!,
      config: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}config'],
      )!,
      globalConfig: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}global_config'],
      ),
      displayConfig: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_config'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      iconUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_url'],
      ),
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CrawlRulesTable createAlias(String alias) {
    return $CrawlRulesTable(attachedDatabase, alias);
  }

  static TypeConverter<CrawlRuleType, int> $convertertype =
      const CrawlRuleTypeConverter();
}

class CrawlRule extends DataClass implements Insertable<CrawlRule> {
  /// 规则 ID
  final int id;

  /// 规则唯一标识符 (用于导入导出和分享)
  final String ruleId;

  /// 规则名称
  final String name;

  /// 规则描述
  final String? description;

  /// 规则类型 (video, music, novel, comic, image, audio, rss, generic)
  final CrawlRuleType type;

  /// 目标网站 URL 模式
  final String pattern;

  /// 规则版本号 (语义化版本)
  final String version;

  /// 规则配置 (JSON 格式,包含 flows, nodes, edges, display)
  final String config;

  /// 全局配置 (JSON 格式,包含 baseUrl, headers, variables)
  final String? globalConfig;

  /// 展示配置 (JSON 格式,包含字段映射和模板配置)
  final String? displayConfig;

  /// 规则来源 (official/third_party/user)
  final String source;

  /// 是否启用
  final bool enabled;

  /// 规则图标 URL
  final String? iconUrl;

  /// 规则作者
  final String? author;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;
  const CrawlRule({
    required this.id,
    required this.ruleId,
    required this.name,
    this.description,
    required this.type,
    required this.pattern,
    required this.version,
    required this.config,
    this.globalConfig,
    this.displayConfig,
    required this.source,
    required this.enabled,
    this.iconUrl,
    this.author,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['rule_id'] = Variable<String>(ruleId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    {
      map['type'] = Variable<int>($CrawlRulesTable.$convertertype.toSql(type));
    }
    map['pattern'] = Variable<String>(pattern);
    map['version'] = Variable<String>(version);
    map['config'] = Variable<String>(config);
    if (!nullToAbsent || globalConfig != null) {
      map['global_config'] = Variable<String>(globalConfig);
    }
    if (!nullToAbsent || displayConfig != null) {
      map['display_config'] = Variable<String>(displayConfig);
    }
    map['source'] = Variable<String>(source);
    map['enabled'] = Variable<bool>(enabled);
    if (!nullToAbsent || iconUrl != null) {
      map['icon_url'] = Variable<String>(iconUrl);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CrawlRulesCompanion toCompanion(bool nullToAbsent) {
    return CrawlRulesCompanion(
      id: Value(id),
      ruleId: Value(ruleId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: Value(type),
      pattern: Value(pattern),
      version: Value(version),
      config: Value(config),
      globalConfig: globalConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(globalConfig),
      displayConfig: displayConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(displayConfig),
      source: Value(source),
      enabled: Value(enabled),
      iconUrl: iconUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(iconUrl),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CrawlRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CrawlRule(
      id: serializer.fromJson<int>(json['id']),
      ruleId: serializer.fromJson<String>(json['ruleId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      type: serializer.fromJson<CrawlRuleType>(json['type']),
      pattern: serializer.fromJson<String>(json['pattern']),
      version: serializer.fromJson<String>(json['version']),
      config: serializer.fromJson<String>(json['config']),
      globalConfig: serializer.fromJson<String?>(json['globalConfig']),
      displayConfig: serializer.fromJson<String?>(json['displayConfig']),
      source: serializer.fromJson<String>(json['source']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      iconUrl: serializer.fromJson<String?>(json['iconUrl']),
      author: serializer.fromJson<String?>(json['author']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ruleId': serializer.toJson<String>(ruleId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'type': serializer.toJson<CrawlRuleType>(type),
      'pattern': serializer.toJson<String>(pattern),
      'version': serializer.toJson<String>(version),
      'config': serializer.toJson<String>(config),
      'globalConfig': serializer.toJson<String?>(globalConfig),
      'displayConfig': serializer.toJson<String?>(displayConfig),
      'source': serializer.toJson<String>(source),
      'enabled': serializer.toJson<bool>(enabled),
      'iconUrl': serializer.toJson<String?>(iconUrl),
      'author': serializer.toJson<String?>(author),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CrawlRule copyWith({
    int? id,
    String? ruleId,
    String? name,
    Value<String?> description = const Value.absent(),
    CrawlRuleType? type,
    String? pattern,
    String? version,
    String? config,
    Value<String?> globalConfig = const Value.absent(),
    Value<String?> displayConfig = const Value.absent(),
    String? source,
    bool? enabled,
    Value<String?> iconUrl = const Value.absent(),
    Value<String?> author = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CrawlRule(
    id: id ?? this.id,
    ruleId: ruleId ?? this.ruleId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    type: type ?? this.type,
    pattern: pattern ?? this.pattern,
    version: version ?? this.version,
    config: config ?? this.config,
    globalConfig: globalConfig.present ? globalConfig.value : this.globalConfig,
    displayConfig: displayConfig.present
        ? displayConfig.value
        : this.displayConfig,
    source: source ?? this.source,
    enabled: enabled ?? this.enabled,
    iconUrl: iconUrl.present ? iconUrl.value : this.iconUrl,
    author: author.present ? author.value : this.author,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CrawlRule copyWithCompanion(CrawlRulesCompanion data) {
    return CrawlRule(
      id: data.id.present ? data.id.value : this.id,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      type: data.type.present ? data.type.value : this.type,
      pattern: data.pattern.present ? data.pattern.value : this.pattern,
      version: data.version.present ? data.version.value : this.version,
      config: data.config.present ? data.config.value : this.config,
      globalConfig: data.globalConfig.present
          ? data.globalConfig.value
          : this.globalConfig,
      displayConfig: data.displayConfig.present
          ? data.displayConfig.value
          : this.displayConfig,
      source: data.source.present ? data.source.value : this.source,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      iconUrl: data.iconUrl.present ? data.iconUrl.value : this.iconUrl,
      author: data.author.present ? data.author.value : this.author,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CrawlRule(')
          ..write('id: $id, ')
          ..write('ruleId: $ruleId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('pattern: $pattern, ')
          ..write('version: $version, ')
          ..write('config: $config, ')
          ..write('globalConfig: $globalConfig, ')
          ..write('displayConfig: $displayConfig, ')
          ..write('source: $source, ')
          ..write('enabled: $enabled, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('author: $author, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ruleId,
    name,
    description,
    type,
    pattern,
    version,
    config,
    globalConfig,
    displayConfig,
    source,
    enabled,
    iconUrl,
    author,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CrawlRule &&
          other.id == this.id &&
          other.ruleId == this.ruleId &&
          other.name == this.name &&
          other.description == this.description &&
          other.type == this.type &&
          other.pattern == this.pattern &&
          other.version == this.version &&
          other.config == this.config &&
          other.globalConfig == this.globalConfig &&
          other.displayConfig == this.displayConfig &&
          other.source == this.source &&
          other.enabled == this.enabled &&
          other.iconUrl == this.iconUrl &&
          other.author == this.author &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CrawlRulesCompanion extends UpdateCompanion<CrawlRule> {
  final Value<int> id;
  final Value<String> ruleId;
  final Value<String> name;
  final Value<String?> description;
  final Value<CrawlRuleType> type;
  final Value<String> pattern;
  final Value<String> version;
  final Value<String> config;
  final Value<String?> globalConfig;
  final Value<String?> displayConfig;
  final Value<String> source;
  final Value<bool> enabled;
  final Value<String?> iconUrl;
  final Value<String?> author;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CrawlRulesCompanion({
    this.id = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.pattern = const Value.absent(),
    this.version = const Value.absent(),
    this.config = const Value.absent(),
    this.globalConfig = const Value.absent(),
    this.displayConfig = const Value.absent(),
    this.source = const Value.absent(),
    this.enabled = const Value.absent(),
    this.iconUrl = const Value.absent(),
    this.author = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CrawlRulesCompanion.insert({
    this.id = const Value.absent(),
    required String ruleId,
    required String name,
    this.description = const Value.absent(),
    required CrawlRuleType type,
    required String pattern,
    this.version = const Value.absent(),
    required String config,
    this.globalConfig = const Value.absent(),
    this.displayConfig = const Value.absent(),
    this.source = const Value.absent(),
    this.enabled = const Value.absent(),
    this.iconUrl = const Value.absent(),
    this.author = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : ruleId = Value(ruleId),
       name = Value(name),
       type = Value(type),
       pattern = Value(pattern),
       config = Value(config);
  static Insertable<CrawlRule> custom({
    Expression<int>? id,
    Expression<String>? ruleId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? type,
    Expression<String>? pattern,
    Expression<String>? version,
    Expression<String>? config,
    Expression<String>? globalConfig,
    Expression<String>? displayConfig,
    Expression<String>? source,
    Expression<bool>? enabled,
    Expression<String>? iconUrl,
    Expression<String>? author,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ruleId != null) 'rule_id': ruleId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (pattern != null) 'pattern': pattern,
      if (version != null) 'version': version,
      if (config != null) 'config': config,
      if (globalConfig != null) 'global_config': globalConfig,
      if (displayConfig != null) 'display_config': displayConfig,
      if (source != null) 'source': source,
      if (enabled != null) 'enabled': enabled,
      if (iconUrl != null) 'icon_url': iconUrl,
      if (author != null) 'author': author,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CrawlRulesCompanion copyWith({
    Value<int>? id,
    Value<String>? ruleId,
    Value<String>? name,
    Value<String?>? description,
    Value<CrawlRuleType>? type,
    Value<String>? pattern,
    Value<String>? version,
    Value<String>? config,
    Value<String?>? globalConfig,
    Value<String?>? displayConfig,
    Value<String>? source,
    Value<bool>? enabled,
    Value<String?>? iconUrl,
    Value<String?>? author,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CrawlRulesCompanion(
      id: id ?? this.id,
      ruleId: ruleId ?? this.ruleId,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      pattern: pattern ?? this.pattern,
      version: version ?? this.version,
      config: config ?? this.config,
      globalConfig: globalConfig ?? this.globalConfig,
      displayConfig: displayConfig ?? this.displayConfig,
      source: source ?? this.source,
      enabled: enabled ?? this.enabled,
      iconUrl: iconUrl ?? this.iconUrl,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<String>(ruleId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $CrawlRulesTable.$convertertype.toSql(type.value),
      );
    }
    if (pattern.present) {
      map['pattern'] = Variable<String>(pattern.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (config.present) {
      map['config'] = Variable<String>(config.value);
    }
    if (globalConfig.present) {
      map['global_config'] = Variable<String>(globalConfig.value);
    }
    if (displayConfig.present) {
      map['display_config'] = Variable<String>(displayConfig.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (iconUrl.present) {
      map['icon_url'] = Variable<String>(iconUrl.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CrawlRulesCompanion(')
          ..write('id: $id, ')
          ..write('ruleId: $ruleId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('pattern: $pattern, ')
          ..write('version: $version, ')
          ..write('config: $config, ')
          ..write('globalConfig: $globalConfig, ')
          ..write('displayConfig: $displayConfig, ')
          ..write('source: $source, ')
          ..write('enabled: $enabled, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('author: $author, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CachedContentTable extends CachedContent
    with TableInfo<$CachedContentTable, CachedContentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedContentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<String> contentId = GeneratedColumn<String>(
    'content_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 128),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<int> ruleId = GeneratedColumn<int>(
    'rule_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES crawl_rules (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CrawlRuleType, int> mediaType =
      GeneratedColumn<int>(
        'media_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<CrawlRuleType>($CachedContentTable.$convertermediaType);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coverUrlMeta = const VerificationMeta(
    'coverUrl',
  );
  @override
  late final GeneratedColumn<String> coverUrl = GeneratedColumn<String>(
    'cover_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rawDataMeta = const VerificationMeta(
    'rawData',
  );
  @override
  late final GeneratedColumn<String> rawData = GeneratedColumn<String>(
    'raw_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    contentId,
    ruleId,
    mediaType,
    title,
    coverUrl,
    author,
    description,
    rawData,
    cachedAt,
    expiresAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_content';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedContentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('rule_id')) {
      context.handle(
        _ruleIdMeta,
        ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('cover_url')) {
      context.handle(
        _coverUrlMeta,
        coverUrl.isAcceptableOrUnknown(data['cover_url']!, _coverUrlMeta),
      );
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('raw_data')) {
      context.handle(
        _rawDataMeta,
        rawData.isAcceptableOrUnknown(data['raw_data']!, _rawDataMeta),
      );
    } else if (isInserting) {
      context.missing(_rawDataMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedContentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedContentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_id'],
      )!,
      ruleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rule_id'],
      )!,
      mediaType: $CachedContentTable.$convertermediaType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}media_type'],
        )!,
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      coverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_url'],
      ),
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      rawData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_data'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
    );
  }

  @override
  $CachedContentTable createAlias(String alias) {
    return $CachedContentTable(attachedDatabase, alias);
  }

  static TypeConverter<CrawlRuleType, int> $convertermediaType =
      const CrawlRuleTypeConverter();
}

class CachedContentData extends DataClass
    implements Insertable<CachedContentData> {
  /// 缓存 ID
  final int id;

  /// 内容唯一标识符 (用于多源关联)
  final String contentId;

  /// 关联的规则 ID
  final int ruleId;

  /// 媒体类型
  final CrawlRuleType mediaType;

  /// 内容标题
  final String title;

  /// 封面 URL
  final String? coverUrl;

  /// 作者
  final String? author;

  /// 描述
  final String? description;

  /// 原始数据 (JSON 格式)
  final String rawData;

  /// 缓存时间
  final DateTime cachedAt;

  /// 过期时间
  final DateTime? expiresAt;
  const CachedContentData({
    required this.id,
    required this.contentId,
    required this.ruleId,
    required this.mediaType,
    required this.title,
    this.coverUrl,
    this.author,
    this.description,
    required this.rawData,
    required this.cachedAt,
    this.expiresAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content_id'] = Variable<String>(contentId);
    map['rule_id'] = Variable<int>(ruleId);
    {
      map['media_type'] = Variable<int>(
        $CachedContentTable.$convertermediaType.toSql(mediaType),
      );
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || coverUrl != null) {
      map['cover_url'] = Variable<String>(coverUrl);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['raw_data'] = Variable<String>(rawData);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    return map;
  }

  CachedContentCompanion toCompanion(bool nullToAbsent) {
    return CachedContentCompanion(
      id: Value(id),
      contentId: Value(contentId),
      ruleId: Value(ruleId),
      mediaType: Value(mediaType),
      title: Value(title),
      coverUrl: coverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverUrl),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      rawData: Value(rawData),
      cachedAt: Value(cachedAt),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
    );
  }

  factory CachedContentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedContentData(
      id: serializer.fromJson<int>(json['id']),
      contentId: serializer.fromJson<String>(json['contentId']),
      ruleId: serializer.fromJson<int>(json['ruleId']),
      mediaType: serializer.fromJson<CrawlRuleType>(json['mediaType']),
      title: serializer.fromJson<String>(json['title']),
      coverUrl: serializer.fromJson<String?>(json['coverUrl']),
      author: serializer.fromJson<String?>(json['author']),
      description: serializer.fromJson<String?>(json['description']),
      rawData: serializer.fromJson<String>(json['rawData']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contentId': serializer.toJson<String>(contentId),
      'ruleId': serializer.toJson<int>(ruleId),
      'mediaType': serializer.toJson<CrawlRuleType>(mediaType),
      'title': serializer.toJson<String>(title),
      'coverUrl': serializer.toJson<String?>(coverUrl),
      'author': serializer.toJson<String?>(author),
      'description': serializer.toJson<String?>(description),
      'rawData': serializer.toJson<String>(rawData),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
    };
  }

  CachedContentData copyWith({
    int? id,
    String? contentId,
    int? ruleId,
    CrawlRuleType? mediaType,
    String? title,
    Value<String?> coverUrl = const Value.absent(),
    Value<String?> author = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? rawData,
    DateTime? cachedAt,
    Value<DateTime?> expiresAt = const Value.absent(),
  }) => CachedContentData(
    id: id ?? this.id,
    contentId: contentId ?? this.contentId,
    ruleId: ruleId ?? this.ruleId,
    mediaType: mediaType ?? this.mediaType,
    title: title ?? this.title,
    coverUrl: coverUrl.present ? coverUrl.value : this.coverUrl,
    author: author.present ? author.value : this.author,
    description: description.present ? description.value : this.description,
    rawData: rawData ?? this.rawData,
    cachedAt: cachedAt ?? this.cachedAt,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
  );
  CachedContentData copyWithCompanion(CachedContentCompanion data) {
    return CachedContentData(
      id: data.id.present ? data.id.value : this.id,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      title: data.title.present ? data.title.value : this.title,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
      author: data.author.present ? data.author.value : this.author,
      description: data.description.present
          ? data.description.value
          : this.description,
      rawData: data.rawData.present ? data.rawData.value : this.rawData,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedContentData(')
          ..write('id: $id, ')
          ..write('contentId: $contentId, ')
          ..write('ruleId: $ruleId, ')
          ..write('mediaType: $mediaType, ')
          ..write('title: $title, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('rawData: $rawData, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    contentId,
    ruleId,
    mediaType,
    title,
    coverUrl,
    author,
    description,
    rawData,
    cachedAt,
    expiresAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedContentData &&
          other.id == this.id &&
          other.contentId == this.contentId &&
          other.ruleId == this.ruleId &&
          other.mediaType == this.mediaType &&
          other.title == this.title &&
          other.coverUrl == this.coverUrl &&
          other.author == this.author &&
          other.description == this.description &&
          other.rawData == this.rawData &&
          other.cachedAt == this.cachedAt &&
          other.expiresAt == this.expiresAt);
}

class CachedContentCompanion extends UpdateCompanion<CachedContentData> {
  final Value<int> id;
  final Value<String> contentId;
  final Value<int> ruleId;
  final Value<CrawlRuleType> mediaType;
  final Value<String> title;
  final Value<String?> coverUrl;
  final Value<String?> author;
  final Value<String?> description;
  final Value<String> rawData;
  final Value<DateTime> cachedAt;
  final Value<DateTime?> expiresAt;
  const CachedContentCompanion({
    this.id = const Value.absent(),
    this.contentId = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.title = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.rawData = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
  });
  CachedContentCompanion.insert({
    this.id = const Value.absent(),
    required String contentId,
    required int ruleId,
    required CrawlRuleType mediaType,
    required String title,
    this.coverUrl = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    required String rawData,
    this.cachedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
  }) : contentId = Value(contentId),
       ruleId = Value(ruleId),
       mediaType = Value(mediaType),
       title = Value(title),
       rawData = Value(rawData);
  static Insertable<CachedContentData> custom({
    Expression<int>? id,
    Expression<String>? contentId,
    Expression<int>? ruleId,
    Expression<int>? mediaType,
    Expression<String>? title,
    Expression<String>? coverUrl,
    Expression<String>? author,
    Expression<String>? description,
    Expression<String>? rawData,
    Expression<DateTime>? cachedAt,
    Expression<DateTime>? expiresAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentId != null) 'content_id': contentId,
      if (ruleId != null) 'rule_id': ruleId,
      if (mediaType != null) 'media_type': mediaType,
      if (title != null) 'title': title,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (author != null) 'author': author,
      if (description != null) 'description': description,
      if (rawData != null) 'raw_data': rawData,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
    });
  }

  CachedContentCompanion copyWith({
    Value<int>? id,
    Value<String>? contentId,
    Value<int>? ruleId,
    Value<CrawlRuleType>? mediaType,
    Value<String>? title,
    Value<String?>? coverUrl,
    Value<String?>? author,
    Value<String?>? description,
    Value<String>? rawData,
    Value<DateTime>? cachedAt,
    Value<DateTime?>? expiresAt,
  }) {
    return CachedContentCompanion(
      id: id ?? this.id,
      contentId: contentId ?? this.contentId,
      ruleId: ruleId ?? this.ruleId,
      mediaType: mediaType ?? this.mediaType,
      title: title ?? this.title,
      coverUrl: coverUrl ?? this.coverUrl,
      author: author ?? this.author,
      description: description ?? this.description,
      rawData: rawData ?? this.rawData,
      cachedAt: cachedAt ?? this.cachedAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<int>(ruleId.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<int>(
        $CachedContentTable.$convertermediaType.toSql(mediaType.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (coverUrl.present) {
      map['cover_url'] = Variable<String>(coverUrl.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rawData.present) {
      map['raw_data'] = Variable<String>(rawData.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedContentCompanion(')
          ..write('id: $id, ')
          ..write('contentId: $contentId, ')
          ..write('ruleId: $ruleId, ')
          ..write('mediaType: $mediaType, ')
          ..write('title: $title, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('rawData: $rawData, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CrawlRulesTable crawlRules = $CrawlRulesTable(this);
  late final $CachedContentTable cachedContent = $CachedContentTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    crawlRules,
    cachedContent,
  ];
}

typedef $$CrawlRulesTableCreateCompanionBuilder =
    CrawlRulesCompanion Function({
      Value<int> id,
      required String ruleId,
      required String name,
      Value<String?> description,
      required CrawlRuleType type,
      required String pattern,
      Value<String> version,
      required String config,
      Value<String?> globalConfig,
      Value<String?> displayConfig,
      Value<String> source,
      Value<bool> enabled,
      Value<String?> iconUrl,
      Value<String?> author,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CrawlRulesTableUpdateCompanionBuilder =
    CrawlRulesCompanion Function({
      Value<int> id,
      Value<String> ruleId,
      Value<String> name,
      Value<String?> description,
      Value<CrawlRuleType> type,
      Value<String> pattern,
      Value<String> version,
      Value<String> config,
      Value<String?> globalConfig,
      Value<String?> displayConfig,
      Value<String> source,
      Value<bool> enabled,
      Value<String?> iconUrl,
      Value<String?> author,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CrawlRulesTableReferences
    extends BaseReferences<_$AppDatabase, $CrawlRulesTable, CrawlRule> {
  $$CrawlRulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CachedContentTable, List<CachedContentData>>
  _cachedContentRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cachedContent,
    aliasName: $_aliasNameGenerator(db.crawlRules.id, db.cachedContent.ruleId),
  );

  $$CachedContentTableProcessedTableManager get cachedContentRefs {
    final manager = $$CachedContentTableTableManager(
      $_db,
      $_db.cachedContent,
    ).filter((f) => f.ruleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cachedContentRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CrawlRulesTableFilterComposer
    extends Composer<_$AppDatabase, $CrawlRulesTable> {
  $$CrawlRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleId => $composableBuilder(
    column: $table.ruleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CrawlRuleType, CrawlRuleType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get config => $composableBuilder(
    column: $table.config,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get globalConfig => $composableBuilder(
    column: $table.globalConfig,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayConfig => $composableBuilder(
    column: $table.displayConfig,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconUrl => $composableBuilder(
    column: $table.iconUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> cachedContentRefs(
    Expression<bool> Function($$CachedContentTableFilterComposer f) f,
  ) {
    final $$CachedContentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cachedContent,
      getReferencedColumn: (t) => t.ruleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedContentTableFilterComposer(
            $db: $db,
            $table: $db.cachedContent,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CrawlRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $CrawlRulesTable> {
  $$CrawlRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleId => $composableBuilder(
    column: $table.ruleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get config => $composableBuilder(
    column: $table.config,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get globalConfig => $composableBuilder(
    column: $table.globalConfig,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayConfig => $composableBuilder(
    column: $table.displayConfig,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconUrl => $composableBuilder(
    column: $table.iconUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CrawlRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CrawlRulesTable> {
  $$CrawlRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ruleId =>
      $composableBuilder(column: $table.ruleId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CrawlRuleType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get pattern =>
      $composableBuilder(column: $table.pattern, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get config =>
      $composableBuilder(column: $table.config, builder: (column) => column);

  GeneratedColumn<String> get globalConfig => $composableBuilder(
    column: $table.globalConfig,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayConfig => $composableBuilder(
    column: $table.displayConfig,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<String> get iconUrl =>
      $composableBuilder(column: $table.iconUrl, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> cachedContentRefs<T extends Object>(
    Expression<T> Function($$CachedContentTableAnnotationComposer a) f,
  ) {
    final $$CachedContentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cachedContent,
      getReferencedColumn: (t) => t.ruleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CachedContentTableAnnotationComposer(
            $db: $db,
            $table: $db.cachedContent,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CrawlRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CrawlRulesTable,
          CrawlRule,
          $$CrawlRulesTableFilterComposer,
          $$CrawlRulesTableOrderingComposer,
          $$CrawlRulesTableAnnotationComposer,
          $$CrawlRulesTableCreateCompanionBuilder,
          $$CrawlRulesTableUpdateCompanionBuilder,
          (CrawlRule, $$CrawlRulesTableReferences),
          CrawlRule,
          PrefetchHooks Function({bool cachedContentRefs})
        > {
  $$CrawlRulesTableTableManager(_$AppDatabase db, $CrawlRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CrawlRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CrawlRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CrawlRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ruleId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<CrawlRuleType> type = const Value.absent(),
                Value<String> pattern = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<String> config = const Value.absent(),
                Value<String?> globalConfig = const Value.absent(),
                Value<String?> displayConfig = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<String?> iconUrl = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CrawlRulesCompanion(
                id: id,
                ruleId: ruleId,
                name: name,
                description: description,
                type: type,
                pattern: pattern,
                version: version,
                config: config,
                globalConfig: globalConfig,
                displayConfig: displayConfig,
                source: source,
                enabled: enabled,
                iconUrl: iconUrl,
                author: author,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ruleId,
                required String name,
                Value<String?> description = const Value.absent(),
                required CrawlRuleType type,
                required String pattern,
                Value<String> version = const Value.absent(),
                required String config,
                Value<String?> globalConfig = const Value.absent(),
                Value<String?> displayConfig = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<String?> iconUrl = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CrawlRulesCompanion.insert(
                id: id,
                ruleId: ruleId,
                name: name,
                description: description,
                type: type,
                pattern: pattern,
                version: version,
                config: config,
                globalConfig: globalConfig,
                displayConfig: displayConfig,
                source: source,
                enabled: enabled,
                iconUrl: iconUrl,
                author: author,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CrawlRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cachedContentRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cachedContentRefs) db.cachedContent,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cachedContentRefs)
                    await $_getPrefetchedData<
                      CrawlRule,
                      $CrawlRulesTable,
                      CachedContentData
                    >(
                      currentTable: table,
                      referencedTable: $$CrawlRulesTableReferences
                          ._cachedContentRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CrawlRulesTableReferences(
                            db,
                            table,
                            p0,
                          ).cachedContentRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.ruleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CrawlRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CrawlRulesTable,
      CrawlRule,
      $$CrawlRulesTableFilterComposer,
      $$CrawlRulesTableOrderingComposer,
      $$CrawlRulesTableAnnotationComposer,
      $$CrawlRulesTableCreateCompanionBuilder,
      $$CrawlRulesTableUpdateCompanionBuilder,
      (CrawlRule, $$CrawlRulesTableReferences),
      CrawlRule,
      PrefetchHooks Function({bool cachedContentRefs})
    >;
typedef $$CachedContentTableCreateCompanionBuilder =
    CachedContentCompanion Function({
      Value<int> id,
      required String contentId,
      required int ruleId,
      required CrawlRuleType mediaType,
      required String title,
      Value<String?> coverUrl,
      Value<String?> author,
      Value<String?> description,
      required String rawData,
      Value<DateTime> cachedAt,
      Value<DateTime?> expiresAt,
    });
typedef $$CachedContentTableUpdateCompanionBuilder =
    CachedContentCompanion Function({
      Value<int> id,
      Value<String> contentId,
      Value<int> ruleId,
      Value<CrawlRuleType> mediaType,
      Value<String> title,
      Value<String?> coverUrl,
      Value<String?> author,
      Value<String?> description,
      Value<String> rawData,
      Value<DateTime> cachedAt,
      Value<DateTime?> expiresAt,
    });

final class $$CachedContentTableReferences
    extends
        BaseReferences<_$AppDatabase, $CachedContentTable, CachedContentData> {
  $$CachedContentTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CrawlRulesTable _ruleIdTable(_$AppDatabase db) =>
      db.crawlRules.createAlias(
        $_aliasNameGenerator(db.cachedContent.ruleId, db.crawlRules.id),
      );

  $$CrawlRulesTableProcessedTableManager get ruleId {
    final $_column = $_itemColumn<int>('rule_id')!;

    final manager = $$CrawlRulesTableTableManager(
      $_db,
      $_db.crawlRules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ruleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CachedContentTableFilterComposer
    extends Composer<_$AppDatabase, $CachedContentTable> {
  $$CachedContentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CrawlRuleType, CrawlRuleType, int>
  get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawData => $composableBuilder(
    column: $table.rawData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CrawlRulesTableFilterComposer get ruleId {
    final $$CrawlRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.crawlRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrawlRulesTableFilterComposer(
            $db: $db,
            $table: $db.crawlRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedContentTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedContentTable> {
  $$CachedContentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawData => $composableBuilder(
    column: $table.rawData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CrawlRulesTableOrderingComposer get ruleId {
    final $$CrawlRulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.crawlRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrawlRulesTableOrderingComposer(
            $db: $db,
            $table: $db.crawlRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedContentTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedContentTable> {
  $$CachedContentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CrawlRuleType, int> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rawData =>
      $composableBuilder(column: $table.rawData, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  $$CrawlRulesTableAnnotationComposer get ruleId {
    final $$CrawlRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleId,
      referencedTable: $db.crawlRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CrawlRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.crawlRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedContentTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedContentTable,
          CachedContentData,
          $$CachedContentTableFilterComposer,
          $$CachedContentTableOrderingComposer,
          $$CachedContentTableAnnotationComposer,
          $$CachedContentTableCreateCompanionBuilder,
          $$CachedContentTableUpdateCompanionBuilder,
          (CachedContentData, $$CachedContentTableReferences),
          CachedContentData,
          PrefetchHooks Function({bool ruleId})
        > {
  $$CachedContentTableTableManager(_$AppDatabase db, $CachedContentTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedContentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedContentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedContentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> contentId = const Value.absent(),
                Value<int> ruleId = const Value.absent(),
                Value<CrawlRuleType> mediaType = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> coverUrl = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> rawData = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
              }) => CachedContentCompanion(
                id: id,
                contentId: contentId,
                ruleId: ruleId,
                mediaType: mediaType,
                title: title,
                coverUrl: coverUrl,
                author: author,
                description: description,
                rawData: rawData,
                cachedAt: cachedAt,
                expiresAt: expiresAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String contentId,
                required int ruleId,
                required CrawlRuleType mediaType,
                required String title,
                Value<String?> coverUrl = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required String rawData,
                Value<DateTime> cachedAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
              }) => CachedContentCompanion.insert(
                id: id,
                contentId: contentId,
                ruleId: ruleId,
                mediaType: mediaType,
                title: title,
                coverUrl: coverUrl,
                author: author,
                description: description,
                rawData: rawData,
                cachedAt: cachedAt,
                expiresAt: expiresAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CachedContentTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ruleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ruleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ruleId,
                                referencedTable: $$CachedContentTableReferences
                                    ._ruleIdTable(db),
                                referencedColumn: $$CachedContentTableReferences
                                    ._ruleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CachedContentTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedContentTable,
      CachedContentData,
      $$CachedContentTableFilterComposer,
      $$CachedContentTableOrderingComposer,
      $$CachedContentTableAnnotationComposer,
      $$CachedContentTableCreateCompanionBuilder,
      $$CachedContentTableUpdateCompanionBuilder,
      (CachedContentData, $$CachedContentTableReferences),
      CachedContentData,
      PrefetchHooks Function({bool ruleId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CrawlRulesTableTableManager get crawlRules =>
      $$CrawlRulesTableTableManager(_db, _db.crawlRules);
  $$CachedContentTableTableManager get cachedContent =>
      $$CachedContentTableTableManager(_db, _db.cachedContent);
}
