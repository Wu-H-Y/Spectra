# App Theme Specification (Delta)

## MODIFIED Requirements

### Requirement: Brand color constants

The system SHALL define brand color constants for consistent theming across the application.

| Color Name | Hex Value | Usage |
|------------|-----------|-------|
| Cyber Cyan | `#00F2FF` | Primary color |
| Electric Violet | `#7000FF` | Secondary color |
| Neon Pink | `#FF0055` | Tertiary/Accent color |
| Deep Void | `#0B0E14` | Dark background |

#### Scenario: Access brand colors
- **WHEN** developer imports `AppColors` class
- **THEN** all brand colors SHALL be accessible as static constants

---

### Requirement: Material 3 theme configuration

The system SHALL provide Material 3 compliant theme configurations using `flex_color_scheme`.

#### Scenario: Dark theme applies correctly
- **WHEN** app uses dark theme mode
- **THEN** theme SHALL use Deep Void (`#0B0E14`) as scaffold background
- **AND** primary color SHALL be Cyber Cyan (`#00F2FF`)
- **AND** secondary color SHALL be Electric Violet (`#7000FF`)
- **AND** tertiary color SHALL be Neon Pink (`#FF0055`)

#### Scenario: Light theme applies correctly
- **WHEN** app uses light theme mode
- **THEN** theme SHALL use light-adapted brand colors
- **AND** primary color SHALL be darkened for readability

---

### Requirement: Typography configuration

The system SHALL configure brand fonts using Google Fonts.

| Text Style | Font Family | Usage |
|------------|-------------|-------|
| displayLarge | Orbitron | Large titles |
| displayMedium | Orbitron | Medium titles |
| titleLarge | Orbitron | Section headers |
| bodyLarge | Inter | Body text |
| bodyMedium | Inter | Secondary text |

#### Scenario: Title text uses Orbitron font
- **WHEN** widget uses `Theme.of(context).textTheme.displayLarge`
- **THEN** text SHALL render with Orbitron font family

#### Scenario: Body text uses Inter font
- **WHEN** widget uses `Theme.of(context).textTheme.bodyLarge`
- **THEN** text SHALL render with Inter font family

---

## ADDED Requirements

### Requirement: Spacing design tokens

The system SHALL define standard spacing values for consistent layout.

| Token Name | Value | Usage |
|------------|-------|-------|
| spacingXs | 4dp | Tight spacing |
| spacingSm | 8dp | Small gaps |
| spacingMd | 16dp | Default spacing |
| spacingLg | 24dp | Section gaps |
| spacingXl | 32dp | Large margins |
| spacingXxl | 48dp | Extra large gaps |

#### Scenario: Spacing access
- **WHEN** developer needs standard spacing values
- **THEN** AppSpacing class SHALL provide predefined constants

#### Scenario: EdgeInsets shortcuts
- **WHEN** developer needs common padding patterns
- **THEN** AppSpacing SHALL provide EdgeInsets shortcuts (e.g., `paddingMd`, `horizontalMd`)

---

### Requirement: Animation duration tokens

The system SHALL define standard animation durations for consistent motion.

| Token Name | Value | Usage |
|------------|-------|-------|
| durationFast | 150ms | Quick transitions |
| durationNormal | 300ms | Standard animations |
| durationSlow | 500ms | Emphasized motion |

#### Scenario: Animation duration access
- **WHEN** developer needs animation duration
- **THEN** AppDurations class SHALL provide predefined constants

---

### Requirement: Responsive breakpoints

The system SHALL define responsive breakpoints for adaptive layouts.

| Breakpoint | Min Width | Target |
|------------|-----------|--------|
| mobile | 0 | Mobile phones |
| tablet | 600 | Tablets |
| desktop | 900 | Desktop screens |

#### Scenario: Breakpoint access
- **WHEN** developer needs to check screen size
- **THEN** AppBreakpoints class SHALL provide breakpoint constants

#### Scenario: Responsive builder usage
- **WHEN** building responsive layouts
- **THEN** developer SHALL use breakpoints for conditional rendering

---

### Requirement: Theme file relocation

Theme files SHALL be relocated to core directory following Feature-First architecture.

#### Scenario: Theme file location
- **WHEN** project follows Feature-First structure
- **THEN** theme files SHALL be in `lib/core/theme/`

#### Scenario: Theme exports
- **WHEN** developer imports theme
- **THEN** `lib/core/theme/theme.dart` SHALL export all theme-related classes

---

### Requirement: Theme mode provider

The system SHALL provide a Riverpod provider for theme mode state management.

#### Scenario: Theme mode provider access
- **WHEN** app needs to read or modify theme mode
- **THEN** themeModeProvider SHALL provide current ThemeMode value

#### Scenario: Theme mode persistence
- **WHEN** user changes theme mode
- **THEN** new value SHALL be persisted to Hive settings box

#### Scenario: Theme mode restoration
- **WHEN** app restarts
- **THEN** previously saved theme mode SHALL be restored
