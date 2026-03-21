# Hooks

This directory contains hook scripts for the claude-code-guardrails plugin.

## check-secrets.sh

Scans staged git diffs for hardcoded secrets before each commit. Blocks the commit if secrets are detected.

### Detected Patterns

- AWS access keys (`AKIA...`)
- AWS secret keys
- GitHub tokens (`ghp_`, `github_pat_`)
- GitLab tokens (`glpat-`)
- Private keys (`-----BEGIN ... PRIVATE KEY-----`)
- Generic API key assignments (`api_key=`, `secret_key=`, etc.)
- `.env` files staged for commit

### Installation

**As a git pre-commit hook** (recommended):

Create a symlink so the hook stays in sync with updates:

```bash
ln -sf ../../hooks/check-secrets.sh .git/hooks/pre-commit
```

Or copy if you prefer:

```bash
cp hooks/check-secrets.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

This runs at the git level, catching all commits regardless of whether they come from Claude Code, the CLI, or a GUI client.

### Suppressing False Positives

**Per-line suppression** — add `# nosecret` to any line containing a test/example key:

```python
EXAMPLE_KEY = "AKIAIOSFODNN7EXAMPLE"  # nosecret
```

**Per-file/path suppression** — create a `.secretsignore` file in the project root (same syntax as `.gitignore`):

```
tests/fixtures/*
docs/examples/fake-credentials.json
```
