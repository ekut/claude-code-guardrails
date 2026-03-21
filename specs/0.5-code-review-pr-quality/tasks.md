# Tasks: Code Review & PR Quality

## Task List

1. [x] Extract PR template — moved inline template from `agents/git-workflow.md` to `agents/supporting-files/pr-template.md`, enhanced with Summary/Changes/Test Plan/Checklist structure
2. [x] Update git-workflow agent — replaced inline template with instruction to read `agents/supporting-files/pr-template.md`
3. [x] Create `pr-quality` rule — wrote `.claude/rules/pr-quality.md` with size limits (400 lines, 10 files), description requirements, and self-review prompt
4. [x] Create review checklist — wrote `skills/review-pr/supporting-files/review-checklist.md` with correctness, tests, security, readability categories
5. [x] Create `review-pr` skill — wrote `skills/review-pr/SKILL.md` with auto-detect input (PR number/URL, uncommitted changes, branch diff), checklist application, and structured report output
6. [x] Dogfooding — tested `/review-pr 8` on this PR, verified size warning (10 files at threshold) and checklist output
7. [x] Update documentation — updated root README and ROADMAP.md (marked v0.5 as Done)

## Definition of Done

- [x] All success criteria from requirements are met
- [x] Documentation updated
