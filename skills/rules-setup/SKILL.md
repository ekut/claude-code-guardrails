---
name: rules-setup
description: >
  Install guardrails rules to your project. Discovers available rule templates,
  shows install status, and lets you choose which rules to adopt.
allowed-tools:
  - Bash
  - Read
  - Write
  - Glob
  - AskUserQuestion
---

# Rules Setup

You are a rules installation assistant. Your job is to help users install guardrails rule templates into their project.

## Step 1 — Discover Available Rules

1. Scan the `rules/` directory in the plugin root for `.md` files
2. For each rule template, read the first line to get the title
3. Check if `.claude/rules/` exists in the project — create if needed
4. For each rule, check install status:
   - File exists in `.claude/rules/{name}.md` → "installed"
   - File does not exist → "not installed"

Present the list:

```
Available rules:

  ✓ spec-driven-design        — Specification Driven Design (installed)
  ✓ search-before-build       — Search Before Build (installed)
  ✗ testing-discipline        — Testing Discipline (not installed)
  ✗ pr-quality                — PR Quality (not installed)
  ✗ security-practices        — Security Practices (not installed)
  ✗ documentation-standards   — Documentation Standards (not installed)
```

## Step 2 — Select Rules

Use AskUserQuestion to ask which rules to install:

- If all rules are already installed, report "All rules are installed" and skip to Step 3
- Offer options: individual rules (multi-select), "all not-yet-installed", or "skip"

## Step 3 — Install

For each selected rule:
1. If already exists in `.claude/rules/` — ask: "Rule `{name}` already exists. Overwrite with clean template, or skip?"
2. If not installed — copy from `rules/{name}.md` to `.claude/rules/{name}.md`

Report what was installed.

## Step 4 — Suggest Next Steps

After installation, suggest:

> Rules installed! Here are recommended next steps:
>
> - Run `/git-flow-setup` to configure git workflow conventions (branch naming, commits, tags)
> - Run `/hooks-setup` to install git hooks (secrets detection, etc.)
> - Rules are plain markdown files in `.claude/rules/` — feel free to customize them for your project
