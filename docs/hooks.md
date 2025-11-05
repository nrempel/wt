# Hooks

`wt` looks for executable files under `<repo>/.wt_hooks/<event>/*` after certain
commands and runs them in order.

For each hook, the following environment variables are set:

| Variable   | Description                                 |
|------------|---------------------------------------------|
| `WT_EVENT` | The event name (`post-new`, `post-archive`, `post-restore`) |
| `WT_ROOT`  | Absolute path to the repository root         |
| `WT_PATH`  | Absolute path to the worktree                |
| `WT_BRANCH`| Branch checked out in the worktree           |
| `WT_NAME`  | The logical worktree name (e.g. `my-feature`)|
| `WT_BASE`  | Base ref used when creating the worktree     |

Example: run tests automatically after creating a new worktree.

```bash
mkdir -p .wt_hooks/post-new
cat > .wt_hooks/post-new/run-tests <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
cd "$WT_PATH"
make test
EOF
chmod +x .wt_hooks/post-new/run-tests
```
