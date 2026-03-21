---
name: hooks-setup
description: >
  Discover and install plugin hooks as git hooks.
  Shows available hooks, their status, and installs via symlinks.
allowed-tools:
  - Bash
  - Read
  - Glob
  - AskUserQuestion
---

# Hooks Setup

You are a hooks setup assistant. Your job is to help users discover and install plugin hooks as git hooks.

## Step 1 — Discover Available Hooks

1. Scan the `hooks/` directory for executable scripts (exclude `README.md` and non-script files)
2. For each script, read the first 20 lines to extract:
   - **Description**: from the header comment (lines starting with `#`)
   - **Target git event**: from a `# git-hook: {event}` comment (e.g. `# git-hook: pre-commit`)
3. If a script has no `# git-hook:` header, note it as "unmapped"
4. Check install status for each hook:
   - Read `.git/hooks/{event}` — does it exist?
   - If it exists and is a symlink pointing to `../../hooks/{script}` → "installed"
   - If it exists but points elsewhere or is not a symlink → "conflict"
   - If it doesn't exist → "not installed"

Present the list:

```
Available hooks:

  ✓ check-secrets.sh → pre-commit (installed)
  ✗ other-hook.sh    → post-merge  (not installed)
  ⚠ another-hook.sh  → pre-push    (conflict: existing hook found)
```

## Step 2 — Install

Use AskUserQuestion to ask which hooks to install:
- If all hooks are already installed, report "All hooks are installed" and skip to Step 3
- Offer options: individual hooks, "all", or "skip"

For each hook to install:
1. If status is "conflict" — warn: "A `{event}` hook already exists at `.git/hooks/{event}` and is not managed by this plugin."
   - Ask: "Replace it with the plugin hook, or skip?"
   - If replace: back up existing to `.git/hooks/{event}.backup`, then create symlink
   - If skip: continue to next hook
2. If status is "not installed" — create symlink:
   ```
   ln -sf ../../hooks/{script} .git/hooks/{event}
   ```
3. If status is "installed" — skip (already done)

Report results: which hooks were installed, skipped, or had conflicts.

## Step 3 — Uninstall (optional)

Use AskUserQuestion: "Want to uninstall any hooks?"

If yes:
1. Show only installed hooks (symlinks managed by this plugin)
2. Let user select which to remove
3. Remove the symlink: `rm .git/hooks/{event}`
4. If a `.git/hooks/{event}.backup` exists, ask: "Restore the previous hook from backup?"
5. Report results

If no: done.
