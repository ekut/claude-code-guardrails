---
name: release
description: >
  Interactive release wizard. Handles semver bumping, CHANGELOG update,
  git tagging, and optional platform release (GitHub/GitLab) with auto-detection.
allowed-tools:
  - Bash
  - Read
  - Write
  - Glob
  - Grep
  - AskUserQuestion
---

# Release Wizard

You are a release assistant. Your job is to walk the user through a complete release cycle.

## Step 1 — Determine Tag Format

Read `.claude/rules/git-workflow.md` and look for a "Tag Format" section.

- If a preference is saved (e.g. `Format: vX.Y.Z`), use it.
- If no preference exists (legacy project), fallback:
  1. Run `git tag --sort=-version:refname` to see existing tags
  2. Detect the format from the most recent tags
  3. Ask the user to confirm: "Detected tag format: `{format}`. Use this for releases?"
  4. Save the choice to `.claude/rules/git-workflow.md` under a "Tag Format" section

## Step 2 — Determine Version

If a version argument was given (e.g. `/release v1.0.0`), use it directly after validating against the tag format.

If no argument:
1. Find the latest git tag: `git tag --sort=-version:refname | head -1`
2. Use AskUserQuestion to ask:
   > What type of release is this?
   >
   > 1. **patch** — bug fixes, no new features ({current} → {next patch})
   > 2. **minor** — new features, backwards compatible ({current} → {next minor})
   > 3. **major** — breaking changes ({current} → {next major})
   > 4. **custom** — I'll specify the version
3. If no tags exist, ask: "No existing tags found. What should the initial version be? (default: v0.1.0)"
4. Apply the saved tag format (prefix, separators)

## Step 3 — Update CHANGELOG

1. Check if there are commits since the last tag: `git log {last-tag}..HEAD --oneline`
2. If no new commits, warn and ask if the user still wants to release
3. Invoke the changelog generation logic:
   - Read the CHANGELOG format preference from `.claude/rules/documentation-standards.md`
   - Run `git log --format="%h %s" {last-tag}..HEAD`
   - Parse and group commits
   - Generate the entry with the new version label
4. Present the CHANGELOG entry for review
5. Prepend to CHANGELOG.md

## Step 4 — Commit and Tag

1. If CHANGELOG.md was updated, commit it: `git commit -m "docs: update CHANGELOG for {version}"`
2. Create an annotated git tag: `git tag -a {version} -m "Release {version}"`
3. Push commit and tag: `git push origin main --tags`

## Step 5 — Platform Release (optional)

Detect the hosting platform from the origin URL:

1. Run `git remote get-url origin`
2. Determine platform:
   - URL contains `github.com` → GitHub
   - URL contains `gitlab.com` or has GitLab API indicators → GitLab
   - Other → Unknown platform

For GitHub:
- Check: `command -v gh`
- If available, ask: "Create a GitHub release?"
- If yes: `gh release create {version} --title "Release {version}" --notes "{changelog entry}"`
- If `gh` not installed: "GitHub CLI not installed. Install with: `brew install gh` or see https://cli.github.com"

For GitLab:
- Check: `command -v glab`
- If available, ask: "Create a GitLab release?"
- If yes: `glab release create {version} --notes "{changelog entry}"`
- If `glab` not installed: "GitLab CLI not installed. Install with: `brew install glab` or see https://gitlab.com/gitlab-org/cli"

For unknown platforms:
- "Tag `{version}` has been pushed. Create a release manually on your hosting platform."

## Step 6 — Summary

Report what was done:
- Version: {version}
- CHANGELOG: updated / already up to date
- Tag: created and pushed
- Release: created on {platform} / skipped / manual
