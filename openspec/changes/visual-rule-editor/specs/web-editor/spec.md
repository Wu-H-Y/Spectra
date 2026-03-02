## MODIFIED Requirements

### Requirement: Crawling Rule Editor Interface
The web interface SHALL utilize a full React Flow node-based builder environment rather than static text input boxes for configuring complicated data pipelines. 

#### Scenario: Edit Existing Field
- **WHEN** loading a saved rule
- **THEN** the node graph dynamically hydrates the connected node blocks representing that rule array
