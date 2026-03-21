# Design: Code Review & PR Quality

## Overview

v0.5 adds three components: (1) a `pr-quality` rule with size limits and description requirements, (2) an extracted PR template as a reusable file read by the git-workflow agent, and (3) a `review-pr` skill that reviews diffs against a standardized checklist. All output is local — nothing posts to GitHub automatically.

## Detailed Design

### 1. PR Template Extraction

The current PR template in `agents/git-workflow.md` moves to `agents/supporting-files/pr-template.md`. The git-workflow agent is updated to read this file when creating PRs instead of using inline text.

Template structure (enhanced from current):
```
## Summary
{1-3 sentences}

## Changes
- {notable changes}

## Test Plan
- {how changes were tested}

## Checklist
- [ ] Tests pass
- [ ] No unintended side effects
- [ ] Changes match the PR title
```

### 2. Rule: `pr-quality.md`

A new rule in `.claude/rules/pr-quality.md` that Claude follows when creating or reviewing PRs.

Contents:
- **PR size limits**: warn if diff exceeds 400 lines or 10 files (defaults editable in the rule file)
- **Description completeness**: PR must have a summary, changes list, and test plan
- **Self-review prompt**: before creating a PR, verify the checklist items

This rule is passive — Claude reads it and follows it. No JSON config needed.

### 3. Skill: `review-pr`

A new skill at `skills/review-pr/SKILL.md` invoked via `/review-pr [target]`.

**Input resolution** (auto-detect):
1. If argument is a PR number or URL → fetch via `gh pr view` and `gh pr diff`
2. If no argument and there are uncommitted changes → review `git diff` (staged + unstaged)
3. If no argument and no uncommitted changes → review branch diff vs main (`git diff main...HEAD`)

**Review process**:
1. Determine the diff to review
2. Check PR size against thresholds (from rule), include in report
3. Read the review checklist from `skills/review-pr/supporting-files/review-checklist.md`
4. Analyze the diff against each checklist category
5. Output a structured report to the terminal

**Review checklist categories** (in supporting file):
- **Correctness**: logic errors, edge cases, error handling
- **Tests**: are changes covered by tests, are tests meaningful
- **Security**: injection, secrets, auth issues, OWASP top 10
- **Readability**: naming, complexity, comments where needed

**Output format**:
```
## Review: {target}

### Size: {lines} lines, {files} files — {OK / ⚠ exceeds threshold}

### Correctness
{findings or "No issues found"}

### Tests
{findings or "No issues found"}

### Security
{findings or "No issues found"}

### Readability
{findings or "No issues found"}

### Summary
{overall assessment, key concerns if any}
```

## Alternatives Considered

| Alternative                       | Pros                         | Cons                               | Why Rejected                                                    |
|-----------------------------------|------------------------------|------------------------------------|-----------------------------------------------------------------|
| Agent instead of skill for review | Can run in background        | Less transparent, heavier          | Skill is simpler, user controls invocation                      |
| JSON config for size thresholds   | Consistent with testing.json | Extra file for two numbers         | Overkill — values editable directly in rule                     |
| Per-flow PR templates             | More tailored                | 3x maintenance, minimal difference | Differences between flows are in branching, not PR descriptions |

## Risks and Unknowns

- Large diffs may exceed context window for thorough review — skill should warn and suggest focusing on specific files
- `gh` CLI must be installed and authenticated for GitHub PR review mode

## Dependencies

- Existing `git-workflow` agent (modified to read external template)
- `gh` CLI for GitHub PR review mode
