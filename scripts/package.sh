#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 <version>" >&2
  exit 1
fi

version="$1"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
dist_dir="$repo_root/dist"

rm -rf "$dist_dir"
mkdir -p "$dist_dir"

cp "$repo_root/wt" "$dist_dir/wt"
chmod 755 "$dist_dir/wt"

(
  cd "$dist_dir"
  zip -r "wt-${version}.zip" wt >/dev/null
  shasum -a 256 "wt-${version}.zip" > "wt-${version}.zip.sha256"
)

echo "Artifacts written to $dist_dir:"
ls -1 "$dist_dir"
