# Design: Security Practices

## Overview

v0.7 adds four components: (1) a `security-practices` rule preventing secrets commits and reminding about dependency audits, (2) a Claude Code hook that scans staged diffs for secret patterns before each commit, (3) a `security-audit` skill for on-demand scanning, and (4) an expanded security section in the review checklist.

## Detailed Design

### 1. Rule: `security-practices.md`

A new rule in `.claude/rules/security-practices.md` with two concerns:

**Secrets prevention:**
- Never commit files that commonly contain secrets: `.env`, `.env.*`, `credentials.json`, `*-key.pem`, `*.p12`, etc.
- Before staging files, check if any match known secret-containing patterns
- Scan diff content for hardcoded secrets (API keys, tokens, passwords)
- If a potential secret is detected, warn the user and suggest using environment variables or a secrets manager

**Dependency audit reminders:**
- When adding or updating dependencies (changes to `package.json`, `requirements.txt`, `Cargo.toml`, `go.mod`, `build.gradle`, `pom.xml`, `Gemfile`, etc.), remind the user to run a security audit
- Auto-discover the audit command based on project files:

| File                                   | Audit Command                |
|----------------------------------------|------------------------------|
| `package.json`                         | `npm audit`                  |
| `requirements.txt` / `pyproject.toml`  | `pip audit`                  |
| `Cargo.toml`                           | `cargo audit`                |
| `go.mod`                               | `govulncheck ./...`          |
| `Gemfile`                              | `bundle audit`               |
| `pom.xml`                              | `mvn dependency-check:check` |

- Suggest running `/security-audit` for a comprehensive check

### 2. Hook: secrets detection

A Claude Code hook configured in the plugin that runs before each commit.

**Hook script** (`hooks/check-secrets.sh`):
- Scans staged diff (`git diff --cached`) for secret patterns
- Exits with non-zero code if secrets are detected, blocking the commit
- Outputs which file and line contains the potential secret

**Secret patterns** (high-confidence only, no high-entropy detection):
- AWS access keys: `AKIA[0-9A-Z]{16}`
- AWS secret keys: strings following `aws_secret_access_key` or `AWS_SECRET_ACCESS_KEY`
- GitHub tokens: `ghp_[A-Za-z0-9]{36}`, `github_pat_[A-Za-z0-9_]{82}`
- GitLab tokens: `glpat-[A-Za-z0-9\-]{20}`
- Private keys: `-----BEGIN (RSA |EC |DSA |OPENSSH )?PRIVATE KEY-----`
- Generic API keys: `(?i)(api[_-]?key|apikey|secret[_-]?key)\s*[:=]\s*['\"][A-Za-z0-9]{16,}`
- `.env` files staged for commit

**False positive suppression:**
- **`.secretsignore`** — a file in the project root listing paths/patterns to skip (same syntax as `.gitignore`). Example: `tests/fixtures/*`, `docs/examples/fake-key.txt`
- **`# nosecret`** — inline comment on a line suppresses the check for that line. Useful for documentation or test fixtures containing example keys.
- The hook skips files matching `.secretsignore` patterns and lines containing `# nosecret` before applying pattern checks.

**Hook configuration** (for plugin users):
- The hook script lives in `hooks/check-secrets.sh`
- Documentation explains how to register it in Claude Code settings
- Users can customize patterns by editing the script

### 3. Skill: `security-audit`

A new skill at `skills/security-audit/SKILL.md` invoked via `/security-audit`.

**Process:**
1. **Secrets scan** — scan the project for committed secrets:
   - Run `grep -rn` with secret patterns across the codebase (excluding `.git/`, `node_modules/`, `venv/`, etc.)
   - Respect `.secretsignore` and `# nosecret` suppression
   - Report any findings with file and line number
2. **Dependency audit** — auto-discover stack and run audit:
   - Check for dependency files (`package.json`, `requirements.txt`, etc.)
   - Verify the audit tool is installed (`command -v npm`, `command -v pip-audit`, etc.)
   - If the tool is not installed, report it and suggest the install command (e.g. `pip install pip-audit`)
   - If installed, run the audit and parse results (critical/high/medium/low counts)
   - If no dependency files are detected, skip and report "No dependency files found"
3. **Report** — output structured results

**Output format:**
```
## Security Audit

### Secrets Scan
{findings or "No secrets detected"}

### Dependency Audit
{tool}: {summary of vulnerabilities found}
{or "Tool not installed — run `pip install pip-audit` to enable"}
{or "No dependency files detected — skipping"}

### Recommendations
{actionable next steps}
```

### 4. Review Checklist Expansion

Expand the Security section in `skills/review-pr/supporting-files/review-checklist.md`:

Current checks:
- No hardcoded secrets, API keys, or credentials
- User input is validated and sanitized
- No injection vulnerabilities (SQL, command, XSS)
- Authentication and authorization checks are correct
- Sensitive data is not logged or exposed

New checks to add:
- No `.env` or credentials files included in the diff
- Dependencies added/updated have been audited for vulnerabilities
- Cryptographic operations use established libraries, not custom implementations
- Error messages do not leak internal details (stack traces, paths, versions)
- HTTPS/TLS is used for all external communication
- Access controls follow the principle of least privilege

## Alternatives Considered

| Alternative                    | Pros                   | Cons                              | Why Rejected                                        |
|--------------------------------|------------------------|-----------------------------------|-----------------------------------------------------|
| Git pre-commit hook only       | Works without Claude   | Requires separate install         | Claude Code hook is simpler for plugin users         |
| External tools (gitleaks, etc.)| More thorough          | External dependency               | We stay dependency-free; users can add tools on top  |
| Rule only, no hook             | Simplest               | No automated safety net           | Hook catches what Claude misses                      |
| High-entropy string detection  | Catches unknown formats | Very noisy, many false positives | Focus on high-confidence patterns; recommend gitleaks for deeper scanning |

## Risks and Unknowns

All identified risks have been addressed in the design:

- ~~False positives~~ → `.secretsignore` file and `# nosecret` inline suppression
- ~~High-entropy detection noise~~ → removed; only high-confidence explicit patterns
- ~~Missing audit tools~~ → graceful degradation with install suggestions

## Dependencies

- Claude Code hooks system (for the commit hook)
- Language-specific audit tools must be installed by the user (npm, pip-audit, cargo-audit, etc.)
