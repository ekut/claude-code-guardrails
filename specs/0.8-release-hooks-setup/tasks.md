# Tasks: Release & Hooks Setup

## Task List

1. [x] Update `/git-flow-setup` — added step 3 asking about tag/version format (vX.Y.Z, X.Y.Z, calendar, custom), saves to "Tag Format" section in generated `git-workflow.md`
2. [x] Update git-flow templates — added "Tag Format" placeholder section to `github-flow.md`, `trunk-based.md`, `git-flow-classic.md`
3. [x] Create `release` skill — wrote `skills/release/SKILL.md` with tag format detection (from git-workflow.md with fallback), semver bump, CHANGELOG integration, git tagging, platform auto-detect (GitHub/GitLab), and graceful fallback
4. [x] Create `hooks-setup` skill — wrote `skills/hooks-setup/SKILL.md` with hook discovery from `hooks/`, `# git-hook:` header parsing, status display, symlink install/uninstall, and conflict detection with backup
5. [x] Add `# git-hook: pre-commit` header to `hooks/check-secrets.sh` for auto-mapping
6. [x] Update documentation — updated README (Current Features, project structure, usage examples) and ROADMAP.md (marked v0.8 as Done)
7. [ ] Dogfooding — deferred to v1.0: test `/release` and `/hooks-setup` on this repository

## Definition of Done

- [x] All success criteria from requirements are met
- [x] Documentation updated
