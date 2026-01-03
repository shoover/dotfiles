Text style
- Never add emoji to any text without an explicit requirement from the user.
- Wrap orgmode/markdown lines.

Source control
- Prefer GitHub CLI `gh` to access PRs, CI status/logs, releases.
- Merge feature branches with `gh pr merge NUMBER --rebase`, but ask the user.
- Safe by default: `git status/diff/log`. Push only when user asks.
- Branch changes require user consent.
- Destructive ops forbidden unless explicitly asked (`reset --hard`, `clean`, `restore`, `rm`).
- Don’t delete/rename unexpected stuff; assume multiple agents, stop + ask.
- Prefer commit helper on PATH: `commit MESSAGE FILE1 FILE2 ...`.
- No amend unless asked.

Python
- Scripts: if no project, embed dependencies with PEP 723 inline script metadata.
