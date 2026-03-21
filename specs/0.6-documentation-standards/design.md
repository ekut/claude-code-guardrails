# Design: Documentation Standards

## Overview

v0.6 adds three components: (1) a `documentation-standards` rule enforcing docs sync, CHANGELOG reminders, and markdown table formatting, (2) a `readme` skill — interactive wizard for generating project READMEs, and (3) a `changelog` skill — generates CHANGELOG entries from git history with user-chosen format.

## Detailed Design

### 1. Rule: `documentation-standards.md`

A new rule in `.claude/rules/documentation-standards.md` with three concerns:

**Documentation sync:**
- When changing public interfaces, project structure, or adding/removing features — remind to update relevant documentation (README, module docs)
- When adding/removing skills, agents, or rules — remind to update the project structure section in README

**CHANGELOG reminders:**
- When committing `feat` or `fix` type changes, remind the user to update CHANGELOG.md
- Suggest running `/changelog` if no CHANGELOG entry has been added

**Markdown table formatting:**
- All markdown tables in `.md` files must have aligned columns before committing
- Pipe characters (`|`) must be vertically aligned, cells padded with spaces

**CHANGELOG format preference:**
- The rule stores the user's chosen CHANGELOG format (Conventional Changelog or Keep a Changelog)
- Initially absent — `/changelog` skill writes this section on first run after asking the user
- The skill reads this preference on subsequent runs to skip the question

### 2. Skill: `readme`

A new skill at `skills/readme/SKILL.md` invoked via `/readme`.

**Wizard flow:**
1. Ask project name and short description
2. Ask about installation method (npm, pip, git clone, other)
3. Ask about license (MIT, Apache-2.0, other, none)
4. Read template from `skills/readme/supporting-files/readme-template.md`
5. Generate README.md filling in the template
6. Present to user for review
7. Write to project root

**Template sections** (standard set):
- Title + description
- Installation
- Usage
- Contributing
- License

### 3. Skill: `changelog`

A new skill at `skills/changelog/SKILL.md` invoked via `/changelog [range]`.

**First run — format selection:**
1. Ask the user which CHANGELOG format to use:
   - **Conventional Changelog** — groups by commit type (Features, Bug Fixes, etc.). Best if the project uses conventional commits.
   - **Keep a Changelog** — groups by change type (Added, Changed, Fixed, Removed). Works with any commit style.
2. Save the choice to `.claude/rules/documentation-standards.md` under a "CHANGELOG format preference" section
3. On subsequent runs, read the preference and skip the question

**Input resolution:**
1. If range argument given (e.g. `/changelog v0.4..v0.5`) — use that range
2. If no argument — auto-detect from last git tag to HEAD
3. If no tags exist — use all commits

**Process:**
1. Run `git log --format=...` for the determined range
2. Parse commit messages according to the chosen format
3. Group entries by category
4. Format output
5. Present to user for review
6. Prepend to CHANGELOG.md (or create if doesn't exist)

**Conventional Changelog output:**
```
## [version] — YYYY-MM-DD

### Features
- **scope:** description (commit-hash)

### Bug Fixes
- **scope:** description (commit-hash)
```

**Keep a Changelog output:**
```
## [version] — YYYY-MM-DD

### Added
- description

### Fixed
- description
```

## Alternatives Considered

| Alternative                        | Pros                 | Cons                         | Why Rejected                                          |
|------------------------------------|----------------------|------------------------------|-------------------------------------------------------|
| Auto-detect format from rules      | No question needed   | Assumption may be wrong      | Explicit ask is clearer, runs only once               |
| Auto-generate on every PR          | No manual step       | Too aggressive, noisy        | Rule reminds, user decides when to generate           |
| Single skill for README + CHANGELOG | Fewer files         | Different concerns, UX       | README and CHANGELOG are distinct workflows           |
| Separate config file               | Clean separation     | Extra file for one setting   | Rule file already exists, one more section is simpler |

## Risks and Unknowns

- The `readme` wizard generates a starting point — users will customize heavily, so the template should be minimal and not overly opinionated

## Dependencies

- Existing conventional commits convention (from git-workflow rules) — beneficial but not required
- Git tags for `/changelog` range detection
