# Contributing to claude-code-guardrails

Thank you for your interest in contributing! This guide will help you understand the project architecture and how to add new components.

## Architecture

claude-code-guardrails is a Claude Code plugin built entirely from markdown definitions — no compiled code. It uses four mechanism types:

| Mechanism | Location       | Purpose                                          | Example                           |
|-----------|----------------|--------------------------------------------------|-----------------------------------|
| Skills    | `skills/`      | Interactive workflows invoked via `/skill-name`  | `/spec`, `/release`, `/review-pr` |
| Agents    | `agents/`      | Specialized sub-agents for delegated tasks       | `git-workflow` agent              |
| Rules     | `rules/`       | Templates installed to user's `.claude/rules/`   | `testing-discipline.md`           |
| Hooks     | `hooks/`       | Shell scripts installed as git hooks             | `check-secrets.sh`                |

### Key Principle: Language Agnostic

All components must work for any programming language or stack. Focus on the development *process*, not specific languages or frameworks. When language-specific behavior is needed (e.g. dependency audit), use auto-discovery to detect the stack and adapt.

### Metaprogramming Loop

This project uses its own plugin during development. Every skill, agent, rule, and hook we ship is validated on this repository first. When building a new component, always consider both perspectives:
- **Product side:** will this work for any external user who installs the plugin?
- **Own development side:** does this work for our own development workflow?

## Creating New Components

### Skills

Skills are interactive workflows defined in `SKILL.md` files:

```
skills/
  my-skill/
    SKILL.md                  # skill definition (required)
    supporting-files/         # templates, checklists, etc. (optional)
      template.md
```

**SKILL.md frontmatter:**
```yaml
---
name: my-skill
description: >
  What this skill does and when to use it.
allowed-tools:
  - Bash
  - Read
  - Write
  - AskUserQuestion
---
```

The body is a prompt that Claude follows step by step. Use `AskUserQuestion` for interactive choices. See existing skills for examples.

### Agents

Agents are specialized sub-agents defined as markdown files in `agents/`:

```yaml
---
name: my-agent
model: haiku
tools:
  - Bash
  - Read
description: >
  When to delegate to this agent.
---
```

Agents run on a specific model (usually `haiku` for cost efficiency) and have a focused set of tools. They are invoked by the main agent, not by users directly.

### Rules

Rules are markdown files in `rules/` that get copied to the user's `.claude/rules/` via `/rules-setup`:

- Write clear, actionable instructions that Claude will follow
- Include "When required" and "When NOT required" sections
- Keep rules language-agnostic
- Use tables for reference data (auto-discovery mappings, etc.)
- Do NOT include project-specific state — rules are templates

### Hooks

Hooks are shell scripts in `hooks/` installed as git hooks via `/hooks-setup`:

- Include a `# git-hook: {event}` comment to specify the target git event
- Include a description comment at the top
- Support suppression mechanisms (`.secretsignore`, inline comments)
- Exit non-zero to block the operation, zero to allow

## Development Workflow

1. **Issue first** — open an issue to discuss your idea before writing code
2. **Spec before code** — for non-trivial changes, run `/spec` to create a specification
3. **Branch from main** — use `type/short-description` format (e.g. `feat/new-skill`)
4. **Conventional commits** — `type(scope): description` format
5. **PR for review** — all changes go through pull requests with squash merge
6. **Dogfooding** — test your changes on this repository before considering them done

## Git Conventions

This project uses GitHub Flow with conventional commits. See `.claude/rules/git-workflow.md` for the full specification.

- **Branch naming:** `feat/`, `fix/`, `docs/`, `chore/`, `refactor/`
- **Commit format:** `type(scope): description` — lowercase, imperative mood
- **PR merge:** squash merge to keep `main` history clean
- **Tags:** `vX.Y.Z` semver format

## Code of Conduct

We follow the [Contributor Covenant](https://www.contributor-covenant.org/version/2/1/code_of_conduct/). Be respectful, inclusive, and constructive.

## Questions?

Open an issue on [GitHub](https://github.com/ekut/claude-code-guardrails/issues) — we're happy to help!
