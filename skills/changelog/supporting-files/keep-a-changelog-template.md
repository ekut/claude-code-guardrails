# Keep a Changelog Format

Group entries by change type following keepachangelog.com conventions.

## Section Order

1. Added — new features
2. Changed — changes in existing functionality
3. Fixed — bug fixes
4. Removed — removed features
5. Deprecated — soon-to-be removed features
6. Security — vulnerability fixes

## Entry Format

```
## [{version}] — {YYYY-MM-DD}

### Added
- {description}

### Fixed
- {description}
```

## Mapping from Conventional Commits

When parsing conventional commits, map types to sections:

| Commit Type | Changelog Section |
|-------------|-------------------|
| `feat`      | Added             |
| `fix`       | Fixed             |
| `refactor`  | Changed           |
| `perf`      | Changed           |
| `docs`      | Changed           |
| `chore`     | (skip)            |
| `ci`        | (skip)            |
| `test`      | (skip)            |
| `style`     | (skip)            |

## Rules

- Omit sections with no entries
- Version comes from the user or from the git tag being created
- Date is the date of generation
