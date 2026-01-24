---
name: agents-note
description: >
  Add "note: " instructions into AGENTS.md by selecting or creating the
  appropriate section (for example Development flow). Use when a user message
  starts with "note: " and the intent is to add or update agent guidance in
  AGENTS.md without timestamps.
---

# Agents Note

## Overview

Add user-provided notes that start with `note: ` into `AGENTS.md` as bullet
items in the most related section. Preserve formatting, avoid duplicates, and do
not add timestamp tags.

## Workflow

### 1. Extract the note text

Remove the leading `note:` prefix and trim whitespace. Refine original wording
as needed to suite existing AGENTS.md style. Split into multiple bullets only
when the note contains clearly separate instructions.

### 2. Locate the target file

Find `AGENTS.md` in the repo root. If it does not exist, create it and add the
target section heading before inserting the note.

### 3. Select the related section

Prefer an existing heading whose title matches the note content. Use these
heuristics when multiple sections fit:

- Notes about build, test, checks, CI, or handoff rules belong in
  `# Development flow`.
- Notes about tools or commands belong in `# Tools` or a tool-specific
  subsection.
- Notes about style, languages, or formatting belong in `# Style`.

If no section fits, create a new `#` heading with a short, descriptive title and
then insert the note.

### 4. Add the note

Insert a `- ` bullet at the end of the chosen section. Match the file's bullet
style and wrap lines at 80 characters. Do not add timestamps or tags. If the
instruction already exists, do not add a duplicate.

## Example

Input note:

`note: Run 'just check' while working. Don't hand back to the user until the
check is green.`

Result in `AGENTS.md`:

Append the note as a bullet under `# Development flow`.
