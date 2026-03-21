# Tasks: Documentation Standards

## Task List

1. [ ] Create `documentation-standards` rule — write `.claude/rules/documentation-standards.md` with docs sync reminders, CHANGELOG prompts on feat/fix, and markdown table alignment requirement
2. [ ] Create README template — write `skills/readme/supporting-files/readme-template.md` with standard sections (Title, Description, Installation, Usage, Contributing, License)
3. [ ] Create `readme` skill — write `skills/readme/SKILL.md` with interactive wizard that asks project details and generates README from template
4. [ ] Create CHANGELOG templates — write `skills/changelog/supporting-files/conventional-changelog-template.md` and `keep-a-changelog-template.md`
5. [ ] Create `changelog` skill — write `skills/changelog/SKILL.md` with format selection on first run (saved to rule), range detection from git tags, commit parsing, and CHANGELOG generation
6. [ ] Dogfooding — test all components on this repository: run `/readme` (verify output), run `/changelog` (verify generation from our git history), verify table formatting rule
7. [ ] Update documentation — update README (Current Features, project structure) and ROADMAP.md (mark v0.6 as Done)

## Definition of Done

- [ ] All success criteria from requirements are met
- [ ] Documentation updated
