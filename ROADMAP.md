# Roadmap

Development milestones for claude-code-guardrails, organized by practice area.

| Version | Practice                    | Status  |
|---------|-----------------------------|---------|
| v0.1    | Git Workflow                | Done    |
| v0.2    | Specification Driven Design | Done    |
| v0.3    | Search Before Build         | Planned |
| v0.4    | Testing Discipline          | Planned |
| v0.5    | Code Review & PR Quality    | Planned |
| v0.6    | Documentation Standards     | Planned |
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

## v0.3 — Search Before Build

Developers (and AI assistants) often reinvent what already exists. Searching the codebase and package registries first avoids duplication and leverages proven solutions.

**Deliverables:**
- Rule enforcing codebase search before writing new code
- Rule encouraging package/library search for common problems
- Deduplication awareness — flag when new code overlaps with existing utilities

**Plugin mechanisms:** rules

---

## v0.4 — Testing Discipline

Tests catch regressions, document behavior, and enable confident refactoring. Without coverage enforcement, test debt accumulates silently.

**Deliverables:**
- Coverage enforcement rule (configurable threshold, default 80% by lines)
- TDD workflow support — encourage test-first when appropriate
- `test-plan` skill — generate a test plan from a spec or feature description

**Plugin mechanisms:** rules, skill

---

## v0.5 — Code Review & PR Quality

Good PRs are small, well-described, and easy to review. Quality gates at the PR level catch issues before they reach the main branch.

**Deliverables:**
- PR description templates with summary, test plan, and checklist
- Review checklists covering correctness, tests, security, and readability
- PR size recommendations — warn when PRs exceed a reasonable diff size

**Plugin mechanisms:** rules, skill (PR template generation)

---

## v0.6 — Documentation Standards

Documentation rots faster than code. Automated rules ensure READMEs stay current, changelogs are maintained, and key decisions are recorded.

**Deliverables:**
- README template skill for new projects
- CHANGELOG management — prompt for changelog entries on notable changes
- Documentation rules — keep docs in sync with code changes

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
