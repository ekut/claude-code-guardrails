---
name: security-audit
description: >
  Run an on-demand security audit: scan for hardcoded secrets and audit dependencies for known vulnerabilities.
  Auto-discovers the project stack and handles missing tools gracefully.
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
---

# Security Audit

You are a security audit assistant. Your job is to scan the project for secrets and vulnerable dependencies, then output a structured report.

## Step 1 — Secrets Scan

Scan the project for hardcoded secrets in tracked files.

1. Read `.secretsignore` if it exists — these paths should be excluded from scanning
2. Run `git ls-files` to get the list of tracked files (excludes `.git/`, respects `.gitignore`)
3. For each secret pattern below, search tracked files using `grep -rn -P`:
   - AWS access keys: `AKIA[0-9A-Z]{16}`
   - AWS secret keys: `(?i)(aws_secret_access_key|aws_secret)\s*[:=]`
   - GitHub tokens: `ghp_[A-Za-z0-9]{36}` or `github_pat_`
   - GitLab tokens: `glpat-[A-Za-z0-9\-]{20,}`
   - Private keys: `-----BEGIN.*PRIVATE KEY-----`
   - Generic API keys: `(?i)(api[_-]?key|apikey|secret[_-]?key|api[_-]?secret)\s*[:=]\s*['"][A-Za-z0-9]{16,}`
4. Filter out:
   - Lines containing `# nosecret`
   - Files matching `.secretsignore` patterns
   - Files in this skill's own definition and the hook script (they document the patterns)
5. Collect findings with file path and line number

## Step 2 — Dependency Audit

Auto-discover the project stack and run the appropriate audit tool.

Check for these files and run the corresponding command:

| File                                  | Tool Check             | Audit Command                |
|---------------------------------------|------------------------|------------------------------|
| `package.json`                        | `command -v npm`       | `npm audit --json`           |
| `requirements.txt` / `pyproject.toml` | `command -v pip-audit` | `pip-audit`                  |
| `Cargo.toml`                          | `command -v cargo-audit` | `cargo audit`              |
| `go.mod`                              | `command -v govulncheck` | `govulncheck ./...`        |
| `Gemfile`                             | `command -v bundle-audit` | `bundle audit`             |

For each detected dependency file:
1. Check if the audit tool is installed
2. If installed — run the audit, parse output, count vulnerabilities by severity
3. If not installed — report: "Tool `{name}` not installed. Install with: `{install command}`"
4. If no dependency files found — report: "No dependency files detected — skipping"

Install suggestions:

| Tool           | Install Command                |
|----------------|--------------------------------|
| `pip-audit`    | `pip install pip-audit`        |
| `cargo-audit`  | `cargo install cargo-audit`    |
| `govulncheck`  | `go install golang.org/x/vuln/cmd/govulncheck@latest` |
| `bundle-audit` | `gem install bundler-audit`    |

## Step 3 — Report

Output a structured report:

```
## Security Audit

### Secrets Scan
{list of findings with file:line, or "No secrets detected"}

### Dependency Audit
{for each stack: tool output summary, or "not installed" message}
{or "No dependency files detected — skipping"}

### Recommendations
{actionable next steps based on findings}
```

If no issues found in either category, end with: "No security issues detected."
