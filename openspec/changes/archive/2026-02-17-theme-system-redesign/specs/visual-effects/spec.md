# Visual Effects Specification

## ADDED Requirements

### Requirement: Glassmorphism card effect for dark theme

The system SHALL provide a glassmorphism card decoration for dark theme.

#### Properties
- Background: `Colors.white.withOpacity(0.05)`
- Border: `Colors.white.withOpacity(0.1)` with 1px width
- Border radius: 16dp
- Backdrop blur: 10px (optional, performance-dependent)

#### Scenario: Apply glass card effect in dark mode
- **WHEN** developer uses `AppEffects.glassCard(context)` in dark mode
- **THEN** the decoration SHALL have translucent white background
- **AND** SHALL have subtle white border
- **AND** SHALL have 16dp border radius

---

### Requirement: Glassmorphism card effect for light theme

The system SHALL provide a soft glass card decoration for light theme.

#### Properties
- Background: `Colors.white.withOpacity(0.8)`
- Border: `Colors.grey.withOpacity(0.2)` with 1px width
- Border radius: 16dp
- Shadow: `Colors.black.withOpacity(0.05)` with 10px blur

#### Scenario: Apply glass card effect in light mode
- **WHEN** developer uses `AppEffects.glassCard(context)` in light mode
- **THEN** the decoration SHALL have semi-transparent white background
- **AND** SHALL have soft shadow
- **AND** SHALL have 16dp border radius

---

### Requirement: Neon glow effect for dark theme

The system SHALL provide a neon glow decoration for accent elements in dark theme.

#### Properties
- Box shadow color: Primary color with 0.3 opacity
- Blur radius: 20dp
- Spread radius: 2dp

#### Scenario: Apply neon glow to button in dark mode
- **WHEN** developer uses `AppEffects.neonGlow(context, color: AppColors.cyberCyan)`
- **THEN** the element SHALL have cyan glow effect
- **AND** glow SHALL be visible around the element

#### Scenario: Neon glow with custom color
- **WHEN** developer uses `AppEffects.neonGlow(context, color: AppColors.neonPink)`
- **THEN** the glow color SHALL be neon pink

---

### Requirement: Soft shadow effect for light theme

The system SHALL provide a soft shadow decoration for elevated elements in light theme.

#### Properties
- Box shadow color: Black with 0.05 opacity
- Blur radius: 10dp
- Offset: (0, 4dp)

#### Scenario: Apply soft shadow to card in light mode
- **WHEN** developer uses `AppEffects.softShadow(context)`
- **THEN** the card SHALL have subtle shadow below it
- **AND** shadow SHALL not be too dark or distracting

---

### Requirement: Theme-aware effect selection

The system SHALL automatically select appropriate effects based on current theme mode.

#### Scenario: Automatic effect selection in dark mode
- **WHEN** developer uses `AppEffects.card(context)` in dark mode
- **THEN** glassmorphism effect SHALL be applied

#### Scenario: Automatic effect selection in light mode
- **WHEN** developer uses `AppEffects.card(context)` in light mode
- **THEN** soft shadow effect SHALL be applied

---

### Requirement: Effect performance guidelines

The system SHALL document performance considerations for visual effects.

| Effect | Performance Impact | Recommendation |
|--------|-------------------|----------------|
| Backdrop blur | High | Avoid in scrollable lists |
| Neon glow | Medium | Limit to static elements |
| Soft shadow | Low | Safe for all contexts |

#### Scenario: Performance warning for backdrop blur
- **WHEN** developer applies backdrop blur effect
- **THEN** documentation SHALL warn about performance implications on low-end devices

---

### Requirement: Effect tokens accessibility

The system SHALL ensure text on effects maintains WCAG AA contrast ratio (4.5:1).

#### Scenario: Text contrast on glass card dark
- **WHEN** text is placed on glassmorphism card in dark mode
- **THEN** text contrast ratio SHALL be at least 4.5:1

#### Scenario: Text contrast on glass card light
- **WHEN** text is placed on soft card in light mode
- **THEN** text contrast ratio SHALL be at least 4.5:1
