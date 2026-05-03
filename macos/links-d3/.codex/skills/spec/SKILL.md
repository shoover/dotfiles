---
name: spec
description: >
  Write a concise implementation or product spec file from a developer,
  agent, or design discussion. Use when the user asks to write, draft,
  consolidate, capture, or update a spec, especially after conversational
  diagnosis, planning, architecture tradeoffs, or multi-agent discussion.

---

# Spec

## Overview

Consolidate relevant parts of the discussion into a spec file that can guide
implementation. Preserve decisions, uncertainty, tradeoffs, and scope; remove
chat transcript noise, false starts, and redundant narration.

## Workflow

1. Identify the spec destination.
   - Use the file path the user provides.
   - If updating an existing spec, preserve its intent and improve it in place.
   - If no path is provided, follow the repo's spec convention when one is
     obvious. Otherwise ask for the destination instead of inventing one.

2. Gather only relevant context.
   - Use the current discussion as the primary source.
   - Inspect nearby code, docs, issues, or prior specs only when needed to make
     the spec concrete.
   - Treat unresolved disagreements as open decisions, not as settled facts.

3. Write for implementation.
   - Prefer succinct, pointed wording over transcript-style completeness.
   - Use concrete names for components, states, commands, and affected flows.
   - Fail fast on unknowns that change the design materially; do not paper over
     uncertainty with generic fallback language.
   - Keep markdown wrapped consistently with the repository style.

## Required Shape

Use these sections unless the repo has a stronger existing spec format.

### Description

Write one sentence to one paragraph describing the situation. Explain what the
user is experiencing, what is missing, or what context created the need for the
work.

### Problem

Define scope. Depending on the request, frame this as bug diagnosis, product
goals, technical goals, or constraints. Make clear what is in scope and what is
out of scope when that boundary matters.

For complex designs that affect multiple use cases or feature areas, include a
use cases table:

```markdown
| \[Problem\] | How | Notes |
| --- | --- | --- |
| Use case 1 |  |  |
| Use case 2 |  |  |
```

Leave the `How` column blank in early iterations where key decisions are not
finalized.

### Approach

Describe the strategy and high-level implementation plan. Break the plan into
more detail when the problem spans multiple modules, phases, or user-facing
states.

Always cover meaningful alternatives considered and their tradeoffs. If the
preferred approach is provisional, say what would confirm or change it.

Typically include one or more decision matrices for the most relevant
implementation decisions:

```markdown
| \[Problem\]) | Current state: ABC | DEF | GHI | JKL | Notes |
| --- | --- | --- | --- | --- | --- |
| Notes |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- |
| Criteria 1 |  |  |  |  |  |
| Criteria 2 |  |  |  |  |  |
```

Cell A1 is a succinct restatement of the problem the spec addresses. e.g. "Need
agent assistance writing specs." Header row cells are approaches with succinct names, starting with "Current state", if applicable, and ordered left-to-right by desirability, i.e. the proposed approach goes in column C.
Expand names or assumptions in the `Notes` row as needed. Criteria rows should
use qualitative aspects, not numeric scoring, unless the discussion already
established a scoring model.

## Output Standards

- Create or update the spec file; do not only summarize in chat unless the user
  asks for inline drafting.
- Keep the spec self-contained enough for another agent or developer to act on.
- Capture open questions explicitly when they block implementation decisions.
- Avoid implementation detail that is speculative or unrelated to the chosen
  approach.
- Aim for succinct and poignant.

# Credit

This skill is based on concepts and formatting in Rich Hickey's talk Design in
Practice https://download.clojure.org/presentations/DesignInPractice.pdf.
