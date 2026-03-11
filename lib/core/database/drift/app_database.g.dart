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

class $FavoritesV1Table extends FavoritesV1
    with TableInfo<$FavoritesV1Table, FavoritesV1Data> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesV1Table(this.attachedDatabase, [this._alias]);
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
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
  static const VerificationMeta _sourceRuleIdMeta = const VerificationMeta(
    'sourceRuleId',
  );
  @override
  late final GeneratedColumn<String> sourceRuleId = GeneratedColumn<String>(
    'source_rule_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceRuleNameMeta = const VerificationMeta(
    'sourceRuleName',
  );
  @override
  late final GeneratedColumn<String> sourceRuleName = GeneratedColumn<String>(
    'source_rule_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentUrlMeta = const VerificationMeta(
    'contentUrl',
  );
  @override
  late final GeneratedColumn<String> contentUrl = GeneratedColumn<String>(
    'content_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _favoritedAtMeta = const VerificationMeta(
    'favoritedAt',
  );
  @override
  late final GeneratedColumn<DateTime> favoritedAt = GeneratedColumn<DateTime>(
    'favorited_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastAccessedAtMeta = const VerificationMeta(
    'lastAccessedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAccessedAt =
      GeneratedColumn<DateTime>(
        'last_accessed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _accessCountMeta = const VerificationMeta(
    'accessCount',
  );
  @override
  late final GeneratedColumn<int> accessCount = GeneratedColumn<int>(
    'access_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    contentId,
    title,
    contentType,
    coverUrl,
    author,
    description,
    sourceRuleId,
    sourceRuleName,
    contentUrl,
    metadataJson,
    favoritedAt,
    lastAccessedAt,
    accessCount,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites_v1';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoritesV1Data> instance, {
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
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
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
    if (data.containsKey('source_rule_id')) {
      context.handle(
        _sourceRuleIdMeta,
        sourceRuleId.isAcceptableOrUnknown(
          data['source_rule_id']!,
          _sourceRuleIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceRuleIdMeta);
    }
    if (data.containsKey('source_rule_name')) {
      context.handle(
        _sourceRuleNameMeta,
        sourceRuleName.isAcceptableOrUnknown(
          data['source_rule_name']!,
          _sourceRuleNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceRuleNameMeta);
    }
    if (data.containsKey('content_url')) {
      context.handle(
        _contentUrlMeta,
        contentUrl.isAcceptableOrUnknown(data['content_url']!, _contentUrlMeta),
      );
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    if (data.containsKey('favorited_at')) {
      context.handle(
        _favoritedAtMeta,
        favoritedAt.isAcceptableOrUnknown(
          data['favorited_at']!,
          _favoritedAtMeta,
        ),
      );
    }
    if (data.containsKey('last_accessed_at')) {
      context.handle(
        _lastAccessedAtMeta,
        lastAccessedAt.isAcceptableOrUnknown(
          data['last_accessed_at']!,
          _lastAccessedAtMeta,
        ),
      );
    }
    if (data.containsKey('access_count')) {
      context.handle(
        _accessCountMeta,
        accessCount.isAcceptableOrUnknown(
          data['access_count']!,
          _accessCountMeta,
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {contentId, sourceRuleId},
  ];
  @override
  FavoritesV1Data map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoritesV1Data(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
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
      sourceRuleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_rule_id'],
      )!,
      sourceRuleName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_rule_name'],
      )!,
      contentUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_url'],
      ),
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      ),
      favoritedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}favorited_at'],
      )!,
      lastAccessedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_accessed_at'],
      ),
      accessCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}access_count'],
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
  $FavoritesV1Table createAlias(String alias) {
    return $FavoritesV1Table(attachedDatabase, alias);
  }
}

class FavoritesV1Data extends DataClass implements Insertable<FavoritesV1Data> {
  /// 自增主键
  final int id;

  /// 内容唯一标识（外部系统ID）
  final String contentId;

  /// 内容标题
  final String title;

  /// 内容类型：video, music, novel, comic, image
  final String contentType;

  /// 封面图片URL
  final String? coverUrl;

  /// 作者/创作者
  final String? author;

  /// 内容描述
  final String? description;

  /// 来源规则ID
  final String sourceRuleId;

  /// 来源规则名称
  final String sourceRuleName;

  /// 原始内容URL
  final String? contentUrl;

  /// 附加数据（JSON字符串，存储额外信息）
  final String? metadataJson;

  /// 收藏时间
  final DateTime favoritedAt;

  /// 最后观看/访问时间
  final DateTime? lastAccessedAt;

