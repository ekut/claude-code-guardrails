# Requirements: Stable Release

## Problem Statement

The plugin has all core practices implemented (v0.1–v0.8), but is not ready for external users: rules are not deliverable through the plugin system, installation instructions are incomplete, plugin.json is outdated, there is no contributor guide, and some features lack dogfooding validation.

## Goals

- Make the plugin installable and functional for any team via standard Claude Code plugin installation
- Create a `/rules-setup` skill that installs rule templates to the user's project interactively
- Separate clean rule templates (product) from our project-specific mutated copies
- Update `plugin.json` to v1.0 with complete metadata
- Write a comprehensive Installation section in README with clear steps
- Write a detailed CONTRIBUTING.md for external contributors
- Complete dogfooding for v0.8 features (`/release`, `/hooks-setup`)
- Polish all documentation for public consumption
- Add a "Future Ideas" section to ROADMAP inviting community suggestions

## Success Criteria

- [ ] Clean rule templates stored in `rules/` directory (product), separate from `.claude/rules/` (our project)
- [ ] A `rules-setup` skill interactively installs selected rule templates to the user's `.claude/rules/`
- [ ] `plugin.json` updated to version 1.0.0 with full metadata (author, homepage, repository, license)
- [ ] README Installation section has clear steps for plugin install, manual install, update, and uninstall
- [ ] CONTRIBUTING.md with architecture overview, how to create skills/agents/rules, issue-first policy
- [ ] All skills, agents, and rules documented in README
- [ ] Dogfooding complete for `/release` and `/hooks-setup`
- [ ] ROADMAP has a "Future Ideas" section with community invitation
- [ ] CHANGELOG up to date through v1.0
- [ ] Git tag v1.0 created

## Out of Scope

- Official Anthropic marketplace submission (separate post-release activity)
- GUI or web interface
- Paid features or licensing beyond MIT
- CI/CD template generation (removed from scope in v0.8)

Ideas beyond v1.0 (new practices, marketplace submission, community suggestions) will be added to ROADMAP as a "Future Ideas" section during implementation.
