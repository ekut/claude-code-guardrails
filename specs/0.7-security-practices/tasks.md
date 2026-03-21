# Tasks: Security Practices

## Task List

1. [x] Create `security-practices` rule — wrote `.claude/rules/security-practices.md` with secrets prevention (file patterns, diff scanning, suppression) and dependency audit reminders (auto-discover table)
2. [x] Create secrets detection hook — wrote `hooks/check-secrets.sh` with high-confidence secret patterns, `.secretsignore` support, and `# nosecret` inline suppression
3. [x] Document hook configuration — wrote `hooks/README.md` explaining Claude Code settings and git pre-commit hook installation
4. [x] Create `security-audit` skill — wrote `skills/security-audit/SKILL.md` with secrets scan, dependency audit (auto-discover + graceful degradation), and structured report
5. [x] Expand review checklist — added 6 new security checks to `skills/review-pr/supporting-files/review-checklist.md`
6. [x] Dogfooding — pre-commit hook ran successfully on commit, `/review-pr 10` caught .secretsignore bug which was fixed, checklist expansion verified
7. [x] Update documentation — updated README (Current Features, project structure, usage examples) and ROADMAP.md (marked v0.7 as Done)

## Definition of Done

- [x] All success criteria from requirements are met
- [x] Documentation updated
