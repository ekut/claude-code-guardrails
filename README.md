# claude-code-guardrails

[![Version](https://img.shields.io/github/v/release/ekut/claude-code-guardrails?label=version)](https://github.com/ekut/claude-code-guardrails/releases)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Built with Claude Code](https://img.shields.io/badge/built%20with-Claude%20Code-blueviolet)](https://claude.ai/code)

A Claude Code plugin that enforces software development best practices — automatically.

## What is this?

claude-code-guardrails is a set of agents, skills, rules, and hooks for [Claude Code](https://claude.ai/code) that guide
AI-assisted development toward proven engineering practices. The plugin is programming language agnostic — it focuses on
*how* you develop, not *what* you develop in.

## Why?

AI coding assistants are powerful but permissive. They will happily skip tests, commit directly to main, or reimplement
something that already exists — unless you tell them not to. This plugin encodes those guardrails so you don't have to
repeat yourself.

Key practices enforced:

- **Specification Driven Design** — think before you code
- **Optimal git flow** — clean history, conventional commits, PR-based workflow
- **Test coverage 80%+** — by lines, configurable
- **Search before build** — check what exists before writing new code
- **Code review & PR quality** — structured PRs, size limits, review checklists
- **Documentation standards** — README generation, changelog management, docs sync
- **Security practices** — secrets detection, dependency audit, security review checklist
- **Release & hooks** — automated releases with platform detection, hook management

## How It Works

The plugin uses four mechanism types to shape Claude Code's behavior:

| Mechanism | What it does                                         | Example                                                      |
|-----------|------------------------------------------------------|--------------------------------------------------------------|
| Rules     | Always-on constraints loaded into every conversation | `testing-discipline` — enforces test coverage                |
| Skills    | Interactive workflows invoked via `/skill-name`      | `/spec` — walks through requirements, design, and tasks      |
| Agents    | Specialized sub-agents that handle delegated tasks   | `git-workflow` — executes commits, pushes, PRs, merges       |
| Hooks     | Shell scripts that run on git events                 | `check-secrets.sh` — blocks commits containing secrets       |

Project structure:

```
claude-code-guardrails/
  agents/
    git-workflow.md              # git operations agent
    supporting-files/
      pr-template.md             # PR description template
  skills/
    git-flow-setup/              # interactive git flow wizard
    spec/                        # spec creation wizard
    test-plan/                   # test plan generator + coverage checker
    review-pr/                   # code review skill
      supporting-files/
        review-checklist.md      # review checklist template
    readme/                      # README generation & audit wizard
      supporting-files/
        readme-template.md       # README template
    changelog/                   # changelog generation from git history
      supporting-files/
        conventional-changelog-template.md
        keep-a-changelog-template.md
    security-audit/              # on-demand security scanning
    release/                     # release wizard
    hooks-setup/                 # hook discovery and installation
    rules-setup/                 # interactive rules installer
  rules/                         # clean rule templates (product)
    spec-driven-design.md
    search-before-build.md
    testing-discipline.md
    pr-quality.md
    security-practices.md
    documentation-standards.md
  hooks/
    check-secrets.sh             # pre-commit secrets detection hook
  specs/                         # feature specifications
  CHANGELOG.md                   # project changelog
  CONTRIBUTING.md                # contributor guidelines
```

## Current Features

### Git Workflow

Eliminates messy git histories and merge conflicts. Every team member follows the same conventions without memorizing
them.

- **Git workflow agent** — delegates all git write operations (commit, push, branch, PR, merge, tag) to a specialized
  agent that enforces conventions
- **Git flow setup skill** — interactive wizard (`/git-flow-setup`) that configures branch naming, commit format, and PR
  rules
- **Git workflow rules** — branch naming format, conventional commits, squash merge policy, protected branches

### Specification Driven Design

Reduces wasted effort and rework by forcing teams to think through requirements before writing code.

- **Spec skill** — interactive wizard (`/spec`) that walks through requirements, design, tasks, and optional test plan
  phases to produce a complete specification before implementation begins
- **Spec templates** — lightweight, requirements, design, and tasks templates in `skills/spec/supporting-files/`
- **Spec-driven design rule** — nudges toward writing specs before non-trivial changes; checks `specs/` for existing
  specs and suggests `/spec` when none is found

### Search Before Build

Prevents duplicate code and reinvented wheels. Teams leverage existing solutions instead of building from scratch.

- **Search before build rule** — requires searching the codebase and package registries before writing new utilities,
  helpers, or abstractions
- **Deduplication awareness** — flags when new code overlaps with existing project code and suggests reuse or extraction

### Testing Discipline

Catches regressions early and gives teams confidence to refactor. Test debt stops accumulating silently.

- **Testing discipline rule** — ensures tests are written and coverage meets a configurable threshold (default 80% by
  lines)
- **Test plan skill** — interactive wizard (`/test-plan`) with two modes: generate a test plan from a spec, or check
  current project coverage
- **Testing config** — optional `.claude/testing.json` stores test/coverage commands; auto-discovers setup if no config
  exists
- **Spec integration** — `/spec` now offers an optional Phase 4 to generate a test plan after tasks are defined

### Code Review & PR Quality

Makes PRs smaller, better described, and easier to review. Catches issues before they reach the main branch.

- **PR quality rule** — enforces PR description completeness (summary, changes, test plan, checklist) and warns when PRs
  exceed size limits (default: 400 lines, 10 files)
- **Review PR skill** — code review wizard (`/review-pr`) that analyzes diffs against a standardized checklist covering
  correctness, tests, security, and readability
- **Auto-detect input** — `/review-pr` works with GitHub PR numbers/URLs, uncommitted local changes, or branch diffs vs
  main
- **PR template** — reusable template in `agents/supporting-files/pr-template.md` used by the git-workflow agent when
  creating PRs

### Documentation Standards

Keeps documentation in sync with code so it never goes stale. READMEs stay current, changelogs are maintained
automatically.

- **Documentation standards rule** — reminds to update docs when code changes affect public interfaces or project
  structure, prompts for CHANGELOG entries on `feat`/`fix` commits, enforces aligned markdown tables
- **README skill** — interactive wizard (`/readme`) that generates a new README or audits an existing one for
  completeness and accuracy
- **Changelog skill** — generator (`/changelog`) that creates CHANGELOG entries from git history, supporting
  Conventional Changelog and Keep a Changelog formats with auto-detection from git tags

### Security Practices

Catches secrets and vulnerable dependencies before they reach production. Security issues found early cost a fraction of
those found after deployment.

- **Security practices rule** — prevents committing files with secrets (`.env`, credentials, private keys), scans diffs
  for hardcoded API keys and tokens, reminds to audit dependencies when dependency files change
- **Secrets detection hook** — shell script (`hooks/check-secrets.sh`) that scans staged diffs for secret patterns
  before each commit, with `.secretsignore` and `# nosecret` suppression
- **Security audit skill** — on-demand scanner (`/security-audit`) that checks the codebase for committed secrets and
  audits dependencies for known vulnerabilities with auto-discovery of the project stack
- **Enhanced review checklist** — expanded security section covering secrets, dependency audit, cryptography, error
  leakage, TLS, and least privilege

### Release & Hooks Setup

Turns error-prone manual releases into a repeatable one-command process. New team members get all safety nets installed
in seconds.

- **Release skill** — interactive wizard (`/release`) that automates the full release cycle: semver bump, CHANGELOG
  update, git tagging, and optional platform release with auto-detection of GitHub/GitLab
- **Hooks setup skill** — discovery and installation wizard (`/hooks-setup`) that finds available hooks in `hooks/`,
  shows install status, and creates git hook symlinks with conflict detection
- **Tag format in git-flow-setup** — `/git-flow-setup` now asks about tag/version format (vX.Y.Z, X.Y.Z, calendar,
  custom) and saves the preference for `/release` to use
- **Rules setup skill** — interactive installer (`/rules-setup`) that discovers available rule templates and lets you
  choose which to adopt for your project

## Usage Examples

**Starting a new feature**

- **Run:** tell Claude "let's add user authentication"
- **Flow:** the `spec-driven-design` rule kicks in — Claude suggests `/spec`, which walks through requirements, design,
  and task breakdown before any code is written
- **Impact:** fewer misunderstandings, less rework, clearer scope for the entire team

**Making a commit**

- **Run:** "commit these changes"
- **Flow:** Claude delegates to the `git-workflow` agent, which stages files, writes a conventional commit message, and
  creates the commit following your project's conventions
- **Impact:** consistent git history across the team without anyone memorizing conventions

**Setting up git flow**

- **Run:** `/git-flow-setup`
- **Flow:** wizard asks which flow you prefer (GitHub Flow, Git Flow Classic, or Trunk-Based), generates the rules file
  so every future operation follows your conventions
- **Impact:** one-time setup, permanent consistency — no more "how do we name branches here?" questions

**Reviewing a PR**

- **Run:** `/review-pr 42` (or without arguments for local changes)
- **Flow:** fetches the diff, checks size limits, analyzes for correctness, test coverage, security, and readability
  against a standardized checklist
- **Impact:** systematic reviews catch more bugs; every PR gets the same quality bar regardless of reviewer

**Creating a PR**

- **Run:** "create a PR"
- **Flow:** the `pr-quality` rule ensures summary, changes, test plan, and checklist are present; warns if diff exceeds
  400 lines or 10 files
- **Impact:** smaller, well-described PRs that reviewers can process faster

**Generating a changelog**

- **Run:** `/changelog`
- **Flow:** parses git history from the last tag, groups commits by type, generates a formatted CHANGELOG entry
- **Impact:** stakeholders always know what shipped, without developers writing release notes manually

**Auditing a README**

- **Run:** `/readme`
- **Flow:** on a new project — generates from template; on an existing project — audits for completeness against the
  codebase
- **Impact:** documentation stays accurate, reducing onboarding time for new team members

**Running a security audit**

- **Run:** `/security-audit`
- **Flow:** scans for hardcoded secrets and checks dependencies for known vulnerabilities, auto-discovering your stack
- **Impact:** security issues caught during development, not after a breach

**Releasing a version**

- **Run:** `/release`
- **Flow:** handles semver bump, CHANGELOG update, git tag, and platform release — auto-detecting GitHub or GitLab
- **Impact:** releases go from a 10-step manual checklist to a single command, eliminating human error

**Setting up hooks**

- **Run:** `/hooks-setup`
- **Flow:** discovers available hooks, shows install status, creates git hook symlinks with conflict detection
- **Impact:** every developer on the team gets the same safety nets in seconds, not hours of setup

## Installation

### As a Plugin (recommended)

1. Add the marketplace source:
   ```
   /plugin marketplace add ekut/claude-code-guardrails
   ```

2. Install the plugin:
   ```
   /plugin install claude-code-guardrails
   ```

3. Set up your project:
   ```
   /rules-setup        # choose which rules to adopt
   /git-flow-setup     # configure git workflow conventions
   /hooks-setup        # install git hooks (secrets detection, etc.)
   ```

### Manual Installation (advanced)

If you prefer to cherry-pick components:

1. Clone the repository:
   ```
   git clone https://github.com/ekut/claude-code-guardrails.git
   ```
2. Copy what you need into your project's `.claude/` directory:
    - `skills/{skill-name}/` → `.claude/skills/{skill-name}/`
    - `agents/{agent-name}.md` → `.claude/agents/{agent-name}.md`
    - `rules/{rule-name}.md` → `.claude/rules/{rule-name}.md`
    - `hooks/{hook-name}.sh` → set up as git hook (see `hooks/README.md`)

### Update

```
/plugin marketplace update
```

### Uninstall

```
/plugin uninstall claude-code-guardrails
```

## Roadmap

See [ROADMAP.md](ROADMAP.md) for the full development plan and milestone details.

## Dogfooding

This project uses its own plugin during development. Every rule, skill, and agent we ship is validated on this
repository first. If it doesn't work for us, it won't work for you.

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for architecture overview, how to create new
skills/agents/rules, and development workflow guidelines.

## License

[MIT](LICENSE)
