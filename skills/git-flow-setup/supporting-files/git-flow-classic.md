# Git Workflow Rules: Git Flow Classic

## Branch Strategy

- `main` — production-ready code, tagged with version numbers
- `develop` — integration branch for features
- `feature/*` — branch from `develop`, merge back to `develop`
- `release/*` — branch from `develop` for release prep, merge to both `main` and `develop`
- `hotfix/*` — branch from `main` for urgent fixes, merge to both `main` and `develop`

## Branch Naming

Feature branches: `feature/short-description`
Release branches: `release/vX.Y.Z`
Hotfix branches: `hotfix/short-description`

Examples:
- `feature/user-authentication`
- `release/v1.2.0`
- `hotfix/fix-login-crash`

## Commits

Use conventional commits format:

```
type(scope): description
```

- Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`, `style`, `perf`, `build`
- Scope is optional but encouraged
- Description: lowercase, imperative mood, no trailing period
- Keep subject line under 72 characters

## Pull Requests

- All merges require a PR — no direct merges
- PR title should follow conventional commit format
- Use merge commits (no squash) to preserve branch history
- Delete the source branch after merge

## Releases

- Create a `release/*` branch when `develop` is ready for release
- Only bug fixes and release prep (version bumps, changelog) go on release branches
- After merging release to `main`, tag it: `vX.Y.Z`
- Merge release back to `develop` as well

## Protected Branch Rules

- No force push to `main` or `develop`
- No direct commits to `main` — only merges from `release/*` or `hotfix/*`

## Tag Format

{tag-format-section}

## Delegation

All git write operations (commit, push, branch creation, PR, merge, tag) MUST be delegated to the `git-workflow` agent. Never run git write commands directly from the main agent.
