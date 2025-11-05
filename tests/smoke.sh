#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
tmpdir="$(mktemp -d)"
cleanup(){
  rm -rf "$tmpdir"
}
trap cleanup EXIT

(
  cd "$tmpdir"
  git init -q
  git config user.email wt@example.com
  git config user.name "WT Smoke Test"
  echo "smoke" > readme.txt
  git add readme.txt
  git commit -q -m "init"
  "$repo_root/wt" status >/dev/null

  if "$repo_root/wt" new feature extra 2>"$tmpdir/wt-new-extra.err"; then
    echo "expected wt new to fail with extra arguments" >&2
    exit 1
  fi

  mkdir -p .worktrees
  git worktree add -q .worktrees/feature.regex -b wt/feature.regex main
  "$repo_root/wt" rm --delete-branch feature.regex >"$tmpdir/wt-rm.log"
  [[ ! -d .worktrees/feature.regex ]]
  if git branch --list "wt/feature.regex" | grep -q "wt/feature.regex"; then
    echo "wt rm --delete-branch did not delete wt/feature.regex" >&2
    exit 1
  fi

  git worktree add -q .worktrees/archive -b wt/archive main
  (
    cd .worktrees/archive
    echo "archived" > data.txt
    git add data.txt
    git commit -q -m "archive"
  )
  "$repo_root/wt" archive archive >"$tmpdir/wt-archive.log"

  git checkout -q wt/archive
  echo "after" > later.txt
  git add later.txt
  git commit -q -m "advance"
  git checkout -q main

  if "$repo_root/wt" restore archive >"$tmpdir/wt-restore.log" 2>"$tmpdir/wt-restore.err"; then
    echo "expected wt restore to fail when wt/archive advanced" >&2
    exit 1
  fi
  [[ ! -d .worktrees/archive ]]
  if ! grep -q "has commits not in archive bundle" "$tmpdir/wt-restore.err"; then
    echo "wt restore error message missing non-fast-forward guidance" >&2
    exit 1
  fi

  "$repo_root/wt" restore --force archive >"$tmpdir/wt-restore-force.log"
  [[ -d .worktrees/archive ]]
  (
    cd .worktrees/archive
    [[ ! -f later.txt ]]
    git rev-parse --verify wt/archive >/dev/null 2>&1
  )

  rm -rf .worktrees .wt_archives
)

echo "smoke test passed"
