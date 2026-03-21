# Tasks: Release & Hooks Setup

## Task List

1. [ ] Update `/git-flow-setup` — add a step asking about tag/version format (vX.Y.Z, X.Y.Z, calendar, custom), save to "Tag Format" section in generated `git-workflow.md`
2. [ ] Update git-flow templates — add "Tag Format" section to `github-flow.md`, `trunk-based.md`, `git-flow-classic.md` templates
3. [ ] Create `release` skill — write `skills/release/SKILL.md` with tag format detection, semver bump, CHANGELOG integration, git tagging, platform auto-detect (GitHub/GitLab), and graceful fallback
4. [ ] Create `hooks-setup` skill — write `skills/hooks-setup/SKILL.md` with hook discovery from `hooks/`, status display, symlink install/uninstall, and conflict detection
5. [ ] Add `# git-hook: pre-commit` header to `hooks/check-secrets.sh` for auto-mapping
6. [ ] Update documentation — update README (Current Features, project structure) and ROADMAP.md (mark v0.8 as Done)
7. [ ] Dogfooding — test `/release` on this repository, test `/hooks-setup` to verify hook discovery and status

## Definition of Done

- [ ] All success criteria from requirements are met
- [ ] Documentation updated
