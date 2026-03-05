# Task 4 Drift Migration Evidence

## 变更摘要

- 在 `crawl_rules` 表新增字段：
  - `irVersion`（`ir_version`，`INTEGER NOT NULL DEFAULT 1`）
  - `ruleEnvelopeJson`（`rule_envelope_json`，`TEXT NULL`）
  - `displayConfigJson`（`display_config_json`，`TEXT NULL`）
  - `cookieJarEncrypted`（`cookie_jar_encrypted`，`TEXT NULL`）
  - `kvStoreEncrypted`（`kv_store_encrypted`，`TEXT NULL`）
- 将 `schemaVersion` 从 `2` 升级到 `3`。
- 迁移策略按要求仅新增字段，不对旧 schema 记录做 IR 数据转换。
- 新增最小迁移测试，验证从 v2 打开数据库时升级成功且新列存在。

## 执行命令

```bash
flutter analyze --fatal-infos
flutter test
```

## 验证结果

- `flutter analyze --fatal-infos`：通过（No issues found）。
- `flutter test`：通过（`app_database_migration_test.dart` 1 个用例通过）。

## 2026-03-05（本次补充）

### 变更文件

- `lib/core/database/drift/app_database.dart`
- `lib/core/database/drift/tables/rules_v1.dart`
- `lib/core/database/drift/app_database.g.dart`
- `lib/core/database/drift/rule_storage_cipher.dart`
- `test/app_database_migration_test.dart`

### 本次功能

- `schemaVersion` 从 `1` 升级到 `2`，并在 `MigrationStrategy.onUpgrade`
  中为 `rules_v1` 增加 `cookie_jar_encrypted` 与
  `kv_store_encrypted`，形成可执行升级路径。
- `rules_v1` 补齐规则级存储密文字段：
  `cookieJarEncrypted`、`kvStoreEncrypted`。
- 新增 `RuleStorageCipher`，使用 `AES/GCM`（AEAD）+
  `HKDF(SHA-256)` 按 `ruleId` 派生子密钥，确保同一 `ruleId`
  可解密恢复且数据库仅存密文。
- 新增最小单测，验证：
  1) v1->v2 迁移后列存在；
  2) 同一 `ruleId` 加密写入后可解密还原 cookieJar。

### 执行命令与结果

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze --fatal-infos --no-pub
flutter test
```

- `dart run build_runner build --delete-conflicting-outputs`：通过。
- `flutter analyze --fatal-infos --no-pub`：通过（No issues found）。
- `flutter test`：通过（2 个用例全部通过）。
