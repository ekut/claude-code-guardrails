# Security Practices

Prevent secrets from being committed and ensure dependencies are audited for vulnerabilities.

## Secrets Prevention

### Dangerous File Patterns

Never stage or commit files that commonly contain secrets:

- `.env`, `.env.*` (environment variables)
- `credentials.json`, `service-account.json` (cloud credentials)
- `*-key.pem`, `*.p12`, `*.pfx`, `*.key` (private keys and certificates)
- `id_rsa`, `id_ed25519`, `id_ecdsa` (SSH keys)
- `.htpasswd`, `.netrc` (authentication files)

If any of these files appear in `git status`, warn the user and suggest adding them to `.gitignore`.

### Diff Scanning

Before committing, scan the staged diff for hardcoded secrets. Watch for these high-confidence patterns:

- AWS access keys: `AKIA` followed by 16 uppercase alphanumeric characters
- GitHub tokens: `ghp_`, `github_pat_`
- GitLab tokens: `glpat-`
- Private key headers: `-----BEGIN ... PRIVATE KEY-----`
- Generic API key assignments: `api_key`, `apikey`, `secret_key` followed by `=` or `:` and a quoted string

If a potential secret is found:
1. Warn the user with the file and line
2. Suggest using environment variables or a secrets manager
3. Do not proceed with the commit until the user confirms it is safe (e.g. a test fixture with `# nosecret`)

### Suppression

- Lines containing `# nosecret` are intentionally excluded from secret detection
- Files listed in `.secretsignore` (project root) are skipped entirely

## Dependency Audit Reminders

When changes touch dependency files, remind the user to run a security audit:

| Dependency File                        | Audit Command                |
|----------------------------------------|------------------------------|
| `package.json` / `package-lock.json`   | `npm audit`                  |
| `requirements.txt` / `pyproject.toml`  | `pip audit`                  |
| `Cargo.toml` / `Cargo.lock`           | `cargo audit`                |
| `go.mod` / `go.sum`                   | `govulncheck ./...`          |
| `Gemfile` / `Gemfile.lock`            | `bundle audit`               |
| `pom.xml`                             | `mvn dependency-check:check` |

Suggest running `/security-audit` for a comprehensive check.

Do not block work — warn clearly and let the user decide.
