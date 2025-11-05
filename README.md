# wt

`wt` is a single-file helper that makes Git worktrees nicer to use. It wraps the
core `git worktree` subcommands with shortcuts for creating, switching, pruning,
archiving, and restoring temporary worktrees that you keep under
`<repo>/.worktrees`.

## Features

- `wt new my-feature` clones `origin/main` (or another base) into
  `.worktrees/my-feature`, creates a `wt/my-feature` branch, and drops you into a
  shell in the new worktree.
- `wt status` shows a compact status for every worktree in the repo.
- `wt rm`, `wt archive`, and `wt restore` help you clean up branches and worktree
  directories after a feature is done.
- Optional hooks let you run automation after creating, archiving, or restoring
  worktrees.

## Installation

### Homebrew (recommended once a release is published)

1. Tap the repo:
   ```bash
   brew tap nrempel/tap https://github.com/nrempel/homebrew-tap.git
   ```
2. Install the cask:
   ```bash
   brew install --cask wt
   ```

### Manual install

```bash
curl -L https://github.com/nrempel/wt/releases/latest/download/wt -o /usr/local/bin/wt
chmod +x /usr/local/bin/wt
```

### From source

```bash
git clone https://github.com/nrempel/wt.git
cd wt
make install PREFIX=/usr/local
```

## Usage

```
wt new <name> [-b base]           Create worktree .worktrees/<name> from base (default: origin/main)
wt ls                              List worktrees (path, branch, head)
wt switch <name|path>              Replace current shell with selected worktree
wt status [<name|path>]            Show git status for one or all worktrees
wt rm  [-f|--force] [--delete-branch|--purge] <name|path>
                                   Remove a worktree; optionally delete its branch:
                                     --delete-branch  delete if safe (not checked out, not ahead, merged to base)
                                     --purge          delete branch regardless (dangerous)
wt archive <name|path>             Tag + bundle branch, write diff (vs main), then remove the worktree
wt restore <name>                  Re-create branch+worktree from newest bundle (or tag if no bundle)
wt prune                           Prune stale worktrees
wt help                            Show this help
```

More detailed docs are in [`docs/`](docs/).

## Development

1. Install dependencies used for checks:
   ```bash
   brew install shellcheck shfmt
   ```
2. Run the checks:
   ```bash
   make lint
   ```
3. Submit a PR on GitHub.
4. Package new versions with `make release VERSION=X.Y.Z` before cutting a release.

## License

The project is licensed under the MIT License. See [LICENSE](LICENSE).
