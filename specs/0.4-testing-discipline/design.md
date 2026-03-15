# Design: Testing Discipline

## Overview

Add a testing discipline rule and a `test-plan` skill to ensure code changes are tested and coverage meets a configurable threshold. The skill has two modes: **generate** (create a test plan from a spec/description) and **check** (run coverage and report gaps). An optional project config (`.claude/testing.json`) stores test/coverage commands; if absent, Claude auto-discovers the setup and offers to save it.

## Detailed Design

### Testing Config (`.claude/testing.json`)

Optional config file that stores project-specific testing setup:

```json
{
  "testCommand": "npm test",
  "coverageCommand": "npm run coverage",
  "coverageThreshold": 80
}
```

- `testCommand` — command to run tests
- `coverageCommand` — command to run tests with coverage report
- `coverageThreshold` — minimum coverage % by lines (default: 80)

If the file doesn't exist, the rule instructs Claude to:
1. Look at project files (`package.json`, `pyproject.toml`, `Makefile`, `Cargo.toml`, etc.) to infer the test framework
2. Suggest commands based on what it finds
3. Offer to save the config for future sessions

### Testing Discipline Rule (`.claude/rules/testing-discipline.md`)

Always-on rule that:
- Reminds Claude to write/update tests when modifying code
- Before considering implementation complete, run tests and check coverage
- Read `.claude/testing.json` for commands; if missing, discover and offer to save
- Warn if coverage drops below threshold

### Test Plan Skill (`skills/test-plan/SKILL.md`)

Interactive skill with two modes:

**Generate mode** (`/test-plan` or `/test-plan generate`):
1. Read the spec from `specs/` if available, or ask user to describe the feature
2. Generate a structured test plan: unit tests, integration tests, edge cases
3. Present to user for review
4. Write to `specs/{folder}/test-plan.md`

**Check mode** (`/test-plan check`):
1. Read `.claude/testing.json` (or discover setup)
2. Run coverage command
3. Parse and report results — overall coverage, files below threshold
4. Suggest areas that need more tests

### Template (`skills/test-plan/supporting-files/test-plan-template.md`)

Structured template with sections: test strategy, unit tests, integration tests, edge cases, coverage targets.

### Integration with `/spec` (Phase 4)

Add optional Phase 4 to `skills/spec/SKILL.md`:
- After tasks are written, ask: "Want to generate a test plan for this spec?"
- If yes, invoke the test-plan skill in generate mode with the spec context
- If no, skip

## Alternatives Considered

| Alternative                  | Pros                     | Cons                           | Why Rejected                              |
|------------------------------|--------------------------|--------------------------------|-------------------------------------------|
| Hardcode coverage tools      | Simpler implementation   | Breaks language-agnostic goal  | Plugin must work across all stacks        |
| TDD enforcement              | Stronger test discipline | Too opinionated, slows work    | User explicitly chose to skip             |
| Test plan inside /spec only  | Simpler, one skill       | Can't check coverage ad-hoc   | User wants standalone coverage checking   |

## Risks and Unknowns

- Coverage output format varies wildly across tools — Claude will need to parse free-form output rather than expect a structured format
- Auto-discovery may fail for non-standard project setups — fallback is to ask the user directly

## Dependencies

- Existing `/spec` skill (for Phase 4 integration)
- Bash tool access (for running test/coverage commands)
