# Git Workflow Rules: GitHub Flow

## Branch Strategy

- The `main` branch is always deployable
- Branch from `main` for all changes
- No direct commits to `main` — all changes go through pull requests
- Delete branches after merging

## Branch Naming

Format: `type/short-description`

Examples:
- `feat/user-authentication`
- `fix/login-redirect`
- `docs/api-reference`
- `chore/update-dependencies`

Allowed types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`, `style`, `perf`, `build`

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

- Every change to `main` requires a PR
- PR title should follow conventional commit format
- Use squash merge to keep `main` history clean
- Delete the source branch after merge

## Protected Branch Rules

- No force push to `main`
- No direct commits to `main`

## Tag Format

{tag-format-section}

## Delegation

All git write operations (commit, push, branch creation, PR, merge, tag) MUST be delegated to the `git-workflow` agent. Never run git write commands directly from the main agent.
