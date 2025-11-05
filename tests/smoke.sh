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
  echo "smoke" > readme.txt
  git add readme.txt
  git commit -q -m "init"
  "$repo_root/wt" status >/dev/null
)

echo "smoke test passed"
