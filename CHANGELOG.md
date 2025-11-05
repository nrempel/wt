# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

## [0.1.1] - 2025-11-05

- Fix `wt restore` to handle diverged `wt/<name>` branches gracefully and add a `--force` flag.
- Reject stray positional arguments passed to `wt new`.
- Make `wt rm --delete-branch` treat branch names literally when checking other worktrees.
- Allow the release packaging script to fall back to `sha256sum` when `shasum` is unavailable.
- Expand smoke tests to cover archive/restore and branch deletion flows.

## [0.1.0] - 2024-11-05

- Initial public release of `wt` as a standalone project.
