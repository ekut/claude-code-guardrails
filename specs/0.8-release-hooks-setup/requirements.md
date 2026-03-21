# Requirements: Release & Hooks Setup

## Problem Statement

Releasing a new version involves multiple manual steps — choosing a version number, creating a tag, updating the changelog, publishing a release on the hosting platform. Each step is error-prone when done by hand. Similarly, installing plugin hooks requires manual symlink creation, and teams have no easy way to discover or manage available hooks.

## Goals

- Automate the release process with an interactive wizard that handles semver bumping, CHANGELOG update, git tagging, and optional hosting release creation
- Auto-detect the hosting platform from origin URL (GitHub, GitLab) and offer platform-specific release creation when the CLI is available
- Provide a hooks discovery and installation skill that helps teams set up plugin hooks with minimal friction
- Remain language-agnostic — release and hooks workflows should work for any project

## Success Criteria

- [ ] A `release` skill walks through the full release cycle: version bump, CHANGELOG update (via `/changelog`), git tag, push
- [ ] `/release` asks the user for bump type (major/minor/patch) or accepts explicit version
- [ ] `/release` auto-detects hosting from origin URL and offers platform release (GitHub via `gh`, GitLab via `glab`)
- [ ] `/release` gracefully handles missing CLI tools (suggests install) and unsupported platforms (tag pushed, create release manually)
- [ ] A `hooks-setup` skill discovers available hooks in `hooks/`, shows their status (installed/not installed), and installs via symlinks
- [ ] `/hooks-setup` detects existing git hooks and warns before overwriting
- [ ] Plugin dogfooding: all components work on this repository itself

## Out of Scope

- CI/CD template generation
- Language-specific linters or formatters
- Package publishing (npm publish, pypi upload, etc.)
- Automatic release on merge (release is always user-initiated)
- Managing third-party hook frameworks (husky, lefthook, pre-commit)
- Bitbucket and AWS CodeCommit release creation (may be added later based on demand)
