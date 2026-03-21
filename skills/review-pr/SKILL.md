---
name: review-pr
description: >
  Review a PR or local changes against a standardized checklist.
  Accepts a GitHub PR number/URL, or reviews local changes automatically.
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
---

# Review PR

You are a code review assistant. Your job is to review code changes against a standardized checklist and output a structured report.

## Step 1 — Determine the Diff

Resolve the review target based on the argument provided:

1. **PR number or URL given** (e.g. `/review-pr 42` or `/review-pr https://github.com/org/repo/pull/42`):
   - Extract the PR number
   - Run `gh pr view <number> --json title,body` to get PR metadata
   - Run `gh pr diff <number>` to get the diff

2. **No argument, uncommitted changes exist**:
   - Run `git status --porcelain` to check for changes
   - If changes exist, run `git diff` (unstaged) and `git diff --cached` (staged) to get the full diff
   - Label the review as "Local uncommitted changes"

3. **No argument, no uncommitted changes**:
   - Run `git diff main...HEAD` to get the branch diff
   - If the diff is empty, inform the user there is nothing to review and stop
   - Label the review as "Branch diff vs main"

## Step 2 — Check Size

Run `git diff --stat` (with the appropriate arguments from Step 1) and parse the summary line to extract:
- Total lines changed (additions + deletions)
- Total files changed

Read `.claude/rules/pr-quality.md` to get the thresholds (default: 400 lines, 10 files).

If the diff is very large (over 2000 lines), warn that the review may be less thorough and suggest focusing on specific files.

## Step 3 — Apply Review Checklist

Read the checklist from `skills/review-pr/supporting-files/review-checklist.md`.

Carefully analyze the diff against each checklist category:
- **Correctness**: logic errors, edge cases, error handling
- **Tests**: coverage of changes, test quality
- **Security**: secrets, injection, auth issues
- **Readability**: naming, complexity, unnecessary changes

For each category, provide specific findings referencing file names and line numbers, or confirm "No issues found."

## Step 4 — Output Report

Output a structured report in this format:

```
## Review: {target description}

### Size: {lines} lines, {files} files — {OK / ⚠ Exceeds threshold}

### Correctness
{findings or "No issues found"}

### Tests
{findings or "No issues found"}

### Security
{findings or "No issues found"}

### Readability
{findings or "No issues found"}

### Summary
{overall assessment — approve, concerns, or blockers}
```

Do not post anything to GitHub. The report is local output only.
