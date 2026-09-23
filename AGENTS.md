# Working on dotfiles

This repository configures a personal macOS development machine. The checkout
may be linked into a live home directory, so tracked configuration edits can
immediately affect running applications. Read README.md when changing setup,
prerequisites, link targets, or local customization.

## Scope and workflow

- Keep edits focused and preserve personal themes, app choices, and package
  inventories unless there is evidence they are obsolete. The Homebrew lists
  include dependencies; being unfamiliar is not grounds for removal.
- Work on a dedicated branch in a new worktree under
  `~/dev/worktrees/dotfiles/<branch>/`. Never commit, push, or merge to `main`.
  Ask for permission before any merge.
- Save plans in `.claude/plans/` with three options where practical, their tradeoffs,
  and unresolved questions. This directory is intentionally ignored.
- Store local credentials in ignored `.env` files. Preserve local settings and
  generated data; never include credentials, caches, or machine logs in commits.

## Setup and shell changes

- `scripts/setup_dotfiles` is the sole setup entry point and owns the symlink
  mapping. Update the README mapping when changing targets.
- Keep setup compatible with macOS `/bin/bash` 3.2. Quote paths, resolve sources
  from the running checkout, and preserve idempotence and dry-run behavior.
- Preflight missing sources, blocked parents, and existing destinations before
  changing anything. Preserve conflicts through explicit `--backup`; never
  replace them with recursive deletion or an implicit force option.
- Link individual files for applications that share config directories with
  local state, especially Kitty, Zed, and VS Code. Keep the default tmux init in
  the repository; customization belongs in project or home `.tmux_init` files.
- Preserve source comments that identify theme provenance and cross-terminal
  palette relationships. Avoid vendoring plugins already installed externally.
- Add a shebang and short usage comment to new scripts, and mark runnable scripts
  executable. Document macOS-only dependencies in README.md.

## Validation and completion

- Check modified shell syntax first with its declared interpreter. Use ShellCheck
  for Bash/POSIX scripts; `.zshrc` and `scripts/list_branches` require zsh.
- Exercise symlink mutations only in temporary directories with `--home`. Check
  dry runs, reruns, existing files/directories, and dangling links when setup
  behavior changes. Do not repoint the live home directory during a review.
- Run the full suite through the `Dotfiles checks` GitHub Actions workflow, never
  locally. Local checks should stay limited to relevant files or specific cases.
  Follow the same restriction in Docker: run only relevant spec files locally.
- Finish with `git diff --check`, a review of every changed file, and a report of
  checks run, failures or untested behavior, and any machine-specific assumptions.
  Keep unrelated fixes out of a focused change.
