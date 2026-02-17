# Localization Specification

## ADDED Requirements

### Requirement: ARB file structure
The system SHALL use ARB (Application Resource Bundle) format for translation files.

#### Scenario: Translation file location
- **WHEN** adding translations
- **THEN** ARB files SHALL be placed in `lib/l10n/` directory

#### Scenario: File naming convention
- **WHEN** creating a language file
- **THEN** the file SHALL be named `app_<locale>.arb` (e.g., `app_en.arb`, `app_zh.arb`)

---

### Requirement: Supported locales
The system SHALL support Chinese (Simplified) and English at minimum.

#### Scenario: English translations
- **WHEN** locale is set to English
- **THEN** app_en.arb translations SHALL be used

#### Scenario: Chinese translations
- **WHEN** locale is set to Chinese
- **THEN** app_zh.arb translations SHALL be used

#### Scenario: Default locale
- **WHEN** application starts for the first time
- **THEN** system locale SHALL be used if supported, otherwise English

---

### Requirement: Generated localization classes
The system SHALL use gen_l10n to generate type-safe localization classes.

#### Scenario: Code generation
- **WHEN** build_runner or flutter gen-l10n runs
- **THEN** AppLocalizations class SHALL be generated from ARB files

#### Scenario: Type-safe access
- **WHEN** accessing a translation in code
- **THEN** the developer SHALL use `AppLocalizations.of(context)!.stringKey` syntax

#### Scenario: Compile-time validation
- **WHEN** a translation key is missing
- **THEN** the code SHALL fail to compile

---

### Requirement: MaterialApp localization integration
The system SHALL configure MaterialApp with localization delegates.

#### Scenario: Delegate configuration
- **WHEN** MaterialApp is built
- **THEN** localizationsDelegates SHALL include AppLocalizations.delegate and Material/Widgets delegates

#### Scenario: Supported locales declaration
- **WHEN** MaterialApp is built
- **THEN** supportedLocales SHALL list all available locales

---

### Requirement: Locale switching
The system SHALL allow users to change the application language at runtime.

#### Scenario: Locale change
- **WHEN** user selects a different language
- **THEN** MaterialApp locale SHALL update immediately

#### Scenario: Locale persistence
- **WHEN** user changes locale
- **THEN** the selected locale SHALL be persisted and restored on next launch

---

### Requirement: Plural and gender support
The system SHALL support plural forms in translations.

#### Scenario: Plural translation
- **WHEN** a string requires pluralization
- **THEN** ARB file SHALL define plural placeholders with `=one`, `=other` selectors

#### Scenario: Plural rendering
- **WHEN** displaying a pluralized string
- **THEN** correct form SHALL be displayed based on quantity
