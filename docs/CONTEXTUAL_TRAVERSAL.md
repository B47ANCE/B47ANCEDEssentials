# Contextual window and ladder traversal

## Status and ownership

Accepted development contract. Contextual input and pre-fall interception are
not implemented yet. `LadderInteraction.lua` recognizes verified property-based
ladder transitions, exposes `Ladder → Climb Ladder`, and routes contextual
ascent/descent through one resolver with execution-time revalidation and the
native sheet-rope action. This is not evidence that automatic movement or Space
traversal already works.

B47ANCEDEssentials owns the shared transition resolver, initiation, input and native
traversal integration. M.O.R.T.I.S. optionally supplies physical capabilities;
B47ANCEDEssentials must function without it and must not duplicate anatomy. No new
required dependency is introduced. Nightfall and its connected release suite
are currently frozen for testing; independent B47ANCEDEssentials development may
continue only where the native interaction seam and intended behavior are proven.

## Exact input contract

| Context | Movement intent | Space at valid transition |
| --- | --- | --- |
| Short fence | Preserve vanilla Shift/run auto-vault | Preserve vanilla behavior |
| Valid climbable window | Shift/run + movement initiates native climb-through | Native climb-through |
| Ladder approached from below | Shift/run + movement mounts and ascends | Mount and ascend |
| Aligned ladder at upper edge | Normal movement mounts and descends; Shift/run explicitly bypasses mounting and permits ordinary running/falling | Deliberately mount and descend |

Every recognized ladder transition also has a discoverable fallback:

```text
Ladder
└─ Climb Ladder
```

The resolver infers ascent from below and descent from an aligned native top
transition. Separate up/down labels are not exposed. Decorative objects never
receive this menu merely because they resemble ladders.

Respect configurable run/sprint control state rather than assuming a fixed
keyboard code. No activation mode or context-menu-only requirement. Space is
intercepted only for an immediately valid contextual window/ladder; otherwise
retain vanilla behavior, including shove. Coordinate this priority with planned
[independent-hand combat](INDEPENDENT_HAND_COMBAT.md).

## Resolver and geometry

One resolver derives NONE, SHORT_FENCE, WINDOW, LADDER_UP or LADDER_DOWN from
origin, movement/facing, the specific crossed edge, object orientation, window
state, ladder continuity, destination, Z-level, obstructions, capabilities and
movement modifiers. Share validation/initiation/cancellation logic, not necessarily
the same animation between horizontal windows and vertical ladders.

Automatic movement, Space, and the explicit context menu are input sources only.
They must all call the same resolver/request pipeline; none may contain a private
climb implementation. Selection from an already-open menu re-resolves the
transition so a removed ladder, blocked destination, changed origin, busy or
incapacitated character, or changed direction is rejected cleanly.

Upper-ladder interception must occur before native fall resolution. Only the
crossed edge exactly aligned with the ladder qualifies. No sideways magnetic
snapping, adjacent-edge guard rail, or teleporting a falling player back upward.
Run bypass is part of the same transition decision, not a later timing check.

Identify ladders by native properties, then tile/object metadata, then explicit
registration, with curated mappings only when necessary. Decorative resemblance
is insufficient. Provide third-party orientation/geometry metadata; permit
future player-built ladders without assuming construction recipe ownership.

Support continuous multi-Z paths with bounded segment checks. A temporary
one-level limitation must be explicit, not embedded in the architecture.

## Native behavior and execution

Reuse native window validation, climb states, animation, glass injury,
obstruction and completion. Respect closed/locked, smashed, glass, barricades,
curtains where relevant and blocked destinations. No automatic opening,
smashing or glass removal is authorized by this feature.

Research sheet-rope/vertical states for ladders. Do not implement position-setter
teleports or a duplicate movement system when native actions can be reused.
Revalidate object existence, origin, destination, geometry and character
capability when executing, not just during client detection.

Handle injury, attacks, death, knockdown, cancellation, destroyed ladders,
new destination blockers and network correction without leaving a player between
levels or inside a wall. Preserve native hand/equipment restrictions; lower or
stow weapons through proper actions where necessary. Test dual-pistol, dual-melee,
mixed and single-weapon configurations without combat intercepting climbing.

## Authority, performance and configuration

Server validates gameplay transitions, origin/destination, object state,
orientation, exact edge, capability, run bypass, obstruction and final position.
Prediction may smooth visuals, never grant client-authoritative Z changes.

Use bounded input/movement-triggered local queries and cached static metadata,
not world-wide per-frame scans. Keep existing feature toggles and expose new
convenience behavior centrally, with local input preferences in normal controls.

## Research sequence and current gaps

The [native traversal audit](NATIVE_TRAVERSAL_AUDIT.md) records verified action
reuse points, the installed-game fingerprint, and unresolved input/pre-fall
authority gates. Automatic traversal is not enabled by that research pass.

1. Audit native short-fence Shift/run initiation and configurable input mapping.
2. Audit window validation, initiation, states and Space/shove dispatch.
3. Audit edge crossing/falling order and a genuine pre-fall interception point.
4. Audit ladder metadata and sheet-rope/vertical animation/lock behavior.
5. Extend the implemented ladder resolver to Space/run window initiation; regress fences.
6. Validate oriented ladder ascent, upper-edge descent and reliable run bypass.
7. Add capability integration, authoritative revalidation, interruption handling,
   diagnostics and third-party registration; test multi-Z and equipped weapons.

The current ladder adapter mutates only exact transition-square climb/top/barrier
properties while preparing native traversal. Shared sprite metadata is no longer
mutated during discovery. Before reusing preparation for movement, audit property
ownership, removal/reversion, continuity, landing obstruction and server
synchronization. Do not blindly promote menu-time preparation into a global hook.

## Acceptance and inspection

Test window run/Space initiation and invalid-window rejection; lower-ladder
run/Space ascent; upper-ladder walking descent, deliberate Space descent and
reliable run/fall bypass; misaligned/adjacent edges remaining ordinary edges;
and the opposite run semantics at windows versus upper ladders. Regress vanilla
walking/falling, fences, climbing and Space actions.

Also require authoritative two-client traversal, optional M.O.R.T.I.S. incapable
character rejection, interruptions, destroyed/blocked transitions, equipped-hand
combinations and multi-level continuity before claiming support.

Context-menu acceptance additionally requires the nested menu from below and
above, one `Climb Ladder` label, execution-time rejection after obstruction, and
equivalence with future Space/automatic entry through the resolver—not merely
equivalent final coordinates.

Developer inspection must show origin square/Z, facing and movement, active run
state, resolved transition/object/orientation, destination/Z, alignment,
obstruction, capability, eligibility and explicit rejection/bypass reason.
