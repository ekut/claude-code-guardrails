# Requirements: Documentation Standards

## Problem Statement

Documentation drifts out of sync with code over time. READMEs become outdated, changelogs are forgotten, and markdown formatting is inconsistent. Currently the plugin has no rules or tools to enforce documentation quality.

## Goals

- Provide a README generation wizard for new projects with a structured template
- Prompt for CHANGELOG updates on notable changes (feat, fix) and offer a skill to generate entries from git history
- Enforce documentation sync — remind to update docs when public interfaces or project structure change
- Enforce markdown table formatting (aligned columns) before commits

## Success Criteria

- [ ] A `readme` skill generates a README via interactive wizard
- [ ] A `changelog` skill generates CHANGELOG entries from git log between versions
- [ ] A `documentation-standards` rule enforces: docs sync with code, CHANGELOG updates on feat/fix, markdown table alignment
- [ ] README template is stored in `skills/readme/supporting-files/`
- [ ] Plugin dogfooding: all components work on this repository itself

## Out of Scope

- API documentation generation (JSDoc, Sphinx, etc.)
- Markdown linters (deferred to v0.8 — CI/CD & pre-commit hooks)
- Automated documentation publishing (GitHub Pages, ReadTheDocs)
- Inline code comment enforcement
