#!/usr/bin/env bash
#
# check-secrets.sh — Scan staged git diff for hardcoded secrets.
# Exit with non-zero code if secrets are detected, blocking the commit.
#
# Supports:
#   .secretsignore — list paths/patterns to skip (gitignore syntax)
#   # nosecret     — inline comment to suppress a specific line
#
# Usage (as a git pre-commit hook):
#   ln -sf ../../hooks/check-secrets.sh .git/hooks/pre-commit

set -euo pipefail

# --- Configuration ---

SECRETSIGNORE=".secretsignore"
FOUND=0

# High-confidence secret patterns (extended regex)
PATTERNS=(
  'AKIA[0-9A-Z]{16}'
  '(?i)(aws_secret_access_key|aws_secret)\s*[:=]\s*['\''"][A-Za-z0-9/+=]{40}'
  'ghp_[A-Za-z0-9]{36}'
  'github_pat_[A-Za-z0-9_]{82}'
  'glpat-[A-Za-z0-9\-]{20,}'
  '-----BEGIN (RSA |EC |DSA |OPENSSH )?PRIVATE KEY-----'
  '(?i)(api[_-]?key|apikey|secret[_-]?key|api[_-]?secret)\s*[:=]\s*['\''"][A-Za-z0-9]{16,}'
)

# --- Check for .env files staged ---

ENV_FILES=$(git diff --cached --name-only | grep -E '^\.(env|env\..*)$' || true)
if [[ -n "$ENV_FILES" ]]; then
  echo "ERROR: .env file(s) staged for commit:"
  echo "$ENV_FILES" | sed 's/^/  /'
  echo "  → Remove from staging: git reset HEAD <file>"
  echo "  → Add to .gitignore to prevent future staging"
  FOUND=1
fi

# --- Build exclude args from .secretsignore ---

EXCLUDE_ARGS=""
if [[ -f "$SECRETSIGNORE" ]]; then
  while IFS= read -r line; do
    # Skip empty lines and comments
    [[ -z "$line" || "$line" == \#* ]] && continue
    EXCLUDE_ARGS="$EXCLUDE_ARGS --ignore=$line"
  done < "$SECRETSIGNORE"
fi

# --- Scan staged diff for secret patterns ---

DIFF=$(git diff --cached -U0)

if [[ -z "$DIFF" ]]; then
  exit 0
fi

for pattern in "${PATTERNS[@]}"; do
  # Get added lines only (start with +, not +++)
  MATCHES=$(echo "$DIFF" | grep -P '^\+[^+]' | grep -P "$pattern" | grep -v '# nosecret' || true)

  if [[ -n "$MATCHES" ]]; then
    echo "ERROR: Potential secret detected matching pattern: $pattern"
    echo "$MATCHES" | head -5 | sed 's/^/  /'
    echo ""
    FOUND=1
  fi
done

# --- Result ---

if [[ $FOUND -ne 0 ]]; then
  echo "---"
  echo "Secrets detected in staged changes. Commit blocked."
  echo ""
  echo "To suppress false positives:"
  echo "  • Add '# nosecret' comment to the line"
  echo "  • Add the file path to .secretsignore"
  exit 1
fi

exit 0
