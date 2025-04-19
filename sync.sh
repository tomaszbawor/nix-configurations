#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

git add -A

commit_msg="chore: update deps"

if ! git diff --cached --quiet; then
  git commit -m "$(commit_msg)"
  echo "Commited ..."
else
  echo "Nothing to commmit - workint tree clean"
fi

git push
