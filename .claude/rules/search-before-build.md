# Search Before Build

Search the codebase and package registries before writing new code. Reuse what exists instead of reinventing it.

## When Search is Required

- Creating a new utility function, helper, or abstraction
- Solving a common problem (date parsing, validation, HTTP requests, string manipulation, etc.)
- Adding a new dependency or library to the project
- Creating a new module or file that might overlap with existing project code

## When Search is NOT Required

- Modifying or extending existing code (already located)
- Following a spec's task list (search was done during the spec phase)
- One-line fixes with an obvious solution
- Writing tests for existing code
- Working within a file you've already read in this conversation

## How to Search

### Codebase Search

Before creating new code, search the project for existing solutions:

1. Grep for keywords, function names, and class names related to the task
2. Glob for files in likely locations (utils/, helpers/, shared/, lib/, common/)
3. Check if a similar pattern is already used elsewhere in the project

If a match is found, reuse or extend it instead of creating a duplicate.

### Package/Library Search

Before implementing common functionality from scratch:

1. Check if a well-maintained package already solves the problem
2. Consider: maintenance status, popularity, bundle size, license compatibility
3. Prefer established packages over custom implementations for non-core logic
4. Suggest the package to the user with a brief rationale

## Deduplication Awareness

When writing new code, actively watch for duplication:

- Before creating a new function, check if similar logic exists elsewhere in the project
- If overlap is found: reuse the existing code, extend it, or extract a shared utility — do not duplicate
- Flag potential duplication to the user: explain what you found and recommend a path forward
