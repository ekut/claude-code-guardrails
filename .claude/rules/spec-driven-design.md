# Specification Driven Design

Write a spec before writing code. Thinking through requirements, design, and tasks up front reduces wasted effort and rework.

## When a Spec is Required

- New features or significant enhancements
- Complex bug fixes that touch multiple files or require design decisions
- Refactors that change architecture or public interfaces
- Any change where the approach isn't immediately obvious

## When a Spec is NOT Required

- Typo fixes, wording changes, comment updates
- Simple config changes (updating a version, toggling a flag)
- One-line bug fixes with an obvious cause and solution
- Single-file refactors that don't change behavior

## How to Check

Before starting implementation of a non-trivial change:

1. Look in `.specs/` for a matching subfolder (e.g. `.specs/0.3-feature-name/`)
2. If no spec exists and the change is non-trivial, suggest running `/spec` to create one
3. Do not block trivial changes — use judgment

## During Implementation

- Reference `tasks.md` to guide implementation order
- Update the spec if the design changes significantly during implementation
- Mark tasks complete in `tasks.md` as they are finished
- If a task turns out to be unnecessary, mark it as skipped with a brief reason
