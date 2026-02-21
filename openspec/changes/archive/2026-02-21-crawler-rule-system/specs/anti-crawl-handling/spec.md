# Anti-Crawl Handling

## ADDED Requirements

### Requirement: Action Sequence

The system SHALL support action sequences for page interaction:

- `wait`: Wait for duration or selector
- `click`: Click an element
- `scroll`: Scroll page (up/down)
- `fill`: Fill form input
- `script`: Execute custom JavaScript
- `condition`: Conditional actions (if/else)
- `loop`: Repeat actions while condition is true

#### Scenario: Wait for element

- **WHEN** action `{ "type": "wait", "selector": ".content" }` is executed
- **THEN** the system SHALL wait until the element appears

#### Scenario: Conditional action

- **WHEN** a condition action is executed
- **THEN** the system SHALL evaluate the condition and execute matching branch

---

### Requirement: Captcha Detection

The system SHALL detect captcha challenges:

- Detect reCAPTCHA (v2/v3)
- Detect hCaptcha
- Detect Cloudflare Turnstile
- Detect custom captcha implementations

#### Scenario: Captcha detection

- **WHEN** a captcha is detected on the page
- **THEN** the system SHALL pause execution and notify the user

---

### Requirement: Rate Limit Detection

The system SHALL detect rate limiting:

- HTTP status codes (429, 503)
- Rate limit headers
- Rate limit page content

#### Scenario: Rate limit handling

- **WHEN** rate limiting is detected
- **THEN** the system SHALL wait and retry with exponential backoff

---

### Requirement: Browser Fingerprint

The system SHALL support browser fingerprint configuration:

- Custom User-Agent
- Viewport size
- Timezone
- Language/Locale
- WebRTC handling

#### Scenario: Custom fingerprint

- **WHEN** custom fingerprint is configured
- **THEN** the browser SHALL use the specified values

---

### Requirement: Proxy Support

The system SHALL support proxy configuration:

- HTTP/HTTPS proxies
- SOCKS5 proxies
- Proxy rotation
- Proxy authentication

#### Scenario: Proxy rotation

- **WHEN** multiple proxies are configured
- **THEN** the system SHALL rotate through them on each request

---

### Requirement: Request Throttling

The system SHALL support request throttling:

- Minimum delay between requests
- Random jitter
- Per-domain rate limits

#### Scenario: Random delay

- **WHEN** request throttling is enabled
- **THEN** the system SHALL add random delay between requests
