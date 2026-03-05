// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RulesV1Table extends RulesV1 with TableInfo<$RulesV1Table, RulesV1Data> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RulesV1Table(this.attachedDatabase, [this._alias]);
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
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _irVersionMeta = const VerificationMeta(
    'irVersion',
  );
  @override
  late final GeneratedColumn<String> irVersion = GeneratedColumn<String>(
    'ir_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruleEnvelopeJsonMeta = const VerificationMeta(
    'ruleEnvelopeJson',
  );
  @override
  late final GeneratedColumn<String> ruleEnvelopeJson = GeneratedColumn<String>(
    'rule_envelope_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayConfigJsonMeta = const VerificationMeta(
    'displayConfigJson',
  );
  @override
  late final GeneratedColumn<String> displayConfigJson =
      GeneratedColumn<String>(
        'display_config_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _cookieJarEncryptedMeta =
      const VerificationMeta('cookieJarEncrypted');
  @override
  late final GeneratedColumn<String> cookieJarEncrypted =
      GeneratedColumn<String>(
        'cookie_jar_encrypted',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _kvStoreEncryptedMeta = const VerificationMeta(
    'kvStoreEncrypted',
  );
  @override
  late final GeneratedColumn<String> kvStoreEncrypted = GeneratedColumn<String>(
    'kv_store_encrypted',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    irVersion,
    ruleEnvelopeJson,
    displayConfigJson,
    cookieJarEncrypted,
    kvStoreEncrypted,
    enabled,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rules_v1';
  @override
  VerificationContext validateIntegrity(
    Insertable<RulesV1Data> instance, {
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
    if (data.containsKey('ir_version')) {
      context.handle(
        _irVersionMeta,
        irVersion.isAcceptableOrUnknown(data['ir_version']!, _irVersionMeta),
      );
    } else if (isInserting) {
      context.missing(_irVersionMeta);
    }
    if (data.containsKey('rule_envelope_json')) {
      context.handle(
        _ruleEnvelopeJsonMeta,
        ruleEnvelopeJson.isAcceptableOrUnknown(
          data['rule_envelope_json']!,
          _ruleEnvelopeJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ruleEnvelopeJsonMeta);
    }
    if (data.containsKey('display_config_json')) {
      context.handle(
        _displayConfigJsonMeta,
        displayConfigJson.isAcceptableOrUnknown(
          data['display_config_json']!,
          _displayConfigJsonMeta,
        ),
      );
    }
    if (data.containsKey('cookie_jar_encrypted')) {
      context.handle(
        _cookieJarEncryptedMeta,
        cookieJarEncrypted.isAcceptableOrUnknown(
          data['cookie_jar_encrypted']!,
          _cookieJarEncryptedMeta,
        ),
      );
    }
    if (data.containsKey('kv_store_encrypted')) {
      context.handle(
        _kvStoreEncryptedMeta,
        kvStoreEncrypted.isAcceptableOrUnknown(
          data['kv_store_encrypted']!,
          _kvStoreEncryptedMeta,
        ),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
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
  RulesV1Data map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RulesV1Data(
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
      irVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ir_version'],
      )!,
      ruleEnvelopeJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_envelope_json'],
      )!,
      displayConfigJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_config_json'],
      ),
      cookieJarEncrypted: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cookie_jar_encrypted'],
      ),
      kvStoreEncrypted: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kv_store_encrypted'],
      ),
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
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
  $RulesV1Table createAlias(String alias) {
    return $RulesV1Table(attachedDatabase, alias);
  }
}

class RulesV1Data extends DataClass implements Insertable<RulesV1Data> {
  /// 自增主键
  final int id;

  /// 规则唯一标识
  final String ruleId;

  /// 规则名称
  final String name;

  /// 规则描述
  final String? description;

  /// IR 版本标识
  final String irVersion;

  /// 规则信封数据（JSON 字符串）
  final String ruleEnvelopeJson;

  /// 展示配置（JSON 字符串）
  final String? displayConfigJson;

  /// 规则级 CookieJar 密文字段
  final String? cookieJarEncrypted;

  /// 规则级 KV 存储密文字段
  final String? kvStoreEncrypted;

  /// 启用状态
  final bool enabled;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;
  const RulesV1Data({
    required this.id,
    required this.ruleId,
    required this.name,
    this.description,
    required this.irVersion,
    required this.ruleEnvelopeJson,
    this.displayConfigJson,
    this.cookieJarEncrypted,
    this.kvStoreEncrypted,
    required this.enabled,
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
    map['ir_version'] = Variable<String>(irVersion);
    map['rule_envelope_json'] = Variable<String>(ruleEnvelopeJson);
    if (!nullToAbsent || displayConfigJson != null) {
      map['display_config_json'] = Variable<String>(displayConfigJson);
    }
    if (!nullToAbsent || cookieJarEncrypted != null) {
      map['cookie_jar_encrypted'] = Variable<String>(cookieJarEncrypted);
    }
    if (!nullToAbsent || kvStoreEncrypted != null) {
      map['kv_store_encrypted'] = Variable<String>(kvStoreEncrypted);
    }
    map['enabled'] = Variable<bool>(enabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RulesV1Companion toCompanion(bool nullToAbsent) {
    return RulesV1Companion(
      id: Value(id),
      ruleId: Value(ruleId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      irVersion: Value(irVersion),
      ruleEnvelopeJson: Value(ruleEnvelopeJson),
      displayConfigJson: displayConfigJson == null && nullToAbsent
          ? const Value.absent()
          : Value(displayConfigJson),
      cookieJarEncrypted: cookieJarEncrypted == null && nullToAbsent
          ? const Value.absent()
          : Value(cookieJarEncrypted),
      kvStoreEncrypted: kvStoreEncrypted == null && nullToAbsent
          ? const Value.absent()
          : Value(kvStoreEncrypted),
      enabled: Value(enabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RulesV1Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RulesV1Data(
      id: serializer.fromJson<int>(json['id']),
      ruleId: serializer.fromJson<String>(json['ruleId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      irVersion: serializer.fromJson<String>(json['irVersion']),
      ruleEnvelopeJson: serializer.fromJson<String>(json['ruleEnvelopeJson']),
      displayConfigJson: serializer.fromJson<String?>(
        json['displayConfigJson'],
      ),
      cookieJarEncrypted: serializer.fromJson<String?>(
        json['cookieJarEncrypted'],
      ),
      kvStoreEncrypted: serializer.fromJson<String?>(json['kvStoreEncrypted']),
      enabled: serializer.fromJson<bool>(json['enabled']),
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
      'irVersion': serializer.toJson<String>(irVersion),
      'ruleEnvelopeJson': serializer.toJson<String>(ruleEnvelopeJson),
      'displayConfigJson': serializer.toJson<String?>(displayConfigJson),
      'cookieJarEncrypted': serializer.toJson<String?>(cookieJarEncrypted),
      'kvStoreEncrypted': serializer.toJson<String?>(kvStoreEncrypted),
      'enabled': serializer.toJson<bool>(enabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RulesV1Data copyWith({
    int? id,
    String? ruleId,
    String? name,
    Value<String?> description = const Value.absent(),
    String? irVersion,
    String? ruleEnvelopeJson,
    Value<String?> displayConfigJson = const Value.absent(),
    Value<String?> cookieJarEncrypted = const Value.absent(),
    Value<String?> kvStoreEncrypted = const Value.absent(),
    bool? enabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RulesV1Data(
    id: id ?? this.id,
    ruleId: ruleId ?? this.ruleId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    irVersion: irVersion ?? this.irVersion,
    ruleEnvelopeJson: ruleEnvelopeJson ?? this.ruleEnvelopeJson,
    displayConfigJson: displayConfigJson.present
        ? displayConfigJson.value
        : this.displayConfigJson,
    cookieJarEncrypted: cookieJarEncrypted.present
        ? cookieJarEncrypted.value
        : this.cookieJarEncrypted,
    kvStoreEncrypted: kvStoreEncrypted.present
        ? kvStoreEncrypted.value
        : this.kvStoreEncrypted,
    enabled: enabled ?? this.enabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RulesV1Data copyWithCompanion(RulesV1Companion data) {
    return RulesV1Data(
      id: data.id.present ? data.id.value : this.id,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      irVersion: data.irVersion.present ? data.irVersion.value : this.irVersion,
      ruleEnvelopeJson: data.ruleEnvelopeJson.present
          ? data.ruleEnvelopeJson.value
          : this.ruleEnvelopeJson,
      displayConfigJson: data.displayConfigJson.present
          ? data.displayConfigJson.value
          : this.displayConfigJson,
      cookieJarEncrypted: data.cookieJarEncrypted.present
          ? data.cookieJarEncrypted.value
          : this.cookieJarEncrypted,
      kvStoreEncrypted: data.kvStoreEncrypted.present
          ? data.kvStoreEncrypted.value
          : this.kvStoreEncrypted,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RulesV1Data(')
          ..write('id: $id, ')
          ..write('ruleId: $ruleId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('irVersion: $irVersion, ')
          ..write('ruleEnvelopeJson: $ruleEnvelopeJson, ')
          ..write('displayConfigJson: $displayConfigJson, ')
          ..write('cookieJarEncrypted: $cookieJarEncrypted, ')
          ..write('kvStoreEncrypted: $kvStoreEncrypted, ')
          ..write('enabled: $enabled, ')
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
    irVersion,
    ruleEnvelopeJson,
    displayConfigJson,
    cookieJarEncrypted,
    kvStoreEncrypted,
    enabled,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RulesV1Data &&
          other.id == this.id &&
          other.ruleId == this.ruleId &&
          other.name == this.name &&
          other.description == this.description &&
          other.irVersion == this.irVersion &&
          other.ruleEnvelopeJson == this.ruleEnvelopeJson &&
          other.displayConfigJson == this.displayConfigJson &&
          other.cookieJarEncrypted == this.cookieJarEncrypted &&
          other.kvStoreEncrypted == this.kvStoreEncrypted &&
          other.enabled == this.enabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RulesV1Companion extends UpdateCompanion<RulesV1Data> {
  final Value<int> id;
  final Value<String> ruleId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> irVersion;
  final Value<String> ruleEnvelopeJson;
  final Value<String?> displayConfigJson;
  final Value<String?> cookieJarEncrypted;
  final Value<String?> kvStoreEncrypted;
  final Value<bool> enabled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RulesV1Companion({
    this.id = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.irVersion = const Value.absent(),
    this.ruleEnvelopeJson = const Value.absent(),
    this.displayConfigJson = const Value.absent(),
    this.cookieJarEncrypted = const Value.absent(),
    this.kvStoreEncrypted = const Value.absent(),
    this.enabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RulesV1Companion.insert({
    this.id = const Value.absent(),
    required String ruleId,
    required String name,
    this.description = const Value.absent(),
    required String irVersion,
    required String ruleEnvelopeJson,
    this.displayConfigJson = const Value.absent(),
    this.cookieJarEncrypted = const Value.absent(),
    this.kvStoreEncrypted = const Value.absent(),
    this.enabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : ruleId = Value(ruleId),
       name = Value(name),
       irVersion = Value(irVersion),
       ruleEnvelopeJson = Value(ruleEnvelopeJson);
  static Insertable<RulesV1Data> custom({
    Expression<int>? id,
    Expression<String>? ruleId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? irVersion,
    Expression<String>? ruleEnvelopeJson,
    Expression<String>? displayConfigJson,
    Expression<String>? cookieJarEncrypted,
    Expression<String>? kvStoreEncrypted,
    Expression<bool>? enabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ruleId != null) 'rule_id': ruleId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (irVersion != null) 'ir_version': irVersion,
      if (ruleEnvelopeJson != null) 'rule_envelope_json': ruleEnvelopeJson,
      if (displayConfigJson != null) 'display_config_json': displayConfigJson,
      if (cookieJarEncrypted != null)
        'cookie_jar_encrypted': cookieJarEncrypted,
      if (kvStoreEncrypted != null) 'kv_store_encrypted': kvStoreEncrypted,
      if (enabled != null) 'enabled': enabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RulesV1Companion copyWith({
    Value<int>? id,
    Value<String>? ruleId,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? irVersion,
    Value<String>? ruleEnvelopeJson,
    Value<String?>? displayConfigJson,
    Value<String?>? cookieJarEncrypted,
    Value<String?>? kvStoreEncrypted,
    Value<bool>? enabled,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RulesV1Companion(
      id: id ?? this.id,
      ruleId: ruleId ?? this.ruleId,
      name: name ?? this.name,
      description: description ?? this.description,
      irVersion: irVersion ?? this.irVersion,
      ruleEnvelopeJson: ruleEnvelopeJson ?? this.ruleEnvelopeJson,
      displayConfigJson: displayConfigJson ?? this.displayConfigJson,
      cookieJarEncrypted: cookieJarEncrypted ?? this.cookieJarEncrypted,
      kvStoreEncrypted: kvStoreEncrypted ?? this.kvStoreEncrypted,
      enabled: enabled ?? this.enabled,
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
    if (irVersion.present) {
      map['ir_version'] = Variable<String>(irVersion.value);
    }
    if (ruleEnvelopeJson.present) {
      map['rule_envelope_json'] = Variable<String>(ruleEnvelopeJson.value);
    }
    if (displayConfigJson.present) {
      map['display_config_json'] = Variable<String>(displayConfigJson.value);
    }
    if (cookieJarEncrypted.present) {
      map['cookie_jar_encrypted'] = Variable<String>(cookieJarEncrypted.value);
    }
    if (kvStoreEncrypted.present) {
      map['kv_store_encrypted'] = Variable<String>(kvStoreEncrypted.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
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
    return (StringBuffer('RulesV1Companion(')
          ..write('id: $id, ')
          ..write('ruleId: $ruleId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('irVersion: $irVersion, ')
          ..write('ruleEnvelopeJson: $ruleEnvelopeJson, ')
          ..write('displayConfigJson: $displayConfigJson, ')
          ..write('cookieJarEncrypted: $cookieJarEncrypted, ')
          ..write('kvStoreEncrypted: $kvStoreEncrypted, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SessionsV1Table extends SessionsV1
    with TableInfo<$SessionsV1Table, SessionsV1Data> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsV1Table(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _cookieJarEncryptedMeta =
      const VerificationMeta('cookieJarEncrypted');
  @override
  late final GeneratedColumn<String> cookieJarEncrypted =
      GeneratedColumn<String>(
        'cookie_jar_encrypted',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _kvStoreEncryptedMeta = const VerificationMeta(
    'kvStoreEncrypted',
  );
  @override
  late final GeneratedColumn<String> kvStoreEncrypted = GeneratedColumn<String>(
    'kv_store_encrypted',
    aliasedName,
    true,
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
    sessionId,
    cookieJarEncrypted,
    kvStoreEncrypted,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions_v1';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionsV1Data> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('cookie_jar_encrypted')) {
      context.handle(
        _cookieJarEncryptedMeta,
        cookieJarEncrypted.isAcceptableOrUnknown(
          data['cookie_jar_encrypted']!,
          _cookieJarEncryptedMeta,
        ),
      );
    }
    if (data.containsKey('kv_store_encrypted')) {
      context.handle(
        _kvStoreEncryptedMeta,
        kvStoreEncrypted.isAcceptableOrUnknown(
          data['kv_store_encrypted']!,
          _kvStoreEncryptedMeta,
        ),
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
  SessionsV1Data map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionsV1Data(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      cookieJarEncrypted: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cookie_jar_encrypted'],
      ),
      kvStoreEncrypted: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kv_store_encrypted'],
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
  $SessionsV1Table createAlias(String alias) {
    return $SessionsV1Table(attachedDatabase, alias);
  }
}

class SessionsV1Data extends DataClass implements Insertable<SessionsV1Data> {
  /// 自增主键
  final int id;

  /// 会话唯一标识
  final String sessionId;

  /// CookieJar 密文字段
  final String? cookieJarEncrypted;

  /// KV 存储密文字段
  final String? kvStoreEncrypted;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;
  const SessionsV1Data({
    required this.id,
    required this.sessionId,
    this.cookieJarEncrypted,
    this.kvStoreEncrypted,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    if (!nullToAbsent || cookieJarEncrypted != null) {
      map['cookie_jar_encrypted'] = Variable<String>(cookieJarEncrypted);
    }
    if (!nullToAbsent || kvStoreEncrypted != null) {
      map['kv_store_encrypted'] = Variable<String>(kvStoreEncrypted);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SessionsV1Companion toCompanion(bool nullToAbsent) {
    return SessionsV1Companion(
      id: Value(id),
      sessionId: Value(sessionId),
      cookieJarEncrypted: cookieJarEncrypted == null && nullToAbsent
          ? const Value.absent()
          : Value(cookieJarEncrypted),
      kvStoreEncrypted: kvStoreEncrypted == null && nullToAbsent
          ? const Value.absent()
          : Value(kvStoreEncrypted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SessionsV1Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionsV1Data(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      cookieJarEncrypted: serializer.fromJson<String?>(
        json['cookieJarEncrypted'],
      ),
      kvStoreEncrypted: serializer.fromJson<String?>(json['kvStoreEncrypted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'cookieJarEncrypted': serializer.toJson<String?>(cookieJarEncrypted),
      'kvStoreEncrypted': serializer.toJson<String?>(kvStoreEncrypted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SessionsV1Data copyWith({
    int? id,
    String? sessionId,
    Value<String?> cookieJarEncrypted = const Value.absent(),
    Value<String?> kvStoreEncrypted = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SessionsV1Data(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    cookieJarEncrypted: cookieJarEncrypted.present
        ? cookieJarEncrypted.value
        : this.cookieJarEncrypted,
    kvStoreEncrypted: kvStoreEncrypted.present
        ? kvStoreEncrypted.value
        : this.kvStoreEncrypted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SessionsV1Data copyWithCompanion(SessionsV1Companion data) {
    return SessionsV1Data(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      cookieJarEncrypted: data.cookieJarEncrypted.present
          ? data.cookieJarEncrypted.value
          : this.cookieJarEncrypted,
      kvStoreEncrypted: data.kvStoreEncrypted.present
          ? data.kvStoreEncrypted.value
          : this.kvStoreEncrypted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionsV1Data(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('cookieJarEncrypted: $cookieJarEncrypted, ')
          ..write('kvStoreEncrypted: $kvStoreEncrypted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    cookieJarEncrypted,
    kvStoreEncrypted,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionsV1Data &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.cookieJarEncrypted == this.cookieJarEncrypted &&
          other.kvStoreEncrypted == this.kvStoreEncrypted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SessionsV1Companion extends UpdateCompanion<SessionsV1Data> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<String?> cookieJarEncrypted;
  final Value<String?> kvStoreEncrypted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SessionsV1Companion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.cookieJarEncrypted = const Value.absent(),
    this.kvStoreEncrypted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SessionsV1Companion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    this.cookieJarEncrypted = const Value.absent(),
    this.kvStoreEncrypted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : sessionId = Value(sessionId);
  static Insertable<SessionsV1Data> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<String>? cookieJarEncrypted,
    Expression<String>? kvStoreEncrypted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (cookieJarEncrypted != null)
        'cookie_jar_encrypted': cookieJarEncrypted,
      if (kvStoreEncrypted != null) 'kv_store_encrypted': kvStoreEncrypted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SessionsV1Companion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<String?>? cookieJarEncrypted,
    Value<String?>? kvStoreEncrypted,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SessionsV1Companion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      cookieJarEncrypted: cookieJarEncrypted ?? this.cookieJarEncrypted,
      kvStoreEncrypted: kvStoreEncrypted ?? this.kvStoreEncrypted,
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
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (cookieJarEncrypted.present) {
      map['cookie_jar_encrypted'] = Variable<String>(cookieJarEncrypted.value);
    }
    if (kvStoreEncrypted.present) {
      map['kv_store_encrypted'] = Variable<String>(kvStoreEncrypted.value);
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
    return (StringBuffer('SessionsV1Companion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('cookieJarEncrypted: $cookieJarEncrypted, ')
          ..write('kvStoreEncrypted: $kvStoreEncrypted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RulesV1Table rulesV1 = $RulesV1Table(this);
  late final $SessionsV1Table sessionsV1 = $SessionsV1Table(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [rulesV1, sessionsV1];
}

typedef $$RulesV1TableCreateCompanionBuilder =
    RulesV1Companion Function({
      Value<int> id,
      required String ruleId,
      required String name,
      Value<String?> description,
      required String irVersion,
      required String ruleEnvelopeJson,
      Value<String?> displayConfigJson,
      Value<String?> cookieJarEncrypted,
      Value<String?> kvStoreEncrypted,
      Value<bool> enabled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$RulesV1TableUpdateCompanionBuilder =
    RulesV1Companion Function({
      Value<int> id,
      Value<String> ruleId,
      Value<String> name,
      Value<String?> description,
      Value<String> irVersion,
      Value<String> ruleEnvelopeJson,
      Value<String?> displayConfigJson,
      Value<String?> cookieJarEncrypted,
      Value<String?> kvStoreEncrypted,
      Value<bool> enabled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$RulesV1TableFilterComposer
    extends Composer<_$AppDatabase, $RulesV1Table> {
  $$RulesV1TableFilterComposer({
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

  ColumnFilters<String> get irVersion => $composableBuilder(
    column: $table.irVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleEnvelopeJson => $composableBuilder(
    column: $table.ruleEnvelopeJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayConfigJson => $composableBuilder(
    column: $table.displayConfigJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cookieJarEncrypted => $composableBuilder(
    column: $table.cookieJarEncrypted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kvStoreEncrypted => $composableBuilder(
    column: $table.kvStoreEncrypted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
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
}

class $$RulesV1TableOrderingComposer
    extends Composer<_$AppDatabase, $RulesV1Table> {
  $$RulesV1TableOrderingComposer({
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

  ColumnOrderings<String> get irVersion => $composableBuilder(
    column: $table.irVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleEnvelopeJson => $composableBuilder(
    column: $table.ruleEnvelopeJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayConfigJson => $composableBuilder(
    column: $table.displayConfigJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cookieJarEncrypted => $composableBuilder(
    column: $table.cookieJarEncrypted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kvStoreEncrypted => $composableBuilder(
    column: $table.kvStoreEncrypted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
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

class $$RulesV1TableAnnotationComposer
    extends Composer<_$AppDatabase, $RulesV1Table> {
  $$RulesV1TableAnnotationComposer({
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

  GeneratedColumn<String> get irVersion =>
      $composableBuilder(column: $table.irVersion, builder: (column) => column);

  GeneratedColumn<String> get ruleEnvelopeJson => $composableBuilder(
    column: $table.ruleEnvelopeJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayConfigJson => $composableBuilder(
    column: $table.displayConfigJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cookieJarEncrypted => $composableBuilder(
    column: $table.cookieJarEncrypted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kvStoreEncrypted => $composableBuilder(
    column: $table.kvStoreEncrypted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RulesV1TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RulesV1Table,
          RulesV1Data,
          $$RulesV1TableFilterComposer,
          $$RulesV1TableOrderingComposer,
          $$RulesV1TableAnnotationComposer,
          $$RulesV1TableCreateCompanionBuilder,
          $$RulesV1TableUpdateCompanionBuilder,
          (
            RulesV1Data,
            BaseReferences<_$AppDatabase, $RulesV1Table, RulesV1Data>,
          ),
          RulesV1Data,
          PrefetchHooks Function()
        > {
  $$RulesV1TableTableManager(_$AppDatabase db, $RulesV1Table table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RulesV1TableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RulesV1TableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RulesV1TableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ruleId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> irVersion = const Value.absent(),
                Value<String> ruleEnvelopeJson = const Value.absent(),
                Value<String?> displayConfigJson = const Value.absent(),
                Value<String?> cookieJarEncrypted = const Value.absent(),
                Value<String?> kvStoreEncrypted = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RulesV1Companion(
                id: id,
                ruleId: ruleId,
                name: name,
                description: description,
                irVersion: irVersion,
                ruleEnvelopeJson: ruleEnvelopeJson,
                displayConfigJson: displayConfigJson,
                cookieJarEncrypted: cookieJarEncrypted,
                kvStoreEncrypted: kvStoreEncrypted,
                enabled: enabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ruleId,
                required String name,
                Value<String?> description = const Value.absent(),
                required String irVersion,
                required String ruleEnvelopeJson,
                Value<String?> displayConfigJson = const Value.absent(),
                Value<String?> cookieJarEncrypted = const Value.absent(),
                Value<String?> kvStoreEncrypted = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RulesV1Companion.insert(
                id: id,
                ruleId: ruleId,
                name: name,
                description: description,
                irVersion: irVersion,
                ruleEnvelopeJson: ruleEnvelopeJson,
                displayConfigJson: displayConfigJson,
                cookieJarEncrypted: cookieJarEncrypted,
                kvStoreEncrypted: kvStoreEncrypted,
                enabled: enabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RulesV1TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RulesV1Table,
      RulesV1Data,
      $$RulesV1TableFilterComposer,
      $$RulesV1TableOrderingComposer,
      $$RulesV1TableAnnotationComposer,
      $$RulesV1TableCreateCompanionBuilder,
      $$RulesV1TableUpdateCompanionBuilder,
      (RulesV1Data, BaseReferences<_$AppDatabase, $RulesV1Table, RulesV1Data>),
      RulesV1Data,
      PrefetchHooks Function()
    >;
typedef $$SessionsV1TableCreateCompanionBuilder =
    SessionsV1Companion Function({
      Value<int> id,
      required String sessionId,
      Value<String?> cookieJarEncrypted,
      Value<String?> kvStoreEncrypted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SessionsV1TableUpdateCompanionBuilder =
    SessionsV1Companion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<String?> cookieJarEncrypted,
      Value<String?> kvStoreEncrypted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$SessionsV1TableFilterComposer
    extends Composer<_$AppDatabase, $SessionsV1Table> {
  $$SessionsV1TableFilterComposer({
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

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cookieJarEncrypted => $composableBuilder(
    column: $table.cookieJarEncrypted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kvStoreEncrypted => $composableBuilder(
    column: $table.kvStoreEncrypted,
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
}

class $$SessionsV1TableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsV1Table> {
  $$SessionsV1TableOrderingComposer({
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

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cookieJarEncrypted => $composableBuilder(
    column: $table.cookieJarEncrypted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kvStoreEncrypted => $composableBuilder(
    column: $table.kvStoreEncrypted,
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

class $$SessionsV1TableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsV1Table> {
  $$SessionsV1TableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get cookieJarEncrypted => $composableBuilder(
    column: $table.cookieJarEncrypted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kvStoreEncrypted => $composableBuilder(
    column: $table.kvStoreEncrypted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SessionsV1TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsV1Table,
          SessionsV1Data,
          $$SessionsV1TableFilterComposer,
          $$SessionsV1TableOrderingComposer,
          $$SessionsV1TableAnnotationComposer,
          $$SessionsV1TableCreateCompanionBuilder,
          $$SessionsV1TableUpdateCompanionBuilder,
          (
            SessionsV1Data,
            BaseReferences<_$AppDatabase, $SessionsV1Table, SessionsV1Data>,
          ),
          SessionsV1Data,
          PrefetchHooks Function()
        > {
  $$SessionsV1TableTableManager(_$AppDatabase db, $SessionsV1Table table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsV1TableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsV1TableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsV1TableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String?> cookieJarEncrypted = const Value.absent(),
                Value<String?> kvStoreEncrypted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SessionsV1Companion(
                id: id,
                sessionId: sessionId,
                cookieJarEncrypted: cookieJarEncrypted,
                kvStoreEncrypted: kvStoreEncrypted,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                Value<String?> cookieJarEncrypted = const Value.absent(),
                Value<String?> kvStoreEncrypted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SessionsV1Companion.insert(
                id: id,
                sessionId: sessionId,
                cookieJarEncrypted: cookieJarEncrypted,
                kvStoreEncrypted: kvStoreEncrypted,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionsV1TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsV1Table,
      SessionsV1Data,
      $$SessionsV1TableFilterComposer,
      $$SessionsV1TableOrderingComposer,
      $$SessionsV1TableAnnotationComposer,
      $$SessionsV1TableCreateCompanionBuilder,
      $$SessionsV1TableUpdateCompanionBuilder,
      (
        SessionsV1Data,
        BaseReferences<_$AppDatabase, $SessionsV1Table, SessionsV1Data>,
      ),
      SessionsV1Data,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RulesV1TableTableManager get rulesV1 =>
      $$RulesV1TableTableManager(_db, _db.rulesV1);
  $$SessionsV1TableTableManager get sessionsV1 =>
      $$SessionsV1TableTableManager(_db, _db.sessionsV1);
}
