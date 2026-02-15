# Spectra Cyber Theme - Implementation Tasks

## 1. Dependencies Setup

- [x] 1.1 Add `flex_color_scheme: ^8.4.0` to pubspec.yaml
- [x] 1.2 Add `google_fonts: ^8.0.1` to pubspec.yaml
- [x] 1.3 Add `flutter_native_splash: ^2.4.7` to pubspec.yaml (dev_dependencies)
- [x] 1.4 Add `window_manager: ^0.4.3` to pubspec.yaml
- [x] 1.5 Run `flutter pub get` to install dependencies

## 2. App Icon (Pre-completed)

- [x] 2.1 Create SVG icon source file at `assets/icon.svg`
- [x] 2.2 Configure `flutter_launcher_icons` in pubspec.yaml
- [x] 2.3 Generate launcher icons for all platforms (Android, iOS, Windows, macOS, Linux)

## 3. Theme System

- [x] 3.1 Create `lib/theme/` directory
- [x] 3.2 Create `lib/theme/app_colors.dart` with brand color constants
- [x] 3.3 Create `lib/theme/spectra_theme.dart` with FlexColorScheme configuration
- [x] 3.4 Export theme from barrel file

## 4. Native Splash Screen

- [x] 4.1 Export SVG icon to PNG (1024x1024) as `assets/splash.png` (MANUAL)
- [x] 4.2 Configure `flutter_native_splash` in pubspec.yaml
- [x] 4.3 Generate native splash screens: `dart run flutter_native_splash:create` (requires 4.1)

## 5. Window Manager (Desktop)

- [x] 5.1 Configure `window_manager` in Windows runner (auto-registered via Flutter plugin)
- [x] 5.2 Configure `window_manager` in macOS runner (auto-registered via Flutter plugin)
- [x] 5.3 Configure `window_manager` in Linux runner (auto-registered via Flutter plugin)

## 6. Main Application Entry

- [x] 6.1 Update `lib/main.dart` with new startup flow
  - FlutterNativeSplash.preserve()
  - windowManager initialization
  - _initializeHeavyTasks() placeholder
  - addPostFrameCallback for show/focus/remove

## 7. Home Page

- [x] 7.1 Create `lib/pages/home/` directory
- [x] 7.2 Create `lib/pages/home/home_page.dart`

## 8. Cleanup

- [x] 8.1 Remove `lib/pages/splash/` directory (no longer needed)
