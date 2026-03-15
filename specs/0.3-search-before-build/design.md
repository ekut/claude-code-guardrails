# Design: Search Before Build

## Overview

A single rule file `.claude/rules/search-before-build.md` that instructs Claude to search the codebase and consider existing packages before writing new code. The rule follows the same structure as existing rules (H1 title, H2 sections with when/when-not applicability, actionable steps). No agents or skills needed — this is a passive always-on constraint.

## Detailed Design

The rule file has five sections:

1. **Opening** — one sentence explaining the principle
2. **When Search is Required** — triggers: new utilities/helpers, common problem solving, adding dependencies, creating modules that might overlap
3. **When Search is NOT Required** — exceptions: modifying existing code, following a spec task list, obvious one-line fixes, writing tests
4. **How to Search** — two subsections:
   - *Codebase Search*: grep for keywords/function names, glob for likely file locations, check existing utils/shared modules
   - *Package/Library Search*: check registries before implementing common functionality, consider maintenance/popularity/license
5. **Deduplication Awareness** — check for similar logic before creating new functions, prefer reuse/extraction over duplication, flag overlaps to user

Tone and format match existing rules: imperative mood, concise bullets, practical guidance.

## Alternatives Considered

| Alternative                          | Pros                      | Cons                                    | Why Rejected                                       |
|--------------------------------------|---------------------------|-----------------------------------------|----------------------------------------------------|
| Multiple rule files (one per aspect) | Finer granularity         | Overhead for 3 small, related concerns  | One practice = one file (matches existing pattern) |
| Skill instead of rule               | Interactive, more control | Overkill for passive guidance           | No user interaction needed, rule is sufficient     |
| Hook-based enforcement              | Hard enforcement          | Hooks not yet implemented (v0.7+)       | Out of scope for v0.3                              |

## Risks and Unknowns

- Rule effectiveness depends on Claude's compliance — rules are guidance, not enforcement. Mitigation: clear, specific instructions with concrete steps.
- Overly aggressive triggering could slow down work on trivial changes. Mitigation: explicit "when NOT required" section.

## Dependencies

- None — rules are standalone files loaded by Claude Code automatically
