# Dartrelic Server Specification

## ADDED Requirements

### Requirement: RelicApp as HTTP server foundation
The system SHALL use dartrelic's `RelicApp` as the HTTP server foundation instead of shelf.

#### Scenario: Server initialization
- **WHEN** creating an HTTP server
- **THEN** `RelicApp()` SHALL be instantiated to define routes and middleware

#### Scenario: Server binding
- **WHEN** starting the server
- **THEN** `app.serve(address, port)` SHALL be called to bind to a port

---

### Requirement: Route definition with path parameters
Routes SHALL be defined using dartrelic's routing syntax with `:param` for path parameters.

#### Scenario: GET route definition
- **WHEN** defining a GET endpoint
- **THEN** `app.get('/path/:id', handler)` syntax SHALL be used

#### Scenario: POST route definition
- **WHEN** defining a POST endpoint
- **THEN** `app.post('/path', handler)` syntax SHALL be used

#### Scenario: Path parameter access
- **WHEN** accessing path parameters in a handler
- **THEN** `request.pathParameters.raw[#paramName]` SHALL be used

---

### Requirement: Body object for responses
All responses SHALL use dartrelic's `Body` object for response content.

#### Scenario: String response body
- **WHEN** returning a string response
- **THEN** `Response.ok(body: Body.fromString(content))` SHALL be used

#### Scenario: JSON response body
- **WHEN** returning JSON data
- **THEN** `Body.fromString(jsonEncode(data), mimeType: MimeType.json)` SHALL be used

#### Scenario: HTML response body
- **WHEN** returning HTML content
- **THEN** `Body.fromString(html, mimeType: MimeType.html)` SHALL be used

---

### Requirement: Middleware with router.use
Middleware SHALL be applied using `router.use()` method with path scoping.

#### Scenario: Global middleware
- **WHEN** middleware should apply to all routes
- **THEN** `app.use('/', middleware)` SHALL be used

#### Scenario: Path-scoped middleware
- **WHEN** middleware should only apply to specific paths
- **THEN** `app.use('/api', middleware)` SHALL be used

#### Scenario: Middleware execution order
- **WHEN** multiple middleware are registered for the same path
- **THEN** they SHALL execute in registration order (first registered executes first)

---

### Requirement: Type-safe headers access
Headers SHALL be accessed using dartrelic's type-safe accessors instead of string keys.

#### Scenario: Cookie header access
- **WHEN** accessing cookies
- **THEN** `request.headers.cookie` SHALL be used

#### Scenario: Content-Type access
- **WHEN** accessing content type
- **THEN** `request.body.bodyType?.mimeType` SHALL be used

#### Scenario: Date header access
- **WHEN** accessing date headers
- **THEN** `request.headers.date` SHALL be used

---

### Requirement: ContextProperty for request context
Request context data SHALL be managed using `ContextProperty<T>` for type safety.

#### Scenario: Define context property
- **WHEN** storing data in request context
- **THEN** `ContextProperty<T>()` SHALL be used as a typed accessor

#### Scenario: Set context value
- **WHEN** middleware adds data to context
- **THEN** `property[request] = value` SHALL be used

#### Scenario: Read context value
- **WHEN** reading context data in a handler
- **THEN** `property[request]` SHALL be used with proper typing

---

### Requirement: Built-in WebSocket support
WebSocket handling SHALL use dartrelic's built-in `WebSocketUpgrade` instead of external packages.

#### Scenario: WebSocket upgrade
- **WHEN** accepting a WebSocket connection
- **THEN** `WebSocketUpgrade((ws) => handler)` SHALL be returned from the route handler

#### Scenario: Send text message
- **WHEN** sending a text message over WebSocket
- **THEN** `ws.sendText(message)` or `ws.trySendText(message)` SHALL be used

#### Scenario: Receive messages
- **WHEN** listening for WebSocket messages
- **THEN** `ws.events.listen((event) => handler)` SHALL be used

---

### Requirement: CORS middleware implementation
CORS middleware SHALL be implemented using dartrelic's middleware pattern.

#### Scenario: Preflight request handling
- **WHEN** receiving an OPTIONS request
- **THEN** the CORS middleware SHALL return appropriate headers without calling next handler

#### Scenario: CORS headers on response
- **WHEN** processing a cross-origin request
- **THEN** the response SHALL include `Access-Control-Allow-Origin` and related headers

---

### Requirement: Static file serving
Static files SHALL be served using dart:io or a custom implementation compatible with dartrelic.

#### Scenario: Serve static directory
- **WHEN** serving files from a directory
- **THEN** a static file handler SHALL be implemented using `dart:io` File API

#### Scenario: MIME type detection
- **WHEN** serving a file
- **THEN** the appropriate MIME type SHALL be set based on file extension

#### Scenario: 404 for missing files
- **WHEN** a requested static file does not exist
- **THEN** a 404 response SHALL be returned

---

### Requirement: Error handling middleware
Error handling SHALL be implemented as middleware catching exceptions and returning appropriate responses.

#### Scenario: Catch handler exceptions
- **WHEN** a handler throws an exception
- **THEN** error middleware SHALL catch it and return a 500 response

#### Scenario: Log errors
- **WHEN** an error occurs
- **THEN** the error SHALL be logged with stack trace via Talker

#### Scenario: JSON error response
- **WHEN** returning an error response
- **THEN** the body SHALL be JSON with `error` and `message` fields
