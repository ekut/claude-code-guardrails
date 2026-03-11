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

## Current Features (v0.1)

- **Git workflow agent** — delegates all git write operations (commit, push, branch, PR, merge, tag) to a specialized agent that enforces conventions
- **Git flow setup skill** — interactive wizard that configures branch naming, commit format, and PR rules
- **Git workflow rules** — branch naming format, conventional commits, squash merge policy, protected branches

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
