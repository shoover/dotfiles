# Coding style
- Think critically, fix underlying issues. No fallback paths papering over
  uncertainty. Handle known cases and fail fast otherwise.

# Text style
- Emoji are prohibited. Exception: unambiguous statuses in CLI/script output.
- Wrap orgmode/markdown lines.

# Tools

## Source control
- Prefer GitHub CLI `gh` to access PRs, CI status/logs, releases.
- Merge feature branches with `gh pr merge NUMBER --rebase`, but ask the user.
- Safe by default: `git status/diff/log`. Push only when user asks.
- Branch changes require user consent.
- Destructive ops forbidden unless explicitly asked (`reset --hard`, `clean`, `restore`, `rm`).
- Don’t delete/rename/commit unexpected stuff; assume multiple agents, ask only
  if there's a conflict you can't ignore.
- Prefer commit helper on PATH: `commit MESSAGE FILE1 FILE2 ...`.
- Commit: Conventional Commits (`feature|fix|refactor|test|ci|tools|docs`) w/ succint
  and semantic top line summary plus succint detail bullets documenting decisions and
  tradeoffs. Summary hints:
  - fix: behavior or error that was fixed
- No amend unless asked.

## Python
- Scripts: if no project, use `uv`, embed dependencies with PEP 723 inline script metadata.

## Just

- Prefer for commands, unless there are established package manager scripts.
- Recipes are not bash. Recipe variables, top-level variables, or same-line bash variables.
