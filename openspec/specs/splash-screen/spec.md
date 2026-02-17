# Splash Screen Specification

## ADDED Requirements

### Requirement: Native splash screen for all platforms

The system SHALL provide a native splash screen for all supported platforms using `flutter_native_splash`.

#### Scenario: Native splash displays immediately

- **WHEN** app launches on any platform
- **THEN** native splash screen SHALL display immediately (zero delay)
- **AND** background color SHALL be Deep Void (`#0B0E14`)
- **AND** brand logo SHALL be centered

#### Scenario: Native splash configuration

- **WHEN** `flutter_native_splash` is configured in pubspec.yaml
- **THEN** color SHALL be `#0B0E14`
- **AND** image SHALL reference `assets/splash.png` (1024x1024 PNG)
- **AND** all platforms (android, ios) SHALL be enabled

### Requirement: Splash screen preservation

The system SHALL preserve the native splash screen until initialization is complete.

#### Scenario: Splash preserved during initialization

- **WHEN** app starts in main()
- **THEN** `FlutterNativeSplash.preserve()` SHALL be called
- **AND** splash screen SHALL remain visible during initialization

### Requirement: Splash screen removal

The system SHALL remove the splash screen after first frame is rendered.

#### Scenario: Splash removed after UI ready

- **WHEN** first frame is rendered (addPostFrameCallback)
- **THEN** `FlutterNativeSplash.remove()` SHALL be called
- **AND** splash screen SHALL fade out smoothly

### Requirement: Window manager integration (Desktop)

For desktop platforms, the system SHALL use `window_manager` to control window visibility.

#### Scenario: Window configured before show

- **WHEN** app initializes on desktop platform
- **THEN** window size SHALL be 1280x720 (minimum 800x600)
- **AND** window SHALL be centered
- **AND** window SHALL NOT be visible until ready

#### Scenario: Window shown after initialization

- **WHEN** initialization is complete and first frame rendered
- **THEN** `windowManager.show()` SHALL be called
- **AND** `windowManager.focus()` SHALL be called
