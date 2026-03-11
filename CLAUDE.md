# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Claude Code plugin (agents, skills, commands, hooks, etc.) that enforces software development best practices and workflows. The plugin is **programming language agnostic** — it focuses on the development process, not specific languages or frameworks.

Key practices the plugin aims to enforce:
- Specification Driven Design
- Optimal git flow
- Test coverage 80%+ by lines
- Search for existing solutions before implementing

See [ROADMAP.md](ROADMAP.md) for the full development plan and milestone details.

This is an open-source project under the MIT license.

## Conventions

- All documentation, code comments, and repository content must be in **English only**.
- The project is in early stage — no build system or tests are set up yet.
- Use `mcp__sequential-thinking__sequentialthinking` for planning and implementing any non-trivial features. Break down the problem into steps before writing code.