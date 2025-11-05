# wt

`wt` is a single-file command that makes Git worktrees feel lightweight and disposable. It wraps core `git worktree` sub-commands with shortcuts for creating, switching, pruning, archiving, and restoring working directories that live under `<repo>/.worktrees`.

## Why wt?
- Spin up a new worktree and branch with one command (`wt new feature-x`).
- Jump between worktrees without losing shell history (`wt switch`).
- Keep your repository tidy with safe branch clean-up, archiving, and restore helpers.
- Drop in executable hooks to automate project-specific workflows after creating, archiving, or restoring worktrees.

## Requirements
- Git 2.38 or newer (worktree features used here landed in that era).
- macOS or Linux with a POSIX-compatible shell (bash, zsh, or sh).

## Installation

### Homebrew (macOS / Linux)
```bash
brew tap nrempel/tap https://github.com/nrempel/homebrew-tap.git
brew install --cask wt
```
`brew upgrade --cask wt` will keep you on the latest release.

### Manual download (pinned release)
```bash
VERSION=0.1.1
curl -L "https://github.com/nrempel/wt/releases/download/v${VERSION}/wt-${VERSION}.zip" -o "wt-${VERSION}.zip"
curl -L "https://github.com/nrempel/wt/releases/download/v${VERSION}/wt-${VERSION}.zip.sha256" -o "wt-${VERSION}.zip.sha256"
shasum -a 256 --check "wt-${VERSION}.zip.sha256"   # use sha256sum --check on Linux
unzip "wt-${VERSION}.zip"
install -m 0755 wt /usr/local/bin/wt
```
Replace `VERSION` with the tag you want to install, and adjust the destination path if you prefer another directory on your `PATH`.

### From source
```bash
git clone https://github.com/nrempel/wt.git
cd wt
make install PREFIX=/usr/local
```

## Quick start
`wt new` replaces the current shell with one rooted in the freshly created worktree.
When you are done hacking, exit that shell to return to the previous worktree.

```bash
wt new feature-x          # create .worktrees/feature-x from origin/main and exec into it
# ...work in the new tree...
exit                      # return to the original shell
wt status                 # show git status for every worktree
wt rm --delete-branch feature-x
```

To preserve work, archive before deleting:
```bash
wt archive feature-x      # bundle branch, write diff vs origin/main, remove worktree
wt restore feature-x      # recreate branch + worktree from the newest archive bundle
wt restore --force ...    # reset wt/feature-x even if it advanced after archiving
```

## Command reference
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
wt restore [--force] <name>        Re-create branch+worktree from newest bundle (or tag if no bundle)
wt prune                           Prune stale worktrees
wt help                            Show this help
```
More background and examples live in [`docs/`](docs/).

## Hooks
Executable files in `<repo>/.wt_hooks/{post-new,post-archive,post-restore}/*` run after the corresponding command. Hooks receive helpful environment variables such as `WT_ROOT`, `WT_PATH`, and `WT_BRANCH`; see [`docs/hooks.md`](docs/hooks.md) for details.

## Development
1. Install tooling:
   ```bash
   brew install shellcheck shfmt
   ```
2. Run the checks:
   ```bash
   make lint
   make test
   ```
3. Package a new release:
   ```bash
   make release VERSION=X.Y.Z
   ```
   This writes `dist/wt-X.Y.Z.zip` and its SHA256 alongside the standalone script.
4. Follow the publishing guide in [`docs/publishing.md`](docs/publishing.md) to tag and update the Homebrew tap.

Contributions via pull requests are welcome—open an issue if you want to discuss ideas first.

## License
`wt` is distributed under the MIT License. See [LICENSE](LICENSE) for the full text.
