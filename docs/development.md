# Development Guide

## Prerequisites

- Git 2.38+
- `shellcheck` and `shfmt` for linting/formatting
- Either `shasum` (macOS) or `sha256sum` for creating release artifacts

## Setup

```bash
git clone https://github.com/nrempel/wt.git
cd wt
make install PREFIX=/usr/local   # optional
```

## Testing

`wt` is a shell script. Lightweight smoke tests are provided under `tests/`. Run
them via:

```bash
./tests/smoke.sh
```

You can extend this with additional scripts as needed.

## Releasing

1. Update `CHANGELOG.md`.
2. Tag a new release: `git tag -a vX.Y.Z -m "Release vX.Y.Z"`.
3. Push with tags: `git push origin main --tags`.
4. Run `make release VERSION=X.Y.Z` to build `dist/wt-X.Y.Z.zip` and its SHA.
5. Attach the ZIP from `dist/` to the GitHub release.
6. Update the Homebrew tap formula/cask with the new tag and checksum.
