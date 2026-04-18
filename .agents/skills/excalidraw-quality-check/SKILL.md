---
name: excalidraw-quality-check
description: >-
  Runs the Excalidraw monorepo quality gate (TypeScript, ESLint, Prettier, Vitest)
  from the repository root. Use before commits, when CI fails, or when the user
  asks to verify the project builds cleanly.
---

# Excalidraw quality check

## Instructions

1. Run checks from the **repository root** (where `package.json` defines `test:all`).
2. **Preferred (full gate)**: execute the bundled script:

   ```bash
   ./.agents/skills/excalidraw-quality-check/scripts/run-quality-check.sh
   ```
   Keep this file executable in git so it works out-of-the-box after clone.

3. **Manual equivalent**: `yarn test:all` (runs typecheck, eslint, prettier check, then Vitest once).
4. **Faster loops**:
   - Types only: `yarn test:typecheck`
   - Lint only: `yarn test:code`
   - Format check: `yarn test:other`
   - Tests only: `yarn test:app --watch=false`
5. **Fix issues**: `yarn fix` (Prettier + ESLint autofix), then re-run the script or `yarn test:all`.
6. If the script is not executable, run `chmod +x .agents/skills/excalidraw-quality-check/scripts/run-quality-check.sh` once, then persist it in the repo index with `git update-index --chmod=+x .agents/skills/excalidraw-quality-check/scripts/run-quality-check.sh` so the executable bit ships by default.

The script exits with **0** when all steps pass and **non-zero** on the first failure.
