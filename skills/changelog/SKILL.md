---
name: changelog
description: >
  Generate CHANGELOG entries from git history.
  Supports Conventional Changelog and Keep a Changelog formats.
  Auto-detects range from git tags or accepts an explicit range argument.
allowed-tools:
  - Bash
  - Read
  - Write
  - Glob
  - AskUserQuestion
---

# Changelog Generator

You are a changelog generation assistant. Your job is to generate CHANGELOG entries from git history in the user's preferred format.

## Step 1 — Determine Format

Read `.claude/rules/documentation-standards.md` and look for a "CHANGELOG Format Preference" section.

- If a preference is saved (e.g. `Format: conventional-changelog` or `Format: keep-a-changelog`), use it and skip the question.
- If no preference exists, use AskUserQuestion to ask:

> Which CHANGELOG format do you want to use?
>
> 1. **Conventional Changelog** — groups entries by commit type (Features, Bug Fixes, etc.). Best if your project uses conventional commits (`feat:`, `fix:`, etc.).
> 2. **Keep a Changelog** — groups entries by change type (Added, Changed, Fixed, Removed). Works with any commit style. Follows keepachangelog.com.

After the user chooses, append the preference to `.claude/rules/documentation-standards.md`:

```
## CHANGELOG Format Preference

Format: {conventional-changelog or keep-a-changelog}
```

## Step 2 — Determine Range

Resolve the commit range based on the argument provided:

1. **Range argument given** (e.g. `/changelog v0.4..v0.5`):
   - Use the provided range directly with `git log`

2. **No argument — tags exist**:
   - Run `git tag --sort=-version:refname` to find the latest tag
   - Use range `{latest-tag}..HEAD`
   - If HEAD equals the latest tag (no new commits), inform the user and stop

3. **No argument — no tags exist**:
   - Use all commits: `git log --reverse`
   - Warn: "No git tags found. Generating changelog from all commits."

Use AskUserQuestion to ask: "What version label should this changelog entry use? (e.g. `v0.6`, `1.0.0`, or `Unreleased`)"

## Step 3 — Parse Commits

Run `git log --format="%h %s" {range}` to get commits in the range.

For each commit, parse the subject line:
- If it matches conventional commit format `type(scope): description` — extract type, scope, description
- If it matches `type: description` (no scope) — extract type and description
- Otherwise — treat as unstructured (type = "other")

## Step 4 — Generate Changelog

Read the appropriate template:
- Conventional Changelog → `skills/changelog/supporting-files/conventional-changelog-template.md`
- Keep a Changelog → `skills/changelog/supporting-files/keep-a-changelog-template.md`

Group commits by category according to the template rules. Format the output.

Present the generated changelog to the user for review.

## Step 5 — Write to File

Use AskUserQuestion to ask: "Write this to CHANGELOG.md? (Will prepend to existing file or create a new one)"

If the user confirms:
1. If CHANGELOG.md exists — read it, prepend the new entry (after the `# Changelog` header if present), write back
2. If CHANGELOG.md does not exist — create it with a `# Changelog` header followed by the new entry

Confirm: "CHANGELOG.md has been updated."
