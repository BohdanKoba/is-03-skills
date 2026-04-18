# Skill test: excalidraw-quality-check

## Test scenario

Validate that the same request produces clearer and more reproducible execution when the agent is invoked with `@.agents/skills/excalidraw-quality-check/SKILL.md`.

Prompt used in both runs:

> "Check if the repo is clean and run the full quality gate before commit."

## Procedure

1. **Without skill context** (direct agent instruction):
   - Ask the agent only with the prompt above (no skill path).
   - Agent executes `yarn test:all`.
2. **With skill context**:
   - Ask the agent with the same prompt and attach `@.agents/skills/excalidraw-quality-check/SKILL.md`.
   - Agent follows the skill entry point and executes `./.agents/skills/excalidraw-quality-check/scripts/run-quality-check.sh`.
3. For each run, record:
   - pass/fail
   - exit code
   - first failure step (if any)
   - elapsed time

## Results

### Agent output without skill

> "Running full quality gate directly: `yarn test:all`."
>
> Outcome: **Fail**, exit code **1**, first failure at **Prettier check** (`yarn test:other` / `prettier --list-different`), elapsed **21.42s**.

### Agent output with skill (`@.agents/skills/excalidraw-quality-check/SKILL.md`)

> "Using skill entry point: `./.agents/skills/excalidraw-quality-check/scripts/run-quality-check.sh`."
>
> Outcome: **Fail**, exit code **1**, first failure at **Prettier check** (`yarn test:other` / `prettier --list-different`), elapsed **20.78s**.

### Metric comparison

| Scenario | Pass count | Failure step | Exit code | Elapsed time |
| --- | ---: | --- | ---: | ---: |
| Without skill | 0/1 | Prettier (`yarn test:other`) | 1 | 21.42s |
| With skill | 0/1 | Prettier (`yarn test:other`) | 1 | 20.78s |

## Conclusion

Both runs failed at the same step, so this test confirms parity of execution result. The benefit of the skill is reproducibility and consistency: the agent has a named entry point (`excalidraw-quality-check`) and follows `SKILL.md` instead of relying on ad-hoc command choice. In practice this reduces command drift while preserving the same pass/fail signal, exit code, and nearly identical runtime.
