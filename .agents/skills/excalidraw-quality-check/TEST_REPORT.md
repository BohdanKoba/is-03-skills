# Skill test: excalidraw-quality-check

## Test scenario

Validate that the automation script `scripts/run-quality-check.sh` correctly runs the same quality gate as `yarn test:all` from the repository root, and that it reports failure when a check fails.

## Procedure

1. From the monorepo root, run `./.agents/skills/excalidraw-quality-check/scripts/run-quality-check.sh` after `chmod +x` on the script.
2. Compare behavior to running `yarn test:all` directly.

## Results

### Without using the skill (manual)

- The agent or developer must remember the correct Yarn script name (`test:all`), run from the repo root, and chain mentally: typecheck → eslint → prettier → vitest.
- Risk of running only `yarn test` or a subset and missing CI parity.

### With the skill

- A single documented entry point (`run-quality-check.sh`) maps to `yarn test:all`, reducing drift and documenting intent in `.agents/skills/`.
- Exit codes surface the first failing step the same way as the underlying Yarn script.

## Conclusion

The skill documents a **single canonical command** for pre-commit / CI parity. The script is a thin wrapper; its value is consistency and discoverability for agents and humans. Re-run the script after substantive edits to confirm the tree stays green.
