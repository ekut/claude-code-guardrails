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
- **Code review & PR quality** — structured PRs, size limits, review checklists
- **Documentation standards** — README generation, changelog management, docs sync
- **Security practices** — secrets detection, dependency audit, security review checklist
- **Release & hooks** — automated releases with platform detection, hook management

## How It Works

The plugin uses three mechanism types to shape Claude Code's behavior:

| Mechanism | What it does                                         | Example                                                   |
|-----------|------------------------------------------------------|-----------------------------------------------------------|
| Rules     | Always-on constraints loaded into every conversation | `git-workflow` — enforces branch naming and commit format |
| Skills    | Interactive workflows invoked via `/skill-name`      | `/spec` — walks through requirements, design, and tasks   |
| Agents    | Specialized sub-agents that handle delegated tasks   | `git-workflow` — executes commits, pushes, PRs, merges    |

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
  hooks/
    check-secrets.sh             # pre-commit secrets detection hook
  specs/                         # feature specifications
  .claude/rules/
    git-workflow.md              # branch naming, commits, PR rules
    spec-driven-design.md        # nudges toward specs before coding
    search-before-build.md       # reuse existing code before writing new
    testing-discipline.md        # test coverage enforcement
    pr-quality.md                # PR size limits and description requirements
    documentation-standards.md   # docs sync, changelog reminders, table formatting
    security-practices.md        # secrets prevention, dependency audit reminders
  CHANGELOG.md                   # project changelog
  CLAUDE.md                      # instructions for Claude Code
```

## Current Features

### Git Workflow

- **Git workflow agent** — delegates all git write operations (commit, push, branch, PR, merge, tag) to a specialized agent that enforces conventions
- **Git flow setup skill** — interactive wizard (`/git-flow-setup`) that configures branch naming, commit format, and PR rules
- **Git workflow rules** — branch naming format, conventional commits, squash merge policy, protected branches

### Specification Driven Design

- **Spec skill** — interactive wizard (`/spec`) that walks through requirements, design, tasks, and optional test plan phases to produce a complete specification before implementation begins
- **Spec templates** — lightweight, requirements, design, and tasks templates in `skills/spec/supporting-files/`
- **Spec-driven design rule** — nudges toward writing specs before non-trivial changes; checks `specs/` for existing specs and suggests `/spec` when none is found

### Search Before Build

- **Search before build rule** — requires searching the codebase and package registries before writing new utilities, helpers, or abstractions
- **Deduplication awareness** — flags when new code overlaps with existing project code and suggests reuse or extraction

### Testing Discipline

- **Testing discipline rule** — ensures tests are written and coverage meets a configurable threshold (default 80% by lines)
- **Test plan skill** — interactive wizard (`/test-plan`) with two modes: generate a test plan from a spec, or check current project coverage
- **Testing config** — optional `.claude/testing.json` stores test/coverage commands; auto-discovers setup if no config exists
- **Spec integration** — `/spec` now offers an optional Phase 4 to generate a test plan after tasks are defined

### Code Review & PR Quality

- **PR quality rule** — enforces PR description completeness (summary, changes, test plan, checklist) and warns when PRs exceed size limits (default: 400 lines, 10 files)
- **Review PR skill** — code review wizard (`/review-pr`) that analyzes diffs against a standardized checklist covering correctness, tests, security, and readability
- **Auto-detect input** — `/review-pr` works with GitHub PR numbers/URLs, uncommitted local changes, or branch diffs vs main
- **PR template** — reusable template in `agents/supporting-files/pr-template.md` used by the git-workflow agent when creating PRs

### Documentation Standards

- **Documentation standards rule** — reminds to update docs when code changes affect public interfaces or project structure, prompts for CHANGELOG entries on `feat`/`fix` commits, enforces aligned markdown tables
- **README skill** — interactive wizard (`/readme`) that generates a new README or audits an existing one for completeness and accuracy
- **Changelog skill** — generator (`/changelog`) that creates CHANGELOG entries from git history, supporting Conventional Changelog and Keep a Changelog formats with auto-detection from git tags

### Security Practices

- **Security practices rule** — prevents committing files with secrets (`.env`, credentials, private keys), scans diffs for hardcoded API keys and tokens, reminds to audit dependencies when dependency files change
- **Secrets detection hook** — shell script (`hooks/check-secrets.sh`) that scans staged diffs for secret patterns before each commit, with `.secretsignore` and `# nosecret` suppression
- **Security audit skill** — on-demand scanner (`/security-audit`) that checks the codebase for committed secrets and audits dependencies for known vulnerabilities with auto-discovery of the project stack
- **Enhanced review checklist** — expanded security section covering secrets, dependency audit, cryptography, error leakage, TLS, and least privilege

