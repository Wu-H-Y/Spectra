---
name: "OPSX: Apply"
description: Implement tasks from an OpenSpec change (Experimental)
category: Workflow
tags: [workflow, artifacts, experimental]
---

Implement tasks from an OpenSpec change.

**Input**: Optionally specify a change name (e.g., `/opsx:apply add-auth`). If omitted, check if it can be inferred from conversation context. If vague or ambiguous you MUST prompt for available changes.

**Steps**

1. **Select the change**

   If a name is provided, use it. Otherwise:
   - Infer from conversation context if the user mentioned a change
   - Auto-select if only one active change exists
   - If ambiguous, run `openspec list --json` to get available changes and use the **AskUserQuestion tool** to let the user select

   Always announce: "Using change: <name>" and how to override (e.g., `/opsx:apply <other>`).

2. **Check status to understand the schema**
   ```bash
   openspec status --change "<name>" --json
   ```
   Parse the JSON to understand:
   - `schemaName`: The workflow being used (e.g., "spec-driven")
   - Which artifact contains the tasks (typically "tasks" for spec-driven, check status for others)

3. **Get apply instructions**

   ```bash
   openspec instructions apply --change "<name>" --json
   ```

   This returns:
   - Context file paths (varies by schema)
   - Progress (total, complete, remaining)
   - Task list with status
   - Dynamic instruction based on current state

   **Handle states:**
   - If `state: "blocked"` (missing artifacts): show message, suggest using `/opsx:continue`
   - If `state: "all_done"`: congratulate, suggest archive
   - Otherwise: proceed to implementation

4. **Read context files (includes Main Specs)**

   a. **Read Change context files**
   
      Read files listed in `contextFiles`:
      - **spec-driven**: proposal, delta specs, design, tasks
      - Other schemas: follow the contextFiles from CLI output

   b. **Load relevant Main Specs**
   
      Implementation must comply with project-defined specifications. Main specs loading strategy:
      
      ```
      openspec/specs/
      ├── database/spec.md
      ├── state-management/spec.md
      ├── routing/spec.md
      └── ...
      ```
      
      **Loading methods (by priority):**
      
      1. **Explicit declaration**: If proposal.md lists capabilities in "Modified Capabilities", must read corresponding main specs
      
      2. **Keyword matching**: Scan keywords in proposal/design and match related main specs:
         - Extract keywords from proposal (module names, feature names, technical terms)
         - Iterate through capability names under openspec/specs/
         - If keyword relates to capability name or spec content, load that spec
      
      3. **Full load (fallback)**: If main specs count ≤ 10, load all
      
      **Output loaded Main Specs:**
      ```
      ## Loaded Main Specs (Project Constraints)
      
      - openspec/specs/database/spec.md ✓
      - openspec/specs/state-management/spec.md ✓
      - openspec/specs/routing/spec.md (not related, skipped)
      ```

   c. **Main Specs Compliance Check**
   
      During implementation, must ensure:
      - Do not violate interfaces and behaviors defined in main specs
      - If modification of existing specs is needed, update delta specs first
      - Pause and report when conflicts are detected

5. **Show current progress**

   Display:
   - Schema being used
   - Progress: "N/M tasks complete"
   - Remaining tasks overview
   - Dynamic instruction from CLI
   - List loaded main specs (constraint sources)

6. **Implement tasks (loop until done or blocked)**

   For each pending task:
   - Show which task is being worked on
   - If task involves modules defined in main specs, explicitly state specs to comply with
   - Make the code changes required
   - Keep changes minimal and focused
   - Mark task complete in the tasks file: `- [ ]` → `- [x]`
   - Continue to next task

   **Pause if:**
   - Task is unclear → ask for clarification
   - Implementation reveals a design issue → suggest updating artifacts
   - Implementation conflicts with main specs → report and ask for decision
   - Error or blocker encountered → report and wait for guidance
   - User interrupts

7. **On completion or pause, show status**

   Display:
   - Tasks completed this session
   - Overall progress: "N/M tasks complete"
   - Main specs compliance status (whether all loaded main specs were followed)
   - If all done: suggest archive
   - If paused: explain why and wait for guidance

**Output During Implementation**

```
## Implementing: <change-name> (schema: <schema-name>)

### Project Constraints (Main Specs Loaded)
- database/spec.md: Defines data layer interfaces
- state-management/spec.md: Defines Riverpod patterns

Working on task 3/7: <task description>
Constraint check: Must follow database/spec.md §3.2 for repository pattern
[...implementation happening...]
✓ Task complete (complies with main specs)

Working on task 4/7: <task description>
[...implementation happening...]
✓ Task complete
```

**Output On Completion**

```
## Implementation Complete

**Change:** <change-name>
**Schema:** <schema-name>
**Progress:** 7/7 tasks complete ✓

### Completed This Session
- [x] Task 1
- [x] Task 2
...

### Main Specs Compliance ✓
All implementations comply with loaded main specs:
- database/spec.md ✓
- state-management/spec.md ✓

All tasks complete! You can archive this change with `/opsx:archive`.
```

**Output On Pause (Issue Encountered)**

```
## Implementation Paused

**Change:** <change-name>
**Schema:** <schema-name>
**Progress:** 4/7 tasks complete

### Issue Encountered
<description of the issue>

**Options:**
1. <option 1>
2. <option 2>
3. Other approach

What would you like to do?
```

**Output On Main Specs Conflict**

```
## Implementation Paused - Main Specs Conflict

**Change:** <change-name>
**Task:** 3/7 - <task description>

### Conflict Detected
The implementation conflicts with an existing main spec:

**Main Spec:** openspec/specs/database/spec.md
**Requirement:** §3.2 Repository Pattern
**Conflict:** Current implementation bypasses the repository layer

**Options:**
1. Modify implementation to comply with main spec
2. Update delta specs to modify the main spec requirement
3. Continue anyway (will cause inconsistency)

Which approach do you prefer?
```

**Guardrails**
- Keep going through tasks until done or blocked
- Always read context files before starting (from the apply instructions output)
- Always load and reference relevant main specs during implementation
- Check implementations against main specs before marking tasks complete
- If task is ambiguous, pause and ask before implementing
- If implementation reveals issues, pause and suggest artifact updates
- If implementation conflicts with main specs, pause and offer options
- Keep code changes minimal and scoped to each task
- Update task checkbox immediately after completing each task
- Pause on errors, blockers, or unclear requirements - don't guess
- Use contextFiles from CLI output, don't assume specific file names

**Fluid Workflow Integration**

This skill supports the "actions on a change" model:

- **Can be invoked anytime**: Before all artifacts are done (if tasks exist), after partial implementation, interleaved with other actions
- **Allows artifact updates**: If implementation reveals design issues, suggest updating artifacts - not phase-locked, work fluidly
- **Respects main specs**: Implementation must comply with project-level specifications unless explicitly modified through delta specs
