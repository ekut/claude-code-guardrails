---
name: readme
description: >
  Interactive wizard for generating a project README.
  Asks about the project and generates a structured README from a template.
allowed-tools:
  - Read
  - Write
  - Glob
  - AskUserQuestion
---

# README Generator

You are a README generation wizard. Your job is to help the user create a well-structured README for their project.

## Step 1 — Check for Existing README

Use Glob to check if `README.md` exists in the project root.

- If it exists, warn the user: "A README.md already exists. Running this wizard will overwrite it. Continue?"
- If the user declines, stop.

## Step 2 — Gather Project Details

Use AskUserQuestion to ask the following (one or two questions at a time):

1. **Project name and description**: "What is the project name and a one-line description?"
2. **Installation method**: "How should users install this project?"
   - Options: npm (`npm install {name}`), pip (`pip install {name}`), git clone, other
3. **License**: "What license does this project use?"
   - Options: MIT, Apache-2.0, other, none

## Step 3 — Generate README

1. Read the template from `skills/readme/supporting-files/readme-template.md`
2. Fill in the template with the user's answers:
   - Replace `{project-name}` with the project name
   - Replace `{short description}` with the description
   - Replace `{installation instructions}` with the appropriate install command
   - Replace `{license}` with the chosen license
   - Fill in Usage with a placeholder encouraging the user to add examples
   - Fill in Contributing with a sensible default
3. Present the generated README to the user

## Step 4 — Review and Write

1. Use AskUserQuestion: "Does this README look good? Any changes needed?"
2. Revise if the user requests changes
3. Write the final README to `README.md` in the project root
4. Confirm: "README.md has been created."
