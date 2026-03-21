# Documentation Standards

Keep documentation in sync with code, maintain a changelog, and format markdown consistently.

## Documentation Sync

When making changes that affect how the project is used or structured, update the relevant documentation:

- **Adding/removing features, skills, agents, or rules** — update the project structure and Current Features sections in README
- **Changing public interfaces or configuration** — update usage instructions and examples
- **Changing installation or setup steps** — update the Installation section

Do not block work — remind clearly and let the user decide when to update docs.

## CHANGELOG Reminders

When committing `feat` or `fix` type changes:

1. Check if CHANGELOG.md exists and has an entry for this change
2. If not, remind the user: "This is a notable change. Consider updating CHANGELOG.md or running `/changelog` to generate entries."
3. Do not auto-generate — the user decides when and how to update the changelog

## Markdown Table Formatting

All markdown tables in `.md` files must have aligned columns before committing:

- Pipe characters (`|`) must be vertically aligned
- Cells must be padded with spaces for readability
- Header separator row (`|---|`) must match column widths

Example of correct formatting:
```
| Column A | Column B | Column C |
|----------|----------|----------|
| value 1  | value 2  | value 3  |
| longer   | short    | medium   |
```

## CHANGELOG Format Preference

Format: conventional-changelog
