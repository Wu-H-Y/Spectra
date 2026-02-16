# App Icon Specification

## ADDED Requirements

### Requirement: Vector icon source file

The system SHALL maintain a master SVG icon file at `assets/icon.svg` with complex visual effects.

#### Scenario: Icon file exists
- **WHEN** build process runs
- **THEN** `assets/icon.svg` SHALL exist
- **AND** SVG SHALL contain gradient definitions for brand colors
- **AND** SVG SHALL contain filter effects (glow, glass distortion, inset shadow)

### Requirement: Multi-platform launcher icons

The system SHALL generate launcher icons for all supported native platforms.

Supported platforms:
- Android (adaptive icon with foreground/background layers)
- iOS (AppIcon asset catalog)
- Windows (app icon)
- macOS (app icon)
- Linux (desktop entry icon)

#### Scenario: Android adaptive icon
- **WHEN** Android build runs
- **THEN** launcher icon SHALL be generated at appropriate densities
- **AND** adaptive icon foreground layer SHALL be provided
- **AND** adaptive icon background SHALL use brand color

#### Scenario: iOS app icon
- **WHEN** iOS build runs
- **THEN** AppIcon asset catalog SHALL contain all required sizes
- **AND** icon SHALL comply with iOS design guidelines

#### Scenario: Desktop platforms icon
- **WHEN** Windows/macOS/Linux build runs
- **THEN** platform-specific icon format SHALL be generated
- **AND** icon SHALL be linked in platform configuration

### Requirement: Icon generation configuration

The system SHALL configure `flutter_launcher_icons` for automated icon generation.

#### Scenario: Configuration is valid
- **WHEN** running `flutter pub run flutter_launcher_icons`
- **THEN** icons SHALL be generated for all platforms
- **AND** no platform SHALL be skipped
