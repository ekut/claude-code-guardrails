# Requirements: Testing Discipline

## Problem Statement

AI coding assistants readily skip tests or write minimal coverage unless explicitly told otherwise. Without automated guardrails, test debt accumulates silently — bugs slip through, refactoring becomes risky, and coverage erodes over time. The plugin currently enforces specs, git flow, and search-before-build, but has no mechanism to ensure code is tested.

## Goals

- Enforce a minimum test coverage threshold (default 80% by lines, configurable)
- Provide a `test-plan` skill that generates test plans from specs or feature descriptions, and can check current project coverage
- Integrate test planning into the `/spec` workflow as an optional phase
- Support any language/framework via optional project config with auto-discovery fallback

## Success Criteria

- [ ] A testing discipline rule exists that reminds Claude to write and run tests before considering work done
- [ ] Coverage threshold is configurable via `.claude/testing.json`; if no config exists, Claude discovers the test setup and offers to save it
- [ ] `/test-plan` skill generates a structured test plan and can report current coverage
- [ ] `/spec` includes an optional Phase 4 that invokes `/test-plan` in the spec context
- [ ] Rule and skill work across different languages and test frameworks

## Out of Scope

- TDD workflow enforcement (may revisit later)
- CI/CD integration (v0.8)
- Specific test framework setup or installation
- Test runner configuration beyond command strings
- Mutation testing or advanced coverage analysis

## Open Questions

- Should `.claude/testing.json` live in the project root or under `.claude/`? (Leaning `.claude/` for consistency with other plugin config)