  /// 访问次数
  final int accessCount;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;
  const FavoritesV1Data({
    required this.id,
    required this.contentId,
    required this.title,
    required this.contentType,
    this.coverUrl,
    this.author,
    this.description,
    required this.sourceRuleId,
    required this.sourceRuleName,
    this.contentUrl,
    this.metadataJson,
    required this.favoritedAt,
    this.lastAccessedAt,
    required this.accessCount,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content_id'] = Variable<String>(contentId);
    map['title'] = Variable<String>(title);
    map['content_type'] = Variable<String>(contentType);
    if (!nullToAbsent || coverUrl != null) {
      map['cover_url'] = Variable<String>(coverUrl);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['source_rule_id'] = Variable<String>(sourceRuleId);
    map['source_rule_name'] = Variable<String>(sourceRuleName);
    if (!nullToAbsent || contentUrl != null) {
      map['content_url'] = Variable<String>(contentUrl);
    }
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    map['favorited_at'] = Variable<DateTime>(favoritedAt);
    if (!nullToAbsent || lastAccessedAt != null) {
      map['last_accessed_at'] = Variable<DateTime>(lastAccessedAt);
    }
    map['access_count'] = Variable<int>(accessCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FavoritesV1Companion toCompanion(bool nullToAbsent) {
    return FavoritesV1Companion(
      id: Value(id),
      contentId: Value(contentId),
      title: Value(title),
      contentType: Value(contentType),
      coverUrl: coverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverUrl),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      sourceRuleId: Value(sourceRuleId),
      sourceRuleName: Value(sourceRuleName),
      contentUrl: contentUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(contentUrl),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
      favoritedAt: Value(favoritedAt),
      lastAccessedAt: lastAccessedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAccessedAt),
      accessCount: Value(accessCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FavoritesV1Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoritesV1Data(
      id: serializer.fromJson<int>(json['id']),
      contentId: serializer.fromJson<String>(json['contentId']),
      title: serializer.fromJson<String>(json['title']),
      contentType: serializer.fromJson<String>(json['contentType']),
      coverUrl: serializer.fromJson<String?>(json['coverUrl']),
      author: serializer.fromJson<String?>(json['author']),
      description: serializer.fromJson<String?>(json['description']),
      sourceRuleId: serializer.fromJson<String>(json['sourceRuleId']),
      sourceRuleName: serializer.fromJson<String>(json['sourceRuleName']),
      contentUrl: serializer.fromJson<String?>(json['contentUrl']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
      favoritedAt: serializer.fromJson<DateTime>(json['favoritedAt']),
      lastAccessedAt: serializer.fromJson<DateTime?>(json['lastAccessedAt']),
      accessCount: serializer.fromJson<int>(json['accessCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contentId': serializer.toJson<String>(contentId),
      'title': serializer.toJson<String>(title),
      'contentType': serializer.toJson<String>(contentType),
      'coverUrl': serializer.toJson<String?>(coverUrl),
      'author': serializer.toJson<String?>(author),
      'description': serializer.toJson<String?>(description),
      'sourceRuleId': serializer.toJson<String>(sourceRuleId),
      'sourceRuleName': serializer.toJson<String>(sourceRuleName),
      'contentUrl': serializer.toJson<String?>(contentUrl),
      'metadataJson': serializer.toJson<String?>(metadataJson),
      'favoritedAt': serializer.toJson<DateTime>(favoritedAt),
      'lastAccessedAt': serializer.toJson<DateTime?>(lastAccessedAt),
      'accessCount': serializer.toJson<int>(accessCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FavoritesV1Data copyWith({
    int? id,
    String? contentId,
    String? title,
    String? contentType,
    Value<String?> coverUrl = const Value.absent(),
    Value<String?> author = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? sourceRuleId,
    String? sourceRuleName,
    Value<String?> contentUrl = const Value.absent(),
    Value<String?> metadataJson = const Value.absent(),
    DateTime? favoritedAt,
    Value<DateTime?> lastAccessedAt = const Value.absent(),
    int? accessCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FavoritesV1Data(
    id: id ?? this.id,
    contentId: contentId ?? this.contentId,
    title: title ?? this.title,
    contentType: contentType ?? this.contentType,
    coverUrl: coverUrl.present ? coverUrl.value : this.coverUrl,
    author: author.present ? author.value : this.author,
    description: description.present ? description.value : this.description,
    sourceRuleId: sourceRuleId ?? this.sourceRuleId,
    sourceRuleName: sourceRuleName ?? this.sourceRuleName,
    contentUrl: contentUrl.present ? contentUrl.value : this.contentUrl,
    metadataJson: metadataJson.present ? metadataJson.value : this.metadataJson,
    favoritedAt: favoritedAt ?? this.favoritedAt,
    lastAccessedAt: lastAccessedAt.present
        ? lastAccessedAt.value
        : this.lastAccessedAt,
    accessCount: accessCount ?? this.accessCount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FavoritesV1Data copyWithCompanion(FavoritesV1Companion data) {
    return FavoritesV1Data(
      id: data.id.present ? data.id.value : this.id,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      title: data.title.present ? data.title.value : this.title,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
      author: data.author.present ? data.author.value : this.author,
      description: data.description.present
          ? data.description.value
          : this.description,
      sourceRuleId: data.sourceRuleId.present
          ? data.sourceRuleId.value
          : this.sourceRuleId,
      sourceRuleName: data.sourceRuleName.present
          ? data.sourceRuleName.value
          : this.sourceRuleName,
      contentUrl: data.contentUrl.present
          ? data.contentUrl.value
          : this.contentUrl,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      favoritedAt: data.favoritedAt.present
          ? data.favoritedAt.value
          : this.favoritedAt,
      lastAccessedAt: data.lastAccessedAt.present
          ? data.lastAccessedAt.value
          : this.lastAccessedAt,
      accessCount: data.accessCount.present
          ? data.accessCount.value
          : this.accessCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesV1Data(')
          ..write('id: $id, ')
          ..write('contentId: $contentId, ')
          ..write('title: $title, ')
          ..write('contentType: $contentType, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('sourceRuleId: $sourceRuleId, ')
          ..write('sourceRuleName: $sourceRuleName, ')
          ..write('contentUrl: $contentUrl, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('favoritedAt: $favoritedAt, ')
          ..write('lastAccessedAt: $lastAccessedAt, ')
          ..write('accessCount: $accessCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    contentId,
    title,
    contentType,
    coverUrl,
    author,
    description,
    sourceRuleId,
    sourceRuleName,
    contentUrl,
    metadataJson,
    favoritedAt,
    lastAccessedAt,
    accessCount,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritesV1Data &&
          other.id == this.id &&
          other.contentId == this.contentId &&
          other.title == this.title &&
          other.contentType == this.contentType &&
          other.coverUrl == this.coverUrl &&
          other.author == this.author &&
          other.description == this.description &&
          other.sourceRuleId == this.sourceRuleId &&
          other.sourceRuleName == this.sourceRuleName &&
          other.contentUrl == this.contentUrl &&
          other.metadataJson == this.metadataJson &&
          other.favoritedAt == this.favoritedAt &&
          other.lastAccessedAt == this.lastAccessedAt &&
          other.accessCount == this.accessCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FavoritesV1Companion extends UpdateCompanion<FavoritesV1Data> {
  final Value<int> id;
  final Value<String> contentId;
  final Value<String> title;
  final Value<String> contentType;
  final Value<String?> coverUrl;
  final Value<String?> author;
  final Value<String?> description;
  final Value<String> sourceRuleId;
  final Value<String> sourceRuleName;
  final Value<String?> contentUrl;
  final Value<String?> metadataJson;
  final Value<DateTime> favoritedAt;
  final Value<DateTime?> lastAccessedAt;
  final Value<int> accessCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FavoritesV1Companion({
    this.id = const Value.absent(),
    this.contentId = const Value.absent(),
    this.title = const Value.absent(),
    this.contentType = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.sourceRuleId = const Value.absent(),
    this.sourceRuleName = const Value.absent(),
    this.contentUrl = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.favoritedAt = const Value.absent(),
    this.lastAccessedAt = const Value.absent(),
    this.accessCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FavoritesV1Companion.insert({
    this.id = const Value.absent(),
    required String contentId,
    required String title,
    required String contentType,
    this.coverUrl = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    required String sourceRuleId,
    required String sourceRuleName,
    this.contentUrl = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.favoritedAt = const Value.absent(),
    this.lastAccessedAt = const Value.absent(),
    this.accessCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : contentId = Value(contentId),
       title = Value(title),
       contentType = Value(contentType),
       sourceRuleId = Value(sourceRuleId),
       sourceRuleName = Value(sourceRuleName);
  static Insertable<FavoritesV1Data> custom({
    Expression<int>? id,
    Expression<String>? contentId,
    Expression<String>? title,
    Expression<String>? contentType,
    Expression<String>? coverUrl,
    Expression<String>? author,
    Expression<String>? description,
    Expression<String>? sourceRuleId,
    Expression<String>? sourceRuleName,
    Expression<String>? contentUrl,
    Expression<String>? metadataJson,
    Expression<DateTime>? favoritedAt,
    Expression<DateTime>? lastAccessedAt,
    Expression<int>? accessCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentId != null) 'content_id': contentId,
      if (title != null) 'title': title,
      if (contentType != null) 'content_type': contentType,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (author != null) 'author': author,
      if (description != null) 'description': description,
      if (sourceRuleId != null) 'source_rule_id': sourceRuleId,
      if (sourceRuleName != null) 'source_rule_name': sourceRuleName,
      if (contentUrl != null) 'content_url': contentUrl,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (favoritedAt != null) 'favorited_at': favoritedAt,
      if (lastAccessedAt != null) 'last_accessed_at': lastAccessedAt,
      if (accessCount != null) 'access_count': accessCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FavoritesV1Companion copyWith({
    Value<int>? id,
    Value<String>? contentId,
    Value<String>? title,
    Value<String>? contentType,
    Value<String?>? coverUrl,
    Value<String?>? author,
    Value<String?>? description,
    Value<String>? sourceRuleId,
    Value<String>? sourceRuleName,
    Value<String?>? contentUrl,
    Value<String?>? metadataJson,
    Value<DateTime>? favoritedAt,
    Value<DateTime?>? lastAccessedAt,
    Value<int>? accessCount,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return FavoritesV1Companion(
      id: id ?? this.id,
      contentId: contentId ?? this.contentId,
      title: title ?? this.title,
      contentType: contentType ?? this.contentType,
      coverUrl: coverUrl ?? this.coverUrl,
      author: author ?? this.author,
      description: description ?? this.description,
      sourceRuleId: sourceRuleId ?? this.sourceRuleId,
      sourceRuleName: sourceRuleName ?? this.sourceRuleName,
      contentUrl: contentUrl ?? this.contentUrl,
      metadataJson: metadataJson ?? this.metadataJson,
      favoritedAt: favoritedAt ?? this.favoritedAt,
      lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
      accessCount: accessCount ?? this.accessCount,
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
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
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
    if (sourceRuleId.present) {
      map['source_rule_id'] = Variable<String>(sourceRuleId.value);
    }
    if (sourceRuleName.present) {
      map['source_rule_name'] = Variable<String>(sourceRuleName.value);
    }
    if (contentUrl.present) {
      map['content_url'] = Variable<String>(contentUrl.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (favoritedAt.present) {
      map['favorited_at'] = Variable<DateTime>(favoritedAt.value);
    }
    if (lastAccessedAt.present) {
      map['last_accessed_at'] = Variable<DateTime>(lastAccessedAt.value);
    }
    if (accessCount.present) {
      map['access_count'] = Variable<int>(accessCount.value);
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
    return (StringBuffer('FavoritesV1Companion(')
          ..write('id: $id, ')
          ..write('contentId: $contentId, ')
          ..write('title: $title, ')
          ..write('contentType: $contentType, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('sourceRuleId: $sourceRuleId, ')
          ..write('sourceRuleName: $sourceRuleName, ')
          ..write('contentUrl: $contentUrl, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('favoritedAt: $favoritedAt, ')
          ..write('lastAccessedAt: $lastAccessedAt, ')
          ..write('accessCount: $accessCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SearchHistoryV1Table extends SearchHistoryV1
    with TableInfo<$SearchHistoryV1Table, SearchHistoryV1Data> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistoryV1Table(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
    'query',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filterTypeMeta = const VerificationMeta(
    'filterType',
  );
  @override
  late final GeneratedColumn<String> filterType = GeneratedColumn<String>(
    'filter_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('all'),
  );
  static const VerificationMeta _searchCountMeta = const VerificationMeta(
    'searchCount',
  );
  @override
  late final GeneratedColumn<int> searchCount = GeneratedColumn<int>(
    'search_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _lastSearchedAtMeta = const VerificationMeta(
    'lastSearchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSearchedAt =
      GeneratedColumn<DateTime>(
        'last_searched_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    query,
    filterType,
    searchCount,
    lastSearchedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_history_v1';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchHistoryV1Data> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('query')) {
      context.handle(
        _queryMeta,
        query.isAcceptableOrUnknown(data['query']!, _queryMeta),
      );
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    if (data.containsKey('filter_type')) {
      context.handle(
        _filterTypeMeta,
        filterType.isAcceptableOrUnknown(data['filter_type']!, _filterTypeMeta),
      );
    }
    if (data.containsKey('search_count')) {
      context.handle(
        _searchCountMeta,
        searchCount.isAcceptableOrUnknown(
          data['search_count']!,
          _searchCountMeta,
        ),
      );
    }
    if (data.containsKey('last_searched_at')) {
      context.handle(
        _lastSearchedAtMeta,
        lastSearchedAt.isAcceptableOrUnknown(
          data['last_searched_at']!,
          _lastSearchedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {query},
  ];
  @override
  SearchHistoryV1Data map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchHistoryV1Data(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      query: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}query'],
      )!,
      filterType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}filter_type'],
      )!,
      searchCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}search_count'],
      )!,
      lastSearchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_searched_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SearchHistoryV1Table createAlias(String alias) {
    return $SearchHistoryV1Table(attachedDatabase, alias);
  }
}

class SearchHistoryV1Data extends DataClass
    implements Insertable<SearchHistoryV1Data> {
  /// 自增主键
  final int id;

  /// 搜索关键词
  final String query;

  /// 搜索类型过滤：all, video, music, novel, comic, image
  final String filterType;

  /// 搜索次数（同一关键词）
  final int searchCount;

  /// 最后搜索时间
  final DateTime lastSearchedAt;

  /// 创建时间
  final DateTime createdAt;
  const SearchHistoryV1Data({
    required this.id,
    required this.query,
    required this.filterType,
    required this.searchCount,
    required this.lastSearchedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['query'] = Variable<String>(query);
    map['filter_type'] = Variable<String>(filterType);
    map['search_count'] = Variable<int>(searchCount);
    map['last_searched_at'] = Variable<DateTime>(lastSearchedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SearchHistoryV1Companion toCompanion(bool nullToAbsent) {
    return SearchHistoryV1Companion(
      id: Value(id),
      query: Value(query),
      filterType: Value(filterType),
      searchCount: Value(searchCount),
      lastSearchedAt: Value(lastSearchedAt),
      createdAt: Value(createdAt),
    );
  }

  factory SearchHistoryV1Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistoryV1Data(
      id: serializer.fromJson<int>(json['id']),
      query: serializer.fromJson<String>(json['query']),
      filterType: serializer.fromJson<String>(json['filterType']),
      searchCount: serializer.fromJson<int>(json['searchCount']),
      lastSearchedAt: serializer.fromJson<DateTime>(json['lastSearchedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'query': serializer.toJson<String>(query),
      'filterType': serializer.toJson<String>(filterType),
      'searchCount': serializer.toJson<int>(searchCount),
      'lastSearchedAt': serializer.toJson<DateTime>(lastSearchedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SearchHistoryV1Data copyWith({
    int? id,
    String? query,
    String? filterType,
    int? searchCount,
    DateTime? lastSearchedAt,
    DateTime? createdAt,
  }) => SearchHistoryV1Data(
    id: id ?? this.id,
    query: query ?? this.query,
    filterType: filterType ?? this.filterType,
    searchCount: searchCount ?? this.searchCount,
    lastSearchedAt: lastSearchedAt ?? this.lastSearchedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  SearchHistoryV1Data copyWithCompanion(SearchHistoryV1Companion data) {
    return SearchHistoryV1Data(
      id: data.id.present ? data.id.value : this.id,
      query: data.query.present ? data.query.value : this.query,
      filterType: data.filterType.present
          ? data.filterType.value
          : this.filterType,
      searchCount: data.searchCount.present
          ? data.searchCount.value
          : this.searchCount,
      lastSearchedAt: data.lastSearchedAt.present
          ? data.lastSearchedAt.value
          : this.lastSearchedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoryV1Data(')
          ..write('id: $id, ')
          ..write('query: $query, ')
          ..write('filterType: $filterType, ')
          ..write('searchCount: $searchCount, ')
          ..write('lastSearchedAt: $lastSearchedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    query,
    filterType,
    searchCount,
    lastSearchedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistoryV1Data &&
          other.id == this.id &&
          other.query == this.query &&
          other.filterType == this.filterType &&
          other.searchCount == this.searchCount &&
          other.lastSearchedAt == this.lastSearchedAt &&
          other.createdAt == this.createdAt);
}

class SearchHistoryV1Companion extends UpdateCompanion<SearchHistoryV1Data> {
  final Value<int> id;
  final Value<String> query;
  final Value<String> filterType;
  final Value<int> searchCount;
  final Value<DateTime> lastSearchedAt;
  final Value<DateTime> createdAt;
  const SearchHistoryV1Companion({
    this.id = const Value.absent(),
    this.query = const Value.absent(),
    this.filterType = const Value.absent(),
    this.searchCount = const Value.absent(),
    this.lastSearchedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SearchHistoryV1Companion.insert({
    this.id = const Value.absent(),
    required String query,
    this.filterType = const Value.absent(),
    this.searchCount = const Value.absent(),
    this.lastSearchedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : query = Value(query);
  static Insertable<SearchHistoryV1Data> custom({
    Expression<int>? id,
    Expression<String>? query,
    Expression<String>? filterType,
    Expression<int>? searchCount,
    Expression<DateTime>? lastSearchedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (query != null) 'query': query,
      if (filterType != null) 'filter_type': filterType,
      if (searchCount != null) 'search_count': searchCount,
      if (lastSearchedAt != null) 'last_searched_at': lastSearchedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SearchHistoryV1Companion copyWith({
    Value<int>? id,
    Value<String>? query,
    Value<String>? filterType,
    Value<int>? searchCount,
    Value<DateTime>? lastSearchedAt,
    Value<DateTime>? createdAt,
  }) {
    return SearchHistoryV1Companion(
      id: id ?? this.id,
      query: query ?? this.query,
      filterType: filterType ?? this.filterType,
      searchCount: searchCount ?? this.searchCount,
      lastSearchedAt: lastSearchedAt ?? this.lastSearchedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    if (filterType.present) {
      map['filter_type'] = Variable<String>(filterType.value);
    }
    if (searchCount.present) {
      map['search_count'] = Variable<int>(searchCount.value);
    }
    if (lastSearchedAt.present) {
      map['last_searched_at'] = Variable<DateTime>(lastSearchedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoryV1Companion(')
          ..write('id: $id, ')
          ..write('query: $query, ')
          ..write('filterType: $filterType, ')
          ..write('searchCount: $searchCount, ')
          ..write('lastSearchedAt: $lastSearchedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DiscoverCacheV1Table extends DiscoverCacheV1
    with TableInfo<$DiscoverCacheV1Table, DiscoverCacheV1Data> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiscoverCacheV1Table(this.attachedDatabase, [this._alias]);
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
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
  static const VerificationMeta _sourceRuleIdMeta = const VerificationMeta(
    'sourceRuleId',
  );
  @override
  late final GeneratedColumn<String> sourceRuleId = GeneratedColumn<String>(
    'source_rule_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceRuleNameMeta = const VerificationMeta(
    'sourceRuleName',
  );
  @override
  late final GeneratedColumn<String> sourceRuleName = GeneratedColumn<String>(
    'source_rule_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _viewCountMeta = const VerificationMeta(
    'viewCount',
  );
  @override
  late final GeneratedColumn<String> viewCount = GeneratedColumn<String>(
    'view_count',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentUrlMeta = const VerificationMeta(
    'contentUrl',
  );
  @override
  late final GeneratedColumn<String> contentUrl = GeneratedColumn<String>(
    'content_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    contentId,
    title,
    contentType,
    coverUrl,
    author,
    description,
    sourceRuleId,
    sourceRuleName,
    viewCount,
    contentUrl,
    metadataJson,
    cachedAt,
    expiresAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'discover_cache_v1';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiscoverCacheV1Data> instance, {
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
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
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
    if (data.containsKey('source_rule_id')) {
      context.handle(
        _sourceRuleIdMeta,
        sourceRuleId.isAcceptableOrUnknown(
          data['source_rule_id']!,
          _sourceRuleIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceRuleIdMeta);
    }
    if (data.containsKey('source_rule_name')) {
      context.handle(
        _sourceRuleNameMeta,
        sourceRuleName.isAcceptableOrUnknown(
          data['source_rule_name']!,
          _sourceRuleNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceRuleNameMeta);
    }
    if (data.containsKey('view_count')) {
      context.handle(
        _viewCountMeta,
        viewCount.isAcceptableOrUnknown(data['view_count']!, _viewCountMeta),
      );
    }
    if (data.containsKey('content_url')) {
      context.handle(
        _contentUrlMeta,
        contentUrl.isAcceptableOrUnknown(data['content_url']!, _contentUrlMeta),
      );
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
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
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {contentId, sourceRuleId},
  ];
  @override
  DiscoverCacheV1Data map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiscoverCacheV1Data(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
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
      sourceRuleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_rule_id'],
      )!,
      sourceRuleName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_rule_name'],
      )!,
      viewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}view_count'],
      ),
      contentUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_url'],
      ),
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DiscoverCacheV1Table createAlias(String alias) {
    return $DiscoverCacheV1Table(attachedDatabase, alias);
  }
}

class DiscoverCacheV1Data extends DataClass
    implements Insertable<DiscoverCacheV1Data> {
  /// 自增主键
  final int id;

  /// 内容唯一标识
  final String contentId;

  /// 内容标题
  final String title;

  /// 内容类型
  final String contentType;

  /// 封面图片URL
  final String? coverUrl;

  /// 作者/创作者
  final String? author;

  /// 内容描述
  final String? description;

  /// 来源规则ID
  final String sourceRuleId;

  /// 来源规则名称
  final String sourceRuleName;

  /// 浏览量/热度
  final String? viewCount;

  /// 原始内容URL
  final String? contentUrl;

  /// 附加数据（JSON字符串）
  final String? metadataJson;

  /// 缓存时间
  final DateTime cachedAt;

  /// 过期时间
  final DateTime expiresAt;

  /// 创建时间
  final DateTime createdAt;
  const DiscoverCacheV1Data({
    required this.id,
    required this.contentId,
    required this.title,
    required this.contentType,
    this.coverUrl,
    this.author,
    this.description,
    required this.sourceRuleId,
    required this.sourceRuleName,
    this.viewCount,
    this.contentUrl,
    this.metadataJson,
    required this.cachedAt,
    required this.expiresAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content_id'] = Variable<String>(contentId);
    map['title'] = Variable<String>(title);
    map['content_type'] = Variable<String>(contentType);
    if (!nullToAbsent || coverUrl != null) {
      map['cover_url'] = Variable<String>(coverUrl);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['source_rule_id'] = Variable<String>(sourceRuleId);
    map['source_rule_name'] = Variable<String>(sourceRuleName);
    if (!nullToAbsent || viewCount != null) {
      map['view_count'] = Variable<String>(viewCount);
    }
    if (!nullToAbsent || contentUrl != null) {
      map['content_url'] = Variable<String>(contentUrl);
    }
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DiscoverCacheV1Companion toCompanion(bool nullToAbsent) {
    return DiscoverCacheV1Companion(
      id: Value(id),
      contentId: Value(contentId),
      title: Value(title),
      contentType: Value(contentType),
      coverUrl: coverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverUrl),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      sourceRuleId: Value(sourceRuleId),
      sourceRuleName: Value(sourceRuleName),
      viewCount: viewCount == null && nullToAbsent
          ? const Value.absent()
          : Value(viewCount),
      contentUrl: contentUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(contentUrl),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
      cachedAt: Value(cachedAt),
      expiresAt: Value(expiresAt),
      createdAt: Value(createdAt),
    );
  }

  factory DiscoverCacheV1Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiscoverCacheV1Data(
      id: serializer.fromJson<int>(json['id']),
      contentId: serializer.fromJson<String>(json['contentId']),
      title: serializer.fromJson<String>(json['title']),
      contentType: serializer.fromJson<String>(json['contentType']),
      coverUrl: serializer.fromJson<String?>(json['coverUrl']),
      author: serializer.fromJson<String?>(json['author']),
      description: serializer.fromJson<String?>(json['description']),
      sourceRuleId: serializer.fromJson<String>(json['sourceRuleId']),
      sourceRuleName: serializer.fromJson<String>(json['sourceRuleName']),
      viewCount: serializer.fromJson<String?>(json['viewCount']),
      contentUrl: serializer.fromJson<String?>(json['contentUrl']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contentId': serializer.toJson<String>(contentId),
      'title': serializer.toJson<String>(title),
      'contentType': serializer.toJson<String>(contentType),
      'coverUrl': serializer.toJson<String?>(coverUrl),
      'author': serializer.toJson<String?>(author),
      'description': serializer.toJson<String?>(description),
      'sourceRuleId': serializer.toJson<String>(sourceRuleId),
      'sourceRuleName': serializer.toJson<String>(sourceRuleName),
      'viewCount': serializer.toJson<String?>(viewCount),
      'contentUrl': serializer.toJson<String?>(contentUrl),
      'metadataJson': serializer.toJson<String?>(metadataJson),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DiscoverCacheV1Data copyWith({
    int? id,
    String? contentId,
    String? title,
    String? contentType,
    Value<String?> coverUrl = const Value.absent(),
    Value<String?> author = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? sourceRuleId,
    String? sourceRuleName,
    Value<String?> viewCount = const Value.absent(),
    Value<String?> contentUrl = const Value.absent(),
    Value<String?> metadataJson = const Value.absent(),
    DateTime? cachedAt,
    DateTime? expiresAt,
    DateTime? createdAt,
  }) => DiscoverCacheV1Data(
    id: id ?? this.id,
    contentId: contentId ?? this.contentId,
    title: title ?? this.title,
    contentType: contentType ?? this.contentType,
    coverUrl: coverUrl.present ? coverUrl.value : this.coverUrl,
    author: author.present ? author.value : this.author,
    description: description.present ? description.value : this.description,
    sourceRuleId: sourceRuleId ?? this.sourceRuleId,
    sourceRuleName: sourceRuleName ?? this.sourceRuleName,
    viewCount: viewCount.present ? viewCount.value : this.viewCount,
    contentUrl: contentUrl.present ? contentUrl.value : this.contentUrl,
    metadataJson: metadataJson.present ? metadataJson.value : this.metadataJson,
    cachedAt: cachedAt ?? this.cachedAt,
    expiresAt: expiresAt ?? this.expiresAt,
    createdAt: createdAt ?? this.createdAt,
  );
  DiscoverCacheV1Data copyWithCompanion(DiscoverCacheV1Companion data) {
    return DiscoverCacheV1Data(
      id: data.id.present ? data.id.value : this.id,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      title: data.title.present ? data.title.value : this.title,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
      author: data.author.present ? data.author.value : this.author,
      description: data.description.present
          ? data.description.value
          : this.description,
      sourceRuleId: data.sourceRuleId.present
          ? data.sourceRuleId.value
          : this.sourceRuleId,
      sourceRuleName: data.sourceRuleName.present
          ? data.sourceRuleName.value
          : this.sourceRuleName,
      viewCount: data.viewCount.present ? data.viewCount.value : this.viewCount,
      contentUrl: data.contentUrl.present
          ? data.contentUrl.value
          : this.contentUrl,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiscoverCacheV1Data(')
          ..write('id: $id, ')
          ..write('contentId: $contentId, ')
          ..write('title: $title, ')
          ..write('contentType: $contentType, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('sourceRuleId: $sourceRuleId, ')
          ..write('sourceRuleName: $sourceRuleName, ')
          ..write('viewCount: $viewCount, ')
          ..write('contentUrl: $contentUrl, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    contentId,
    title,
    contentType,
    coverUrl,
    author,
    description,
    sourceRuleId,
    sourceRuleName,
    viewCount,
    contentUrl,
    metadataJson,
    cachedAt,
    expiresAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiscoverCacheV1Data &&
          other.id == this.id &&
          other.contentId == this.contentId &&
          other.title == this.title &&
          other.contentType == this.contentType &&
          other.coverUrl == this.coverUrl &&
          other.author == this.author &&
          other.description == this.description &&
          other.sourceRuleId == this.sourceRuleId &&
          other.sourceRuleName == this.sourceRuleName &&
          other.viewCount == this.viewCount &&
          other.contentUrl == this.contentUrl &&
          other.metadataJson == this.metadataJson &&
          other.cachedAt == this.cachedAt &&
          other.expiresAt == this.expiresAt &&
          other.createdAt == this.createdAt);
}

class DiscoverCacheV1Companion extends UpdateCompanion<DiscoverCacheV1Data> {
  final Value<int> id;
  final Value<String> contentId;
  final Value<String> title;
  final Value<String> contentType;
  final Value<String?> coverUrl;
  final Value<String?> author;
  final Value<String?> description;
  final Value<String> sourceRuleId;
  final Value<String> sourceRuleName;
  final Value<String?> viewCount;
  final Value<String?> contentUrl;
  final Value<String?> metadataJson;
  final Value<DateTime> cachedAt;
  final Value<DateTime> expiresAt;
  final Value<DateTime> createdAt;
  const DiscoverCacheV1Companion({
    this.id = const Value.absent(),
    this.contentId = const Value.absent(),
    this.title = const Value.absent(),
    this.contentType = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.sourceRuleId = const Value.absent(),
    this.sourceRuleName = const Value.absent(),
    this.viewCount = const Value.absent(),
    this.contentUrl = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DiscoverCacheV1Companion.insert({
    this.id = const Value.absent(),
    required String contentId,
    required String title,
    required String contentType,
    this.coverUrl = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    required String sourceRuleId,
    required String sourceRuleName,
    this.viewCount = const Value.absent(),
    this.contentUrl = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.cachedAt = const Value.absent(),
    required DateTime expiresAt,
    this.createdAt = const Value.absent(),
  }) : contentId = Value(contentId),
       title = Value(title),
       contentType = Value(contentType),
       sourceRuleId = Value(sourceRuleId),
       sourceRuleName = Value(sourceRuleName),
       expiresAt = Value(expiresAt);
  static Insertable<DiscoverCacheV1Data> custom({
    Expression<int>? id,
    Expression<String>? contentId,
    Expression<String>? title,
    Expression<String>? contentType,
    Expression<String>? coverUrl,
    Expression<String>? author,
    Expression<String>? description,
    Expression<String>? sourceRuleId,
    Expression<String>? sourceRuleName,
    Expression<String>? viewCount,
    Expression<String>? contentUrl,
    Expression<String>? metadataJson,
    Expression<DateTime>? cachedAt,
    Expression<DateTime>? expiresAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentId != null) 'content_id': contentId,
      if (title != null) 'title': title,
      if (contentType != null) 'content_type': contentType,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (author != null) 'author': author,
      if (description != null) 'description': description,
      if (sourceRuleId != null) 'source_rule_id': sourceRuleId,
      if (sourceRuleName != null) 'source_rule_name': sourceRuleName,
      if (viewCount != null) 'view_count': viewCount,
      if (contentUrl != null) 'content_url': contentUrl,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DiscoverCacheV1Companion copyWith({
    Value<int>? id,
    Value<String>? contentId,
    Value<String>? title,
    Value<String>? contentType,
    Value<String?>? coverUrl,
    Value<String?>? author,
    Value<String?>? description,
    Value<String>? sourceRuleId,
    Value<String>? sourceRuleName,
    Value<String?>? viewCount,
    Value<String?>? contentUrl,
    Value<String?>? metadataJson,
    Value<DateTime>? cachedAt,
    Value<DateTime>? expiresAt,
    Value<DateTime>? createdAt,
  }) {
    return DiscoverCacheV1Companion(
      id: id ?? this.id,
      contentId: contentId ?? this.contentId,
      title: title ?? this.title,
      contentType: contentType ?? this.contentType,
      coverUrl: coverUrl ?? this.coverUrl,
      author: author ?? this.author,
      description: description ?? this.description,
      sourceRuleId: sourceRuleId ?? this.sourceRuleId,
      sourceRuleName: sourceRuleName ?? this.sourceRuleName,
      viewCount: viewCount ?? this.viewCount,
      contentUrl: contentUrl ?? this.contentUrl,
      metadataJson: metadataJson ?? this.metadataJson,
      cachedAt: cachedAt ?? this.cachedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
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
    if (sourceRuleId.present) {
      map['source_rule_id'] = Variable<String>(sourceRuleId.value);
    }
    if (sourceRuleName.present) {
      map['source_rule_name'] = Variable<String>(sourceRuleName.value);
    }
    if (viewCount.present) {
      map['view_count'] = Variable<String>(viewCount.value);
    }
    if (contentUrl.present) {
      map['content_url'] = Variable<String>(contentUrl.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscoverCacheV1Companion(')
          ..write('id: $id, ')
          ..write('contentId: $contentId, ')
          ..write('title: $title, ')
          ..write('contentType: $contentType, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('sourceRuleId: $sourceRuleId, ')
          ..write('sourceRuleName: $sourceRuleName, ')
          ..write('viewCount: $viewCount, ')
          ..write('contentUrl: $contentUrl, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsV1Table extends UserSettingsV1
    with TableInfo<$UserSettingsV1Table, UserSettingsV1Data> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsV1Table(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueTypeMeta = const VerificationMeta(
    'valueType',
  );
  @override
  late final GeneratedColumn<String> valueType = GeneratedColumn<String>(
    'value_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    key,
    value,
    valueType,
    updatedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings_v1';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSettingsV1Data> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('value_type')) {
      context.handle(
        _valueTypeMeta,
        valueType.isAcceptableOrUnknown(data['value_type']!, _valueTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_valueTypeMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSettingsV1Data map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSettingsV1Data(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      valueType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_type'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UserSettingsV1Table createAlias(String alias) {
    return $UserSettingsV1Table(attachedDatabase, alias);
  }
}

class UserSettingsV1Data extends DataClass
    implements Insertable<UserSettingsV1Data> {
  /// 自增主键
  final int id;

  /// 设置键
  final String key;

  /// 设置值（JSON字符串）
  final String value;

  /// 设置类型：string, int, bool, double, json
  final String valueType;

  /// 更新时间
  final DateTime updatedAt;

  /// 创建时间
  final DateTime createdAt;
  const UserSettingsV1Data({
    required this.id,
    required this.key,
    required this.value,
    required this.valueType,
    required this.updatedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['value_type'] = Variable<String>(valueType);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserSettingsV1Companion toCompanion(bool nullToAbsent) {
    return UserSettingsV1Companion(
      id: Value(id),
      key: Value(key),
      value: Value(value),
      valueType: Value(valueType),
      updatedAt: Value(updatedAt),
      createdAt: Value(createdAt),
    );
  }

  factory UserSettingsV1Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSettingsV1Data(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      valueType: serializer.fromJson<String>(json['valueType']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'valueType': serializer.toJson<String>(valueType),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserSettingsV1Data copyWith({
    int? id,
    String? key,
    String? value,
    String? valueType,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) => UserSettingsV1Data(
    id: id ?? this.id,
    key: key ?? this.key,
    value: value ?? this.value,
    valueType: valueType ?? this.valueType,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  UserSettingsV1Data copyWithCompanion(UserSettingsV1Companion data) {
    return UserSettingsV1Data(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      valueType: data.valueType.present ? data.valueType.value : this.valueType,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsV1Data(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('valueType: $valueType, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, key, value, valueType, updatedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSettingsV1Data &&
          other.id == this.id &&
          other.key == this.key &&
          other.value == this.value &&
          other.valueType == this.valueType &&
          other.updatedAt == this.updatedAt &&
          other.createdAt == this.createdAt);
}

class UserSettingsV1Companion extends UpdateCompanion<UserSettingsV1Data> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> value;
  final Value<String> valueType;
  final Value<DateTime> updatedAt;
  final Value<DateTime> createdAt;
  const UserSettingsV1Companion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.valueType = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UserSettingsV1Companion.insert({
    this.id = const Value.absent(),
    required String key,
    required String value,
    required String valueType,
    this.updatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       valueType = Value(valueType);
  static Insertable<UserSettingsV1Data> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? value,
    Expression<String>? valueType,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (valueType != null) 'value_type': valueType,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UserSettingsV1Companion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<String>? value,
    Value<String>? valueType,
    Value<DateTime>? updatedAt,
    Value<DateTime>? createdAt,
  }) {
    return UserSettingsV1Companion(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      valueType: valueType ?? this.valueType,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (valueType.present) {
      map['value_type'] = Variable<String>(valueType.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsV1Companion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('valueType: $valueType, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RulesV1Table rulesV1 = $RulesV1Table(this);
  late final $SessionsV1Table sessionsV1 = $SessionsV1Table(this);
  late final $FavoritesV1Table favoritesV1 = $FavoritesV1Table(this);
  late final $SearchHistoryV1Table searchHistoryV1 = $SearchHistoryV1Table(
    this,
  );
  late final $DiscoverCacheV1Table discoverCacheV1 = $DiscoverCacheV1Table(
    this,
  );
  late final $UserSettingsV1Table userSettingsV1 = $UserSettingsV1Table(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    rulesV1,
    sessionsV1,
    favoritesV1,
    searchHistoryV1,
    discoverCacheV1,
    userSettingsV1,
  ];
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
typedef $$FavoritesV1TableCreateCompanionBuilder =
    FavoritesV1Companion Function({
      Value<int> id,
      required String contentId,
      required String title,
      required String contentType,
      Value<String?> coverUrl,
      Value<String?> author,
      Value<String?> description,
      required String sourceRuleId,
      required String sourceRuleName,
      Value<String?> contentUrl,
      Value<String?> metadataJson,
      Value<DateTime> favoritedAt,
      Value<DateTime?> lastAccessedAt,
      Value<int> accessCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$FavoritesV1TableUpdateCompanionBuilder =
    FavoritesV1Companion Function({
      Value<int> id,
      Value<String> contentId,
      Value<String> title,
      Value<String> contentType,
      Value<String?> coverUrl,
      Value<String?> author,
      Value<String?> description,
      Value<String> sourceRuleId,
      Value<String> sourceRuleName,
      Value<String?> contentUrl,
      Value<String?> metadataJson,
      Value<DateTime> favoritedAt,
      Value<DateTime?> lastAccessedAt,
      Value<int> accessCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$FavoritesV1TableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesV1Table> {
  $$FavoritesV1TableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
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

  ColumnFilters<String> get sourceRuleId => $composableBuilder(
    column: $table.sourceRuleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRuleName => $composableBuilder(
    column: $table.sourceRuleName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentUrl => $composableBuilder(
    column: $table.contentUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get favoritedAt => $composableBuilder(
    column: $table.favoritedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAccessedAt => $composableBuilder(
    column: $table.lastAccessedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accessCount => $composableBuilder(
    column: $table.accessCount,
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

class $$FavoritesV1TableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesV1Table> {
  $$FavoritesV1TableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
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

  ColumnOrderings<String> get sourceRuleId => $composableBuilder(
    column: $table.sourceRuleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRuleName => $composableBuilder(
    column: $table.sourceRuleName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentUrl => $composableBuilder(
    column: $table.contentUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get favoritedAt => $composableBuilder(
    column: $table.favoritedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAccessedAt => $composableBuilder(
    column: $table.lastAccessedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accessCount => $composableBuilder(
    column: $table.accessCount,
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

class $$FavoritesV1TableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesV1Table> {
  $$FavoritesV1TableAnnotationComposer({
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

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRuleId => $composableBuilder(
    column: $table.sourceRuleId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRuleName => $composableBuilder(
    column: $table.sourceRuleName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentUrl => $composableBuilder(
    column: $table.contentUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get favoritedAt => $composableBuilder(
    column: $table.favoritedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAccessedAt => $composableBuilder(
    column: $table.lastAccessedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get accessCount => $composableBuilder(
    column: $table.accessCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FavoritesV1TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesV1Table,
          FavoritesV1Data,
          $$FavoritesV1TableFilterComposer,
          $$FavoritesV1TableOrderingComposer,
          $$FavoritesV1TableAnnotationComposer,
          $$FavoritesV1TableCreateCompanionBuilder,
          $$FavoritesV1TableUpdateCompanionBuilder,
          (
            FavoritesV1Data,
            BaseReferences<_$AppDatabase, $FavoritesV1Table, FavoritesV1Data>,
          ),
          FavoritesV1Data,
          PrefetchHooks Function()
        > {
  $$FavoritesV1TableTableManager(_$AppDatabase db, $FavoritesV1Table table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesV1TableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesV1TableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesV1TableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> contentId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String?> coverUrl = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> sourceRuleId = const Value.absent(),
                Value<String> sourceRuleName = const Value.absent(),
                Value<String?> contentUrl = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<DateTime> favoritedAt = const Value.absent(),
                Value<DateTime?> lastAccessedAt = const Value.absent(),
                Value<int> accessCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FavoritesV1Companion(
                id: id,
                contentId: contentId,
                title: title,
                contentType: contentType,
                coverUrl: coverUrl,
                author: author,
                description: description,
                sourceRuleId: sourceRuleId,
                sourceRuleName: sourceRuleName,
                contentUrl: contentUrl,
                metadataJson: metadataJson,
                favoritedAt: favoritedAt,
                lastAccessedAt: lastAccessedAt,
                accessCount: accessCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String contentId,
                required String title,
                required String contentType,
                Value<String?> coverUrl = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required String sourceRuleId,
                required String sourceRuleName,
                Value<String?> contentUrl = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<DateTime> favoritedAt = const Value.absent(),
                Value<DateTime?> lastAccessedAt = const Value.absent(),
                Value<int> accessCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FavoritesV1Companion.insert(
                id: id,
                contentId: contentId,
                title: title,
                contentType: contentType,
                coverUrl: coverUrl,
                author: author,
                description: description,
                sourceRuleId: sourceRuleId,
                sourceRuleName: sourceRuleName,
                contentUrl: contentUrl,
                metadataJson: metadataJson,
                favoritedAt: favoritedAt,
                lastAccessedAt: lastAccessedAt,
                accessCount: accessCount,
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

typedef $$FavoritesV1TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesV1Table,
      FavoritesV1Data,
      $$FavoritesV1TableFilterComposer,
      $$FavoritesV1TableOrderingComposer,
      $$FavoritesV1TableAnnotationComposer,
      $$FavoritesV1TableCreateCompanionBuilder,
      $$FavoritesV1TableUpdateCompanionBuilder,
      (
        FavoritesV1Data,
        BaseReferences<_$AppDatabase, $FavoritesV1Table, FavoritesV1Data>,
      ),
      FavoritesV1Data,
      PrefetchHooks Function()
    >;
typedef $$SearchHistoryV1TableCreateCompanionBuilder =
    SearchHistoryV1Companion Function({
      Value<int> id,
      required String query,
      Value<String> filterType,
      Value<int> searchCount,
      Value<DateTime> lastSearchedAt,
      Value<DateTime> createdAt,
    });
typedef $$SearchHistoryV1TableUpdateCompanionBuilder =
    SearchHistoryV1Companion Function({
      Value<int> id,
      Value<String> query,
      Value<String> filterType,
      Value<int> searchCount,
      Value<DateTime> lastSearchedAt,
      Value<DateTime> createdAt,
    });

class $$SearchHistoryV1TableFilterComposer
    extends Composer<_$AppDatabase, $SearchHistoryV1Table> {
  $$SearchHistoryV1TableFilterComposer({
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

  ColumnFilters<String> get query => $composableBuilder(
    column: $table.query,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filterType => $composableBuilder(
    column: $table.filterType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get searchCount => $composableBuilder(
    column: $table.searchCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSearchedAt => $composableBuilder(
    column: $table.lastSearchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SearchHistoryV1TableOrderingComposer
    extends Composer<_$AppDatabase, $SearchHistoryV1Table> {
  $$SearchHistoryV1TableOrderingComposer({
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

  ColumnOrderings<String> get query => $composableBuilder(
    column: $table.query,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filterType => $composableBuilder(
    column: $table.filterType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get searchCount => $composableBuilder(
    column: $table.searchCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSearchedAt => $composableBuilder(
    column: $table.lastSearchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SearchHistoryV1TableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchHistoryV1Table> {
  $$SearchHistoryV1TableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get query =>
      $composableBuilder(column: $table.query, builder: (column) => column);

  GeneratedColumn<String> get filterType => $composableBuilder(
    column: $table.filterType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get searchCount => $composableBuilder(
    column: $table.searchCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSearchedAt => $composableBuilder(
    column: $table.lastSearchedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SearchHistoryV1TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SearchHistoryV1Table,
          SearchHistoryV1Data,
          $$SearchHistoryV1TableFilterComposer,
          $$SearchHistoryV1TableOrderingComposer,
          $$SearchHistoryV1TableAnnotationComposer,
          $$SearchHistoryV1TableCreateCompanionBuilder,
          $$SearchHistoryV1TableUpdateCompanionBuilder,
          (
            SearchHistoryV1Data,
            BaseReferences<
              _$AppDatabase,
              $SearchHistoryV1Table,
              SearchHistoryV1Data
            >,
          ),
          SearchHistoryV1Data,
          PrefetchHooks Function()
        > {
  $$SearchHistoryV1TableTableManager(
    _$AppDatabase db,
    $SearchHistoryV1Table table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchHistoryV1TableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchHistoryV1TableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SearchHistoryV1TableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> query = const Value.absent(),
                Value<String> filterType = const Value.absent(),
                Value<int> searchCount = const Value.absent(),
                Value<DateTime> lastSearchedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SearchHistoryV1Companion(
                id: id,
                query: query,
                filterType: filterType,
                searchCount: searchCount,
                lastSearchedAt: lastSearchedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String query,
                Value<String> filterType = const Value.absent(),
                Value<int> searchCount = const Value.absent(),
                Value<DateTime> lastSearchedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SearchHistoryV1Companion.insert(
                id: id,
                query: query,
                filterType: filterType,
                searchCount: searchCount,
                lastSearchedAt: lastSearchedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SearchHistoryV1TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SearchHistoryV1Table,
      SearchHistoryV1Data,
      $$SearchHistoryV1TableFilterComposer,
      $$SearchHistoryV1TableOrderingComposer,
      $$SearchHistoryV1TableAnnotationComposer,
      $$SearchHistoryV1TableCreateCompanionBuilder,
      $$SearchHistoryV1TableUpdateCompanionBuilder,
      (
        SearchHistoryV1Data,
        BaseReferences<
          _$AppDatabase,
          $SearchHistoryV1Table,
          SearchHistoryV1Data
        >,
      ),
      SearchHistoryV1Data,
      PrefetchHooks Function()
    >;
typedef $$DiscoverCacheV1TableCreateCompanionBuilder =
    DiscoverCacheV1Companion Function({
      Value<int> id,
      required String contentId,
      required String title,
      required String contentType,
      Value<String?> coverUrl,
      Value<String?> author,
      Value<String?> description,
      required String sourceRuleId,
      required String sourceRuleName,
      Value<String?> viewCount,
      Value<String?> contentUrl,
      Value<String?> metadataJson,
      Value<DateTime> cachedAt,
      required DateTime expiresAt,
      Value<DateTime> createdAt,
    });
typedef $$DiscoverCacheV1TableUpdateCompanionBuilder =
    DiscoverCacheV1Companion Function({
      Value<int> id,
      Value<String> contentId,
      Value<String> title,
      Value<String> contentType,
      Value<String?> coverUrl,
      Value<String?> author,
      Value<String?> description,
      Value<String> sourceRuleId,
      Value<String> sourceRuleName,
      Value<String?> viewCount,
      Value<String?> contentUrl,
      Value<String?> metadataJson,
      Value<DateTime> cachedAt,
      Value<DateTime> expiresAt,
      Value<DateTime> createdAt,
    });

class $$DiscoverCacheV1TableFilterComposer
    extends Composer<_$AppDatabase, $DiscoverCacheV1Table> {
  $$DiscoverCacheV1TableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
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

  ColumnFilters<String> get sourceRuleId => $composableBuilder(
    column: $table.sourceRuleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRuleName => $composableBuilder(
    column: $table.sourceRuleName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get viewCount => $composableBuilder(
    column: $table.viewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentUrl => $composableBuilder(
    column: $table.contentUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DiscoverCacheV1TableOrderingComposer
    extends Composer<_$AppDatabase, $DiscoverCacheV1Table> {
  $$DiscoverCacheV1TableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
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

  ColumnOrderings<String> get sourceRuleId => $composableBuilder(
    column: $table.sourceRuleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRuleName => $composableBuilder(
    column: $table.sourceRuleName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get viewCount => $composableBuilder(
    column: $table.viewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentUrl => $composableBuilder(
    column: $table.contentUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DiscoverCacheV1TableAnnotationComposer
    extends Composer<_$AppDatabase, $DiscoverCacheV1Table> {
  $$DiscoverCacheV1TableAnnotationComposer({
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

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRuleId => $composableBuilder(
    column: $table.sourceRuleId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRuleName => $composableBuilder(
    column: $table.sourceRuleName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get viewCount =>
      $composableBuilder(column: $table.viewCount, builder: (column) => column);

  GeneratedColumn<String> get contentUrl => $composableBuilder(
    column: $table.contentUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DiscoverCacheV1TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiscoverCacheV1Table,
          DiscoverCacheV1Data,
          $$DiscoverCacheV1TableFilterComposer,
          $$DiscoverCacheV1TableOrderingComposer,
          $$DiscoverCacheV1TableAnnotationComposer,
          $$DiscoverCacheV1TableCreateCompanionBuilder,
          $$DiscoverCacheV1TableUpdateCompanionBuilder,
          (
            DiscoverCacheV1Data,
            BaseReferences<
              _$AppDatabase,
              $DiscoverCacheV1Table,
              DiscoverCacheV1Data
            >,
          ),
          DiscoverCacheV1Data,
          PrefetchHooks Function()
        > {
  $$DiscoverCacheV1TableTableManager(
    _$AppDatabase db,
    $DiscoverCacheV1Table table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiscoverCacheV1TableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiscoverCacheV1TableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiscoverCacheV1TableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> contentId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String?> coverUrl = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> sourceRuleId = const Value.absent(),
                Value<String> sourceRuleName = const Value.absent(),
                Value<String?> viewCount = const Value.absent(),
                Value<String?> contentUrl = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DiscoverCacheV1Companion(
                id: id,
                contentId: contentId,
                title: title,
                contentType: contentType,
                coverUrl: coverUrl,
                author: author,
                description: description,
                sourceRuleId: sourceRuleId,
                sourceRuleName: sourceRuleName,
                viewCount: viewCount,
                contentUrl: contentUrl,
                metadataJson: metadataJson,
                cachedAt: cachedAt,
                expiresAt: expiresAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String contentId,
                required String title,
                required String contentType,
                Value<String?> coverUrl = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required String sourceRuleId,
                required String sourceRuleName,
                Value<String?> viewCount = const Value.absent(),
                Value<String?> contentUrl = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                required DateTime expiresAt,
                Value<DateTime> createdAt = const Value.absent(),
              }) => DiscoverCacheV1Companion.insert(
                id: id,
                contentId: contentId,
                title: title,
                contentType: contentType,
                coverUrl: coverUrl,
                author: author,
                description: description,
                sourceRuleId: sourceRuleId,
                sourceRuleName: sourceRuleName,
                viewCount: viewCount,
                contentUrl: contentUrl,
                metadataJson: metadataJson,
                cachedAt: cachedAt,
                expiresAt: expiresAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DiscoverCacheV1TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiscoverCacheV1Table,
      DiscoverCacheV1Data,
      $$DiscoverCacheV1TableFilterComposer,
      $$DiscoverCacheV1TableOrderingComposer,
      $$DiscoverCacheV1TableAnnotationComposer,
      $$DiscoverCacheV1TableCreateCompanionBuilder,
      $$DiscoverCacheV1TableUpdateCompanionBuilder,
      (
        DiscoverCacheV1Data,
        BaseReferences<
          _$AppDatabase,
          $DiscoverCacheV1Table,
          DiscoverCacheV1Data
        >,
      ),
      DiscoverCacheV1Data,
      PrefetchHooks Function()
    >;
typedef $$UserSettingsV1TableCreateCompanionBuilder =
    UserSettingsV1Companion Function({
      Value<int> id,
      required String key,
      required String value,
      required String valueType,
      Value<DateTime> updatedAt,
      Value<DateTime> createdAt,
    });
typedef $$UserSettingsV1TableUpdateCompanionBuilder =
    UserSettingsV1Companion Function({
      Value<int> id,
      Value<String> key,
      Value<String> value,
      Value<String> valueType,
      Value<DateTime> updatedAt,
      Value<DateTime> createdAt,
    });

class $$UserSettingsV1TableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsV1Table> {
  $$UserSettingsV1TableFilterComposer({
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

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueType => $composableBuilder(
    column: $table.valueType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserSettingsV1TableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsV1Table> {
  $$UserSettingsV1TableOrderingComposer({
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

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueType => $composableBuilder(
    column: $table.valueType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSettingsV1TableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsV1Table> {
  $$UserSettingsV1TableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get valueType =>
      $composableBuilder(column: $table.valueType, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserSettingsV1TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserSettingsV1Table,
          UserSettingsV1Data,
          $$UserSettingsV1TableFilterComposer,
          $$UserSettingsV1TableOrderingComposer,
          $$UserSettingsV1TableAnnotationComposer,
          $$UserSettingsV1TableCreateCompanionBuilder,
          $$UserSettingsV1TableUpdateCompanionBuilder,
          (
            UserSettingsV1Data,
            BaseReferences<
              _$AppDatabase,
              $UserSettingsV1Table,
              UserSettingsV1Data
            >,
          ),
          UserSettingsV1Data,
          PrefetchHooks Function()
        > {
  $$UserSettingsV1TableTableManager(
    _$AppDatabase db,
    $UserSettingsV1Table table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsV1TableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsV1TableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsV1TableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> valueType = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UserSettingsV1Companion(
                id: id,
                key: key,
                value: value,
                valueType: valueType,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required String value,
                required String valueType,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UserSettingsV1Companion.insert(
                id: id,
                key: key,
                value: value,
                valueType: valueType,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserSettingsV1TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserSettingsV1Table,
      UserSettingsV1Data,
      $$UserSettingsV1TableFilterComposer,
      $$UserSettingsV1TableOrderingComposer,
      $$UserSettingsV1TableAnnotationComposer,
      $$UserSettingsV1TableCreateCompanionBuilder,
      $$UserSettingsV1TableUpdateCompanionBuilder,
      (
        UserSettingsV1Data,
        BaseReferences<_$AppDatabase, $UserSettingsV1Table, UserSettingsV1Data>,
      ),
      UserSettingsV1Data,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RulesV1TableTableManager get rulesV1 =>
      $$RulesV1TableTableManager(_db, _db.rulesV1);
  $$SessionsV1TableTableManager get sessionsV1 =>
      $$SessionsV1TableTableManager(_db, _db.sessionsV1);
  $$FavoritesV1TableTableManager get favoritesV1 =>
      $$FavoritesV1TableTableManager(_db, _db.favoritesV1);
  $$SearchHistoryV1TableTableManager get searchHistoryV1 =>
      $$SearchHistoryV1TableTableManager(_db, _db.searchHistoryV1);
  $$DiscoverCacheV1TableTableManager get discoverCacheV1 =>
      $$DiscoverCacheV1TableTableManager(_db, _db.discoverCacheV1);
  $$UserSettingsV1TableTableManager get userSettingsV1 =>
      $$UserSettingsV1TableTableManager(_db, _db.userSettingsV1);
}
