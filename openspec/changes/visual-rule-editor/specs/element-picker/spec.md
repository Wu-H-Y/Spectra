## ADDED Requirements

### Requirement: Interative DOM Element Selection
The editor MUST provide an overlying framework over a live rendering of the remote URL, allowing users to hover and click to analyze nodes.

#### Scenario: Click Target Element
- **WHEN** a user clicks on an article title inside the iframe target
- **THEN** the editor extracts the optimal CSS/XPath selector bridging back to the editor node

### Requirement: Cross Domain Bypass
The live picker iframe MUST proxy requests or inject scripts capable of bypassing CORS to successfully analyze third-party DOMs.

#### Scenario: Proxy Website Loading
- **WHEN** pointing the picker to a site with strict Content Security Policies
- **THEN** it successfully renders via a built-in bypassing mechanism or local proxy layer
