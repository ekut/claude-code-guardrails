# PR Quality

Ensure pull requests are well-described, reasonably sized, and self-reviewed before submission.

## PR Size Limits

Before creating a PR, check the diff size:

- **Lines threshold**: 400 lines of diff (additions + deletions)
- **Files threshold**: 10 files changed

If either threshold is exceeded, warn the user and suggest splitting the PR into smaller, focused changes. Do not block — warn clearly and let the user decide.

To check: run `git diff --stat main...HEAD` (or the appropriate base branch) and parse the summary line.

## Description Completeness

Every PR description must include:

1. **Summary** — 1-3 sentences explaining what the PR does and why
2. **Changes** — a list of notable changes
3. **Test Plan** — how the changes were tested
4. **Checklist** — self-review checklist items checked off

If any section is missing or empty, prompt the user to fill it in before creating the PR.

## Self-Review Before Submission

Before creating a PR, verify:

- [ ] Tests pass
- [ ] No unintended side effects
- [ ] Changes match the PR title
