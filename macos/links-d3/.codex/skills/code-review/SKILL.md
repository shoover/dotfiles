---
name: code-review
description: >-
  Review a pull request for scope alignment, code quality, style, and
  security. Use when the user provides a PR number, asks for a code
  review, or mentions reviewing changes against a Jira ticket.
---

# Code Review

## Input

The user provides one or both of:

- **PR number** -- the primary input. Refers to the current repo.
- **Jira ticket key** (e.g. `PROJ-123`) -- optional. If not
  provided, extract from the PR title, branch name, or description.

## Phase 1 -- Gather context

### Jira ticket

If a ticket key is available (provided or extracted from the PR):

1. Fetch the ticket via the Atlassian MCP (`get_issue` or
   equivalent). Read the summary, description, and acceptance
   criteria.
2. Summarize the **intended scope**: what the ticket asks for, what
   it explicitly excludes, and any acceptance criteria.

If no ticket key is found, skip and note that scope was evaluated
against the PR description only.

### PR details

Run these in parallel:

```
gh pr view NUMBER --json title,body,baseRefName,headRefName,labels,reviewDecision,commits
gh pr diff NUMBER
```

Read the PR description and commit messages to understand the
author's intent. If the diff is large, use `gh pr diff NUMBER
--name-only` first to identify affected areas, then read changed
files selectively.

### Repo context

Read key files (README, CONTRIBUTING, linter configs, AGENTS.md)
when they exist and are relevant. Use project rules and style
conventions already in context.

## Phase 2 -- Scope check

Compare the PR's changes against the ticket scope (or PR
description if no ticket).

Report:

- **Scope alignment**: does the implementation match the stated
  requirements?
- **Missing requirements**: acceptance criteria or ticket items not
  addressed by the diff.
- **Scope additions**: changes that go beyond the ticket. Flag as
  intentional cleanup vs. unrelated drift.

## Phase 3 -- Code review

Evaluate every changed file. For each issue found, assign a
severity:

| Rank | Label | Meaning |
|------|-------|---------|
| 1 | **Critical** | Bugs, data loss, security vulnerabilities, broken behavior. Must fix. |
| 2 | **Warning** | Logic risks, missing edge cases, test gaps, performance concerns. Should fix. |
| 3 | **Suggestion** | Style, naming, simplification, minor readability. Consider fixing. Suggest tooling improvements. |

### Quality

- Correctness: logic errors, off-by-one, nil/null handling, race conditions.
- Error handling: are failures surfaced, logged, or silently swallowed?
- Tests: are new/changed paths covered? Are existing tests invalidated?

### Style

- Adherence to project conventions (formatting, naming, file organization).
- Readability: unclear names, overly clever code, large functions.
- API design: public surface area, parameter choices, documentation.

### Security

- Input validation and sanitization.
- Authentication / authorization gaps.
- Secrets or credentials in code or config.
- Dependency risks (new or upgraded packages).

### Strengths

Explicitly call out what the PR does well: clean abstractions, good
test coverage, clear commit messages, thoughtful error handling.
Review is not only about problems.

## Output format

Structure the review as:

```
## Scope

[Jira issue key: Title]
[PR # (branch): Title]

[Scope alignment summary. Missing or extra items if any.]

## Summary

[One-paragraph overall assessment and recommendation:
approve / approve with minor fixes / request changes.]

## Strengths

[What the PR does well.]

## Issues

### Critical
- [file:line] Description of issue.

### Warning
- [file:line] Description of issue.

### Suggestion
- [file:line] Description of issue.

```

Omit empty severity sections. If the review is clean, say so.
