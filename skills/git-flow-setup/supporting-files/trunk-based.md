# Git Workflow Rules: Trunk-Based Development

## Branch Strategy

- `main` is the trunk — the single source of truth
- Use short-lived feature branches (ideally < 1-2 days)
- Direct commits to `main` are OK for trivial changes (typos, small fixes, config)
- Use feature flags for incomplete work that lands on `main`
- Merge or rebase feature branches frequently to avoid drift

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
- Keep commits small and focused — one logical change per commit

## Pull Requests

- PRs are recommended for non-trivial changes
- PR title should follow conventional commit format
- Prefer rebase or squash merge to keep history linear
- Delete the source branch after merge

## Protected Branch Rules

- No force push to `main`

## Delegation

All git write operations (commit, push, branch creation, PR, merge, tag) MUST be delegated to the `git-workflow` agent. Never run git write commands directly from the main agent.
