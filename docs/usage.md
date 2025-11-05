# Usage

This document expands on the built-in help for `wt`.

## `wt new`

```bash
wt new <name> [-b base]
```

- Creates `<repo>/.worktrees/<name>`.
- Creates a new branch `wt/<name>`.
- Uses the first available base ref from `origin/main`, `origin/master`,
  `main`, or `master` unless you pass `-b <ref>`.
- Runs `git fetch` before verifying the base so you get the latest remote tip.
- Drops you into an interactive shell inside the new worktree.

## `wt ls`

Lists every worktree with its branch and head.

## `wt switch`

Switches the current shell into an existing worktree (by name or path).

## `wt status`

- With no arguments, prints the status for every worktree.
- With an argument, limits the output to that worktree.

## `wt rm`

Removes the worktree directory. For branches starting with `wt/` you can add:

- `--delete-branch`: delete if it is safe (not checked out elsewhere, not ahead
  of upstream, merged into `origin/main` when present).
- `--purge`: delete the branch regardless of state.

## `wt archive`

- Optionally writes a diff from `origin/main` into `.wt_archives`.
- Tags the head as `archive/<worktree>-<timestamp>`.
- Creates a bundle named `branch-timestamp.bundle`.
- Removes the worktree.

## `wt restore`

Recreates a worktree from the most recent archive bundle or tag with the given
name.

## Hooks

Executable scripts in `<repo>/.wt_hooks/<event>/*` run after selected commands:

- `post-new`
- `post-archive`
- `post-restore`

See [docs/hooks.md](hooks.md) for details.
