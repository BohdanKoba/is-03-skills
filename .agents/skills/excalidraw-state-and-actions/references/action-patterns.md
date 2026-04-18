# Excalidraw actions and state: patterns

Use this reference when implementing or debugging editor state changes.

## Defaults

- Prefer existing actions over adding new ones.
- Keep state changes inside `actionManager.dispatch(...)` flows.
- Keep UI components as intent emitters (dispatch actions) + renderers (read props).

## Adding a new AppState field

1. Add the field to `AppState` (and any derived types) with a safe default.
2. Ensure the default is applied when initializing state (follow nearby patterns).
3. Verify serialization/persistence implications (if the state is persisted).
4. If it affects rendering, verify it is passed down to where it is needed rather than being “re-fetched” ad-hoc.

## Adding a new action

- Name actions consistently with siblings in `packages/excalidraw/actions/`.
- Keep `perform` deterministic given its inputs; avoid reading ambient globals.
- If an action toggles behavior, prefer deriving `checked` from `appState`.

## Debugging dispatch/update issues

- Confirm the action is registered and reachable (same as sibling actions).
- Confirm the call site is actually dispatching (not mutating).
- Check whether your expected `AppState` field is present and initialized.
- If the bug is “UI didn’t update”, confirm the updated state is threaded to the component that renders it.

