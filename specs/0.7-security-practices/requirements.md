# Requirements: Security Practices

## Problem Statement

Security issues caught late are expensive to fix. Secrets accidentally committed to repositories can be exploited within minutes. Vulnerable dependencies silently accumulate risk. Currently the plugin has only a basic security section in the review checklist, with no proactive detection or automated checks.

## Goals

- Prevent secrets (API keys, tokens, credentials, private keys) from being committed — via both a rule for Claude and a hook as a safety net
- Remind to audit dependencies for known vulnerabilities when dependencies are added or updated, with language-agnostic auto-discovery
- Expand the security section in the review checklist with more detailed checks
- Provide a `/security-audit` skill for on-demand dependency and secrets scanning

## Success Criteria

- [ ] A `security-practices` rule prevents Claude from committing secrets and reminds to audit dependencies
- [ ] A secrets detection hook script scans staged diffs for common secret patterns before commit
- [ ] The hook configuration is documented for users to install in their projects
- [ ] A `security-audit` skill runs dependency audit (auto-discovers stack) and secrets scan on demand
- [ ] The review checklist Security section is expanded with OWASP-informed checks
- [ ] Plugin dogfooding: all components work on this repository itself

## Out of Scope

- Static/dynamic application security testing tools (code scanners, vulnerability scanners)
- Container image scanning
- Integration with external security services (Snyk, Dependabot, etc.)
- Automatic vulnerability remediation
- Security policy enforcement beyond the scope of this plugin
