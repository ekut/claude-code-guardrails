# Conventional Changelog Format

Group entries by conventional commit type. Only include sections that have entries.

## Section Order

1. Features (`feat`)
2. Bug Fixes (`fix`)
3. Performance (`perf`)
4. Refactoring (`refactor`)
5. Documentation (`docs`)
6. Other (any remaining types: `chore`, `ci`, `test`, `style`, `build`)

## Entry Format

```
## [{version}] — {YYYY-MM-DD}

### Features
- **{scope}:** {description} ({short-hash})

### Bug Fixes
- **{scope}:** {description} ({short-hash})
```

## Rules

- Omit sections with no entries
- If commit has no scope, omit the bold prefix: `- {description} ({short-hash})`
- Use short commit hash (7 characters)
- Version comes from the user or from the git tag being created
- Date is the date of generation
