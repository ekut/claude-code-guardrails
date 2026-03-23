# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Claude Code plugin that enforces software development best practices and workflows. The plugin is **programming language agnostic** — it focuses on the development process, not specific languages or frameworks.

Key practices enforced:

- Specification Driven Design
- Optimal git flow
- Search before build
- Test coverage 80%+ by lines
- Code review & PR quality
- Documentation standards
- Security practices
- Release & hooks management

See [ROADMAP.md](ROADMAP.md) for the full development plan and milestone details.

This is an open-source project under the MIT license.

## Conventions

- All documentation, code comments, and repository content must be in **English only**.
- The plugin consists entirely of markdown definitions (skills, agents, rules) and shell scripts (hooks) — no build system or compiled code.
- This project uses its own plugin during development (dogfooding). Our `.claude/rules/`, agents, and skills are the product we ship.
- Clean rule templates live in `rules/` (product). Our project-specific copies live in `.claude/rules/` (may be mutated).
