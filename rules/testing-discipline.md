# Testing Discipline

Write and run tests for every code change. Ensure coverage meets the project threshold before considering work done.

## When Tests are Required

- Adding new functions, classes, or modules
- Fixing bugs (add a regression test that reproduces the bug)
- Changing existing behavior (update affected tests)
- Refactoring code (existing tests must still pass; add tests if coverage drops)

## When Tests are NOT Required

- Documentation-only changes (README, comments, specs)
- Configuration changes that don't affect runtime behavior
- Adding rules, skills, or agent definitions for this plugin

## How to Check

### 1. Read the Testing Config

Look for `.claude/testing.json` in the project root. It contains:

```json
{
  "testCommand": "npm test",
  "coverageCommand": "npm run coverage",
  "coverageThreshold": 80
}
```

- `testCommand` — command to run the test suite
- `coverageCommand` — command to run tests with coverage report
- `coverageThreshold` — minimum coverage percentage by lines (default: 80)

### 2. If No Config Exists

Auto-discover the test setup:

1. Check project files: `package.json` (scripts.test), `pyproject.toml`, `Makefile`, `Cargo.toml`, `go.mod`, `build.gradle`, `pom.xml`
2. Look for test directories: `tests/`, `test/`, `__tests__/`, `spec/`
3. Infer the test and coverage commands from what you find
4. Offer to save the config: "I detected {framework}. Want me to save this to `.claude/testing.json` so I remember next time?"

### 3. Run Tests and Check Coverage

Before considering an implementation task complete:

1. Run the test command — all tests must pass
2. Run the coverage command — parse the output for overall line coverage
3. Compare against the threshold — warn if coverage is below the target
4. If coverage dropped, identify untested code and suggest what tests to add

## Coverage Enforcement

- Default threshold: **80% by lines**
- Override via `coverageThreshold` in `.claude/testing.json`
- When coverage is below threshold: report the gap, list uncovered files/areas, and suggest specific tests to write
- Do not block work — warn clearly and let the user decide whether to add tests now or defer
