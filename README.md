# claude-code-guardrails

A Claude Code plugin that enforces software development best practices — automatically.

## What is this?

claude-code-guardrails is a set of agents, skills, rules, and hooks for [Claude Code](https://claude.ai/code) that guide AI-assisted development toward proven engineering practices. The plugin is programming language agnostic — it focuses on *how* you develop, not *what* you develop in.

## Why?

AI coding assistants are powerful but permissive. They will happily skip tests, commit directly to main, or reimplement something that already exists — unless you tell them not to. This plugin encodes those guardrails so you don't have to repeat yourself.

Key practices enforced:
- **Specification Driven Design** — think before you code
- **Optimal git flow** — clean history, conventional commits, PR-based workflow
- **Test coverage 80%+** — by lines, configurable
- **Search before build** — check what exists before writing new code

## How It Works

The plugin uses four mechanism types to shape Claude Code's behavior:

| Mechanism | What it does                                              | Example                                                    |
|-----------|-----------------------------------------------------------|------------------------------------------------------------|
| Rules     | Always-on constraints loaded into every conversation      | `git-workflow` — enforces branch naming and commit format  |
| Skills    | Interactive workflows invoked via `/skill-name`           | `/spec` — walks through requirements, design, and tasks    |
| Agents    | Specialized sub-agents that handle delegated tasks        | `git-workflow` — executes commits, pushes, PRs, merges     |
| Hooks     | Shell commands triggered by Claude Code events (planned)  | Secrets detection — block commits containing API keys      |

Project structure:

```
claude-code-guardrails/
  agents/
    git-workflow.md          # git operations agent
  skills/
    git-flow-setup/          # interactive git flow wizard
    spec/                    # spec creation wizard
  .claude/rules/
    git-workflow.md          # branch naming, commits, PR rules
    spec-driven-design.md    # nudges toward specs before coding
```

## Current Features (v0.2)

### v0.1 — Git Workflow

- **Git workflow agent** — delegates all git write operations (commit, push, branch, PR, merge, tag) to a specialized agent that enforces conventions
- **Git flow setup skill** — interactive wizard (`/git-flow-setup`) that configures branch naming, commit format, and PR rules
- **Git workflow rules** — branch naming format, conventional commits, squash merge policy, protected branches

### v0.2 — Specification Driven Design

- **Spec skill** — interactive wizard (`/spec`) that walks through requirements, design, and tasks phases to produce a complete specification before implementation begins
- **Spec templates** — lightweight, requirements, design, and tasks templates in `skills/spec/supporting-files/`
- **Spec-driven design rule** — nudges toward writing specs before non-trivial changes; checks `specs/` for existing specs and suggests `/spec` when none is found

## Usage Examples

**Starting a new feature.** You tell Claude "let's add user authentication". The `spec-driven-design` rule kicks in — Claude suggests running `/spec` first. The wizard walks you through requirements, design decisions, and task breakdown. Only after the spec is written does implementation begin, following the task list.

**Making a commit.** You say "commit these changes". Claude delegates to the `git-workflow` agent, which stages files, writes a conventional commit message, and creates the commit — all following the rules defined during `/git-flow-setup`. No manual formatting needed.

**Setting up git flow on a new project.** You run `/git-flow-setup` and the wizard asks which flow you prefer (GitHub Flow, Git Flow Classic, or Trunk-Based). It generates the rules file and agent configuration so every future git operation follows your chosen conventions.

## Installation

1. Clone this repository (or add it as a git submodule):
   ```
   git clone https://github.com/ekut/claude-code-guardrails.git
   ```
2. Reference the plugin from your project's Claude Code configuration.

> Installation details will be refined as Claude Code's plugin system matures.

## Roadmap

See [ROADMAP.md](ROADMAP.md) for the full development plan and milestone details.

## Dogfooding

This project uses its own plugin during development. Every rule, skill, and agent we ship is validated on this repository first. If it doesn't work for us, it won't work for you.

## Contributing

The project is in early stage. If you'd like to contribute, please open an issue first to discuss your idea before submitting a PR.

## License

[MIT](LICENSE)
