# Tasks: Security Practices

## Task List

1. [ ] Create `security-practices` rule — write `.claude/rules/security-practices.md` with secrets prevention (file patterns, diff scanning) and dependency audit reminders (auto-discover table)
2. [ ] Create secrets detection hook — write `hooks/check-secrets.sh` with high-confidence secret patterns, `.secretsignore` support, and `# nosecret` inline suppression
3. [ ] Document hook configuration — write `hooks/README.md` explaining how to register the hook in Claude Code settings
4. [ ] Create `security-audit` skill — write `skills/security-audit/SKILL.md` with secrets scan, dependency audit (auto-discover + graceful degradation), and structured report
5. [ ] Expand review checklist — add new security checks to `skills/review-pr/supporting-files/review-checklist.md`
6. [ ] Dogfooding — test all components on this repository: run `/security-audit`, verify hook blocks a test secret, verify checklist expansion
7. [ ] Update documentation — update README (Current Features, project structure) and ROADMAP.md (mark v0.7 as Done)

## Definition of Done

- [ ] All success criteria from requirements are met
- [ ] Documentation updated