### Release & Hooks Setup

- **Release skill** — interactive wizard (`/release`) that automates the full release cycle: semver bump, CHANGELOG update, git tagging, and optional platform release with auto-detection of GitHub/GitLab
- **Hooks setup skill** — discovery and installation wizard (`/hooks-setup`) that finds available hooks in `hooks/`, shows install status, and creates git hook symlinks with conflict detection
- **Tag format in git-flow-setup** — `/git-flow-setup` now asks about tag/version format (vX.Y.Z, X.Y.Z, calendar, custom) and saves the preference for `/release` to use

## Usage Examples

**Starting a new feature.** You tell Claude "let's add user authentication". The `spec-driven-design` rule kicks in — Claude suggests running `/spec` first. The wizard walks you through requirements, design decisions, and task breakdown. Only after the spec is written does implementation begin, following the task list.

**Making a commit.** You say "commit these changes". Claude delegates to the `git-workflow` agent, which stages files, writes a conventional commit message, and creates the commit — all following the rules defined during `/git-flow-setup`. No manual formatting needed.

**Setting up git flow on a new project.** You run `/git-flow-setup` and the wizard asks which flow you prefer (GitHub Flow, Git Flow Classic, or Trunk-Based). It generates the rules file and agent configuration so every future git operation follows your chosen conventions.

**Reviewing a PR.** You run `/review-pr 42` and the skill fetches the PR diff from GitHub, checks it against size limits, and analyzes the code for correctness, test coverage, security issues, and readability. You get a structured report in the terminal. Works with local changes too — run `/review-pr` without arguments and it auto-detects uncommitted changes or the branch diff vs main.

**Creating a PR.** You say "create a PR". The `pr-quality` rule ensures the description includes a summary, changes list, test plan, and self-review checklist. If the diff exceeds 400 lines or 10 files, Claude warns you and suggests splitting into smaller PRs.

**Generating a changelog.** You run `/changelog` and the skill parses your git history from the last tag, groups commits by type, and generates a formatted CHANGELOG entry. On first run, it asks which format you prefer — Conventional Changelog or Keep a Changelog — and remembers your choice.

**Bootstrapping or auditing a README.** You run `/readme` — on a new project, the wizard asks for project name, install method, and license, then generates a complete README from a template. On an existing project, it offers to audit the current README for completeness and accuracy against the codebase.

**Running a security audit.** You run `/security-audit` and the skill scans your codebase for hardcoded secrets (AWS keys, GitHub tokens, private keys) and checks dependencies for known vulnerabilities. It auto-discovers your stack and runs the appropriate audit tool (`npm audit`, `pip audit`, etc.).

**Releasing a version.** You run `/release` and the wizard asks for bump type (patch/minor/major), updates the CHANGELOG, creates a git tag, and offers to create a GitHub or GitLab release — all auto-detected from your origin URL.

**Setting up hooks.** You run `/hooks-setup` and the skill discovers available hooks, shows which are installed, and creates git hook symlinks. If an existing hook conflicts, it warns and offers to back it up.

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
