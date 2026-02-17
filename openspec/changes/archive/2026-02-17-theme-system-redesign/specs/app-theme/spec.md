# App Theme Specification (Delta)

## MODIFIED Requirements

### Requirement: Brand color constants

The system SHALL define brand color constants for consistent theming across the application.

| Color Name | Hex Value | Usage |
|------------|-----------|-------|
| Cyber Cyan | `#00F2FF` | Primary color (dark theme) |
| Electric Violet | `#7000FF` | Secondary color (dark theme) |
| Neon Pink | `#FF0055` | Tertiary/Accent color (dark theme) |
| Deep Void | `#0B0E14` | Dark background |
| Digital Teal | `#0891B2` | Primary color (light theme) |
| Deep Indigo | `#6366F1` | Secondary color (light theme) |
| Vibrant Rose | `#E11D48` | Tertiary color (light theme) |

#### Scenario: Access brand colors
- **WHEN** developer imports `AppColors` class
- **THEN** all brand colors SHALL be accessible as static constants
- **AND** colors SHALL be organized by theme (dark/light)

---

### Requirement: Material 3 theme configuration

The system SHALL provide Material 3 compliant theme configurations using `flex_color_scheme`.

#### Scenario: Dark theme applies correctly
- **WHEN** app uses dark theme mode
- **THEN** theme SHALL use Deep Void (`#0B0E14`) as scaffold background
- **AND** primary color SHALL be Cyber Cyan (`#00F2FF`)
- **AND** secondary color SHALL be Electric Violet (`#7000FF`)
- **AND** tertiary color SHALL be Neon Pink (`#FF0055`)
- **AND** surface color SHALL be `#0F172A`

#### Scenario: Light theme applies correctly
- **WHEN** app uses light theme mode
- **THEN** theme SHALL use Light Void (`#F8FAFC`) as scaffold background
- **AND** primary color SHALL be Digital Teal (`#0891B2`)
- **AND** secondary color SHALL be Deep Indigo (`#6366F1`)
- **AND** tertiary color SHALL be Vibrant Rose (`#E11D48`)
- **AND** surface color SHALL be `#FFFFFF`

---

### Requirement: Typography configuration

The system SHALL configure brand fonts using Google Fonts with Chinese support.

| Text Style | Font Family | Usage |
|------------|-------------|-------|
| displayLarge | Orbitron | Large titles |
| displayMedium | Orbitron | Medium titles |
| headlineLarge | Orbitron | Section headers |
| titleMedium | Noto Sans SC | Medium titles |
| bodyLarge | Noto Sans SC | Body text |
| bodyMedium | Noto Sans SC | Secondary text |

#### Scenario: Title text uses Orbitron font
- **WHEN** widget uses `Theme.of(context).textTheme.displayLarge`
- **THEN** text SHALL render with Orbitron font family

#### Scenario: Body text uses Noto Sans SC font
- **WHEN** widget uses `Theme.of(context).textTheme.bodyLarge`
- **THEN** text SHALL render with Noto Sans SC font family

#### Scenario: Chinese text rendering
- **WHEN** widget displays Chinese characters in body text
- **THEN** characters SHALL render clearly with proper line height

---

## ADDED Requirements

### Requirement: Light theme independent color scheme

The system SHALL provide an independent color scheme for light theme, not derived from dark theme.

#### Color Roles
- Primary: Digital Teal (`#0891B2`)
- Secondary: Deep Indigo (`#6366F1`)
- Tertiary: Vibrant Rose (`#E11D48`)
- Surface: White (`#FFFFFF`)
- Surface Container: Light Gray (`#F1F5F9`)
- Scaffold Background: Light Void (`#F8FAFC`)

#### Scenario: Light theme not derived from dark theme
- **WHEN** light theme is active
- **THEN** colors SHALL use independent Tech Refined palette
- **AND** colors SHALL NOT be desaturated versions of dark theme colors

---

### Requirement: Semantic color token access

The system SHALL provide semantic color tokens accessible via theme extension.

#### API Design
```dart
extension ThemeColors on ThemeData {
  Color get surfaceContainer => // appropriate surface color
}
```

#### Scenario: Access surface container color
- **WHEN** developer uses `Theme.of(context).colorScheme.surfaceContainerHighest`
- **THEN** appropriate surface elevation color SHALL be returned

---

### Requirement: Theme file structure

Theme files SHALL be organized in a clear directory structure.

#### Directory Structure
```
lib/core/theme/
├── theme.dart              # Export file
├── spectra_theme.dart      # Main theme configuration
├── app_spacing.dart        # Spacing tokens
├── app_durations.dart      # Animation durations
└── tokens/
    ├── color_tokens.dart   # Color tokens
    ├── text_tokens.dart    # Typography tokens
    └── effect_tokens.dart  # Visual effect tokens
```

#### Scenario: Theme import
- **WHEN** developer imports theme
- **THEN** `import 'package:spectra/core/theme/theme.dart'` SHALL provide access to all theme classes

---

## REMOVED Requirements

### Requirement: Inter font for body text

**Reason**: Replaced by Noto Sans SC for better Chinese support
**Migration**: Use Noto Sans SC instead of Inter for body text styles
