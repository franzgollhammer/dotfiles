# AGENTS.md

## Purpose
- This repository stores personal dotfiles and machine setup configuration.
- Keep changes small, reviewable, and safe to apply on a live system.

## Working Rules
- Prefer minimal, surgical edits over broad refactors.
- Preserve existing file layout unless a change clearly improves maintainability.
- Do not commit secrets, tokens, private keys, or machine-specific credentials.
- Favor portable shell where practical; call out macOS-only behavior when used.
- When changing shell scripts, prefer idempotent commands so reruns are safe.

## Repository Conventions
- Keep documentation close to the relevant config when possible.
- For new scripts, use descriptive names and include a short usage comment at the top.
- Avoid adding generated files, caches, or local machine artifacts to the repo.

## Validation
- For shell changes, run the narrowest relevant check first.
- If a formatter or linter already exists for the changed area, use it.
- Do not fix unrelated breakages while completing a focused task.

## Safety
- Flag destructive operations before making them.
- Treat symlink management, bootstrap scripts, and system preference changes as high impact.
- When a change is machine-specific, document the assumption in the final response.
