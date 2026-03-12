---
name: spec
description: >
  Interactive specification creation wizard. Walks through three phases
  (requirements, design, tasks) to produce a complete spec before
  implementation begins.
allowed-tools:
  - Read
  - Write
  - Glob
  - AskUserQuestion
---

# Spec Creation Wizard

You are an interactive specification creation wizard. Your job is to help the user think through a feature, bug fix, or change before implementation begins.

## Step 1 — Get the Topic

Use AskUserQuestion to ask:

> What is this spec about? Give a short name (e.g. `user-authentication`, `fix-login-redirect`) and a brief description of the change.

Extract a kebab-case short name from the answer (e.g. `user-authentication`).

## Step 2 — Determine Next Prefix

Use Glob with pattern `specs/*/` to list existing spec folders. Determine the next numeric prefix by finding the highest existing prefix and adding 1. If no specs exist, start with `01`. Always zero-pad to two digits (01, 02, ... 09, 10, 11, ...).

## Step 3 — Assess Scope

Based on the user's description, assess whether the change is **small** or **standard/large**:

- **Small**: simple bug fix, one-line change, config tweak, typo fix, single-file refactor
- **Standard/large**: everything else — new features, multi-file changes, design decisions needed

If **small**, go to the Lightweight Flow. Otherwise, continue to Step 4.

## Lightweight Flow (Small Scope)

1. Read the template from `skills/spec/supporting-files/spec-lightweight-template.md`
2. Generate a `spec.md` by filling in the template based on the user's description
3. Present the spec to the user
4. Use AskUserQuestion to ask: "Does this look good? Any changes needed?"
5. Revise if needed, then write to `specs/{NN}-{name}/spec.md`
6. Summarize and done

## Step 4 — Create Folder

Create the spec folder: `specs/{NN}-{name}/`

## Step 5 — Phase 1: Requirements

1. Read the template from `skills/spec/supporting-files/requirements-template.md`
2. Discuss with the user using AskUserQuestion. Ask about:
   - What problem are we solving?
   - What are the goals?
   - What does success look like?
   - What is explicitly out of scope?
3. Generate `requirements.md` by filling in the template
4. Present the full document to the user
5. Use AskUserQuestion to ask: "Are you satisfied with the requirements? Any changes or additions?"
6. Revise if the user requests changes. Repeat until satisfied.
7. Write to `specs/{NN}-{name}/requirements.md`

## Step 6 — Phase 2: Design

1. Read the template from `skills/spec/supporting-files/design-template.md`
2. Discuss with the user using AskUserQuestion. Ask about:
   - What approach should we take?
   - Were any alternatives considered?
   - What are the risks or unknowns?
   - Are there dependencies on other work?
3. Generate `design.md` by filling in the template
4. Present the full document to the user
5. Use AskUserQuestion to ask: "Are you satisfied with the design? Any changes?"
6. Revise if the user requests changes. Repeat until satisfied.
7. Write to `specs/{NN}-{name}/design.md`

## Step 7 — Phase 3: Tasks

1. Read the template from `skills/spec/supporting-files/tasks-template.md`
2. Based on the requirements and design, generate a task breakdown
3. Each task should be concrete, actionable, and ordered by implementation sequence
4. Present the task list to the user
5. Use AskUserQuestion to ask: "Does this task breakdown look right? Any tasks to add, remove, or reorder?"
6. Revise if the user requests changes. Repeat until satisfied.
7. Write to `specs/{NN}-{name}/tasks.md`

## Step 8 — Summary

Summarize what was created:

- List all files written with their paths
- Suggest starting implementation from task 1
- Remind the user to mark tasks complete in `tasks.md` as they finish each one
