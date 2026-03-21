# Roadmap

Development milestones for claude-code-guardrails, organized by practice area.

| Version | Practice                    | Status  |
|---------|-----------------------------|---------|
| v0.1    | Git Workflow                | Done    |
| v0.2    | Specification Driven Design | Done    |
| v0.3    | Search Before Build         | Done    |
| v0.4    | Testing Discipline          | Done    |
| v0.5    | Code Review & PR Quality    | Done    |
| v0.6    | Documentation Standards     | Done    |
| v0.7    | Security Practices          | Planned |
| v0.8    | Release & CI/CD             | Planned |
| v1.0    | Stable Release              | Planned |

---

## v0.1 — Git Workflow (Done)

A consistent git workflow prevents messy histories, lost work, and merge conflicts. It is the foundation every other practice builds on.

**Deliverables:**
- `git-flow-setup` skill — interactive setup wizard that asks the user which git flow to use and generates rules
- `git-workflow` agent — handles all git write operations (commit, push, branch, PR, merge, tag)
- Rules: branch naming, conventional commits, PR requirements

**Plugin mechanisms:** skill, agent, rules

---

## v0.2 — Specification Driven Design (Done)

Writing a spec before code forces you to think through requirements, edge cases, and scope — reducing wasted effort and rework.

**Deliverables:**
- `spec` skill — interactive wizard that walks through requirements, design, and tasks phases
- Spec templates (lightweight, requirements, design, tasks) in `skills/spec/supporting-files/`
- `spec-driven-design` rule — nudges toward writing specs before non-trivial changes

**Plugin mechanisms:** rules, skill (spec creation)

---

## v0.3 — Search Before Build (Done)

Developers (and AI assistants) often reinvent what already exists. Searching the codebase and package registries first avoids duplication and leverages proven solutions.

**Deliverables:**
- Rule enforcing codebase search before writing new code
- Rule encouraging package/library search for common problems
- Deduplication awareness — flag when new code overlaps with existing utilities

**Plugin mechanisms:** rules

---

## v0.4 — Testing Discipline (Done)

Tests catch regressions, document behavior, and enable confident refactoring. Without coverage enforcement, test debt accumulates silently.

**Deliverables:**
- Coverage enforcement rule (configurable threshold, default 80% by lines)
- `test-plan` skill — generate a test plan from a spec or feature description, check current coverage
- Optional `.claude/testing.json` config with auto-discovery fallback
- `/spec` Phase 4 integration — optional test plan generation after tasks

**Plugin mechanisms:** rules, skill

---

## v0.5 — Code Review & PR Quality (Done)

Good PRs are small, well-described, and easy to review. Quality gates at the PR level catch issues before they reach the main branch.

**Deliverables:**
- `review-pr` skill — code review wizard (`/review-pr`) that analyzes GitHub PRs or local diffs against a standardized checklist
- `pr-quality` rule — enforces PR description completeness and size limits (default: 400 lines, 10 files)
- Review checklist covering correctness, tests, security, and readability
- PR template extracted to `agents/supporting-files/pr-template.md`, used by git-workflow agent

**Plugin mechanisms:** rules, skill

---

## v0.6 — Documentation Standards (Done)

Documentation rots faster than code. Automated rules ensure READMEs stay current, changelogs are maintained, and key decisions are recorded.

**Deliverables:**
- `readme` skill — interactive wizard (`/readme`) for generating structured project READMEs
- `changelog` skill — generator (`/changelog`) that creates CHANGELOG entries from git history, supporting Conventional Changelog and Keep a Changelog formats
- `documentation-standards` rule — docs sync reminders, CHANGELOG prompts on feat/fix, markdown table alignment

**Plugin mechanisms:** rules, skill

---

## v0.7 — Security Practices

Security issues are expensive to fix after deployment. Catching secrets, vulnerable dependencies, and common mistakes early is far cheaper.

**Deliverables:**
- Secrets detection hook — block commits containing API keys, tokens, or credentials
- Dependency audit — flag known vulnerabilities in dependencies
- Security checklist for code review

**Plugin mechanisms:** hooks, rules

---

## v0.8 — Release & CI/CD

A repeatable release process reduces human error and makes deployments predictable. CI/CD ensures every change is validated automatically.

**Deliverables:**
- Release workflow — semver versioning, git tagging, release notes
- CI template generation for common providers
- Pre-commit hooks setup for linting and formatting

**Plugin mechanisms:** skill, hooks, rules

---

## v1.0 — Stable Release

The plugin is feature-complete for its core practices. All mechanisms are validated through real-world use (dogfooding) and documented for contributors.

**Deliverables:**
- Dogfooding validation — confirm all practices work on this repository itself
- CONTRIBUTING.md with guidelines for external contributors
- Documentation polish — all skills, agents, and rules are documented
- Stability guarantees — no breaking changes without a major version bump
