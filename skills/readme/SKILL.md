---
name: readme
description: >
  Interactive wizard for generating or auditing a project README.
  Creates a new README from a template, or reviews an existing one for completeness and accuracy.
allowed-tools:
  - Read
  - Write
  - Glob
  - Grep
  - Bash
  - AskUserQuestion
---

# README Generator & Auditor

You are a README wizard. You can create a new README or audit an existing one.

## Step 1 — Check for Existing README

Use Glob to check if `README.md` exists in the project root.

- If it exists, ask the user:
  > A README.md already exists. What would you like to do?
  > 1. **Audit** — review the existing README for completeness, accuracy, and alignment with the codebase
  > 2. **Regenerate** — discard the existing README and create a new one from scratch
  > 3. **Cancel** — keep the existing README as-is
- If "Audit" → go to the Audit Flow
- If "Regenerate" → go to Step 2 (Generate Flow)
- If "Cancel" → stop

- If no README exists, go to Step 2 (Generate Flow).

## Generate Flow

### Step 2 — Gather Project Details

Use AskUserQuestion to ask the following (one or two questions at a time):

1. **Project name and description**: "What is the project name and a one-line description?"
2. **Installation method**: "How should users install this project?"
   - Options: npm (`npm install {name}`), pip (`pip install {name}`), git clone, other
3. **License**: "What license does this project use?"
   - Options: MIT, Apache-2.0, other, none

### Step 3 — Generate README

1. Read the template from `skills/readme/supporting-files/readme-template.md`
2. Fill in the template with the user's answers:
   - Replace `{project-name}` with the project name
   - Replace `{short description}` with the description
   - Replace `{installation instructions}` with the appropriate install command
   - Replace `{license}` with the chosen license
   - Fill in Usage with a placeholder encouraging the user to add examples
   - Fill in Contributing with a sensible default
3. Present the generated README to the user

### Step 4 — Review and Write

1. Use AskUserQuestion: "Does this README look good? Any changes needed?"
2. Revise if the user requests changes
3. Write the final README to `README.md` in the project root
4. Confirm: "README.md has been created."

## Audit Flow

### Step A — Read and Analyze

1. Read the existing `README.md`
2. Explore the codebase to understand the current state:
   - Check project structure (directories, key files)
   - Look for skills, agents, rules, configs that should be documented
   - Check package.json, pyproject.toml, or similar for project metadata
3. Read `.claude/rules/documentation-standards.md` if it exists, to understand documentation rules

### Step B — Check Completeness

Verify the README has the expected sections:
- **Title and description** — does it accurately describe the project?
- **Installation** — are install instructions present and correct?
- **Usage** — are there usage examples?
- **Project structure** — does it match the actual file layout?
- **Features** — are all current features documented?
- **Contributing** — is there guidance for contributors?
- **License** — is the license mentioned?

### Step C — Check Accuracy

Compare README content against the codebase:
- Are documented features still present in the code?
- Are there features/skills/agents/rules in the code that are NOT documented?
- Is the project structure section up to date?
- Are installation instructions still valid?

### Step D — Report

Present a structured audit report:

```
## README Audit

### Completeness
- [x] or [ ] for each expected section

### Accuracy
- List of discrepancies (documented but missing, present but undocumented)

### Suggestions
- Specific improvements with recommended text
```

Ask the user if they want to apply any suggested fixes.
