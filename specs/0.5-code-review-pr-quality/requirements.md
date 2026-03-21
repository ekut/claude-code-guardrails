# Requirements: Code Review & PR Quality

## Problem Statement

PRs without clear descriptions, review checklists, and size control lead to low-quality reviews, missed bugs, and hard-to-understand changes. Currently the plugin has only a basic PR template hardcoded in the git-workflow agent, no review capabilities, and no PR size awareness.

## Goals

- Improve PR creation quality through structured templates with summary, test plan, and self-review checklist
- Enable code review of existing PRs against a standardized checklist (correctness, tests, security, readability)
- Warn when a PR exceeds a reasonable size (by diff lines and file count) to encourage smaller, focused changes

## Success Criteria

- [ ] PR template is extracted from git-workflow agent into a reusable supporting file
- [ ] git-workflow agent reads the external template when creating PRs
- [ ] A `pr-quality` rule enforces PR description completeness and size limits
- [ ] A `review-pr` skill reviews a PR against a checklist and outputs results locally
- [ ] `review-pr` accepts both a GitHub PR (number/URL) and local diff (uncommitted or branch diff)
- [ ] Review checklist covers: correctness, tests, security, readability
- [ ] PR size thresholds are configurable (default: 400 lines diff, 10 files)
- [ ] One universal PR template shared across all git flow types
- [ ] Plugin dogfooding: all components work on this repository itself

## Out of Scope

- CI/CD integration (v0.8)
- Auto-approve or auto-merge
- GitHub webhooks or GitHub Actions
- Custom review policies per team
- Posting review comments to GitHub (output is local only)
- Per-git-flow PR templates
