# Skill test: excalidraw-quality-check

## Test scenario

Canonical write-up lives in `docs/skill-testing/excalidraw-quality-check.md`.
This file is a concise skill-local pointer plus concrete A/B artifacts.

Exact prompt used in both runs:

> "Check if the repo is clean and run the full quality gate before commit."

## Procedure

1. Run the prompt **without** skill context (agent chooses direct command path).
2. Run the same prompt **with** `@.agents/skills/excalidraw-quality-check/SKILL.md`.
3. Capture raw command/output snippets, exit code, failure step, and elapsed time.

## Results

### Without using the skill

Raw agent output (direct):

```text
Running full quality gate directly: yarn test:all
...
.agents/skills/community-doc-coauthoring/SKILL.md
.agents/skills/creating-excalidraw-components/SKILL.md
.agents/skills/excalidraw-quality-check/SKILL.md
.agents/skills/excalidraw-state-and-actions/references/action-patterns.md
.agents/skills/excalidraw-state-and-actions/SKILL.md
AGENTS.md
error Command failed with exit code 1.
real 21.42
```

Outcome: **Fail**, exit code **1**, first failure step **Prettier** (`yarn test:other`).

### With the skill

Raw agent output (via skill entry point):

```text
Using @.agents/skills/excalidraw-quality-check/SKILL.md
Executing: ./.agents/skills/excalidraw-quality-check/scripts/run-quality-check.sh
==> Excalidraw quality check (from /Users/bohdankoba/IdeaProjects/is-03-skills)
...
.agents/skills/community-doc-coauthoring/SKILL.md
.agents/skills/creating-excalidraw-components/SKILL.md
.agents/skills/excalidraw-quality-check/SKILL.md
.agents/skills/excalidraw-state-and-actions/references/action-patterns.md
.agents/skills/excalidraw-state-and-actions/SKILL.md
AGENTS.md
error Command failed with exit code 1.
real 20.78
```

Outcome: **Fail**, exit code **1**, first failure step **Prettier** (`yarn test:other`).

### Diff / highlights

- **Command path differs**: direct `yarn test:all` vs skill entry `scripts/run-quality-check.sh` (which invokes `yarn test:all`).
- **Failure signal identical**: both fail on Prettier list-different with exit code `1`.
- **Timing nearly identical**: 21.42s (without skill) vs 20.78s (with skill).

## Conclusion

The skill does not change test outcomes; it standardizes how the agent invokes the quality gate. This keeps execution reproducible through a named entry point while preserving the same pass/fail behavior.
