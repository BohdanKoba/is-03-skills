---
name: excalidraw-state-and-actions
description: >-
  Guides changes to Excalidraw editor state via actionManager and AppState. Use
  when adding or modifying actions, reducers, or state fields in
  packages/excalidraw, or when debugging dispatch/update flows.
---

# Excalidraw state and actions

## Instructions

1. **Single path for updates**: All editor state changes go through `actionManager.executeAction(...)`. Do not introduce Redux, Zustand, MobX, or ad-hoc global stores.
2. **Read the types first**: Inspect `AppState` and related types in `packages/excalidraw/types.ts` (and nearby files) before adding fields or actions.
3. **Add an action**: Define the action in `packages/excalidraw/actions/` following existing patterns (naming, `perform`, `checked`, etc.). Register it with the action system the same way sibling actions are.
4. **Keep components dumb**: UI components receive state via props and report intent by dispatching actions; avoid mutating `AppState` outside the supported pipeline.
5. **Rendering boundary**: Scene drawing uses the Canvas pipeline (`renderScene`, etc.), not React DOM for canvas content—do not “fix” rendering by mixing paradigms.
6. **Tests**: Prefer Vitest + RTL; colocate tests as `*.test.tsx`. Run targeted tests with `yarn test:app --watch=false` and use the **excalidraw-quality-check** skill for full gates.

## References

- Action patterns and do/don’t notes: `references/action-patterns.md`

## Anti-patterns

- Direct mutation of state objects held in React props or scene data.
- Bypassing `actionManager` for “quick” fixes.
- Adding parallel state layers for editor concerns.

## Related

- Component UI patterns: **creating-excalidraw-components** skill.
- Repo-wide checks before merge: **excalidraw-quality-check** skill.
