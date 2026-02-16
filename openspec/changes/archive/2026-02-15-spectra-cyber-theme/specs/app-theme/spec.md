# App Theme Specification

## ADDED Requirements

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

### Requirement: Component style overrides

The system SHALL customize Material component styles for brand consistency.

#### Scenario: Input decorator style
- **WHEN** text field is rendered
- **THEN** border type SHALL be underline
- **AND** unfocused border SHALL NOT be colored

#### Scenario: FAB style
- **WHEN** FloatingActionButton is rendered
- **THEN** shape SHALL be circular
- **AND** elevation SHALL be consistent with theme

#### Scenario: Card style
- **WHEN** Card widget is rendered
- **THEN** elevation SHALL be 2
- **AND** border radius SHALL match theme default radius (16dp for dark, 12dp for light)
