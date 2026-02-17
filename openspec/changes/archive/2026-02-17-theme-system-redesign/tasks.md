# Theme System Redesign - Tasks

## 1. Design Tokens System

- [x] 1.1 Create `lib/core/theme/tokens/` directory structure
- [x] 1.2 Implement `ColorTokens` class with core brand colors (cyberCyan, electricViolet, neonPink, digitalTeal, deepIndigo, vibrantRose)
- [x] 1.3 Implement `ColorTokens` class with dark theme semantic colors (primary, onPrimary, secondary, surface, surfaceContainer, etc.)
- [x] 1.4 Implement `ColorTokens` class with light theme semantic colors (independent palette)
- [x] 1.5 Implement `AppRadius` class with border radius tokens (sm, md, lg, xl, full)
- [x] 1.6 Update `AppSpacing` class if needed (already exists, verify compatibility)
- [x] 1.7 Update `AppDurations` class if needed (already exists, verify compatibility)

## 2. Visual Effects System

- [x] 2.1 Create `lib/core/theme/tokens/effect_tokens.dart` file
- [x] 2.2 Implement `AppEffects.glassCardDark()` - Glassmorphism card decoration for dark theme
- [x] 2.3 Implement `AppEffects.glassCardLight()` - Soft card decoration for light theme
- [x] 2.4 Implement `AppEffects.neonGlow()` - Neon glow effect with customizable color
- [x] 2.5 Implement `AppEffects.softShadow()` - Soft shadow effect for light theme
- [x] 2.6 Implement `AppEffects.card(BuildContext context)` - Theme-aware card effect selector
- [x] 2.7 Add performance documentation comments for backdrop blur usage

## 3. Typography System (Chinese Support)

- [x] 3.1 Create `lib/core/theme/tokens/text_tokens.dart` file
- [x] 3.2 Implement typography tokens with Orbitron for display text (displayLarge, displayMedium, displaySmall, headlineLarge, headlineMedium, headlineSmall, titleLarge)
- [x] 3.3 Implement typography tokens with Noto Sans SC for body text (titleMedium, titleSmall, bodyLarge, bodyMedium, bodySmall, labelLarge, labelMedium, labelSmall)
- [x] 3.4 Implement typography tokens with JetBrains Mono for code/monospace text
- [x] 3.5 Configure Chinese text line height multiplier (1.6 for better readability)
- [x] 3.6 Add `ChineseTextStyles` extension on `TextTheme` for Chinese-optimized styles

## 4. Theme Configuration Refactoring

- [x] 4.1 Refactor `SpectraTheme` class to use new token system
- [x] 4.2 Update dark theme configuration with new semantic colors and typography
- [x] 4.3 Implement light theme with independent Tech Refined color palette
- [x] 4.4 Update light theme configuration with semantic colors and typography
- [x] 4.5 Ensure both themes use FlexColorScheme properly with Material 3 support
- [x] 4.6 Update `theme.dart` export file to include all new classes

## 5. Backward Compatibility

- [x] 5.1 Remove old `AppColors` class completely
- [x] 5.2 Update `home_page.dart` to use new theme system
- [x] 5.3 Update `settings_page.dart` to use new theme system
- [x] 5.4 Remove `AppColors` export from `theme.dart`

## 6. Theme Provider Updates

- [x] 6.1 Verify existing `themeModeProvider` works with new theme system
- [x] 6.2 Verify theme switching persistence with Hive

## 7. Testing and Verification

- [x] 7.1 Visual verification: Dark theme renders correctly with all new colors
- [x] 7.2 Visual verification: Light theme renders correctly with independent palette
- [x] 7.3 Visual verification: Chinese text renders clearly with Noto Sans SC
- [x] 7.4 Visual verification: Mixed Chinese-English text renders harmoniously
- [x] 7.5 Contrast verification: Text on surfaces meets WCAG AA (4.5:1) in both themes
- [x] 7.6 Performance test: Verify blur effects don't cause frame drops
- [x] 7.7 Run `flutter analyze` to ensure no errors
- [x] 7.8 Run existing tests to ensure no regressions

## 8. Documentation

- [x] 8.1 Update inline documentation for all new token classes
- [x] 8.2 Document when to use visual effects (performance considerations)
- [x] 8.3 Update `openspec/specs/app-theme/spec.md` with new requirements (sync from delta)
