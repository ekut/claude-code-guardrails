---
name: git-flow-setup
description: >
  Interactive setup wizard for git workflow conventions.
  Triggers when the user requests a git write operation (commit, push, branch, PR, merge)
  and no `.claude/rules/git-workflow.md` exists yet.
  Asks the user which git flow to use and saves the choice as project rules.
allowed-tools:
  - Read
  - Write
  - Glob
  - AskUserQuestion
---

# Git Flow Setup Wizard

You are setting up git workflow conventions for this project.

## Steps

1. **Check if already configured**: Use Glob to check if `.claude/rules/git-workflow.md` exists. If it does, inform the user that git workflow is already configured and skip setup.

2. **Ask which git flow to use**: Use AskUserQuestion to ask:
   > Which git workflow do you want to use for this project?
   >
   > 1. **GitHub Flow** — Simple branch-based flow. Branch from `main`, open PR, merge back. Best for continuous delivery.
   > 2. **Trunk-based development** — Short-lived branches, frequent integration to `main`. Direct commits OK for small changes.
   > 3. **Git Flow classic** — `main` + `develop` branches with `feature/*`, `release/*`, `hotfix/*` prefixes. Best for versioned releases.

3. **Ask about co-authorship**: Use AskUserQuestion to ask:
   > Should commits include Claude Code as co-author?
   >
   > If yes, every commit will include: `Co-Authored-By: Claude Code <noreply@anthropic.com>`

4. **Read the matching template**: Based on the user's choice, read the corresponding template:
   - GitHub Flow → `skills/git-flow-setup/supporting-files/github-flow.md`
   - Trunk-based → `skills/git-flow-setup/supporting-files/trunk-based.md`
   - Git Flow classic → `skills/git-flow-setup/supporting-files/git-flow-classic.md`

   Use a path relative to the project root to read the file.

5. **Append co-author preference**: After the template content, append a "Co-Authorship" section:
   - If yes: add a section stating every commit MUST end with `Co-Authored-By: Claude Code <noreply@anthropic.com>`
   - If no: add a section stating do NOT add any Co-Authored-By footer for Claude

6. **Write the rules file**: Write the final content to `.claude/rules/git-workflow.md`. Create the `.claude/rules/` directory path if needed.

7. **Confirm**: Tell the user setup is complete and summarize the chosen workflow. Then proceed with the original git operation if one was requested.
