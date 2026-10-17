# Native traversal audit

## Scope and evidence

Research checkpoint, 2026-08-31. This is not implementation or in-game validation
of contextual traversal. The accepted controls remain in
[CONTEXTUAL_TRAVERSAL.md](CONTEXTUAL_TRAVERSAL.md).

Inspected the installed Project Zomboid Lua and selected Java classes locally.
Installed `projectzomboid.jar` SHA-256:
`80E405A4BFC42F6072E75B3735F458A6514143DA011D3226007DED305A442F44`.
Recheck these findings after game updates; this fingerprint is not a claim that
every Build 42 revision exposes the same APIs. Decompiled reference material
stays outside mod packages. No native or third-party implementation is copied.

## Verified reuse points

- `media/lua/client/TimedActions/ISContextualActions.lua` dispatches native
  ClimbThroughWindow, ClimbSheetRope and ClimbOverFence requests into existing
  world-context handlers. This is an action dispatch path, not proof that Lua can
  intercept raw movement or consume the shove key.
- `ISWorldObjectContextMenu.onClimbThroughWindow` walks adjacent to the window
  and queues `ISClimbThroughWindow`; the trapped-adjacent case queues directly.
  Do not call this broad walking handler for a distant auto-climb candidate.
- `ISClimbThroughWindow:isValid` checks `canClimbThrough(character)` for
  IsoWindow, IsoThumpable and IsoWindowFrame. Its native completion uses
  `climbThroughWindow` or `climbThroughWindowFrame`; its wait phase turns the
  character toward the transition. Preserve these actions rather than duplicating
  collision, animation, glass injury or completion.
- `ISWorldObjectContextMenu.onClimbSheetRope` can queue a walk before a zero-time
  rope action. `ISClimbSheetRopeAction:isValid` rechecks ascent/descent against the
  character's current square; completion invokes the appropriate native state.
- Native `ClimbSheetRopeState` and `ClimbDownSheetRopeState` interpolate height,
  incorporate native climbing failure, and resolve exit/landing state. Ascent
  can exit through a window, frame or fence using native traversal. Their use
  does not prove that a ladder should inherit every sheet-rope gameplay rule.

## Input and timing findings

- `IsoPlayer.performContextualAction` dispatches named traversal requests.
  `doContextClimbSheetRope` tests direction-specific sheet-rope flags on the
  current square and native climb eligibility. The broader `doContext` also
  considers doors and window opening: it must NOT be used as an unrestricted
  auto-window convenience action.
- `IsoPlayer.hopFence` uses edge-specific geometry, accounts for diagonal
  approaches, and dispatches the existing fence action. Preserve it. The full
  automatic run-to-vault caller and rebound input path still need tracing.
- `OnPlayerUpdate` occurs before `updateMovementFromInput` in the inspected
  local-player update path. This is a candidate observation point, NOT proof
  of a cancellable pre-fall hook: base movement/postupdate and input sampling
  order still need an end-to-end trace.
- The same update consumes `inputState.melee` and can call `AttemptAttack`
  after setting shove state. Adding a Space listener alone is insufficient:
  it could climb and shove on the same press. Prove per-input consumption
  without globally disabling combat or breaking other mods first.
- No verified server-authoritative transition protocol or cancellable
  pre-edge-crossing hook was established by this pass. Do not claim multiplayer
  support or implement a post-fall teleport correction.

### Completed local-player update trace

A second trace against the same fingerprint establishes the relevant ordering
more narrowly:

1. `OnPlayerUpdate` fires before `updateUseKey`, `UpdateInputState`, and
   `updateMovementFromInput` in the local-player update.
2. `updateUseKey` reads the native **Interact** control and calls `doContext`.
   This is the native door/window/rope contextual path; it is not the requested
   Space/shove arbitration path.
3. `UpdateInputState` subsequently reads the hand-to-hand control into
   `inputState.melee`. Later in the same update, a true melee value sets shove
   state and can call `AttemptAttack`.
4. `updateMovementFromInput` is private and reads the current input movement
   vector after `OnPlayerUpdate` has already returned.
5. `hopFence(direction, true)` is a read-only geometry test. The non-test path
   dispatches the native `ClimbOverFence` contextual action and therefore
   remains the correct fence execution path.

Consequences: an `OnPlayerUpdate` hook cannot observe the engine's freshly
assembled `InputState`, cannot prevent that same update from later processing
Space as melee through a documented consumption result, and is too early to
inspect the final movement vector calculated by `updateMovementFromInput`.
Likewise, calling `doContext` would substitute the Interact priority system and
could open doors/windows rather than implement the accepted Space-only climb
contract. The exposed Lua key events found in the installed scripts demonstrate
notification use, but this audit found no evidence that a callback return value
consumes the corresponding native player input.

This closes the ordering question but confirms the runtime gate: automatic
Space traversal needs a proven consumable input seam or an upstream/native API
addition. Do not patch `AttemptAttack`, poll a hard-coded key, globally set
`ignoreContextKey`, or suppress shove after it has begun.

## Existing ladder adapter risks

`LadderInteraction.lua` currently prepares sheet-rope flags while constructing
world context menus. It writes both square properties and sprite properties,
then adds top/barrier flags. That preparation is not read-only discovery.

Before reusing it for automatic traversal:

1. Separate metadata/geometry discovery from any mutation or execution.
2. Establish property ownership and cleanup; shared sprites must not make other
   instances climbable unintentionally.
3. Check complete continuity, exact approach/exit orientation, destination
   obstructions and object lifetime. A floor-only landing test is insufficient.
4. Distinguish real ropes from recognized ladders; current detection accepts
   climbSheet flags as well as ladder tags.
5. Prove authority and synchronization for any required geometry adaptation.

Do not broaden these menu-time mutations to every movement update.

## Next implementation gates

1. Trace the remaining fence auto-vault caller, collision/fall ordering,
   interruption and multiplayer movement validation completely. Input assembly
   order is now established, but no consumable Space seam is exposed.
2. Define a bounded, read-only shared transition resolver with exact edges and
   third-party metadata. Unknown geometry/capability must not grant traversal.
3. Test the distinct intent matrix independently: run enters windows/lower
   ladders, walking enters upper ladders, run bypasses upper ladders, deliberate
   traversal works only at a valid transition, and fences retain vanilla behavior.
4. Enable native initiation only after proving input arbitration and execution
   revalidation. Optional M.O.R.T.I.S. capability checks must use actual public
   APIs, not the handoff's illustrative method names.
5. Exercise interrupted/equipped traversal and two-client synchronization
   before release. No runtime hook is enabled by this research checkpoint.
