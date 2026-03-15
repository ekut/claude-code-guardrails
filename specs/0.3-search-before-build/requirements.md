# Requirements: Search Before Build

## Problem Statement

AI coding assistants (and developers) often reinvent what already exists — writing a utility that's already in the codebase, or implementing functionality that a well-maintained package handles. This wastes time and increases maintenance burden. There is no mechanism in the plugin to nudge Claude toward searching before writing new code.

## Goals

- Enforce codebase search before creating new utilities, helpers, or abstractions
- Encourage package/library search for common problems instead of custom implementations
- Flag duplication when new code overlaps with existing code in the project

## Success Criteria

- [ ] Claude searches the codebase (grep/glob) before creating new utilities or helpers
- [ ] Claude suggests established packages instead of reimplementing common functionality
- [ ] Claude warns the user when new code appears to duplicate existing project code
- [ ] The rule does not trigger on trivial changes or modifications to existing code
- [ ] The rule works on any project regardless of programming language

## Out of Scope

- Automated enforcement via hooks (planned for later milestones)
- Dependency vulnerability scanning (v0.7 — Security Practices)
- Package version management or lockfile handling

## Open Questions

- None
