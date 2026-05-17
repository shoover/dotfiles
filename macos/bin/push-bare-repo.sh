#!/bin/bash
# Push the current git repo to a new bare remote.
#
# Creates a bare remote repository over SSH, adds it as a remote, and pushes the
# current repo.
#
# Usage:
#   push-bare-repo.sh HOST DEPOT_PATH [REMOTE]
#   From a local git repo named my-repo, running this command:
#     push-bare-repo.sh my-desktop "/Users/me/data/depot" origin
#
#   Will create this repo on the host:
#     /Users/me/data/depot/my-repo.git

set -euo pipefail

usage() {
  printf 'Usage: %s HOST DEPOT_PATH [REMOTE]\n' "$(basename "$0")" >&2
  exit 2
}

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
  usage
fi

HOST=$1
DEPOT=$2
REMOTE=${3:-origin}

for arg in HOST DEPOT REMOTE; do
  if [ -z "${!arg}" ]; then
    printf 'Error: %s must not be empty\n' "$arg" >&2
    usage
  fi
done

shell_quote() {
  printf "'%s'" "$(printf '%s' "$1" | sed "s/'/'\\\\''/g")"
}

git_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
  echo "Not inside a Git repository" >&2
  exit 1
}

REPO=$(basename "$git_root")
BRANCH=$(git branch --show-current)

if [ -z "$BRANCH" ]; then
  echo "Cannot push from detached HEAD; check out a branch first" >&2
  exit 1
fi

if git remote get-url "$REMOTE" >/dev/null 2>&1; then
  printf 'Remote already exists: %s\n' "$REMOTE" >&2
  exit 1
fi

REMOTE_REPO=$DEPOT/$REPO.git
REMOTE_REPO_Q=$(shell_quote "$REMOTE_REPO")
BRANCH_Q=$(shell_quote "$BRANCH")

ssh "$HOST" "
  if [ -e $REMOTE_REPO_Q ]; then
    printf 'Bare repository already exists: %s\n' $REMOTE_REPO_Q >&2
    exit 1
  fi

  git init --bare --initial-branch $BRANCH_Q $REMOTE_REPO_Q
"
git remote add "$REMOTE" "$HOST:$REMOTE_REPO"
git push --set-upstream "$REMOTE" "$BRANCH"
