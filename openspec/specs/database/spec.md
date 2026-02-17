# Database Specification

## ADDED Requirements

### Requirement: Drift database configuration
The system SHALL configure Drift database for relational data storage with code generation.

#### Scenario: Database initialization
- **WHEN** the application starts
- **THEN** Drift database SHALL be initialized with defined schema

#### Scenario: Database location
- **WHEN** database is created
- **THEN** it SHALL be stored in platform-appropriate location using drift_flutter

---

### Requirement: Hive CE box configuration
The system SHALL configure Hive CE for key-value storage with type adapters.

#### Scenario: Box initialization
- **WHEN** the application starts
- **THEN** required Hive boxes SHALL be opened and ready for use

#### Scenario: Box registration
- **WHEN** build_runner completes
- **THEN** type adapters SHALL be generated for all Hive-annotated classes

---

### Requirement: Data layer separation
The system SHALL separate data storage by purpose using the dual-database strategy.

#### Scenario: Relational data storage
- **WHEN** storing crawl rules, content, tasks, or collections
- **THEN** data SHALL be stored in Drift SQLite database

#### Scenario: Key-value data storage
- **WHEN** storing user settings, cache, or credentials
- **THEN** data SHALL be stored in Hive CE boxes

---

### Requirement: Database schema for rules
The system SHALL define a `crawl_rules` table in Drift for storing crawler rules.

#### Scenario: Rule table structure
- **WHEN** database is created
- **THEN** crawl_rules table SHALL include fields: id, name, type, pattern, config, created_at, updated_at

#### Scenario: Rule query
- **WHEN** searching for rules by name or pattern
- **THEN** the system SHALL support LIKE queries on name and pattern fields

---

### Requirement: Hive settings box
The system SHALL provide a `settings` Hive box for user preferences.

#### Scenario: Settings storage
- **WHEN** user modifies a setting
- **THEN** the setting SHALL be stored with a string key in the settings box

#### Scenario: Settings retrieval
- **WHEN** application reads a setting
- **THEN** the value SHALL be retrieved from settings box with default fallback

---

### Requirement: Repository pattern
The system SHALL implement repositories to abstract data access from business logic.

#### Scenario: Repository interface
- **WHEN** a feature needs data access
- **THEN** it SHALL depend on repository interfaces defined in domain layer

#### Scenario: Repository implementation
- **WHEN** implementing data access
- **THEN** repository implementations SHALL be placed in data layer

---

### Requirement: Database migration support
The system SHALL support database schema migrations for future updates.

#### Scenario: Schema version upgrade
- **WHEN** database schema changes in a new version
- **THEN** migration code SHALL handle upgrade from previous version

#### Scenario: Data preservation
- **WHEN** migration occurs
- **THEN** existing user data SHALL be preserved
