# Review Checklist

Use this checklist to evaluate code changes. For each category, note specific findings or confirm no issues found.

## Correctness

- Does the logic match the stated intent?
- Are edge cases handled (null, empty, boundary values)?
- Are error paths handled appropriately?
- Could any change break existing behavior?

## Tests

- Are new/changed code paths covered by tests?
- Do tests verify behavior, not implementation details?
- Are regression tests added for bug fixes?
- Do existing tests still pass with these changes?

## Security

- No hardcoded secrets, API keys, or credentials
- No `.env` or credentials files included in the diff
- User input is validated and sanitized
- No injection vulnerabilities (SQL, command, XSS)
- Authentication and authorization checks are correct
- Sensitive data is not logged or exposed
- Dependencies added/updated have been audited for vulnerabilities
- Cryptographic operations use established libraries, not custom implementations
- Error messages do not leak internal details (stack traces, paths, versions)
- HTTPS/TLS is used for all external communication
- Access controls follow the principle of least privilege

## Readability

- Are names (variables, functions, files) clear and consistent?
- Is complex logic explained with comments where needed?
- Is code structure easy to follow?
- Are there unnecessary changes (formatting-only, unrelated refactors)?
