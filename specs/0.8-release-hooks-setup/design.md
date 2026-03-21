# Design: Release & Hooks Setup

## Overview

v0.8 adds two skills: (1) a `release` skill that automates the full release cycle — semver bump, CHANGELOG update, git tag, and optional platform release with auto-detection of GitHub/GitLab, and (2) a `hooks-setup` skill that discovers and installs plugin hooks as git hooks via symlinks.

## Detailed Design

### 1. Skill: `release`

A new skill at `skills/release/SKILL.md` invoked via `/release [version]`.

**Step 1 — Determine tag format:**
- Read `.claude/rules/git-workflow.md` and look for a "Tag Format" section (configured by `/git-flow-setup`)
- If a preference is saved (e.g. `Format: vX.Y.Z`), use it
- If no preference (legacy project without `/git-flow-setup`), fallback:
  - Detect from existing tags: `v1.2.3` → semver with `v` prefix, `1.2.3` → without
  - No tags or mixed → ask the user
  - Save the choice to `.claude/rules/git-workflow.md` under a "Tag Format" section

**Step 2 — Determine version:**
- If version argument given (e.g. `/release v1.0.0`) — use it directly
- If no argument — find latest git tag, ask bump type:
  - **patch** (v0.7.0 → v0.7.1) — bug fixes
  - **minor** (v0.7.0 → v0.8.0) — new features
  - **major** (v0.7.0 → v1.0.0) — breaking changes
- If no tags exist — ask for initial version (default: v0.1.0)
- Apply the saved tag format

**Step 3 — Update CHANGELOG:**
- Invoke `/changelog` with range from last tag to HEAD
- Use the new version as the label
- If CHANGELOG.md already has an entry for this version, skip

**Step 4 — Commit and tag:**
- Commit CHANGELOG update (if changed)
- Create annotated git tag: `git tag -a {version} -m "Release {version}"`
- Push tag and commit: `git push origin main --tags`

**Step 5 — Platform release (optional):**
- Detect hosting from `git remote get-url origin`:

| URL Pattern                      | Platform | CLI    | Release Command                              |
|----------------------------------|----------|--------|----------------------------------------------|
| `github.com`                     | GitHub   | `gh`   | `gh release create {version} --notes ...`    |
| `gitlab.com` or self-hosted GitLab | GitLab | `glab` | `glab release create {version} --notes ...`  |
| Other                            | Unknown  | —      | "Tag pushed. Create a release manually."     |

- Check if CLI is installed (`command -v gh` / `command -v glab`)
- If installed — ask "Create a {platform} release?" and proceed
- If not installed — suggest install command and continue without release
- Release notes are extracted from the CHANGELOG entry for this version

**Step 6 — Summary:**
- Report: version tagged, CHANGELOG updated, release created (or skipped)

### 2. Skill: `hooks-setup`

A new skill at `skills/hooks-setup/SKILL.md` invoked via `/hooks-setup`.

**Step 1 — Discover available hooks:**
- Scan `hooks/` directory for executable scripts (exclude `README.md`)
- For each script, read the header comment to extract description and target git event
- Each hook script should contain a comment: `# git-hook: pre-commit`
- Present a list with install status:

```
Available hooks:
  ✓ check-secrets.sh → pre-commit (installed)
  ✗ other-hook.sh    → post-merge  (not installed)
```

**Step 2 — Install:**
- Ask user which hooks to install (multi-select, or "all")
- For each selected hook:
  - Check if `.git/hooks/{event}` already exists
  - If exists and is not our symlink — warn: "A {event} hook already exists. Replace it, or skip?"
  - If exists and is our symlink — skip (already installed)
  - Create symlink: `ln -sf ../../hooks/{script} .git/hooks/{event}`
- Report results

**Step 3 — Uninstall option:**
- Ask "Want to uninstall any hooks?"
- If yes, show installed hooks, let user select, remove symlinks

## Alternatives Considered

| Alternative                      | Pros                      | Cons                         | Why Rejected                                        |
|----------------------------------|---------------------------|------------------------------|-----------------------------------------------------|
| Support all hosting platforms    | Maximum coverage          | 4x implementation effort     | GitHub + GitLab cover ~90%; graceful fallback for rest |
| Copy hooks instead of symlinks   | No broken links           | Hooks diverge from source    | Symlinks stay in sync with plugin updates           |
| Auto-install hooks on plugin setup | Zero friction            | Modifies .git without asking | User should opt-in to hook installation             |
| Enforce semver only              | Simpler logic             | Excludes calver projects     | Auto-detect + confirm is more universal             |

## Risks and Unknowns

All identified risks have been addressed in the design:

- ~~Non-standard tag formats~~ → auto-detect from existing tags, confirm with user, save preference to `git-workflow.md`
- ~~Existing git hooks conflict~~ → detect and warn before overwriting, offer skip option
- ~~Missing CLI tools~~ → graceful fallback with install suggestions

## Dependencies

- `/changelog` skill (invoked during release)
- `gh` CLI for GitHub releases (optional)
- `glab` CLI for GitLab releases (optional)
