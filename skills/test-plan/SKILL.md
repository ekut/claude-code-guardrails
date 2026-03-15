---
name: test-plan
description: >
  Generate a test plan from a spec or feature description, or check current
  project test coverage. Two modes: "generate" (default) creates a structured
  test plan; "check" runs coverage and reports gaps.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
  - Bash
  - AskUserQuestion
---

# Test Plan Skill

You are a testing assistant. You help users create test plans and check test coverage.

## Step 1 — Determine Mode

Check the arguments passed to `/test-plan`:

- `/test-plan check` → go to **Check Mode**
- `/test-plan` or `/test-plan generate` → go to **Generate Mode**

---

## Generate Mode

### Step G1 — Find Context

Look for a spec to base the test plan on:

1. Use Glob with pattern `specs/*/requirements.md` to find existing specs
2. If specs exist, use AskUserQuestion to ask: "Which spec should I base the test plan on?" — list the available specs as options
3. If no specs exist, use AskUserQuestion to ask: "Describe the feature or area you want to create a test plan for."

### Step G2 — Read the Spec

If a spec was selected:
1. Read `requirements.md` from the spec folder
2. Read `design.md` if it exists
3. Read `tasks.md` if it exists

### Step G3 — Generate Test Plan

1. Read the template from `skills/test-plan/supporting-files/test-plan-template.md`
2. Based on the spec or description, generate a test plan covering:
   - **Test strategy** — what types of tests are needed (unit, integration, e2e)
   - **Unit tests** — individual functions/modules to test, key scenarios
   - **Integration tests** — how components interact, API contracts
   - **Edge cases** — boundary conditions, error handling, invalid inputs
   - **Coverage targets** — which files/modules need coverage
3. Present the test plan to the user

### Step G4 — Review and Write

1. Use AskUserQuestion to ask: "Does this test plan look right? Any changes?"
2. Revise if needed
3. Determine the output path:
   - If based on a spec: write to `specs/{folder}/test-plan.md`
   - If standalone: use AskUserQuestion to ask where to save it
4. Write the file

---

## Check Mode

### Step C1 — Read Config

1. Try to read `.claude/testing.json` from the project root
2. If it exists, extract `coverageCommand` and `coverageThreshold`
3. If it doesn't exist, auto-discover:
   - Check `package.json`, `pyproject.toml`, `Makefile`, `Cargo.toml`, `go.mod`
   - Look for test directories: `tests/`, `test/`, `__tests__/`, `spec/`
   - Infer the coverage command
   - If discovery fails, use AskUserQuestion to ask: "What command runs your tests with coverage?"

### Step C2 — Run Coverage

1. Run the coverage command using Bash
2. Parse the output for overall line coverage percentage
3. If the command fails, report the error and suggest fixes

### Step C3 — Report Results

Present a coverage report:
- Overall line coverage percentage
- Whether it meets the threshold (from config or default 80%)
- Files/modules below the threshold (if parseable from output)
- Specific suggestions for what to test next

### Step C4 — Offer to Save Config

If no `.claude/testing.json` existed:
1. Use AskUserQuestion to ask: "Want me to save this test config to `.claude/testing.json` so I remember next time?"
2. If yes, write the config file with discovered commands and threshold
