Text generation style
- Never add emoji to any text without an explicit requirement from the user.

Source control
- Use `gh` CLI if you need any information about the remote repo, to create and
  view PRs, monitor workflow runs, etc.
- Merge feature branches with `gh pr merge NUMBER --rebase`, but ask the user.

Python
- When creating scripts in absence of a proper Python project, embed
  dependencies using PEP 723 inline script metadata.
