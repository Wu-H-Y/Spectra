# Design Tokens Specification

## ADDED Requirements

### Requirement: Core color tokens

The system SHALL define core brand color tokens as the foundation of the color system.

| Token Name | Hex Value | Description |
|------------|-----------|-------------|
| cyberCyan | `#00F2FF` | Primary brand color |
| electricViolet | `#7000FF` | Secondary brand color |
| neonPink | `#FF0055` | Tertiary/Accent brand color |
| deepVoid | `#0B0E14` | Dark background foundation |
| digitalTeal | `#0891B2` | Light theme primary |
| deepIndigo | `#6366F1` | Light theme secondary |
| vibrantRose | `#E11D48` | Light theme tertiary |

#### Scenario: Access core color tokens
- **WHEN** developer imports `ColorTokens` class
- **THEN** all core colors SHALL be accessible as static constants

---

### Requirement: Semantic color tokens for dark theme

The system SHALL define semantic color tokens that map to appropriate values for dark theme.

| Semantic Token | Dark Theme Value | Usage |
|----------------|------------------|-------|
| primary | cyberCyan (`#00F2FF`) | Primary actions |
| onPrimary | `#003840` | Text on primary |
| secondary | electricViolet (`#7000FF`) | Secondary elements |
| onSecondary | `#FFFFFF` | Text on secondary |
| tertiary | neonPink (`#FF0055`) | Accent elements |
| surface | `#0F172A` | Card/dialog backgrounds |
| onSurface | `#FFFFFF` | Text on surface |
| surfaceContainer | `#1E293B` | Elevated surfaces |
| scaffoldBackground | deepVoid (`#0B0E14`) | Page background |
| outline | `#334155` | Borders |
| outlineVariant | `#475569` | Subtle borders |

#### Scenario: Dark theme semantic tokens accessible
- **WHEN** app is in dark mode
- **THEN** `Theme.of(context).colorScheme.primary` SHALL return `#00F2FF`
- **AND** `Theme.of(context).colorScheme.surface` SHALL return `#0F172A`

---

### Requirement: Semantic color tokens for light theme

The system SHALL define semantic color tokens that map to appropriate values for light theme.

| Semantic Token | Light Theme Value | Usage |
|----------------|-------------------|-------|
| primary | digitalTeal (`#0891B2`) | Primary actions |
| onPrimary | `#FFFFFF` | Text on primary |
| secondary | deepIndigo (`#6366F1`) | Secondary elements |
| onSecondary | `#FFFFFF` | Text on secondary |
| tertiary | vibrantRose (`#E11D48`) | Accent elements |
| surface | `#FFFFFF` | Card/dialog backgrounds |
| onSurface | `#0F172A` | Text on surface |
| surfaceContainer | `#F1F5F9` | Elevated surfaces |
| scaffoldBackground | `#F8FAFC` | Page background |
| outline | `#E2E8F0` | Borders |
| outlineVariant | `#CBD5E1` | Subtle borders |

#### Scenario: Light theme semantic tokens accessible
- **WHEN** app is in light mode
- **THEN** `Theme.of(context).colorScheme.primary` SHALL return `#0891B2`
- **AND** `Theme.of(context).colorScheme.surface` SHALL return `#FFFFFF`

---

### Requirement: Spacing tokens

The system SHALL define standard spacing tokens for consistent layout.

| Token Name | Value | Usage |
|------------|-------|-------|
| xs | 4dp | Tight spacing |
| sm | 8dp | Small gaps |
| md | 16dp | Default spacing |
| lg | 24dp | Section gaps |
| xl | 32dp | Large margins |
| xxl | 48dp | Extra large gaps |

#### Scenario: Spacing tokens accessible
- **WHEN** developer needs spacing values
- **THEN** `AppSpacing.md` SHALL return `16.0`
- **AND** `AppSpacing.paddingMd` SHALL return `EdgeInsets.all(16.0)`

---

### Requirement: Animation duration tokens

The system SHALL define standard animation duration tokens.

| Token Name | Value | Usage |
|------------|-------|-------|
| fast | 150ms | Quick transitions |
| normal | 300ms | Standard animations |
| slow | 500ms | Emphasized motion |

#### Scenario: Duration tokens accessible
- **WHEN** developer needs animation duration
- **THEN** `AppDurations.fast` SHALL return `Duration(milliseconds: 150)`

---

### Requirement: Border radius tokens

The system SHALL define standard border radius tokens.

| Token Name | Value | Usage |
|------------|-------|-------|
| sm | 8dp | Small radius (chips, tags) |
| md | 12dp | Medium radius (buttons, inputs) |
| lg | 16dp | Large radius (cards) |
| xl | 24dp | Extra large radius (modals) |
| full | 9999dp | Circular/pill shape |

#### Scenario: Radius tokens accessible
- **WHEN** developer needs border radius
- **THEN** `AppRadius.lg` SHALL return `Radius.circular(16.0)`

---

### Requirement: Typography tokens

The system SHALL define typography tokens for consistent text styling.

| Token Name | Font Family | Size | Weight |
|------------|-------------|------|--------|
| displayLarge | Orbitron | 57dp | Bold |
| displayMedium | Orbitron | 45dp | Bold |
| displaySmall | Orbitron | 36dp | Bold |
| headlineLarge | Orbitron | 32dp | SemiBold |
| headlineMedium | Orbitron | 28dp | SemiBold |
| headlineSmall | Orbitron | 24dp | SemiBold |
| titleLarge | Orbitron | 22dp | SemiBold |
| titleMedium | Noto Sans SC | 16dp | SemiBold |
| titleSmall | Noto Sans SC | 14dp | SemiBold |
| bodyLarge | Noto Sans SC | 16dp | Regular |
| bodyMedium | Noto Sans SC | 14dp | Regular |
| bodySmall | Noto Sans SC | 12dp | Regular |
| labelLarge | Noto Sans SC | 14dp | Medium |
| labelMedium | Noto Sans SC | 12dp | Medium |
| labelSmall | Noto Sans SC | 11dp | Medium |

#### Scenario: Display text uses Orbitron font
- **WHEN** widget uses `Theme.of(context).textTheme.displayLarge`
- **THEN** text SHALL render with Orbitron font family
- **AND** font size SHALL be 57dp

#### Scenario: Body text uses Noto Sans SC font
- **WHEN** widget uses `Theme.of(context).textTheme.bodyLarge`
- **THEN** text SHALL render with Noto Sans SC font family
- **AND** font size SHALL be 16dp
