# Tasks: Code Review & PR Quality

## Task List

1. [ ] Extract PR template — move inline template from `agents/git-workflow.md` to `agents/supporting-files/pr-template.md`, enhance with Summary/Changes/Test Plan/Checklist structure
2. [ ] Update git-workflow agent — replace inline template with instruction to read `agents/supporting-files/pr-template.md`
3. [ ] Create `pr-quality` rule — write `.claude/rules/pr-quality.md` with size limits (400 lines, 10 files), description requirements, and self-review prompt
4. [ ] Create review checklist — write `skills/review-pr/supporting-files/review-checklist.md` with correctness, tests, security, readability categories
5. [ ] Create `review-pr` skill — write `skills/review-pr/SKILL.md` with auto-detect input (PR number/URL, uncommitted changes, branch diff), checklist application, and structured report output
6. [ ] Dogfooding — test all components on this repository: create a test PR, run `/review-pr`, verify size warnings and checklist output
7. [ ] Update documentation — update root README and ROADMAP.md (mark v0.5 as Done)

## Definition of Done

- [ ] All success criteria from requirements are met
- [ ] Documentation updated
