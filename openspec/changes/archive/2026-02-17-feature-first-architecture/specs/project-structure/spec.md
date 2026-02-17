# Project Structure Specification

## ADDED Requirements

### Requirement: Core directory structure
The system SHALL organize shared infrastructure in `lib/core/` directory.

#### Scenario: Core subdirectories
- **WHEN** project is structured
- **THEN** core/ SHALL contain: database/, router/, theme/, constants/, utils/

#### Scenario: Core module purpose
- **WHEN** adding cross-cutting functionality
- **THEN** it SHALL be placed in the appropriate core/ subdirectory

---

### Requirement: Shared directory structure
The system SHALL organize shared components in `lib/shared/` directory.

#### Scenario: Shared subdirectories
- **WHEN** project is structured
- **THEN** shared/ SHALL contain: widgets/, providers/

#### Scenario: Shared widget usage
- **WHEN** multiple features need the same UI component
- **THEN** the component SHALL be placed in shared/widgets/

---

### Requirement: Feature module structure
Each feature module SHALL follow the three-layer architecture: data/, domain/, presentation/.

#### Scenario: Feature directory structure
- **WHEN** creating a new feature module
- **THEN** it SHALL have: features/<name>/data/, features/<name>/domain/, features/<name>/presentation/

#### Scenario: Data layer contents
- **WHEN** implementing data layer
- **THEN** it SHALL contain: datasources/, models/, repositories/

#### Scenario: Domain layer contents
- **WHEN** implementing domain layer
- **THEN** it SHALL contain: entities/, repositories/ (interfaces), usecases/

#### Scenario: Presentation layer contents
- **WHEN** implementing presentation layer
- **THEN** it SHALL contain: providers/, pages/, widgets/

---

### Requirement: Feature naming convention
Feature directory names SHALL use kebab-case (lowercase with hyphens).

#### Scenario: Feature directory naming
- **WHEN** creating a feature for video collection
- **THEN** the directory SHALL be named `video/`

#### Scenario: Multi-word feature naming
- **WHEN** creating a feature with multiple words
- **THEN** the directory SHALL use hyphens (e.g., `download-manager/`)

---

### Requirement: Generated code placement
Generated code files SHALL use `.g.dart` suffix and coexist with source files.

#### Scenario: Riverpod generated files
- **WHEN** riverpod_generator runs
- **THEN** `<name>.g.dart` SHALL be generated alongside `<name>.dart`

#### Scenario: Drift generated files
- **WHEN** drift_dev runs
- **THEN** database code SHALL be generated in the same directory as table definitions

---

### Requirement: Localization file placement
Localization files SHALL be placed in `lib/l10n/` directory.

#### Scenario: ARB file location
- **WHEN** adding translation files
- **THEN** they SHALL be in `lib/l10n/app_<locale>.arb`

#### Scenario: Generated localization location
- **WHEN** gen_l10n runs
- **THEN** generated files SHALL be in `lib/l10n/` or `.dart_tool/flutter_gen/gen_l10n/`

---

### Requirement: Asset directory structure
Assets SHALL be organized in `assets/` directory with subdirectories by type.

#### Scenario: Asset organization
- **WHEN** adding assets
- **THEN** they SHALL be in: assets/images/, assets/icons/, assets/fonts/, etc.

#### Scenario: Asset declaration
- **WHEN** assets are added
- **THEN** they SHALL be declared in pubspec.yaml under flutter.assets
