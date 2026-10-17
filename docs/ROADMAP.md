# B47ANCE'd Essentials Roadmap

> Consolidated status: [MASTER_ROADMAP.md](MASTER_ROADMAP.md).

## Current boundary

B47ANCEDEssentials owns narrowly scoped vanilla-plus workflows. It may orchestrate
canonical actions and expose capability queries, but it does not own foreign
physics, inventory, terrain, animal, or vehicle state.

## Approved research additions

### Independent camera and visibility system

Historical research proposed a Java bridge for independently designed
StairCast/PeekAView-class behavior. That authorization is superseded by the
current Lua-only rule: no custom Java, bridge or JAR may be implemented or shipped.
The feature remains blocked until a safe Lua-only path is verified. StairCast
and PeekAView remain behavioral references only: do not copy their source,
assets, constants, schemas, algorithms or implementation structure. Preserve
earlier research as historical evidence rather than current authorization.

### Ear-protection audio muffling

When the local player actively wears `Base.Hat_EarMuff_Protectors`, reduce and
muffle only diegetic world audio they hear; immediately restore normal world audio
when removed. Jump scares, UI/clicks, menus, notifications, alerts, music, and
other non-diegetic presentation audio remain unchanged. This listener-local effect
must not change emitted sound radius, zombie/NPC hearing, stealth, health,
multiplayer state, or persistent user volume settings. Carrying the item and
cosmetic/on-neck variants do not qualify.

Implementation is gated on a verified reversible Build 42 audio bus/filter path
that isolates diegetic world audio from jump scares and other excluded channels.
If the engine exposes only broad or persistent global volume setters, stop rather
than changing excluded audio or rewriting player preferences. Exact eligibility,
lifecycle, compatibility, and regression requirements are in
[EAR_PROTECTION_AUDIO_HANDOFF.md](EAR_PROTECTION_AUDIO_HANDOFF.md).

The 42.20.3 source audit is complete and records a runtime implementation
blocker in [BUILD42_EAR_PROTECTION_AUDIO_AUDIT.md](BUILD42_EAR_PROTECTION_AUDIO_AUDIT.md):
the useful in-game bus and filter primitives are Java-internal, their routing
does not prove the required exclusions, and no supported listener-local Lua
control was found. Do not substitute broad settings-volume mutation.

### EXT-16 and EXT-17 — Heavy-object capability and transaction contract

Expose a bounded query returning stable target identity, provider, supported
push/pull/carry operations, current eligibility, and reason. Execution uses
provider-owned reserve/start/complete/cancel phases with exact actor/target/reach,
collision, contents, and authority revalidation. No generic physics engine or
unbounded nearby-object scan is permitted.

### EXT-21 — Recursive inventory traversal

Version 0.10.0 supplies the shared read-only traversal foundation: caller-provided
roots, explicit access callbacks, stable identity, deterministic ordering, cycle
detection, and bounded depth/container/item budgets. Containers without proven
access or stable identity fail closed. See [INVENTORY_TRAVERSAL.md](INVENTORY_TRAVERSAL.md).
Canonical mutation and runtime proof of Build 42 identity/access adapters remain
EXT-20 work and must revalidate access/weight at execution.

### EXT-20 support — Storage workflows

Version 0.11.0 supplies bounded traversal plus a canonical batch-transfer
transaction to uiWorks provider-driven views. Existing sorting now uses that
transaction. Automatic sorting remains a distinct server-authoritative request
and is never a side effect of opening or inspecting a container. Stable-reference
resolution for general client requests and native multiplayer proof remain.

Version 0.13.0 adds the reusable reference boundary: versioned exact world
container references, stable item-ID lookup within the resolved container, and
conflict-safe custom reference providers. Existing sorting now creates its world
reference through this canonical descriptor.

The same release now supplies that bounded transport API: 1–100 reference moves,
per-player operation-ID replay binding, authority-side resolution immediately
before the canonical transaction, capped server/client result histories, and
explicit outcome inspection. It is not invoked by opening storage and remains
implemented-but-unverified until hosted and dedicated tests prove native IDs,
streaming races, replication, retries, and reconnect behavior.

Version 0.14.0 adds the first live-owner reference provider: an exact actor-root
descriptor resolves only the requesting actor's root inventory and stable item
IDs. Nested containers remain closed until their parent-item path can be
represented and revalidated without ambiguity. This enables presentation; it
does not weaken authority or initiate transfers while browsing.

Version 0.15.0 extends that provider with a maximum-16-link nested container
path made only from native item IDs. Authority resolves each parent item and
child inventory again from the actor root; missing, moved, malformed, or
non-container links fail closed. No container indexes or object handles cross
the request boundary.

Version 0.16.0 exposes the deduplicated, unlocked real-container roots already
admitted by vanilla's loot-window buttons. Consumers receive no radius or world
scan API and must still obtain a canonical reference before presenting a root.

Version 0.17.0 adds exact loaded-vehicle storage references using the same
vehicle IDs used by vanilla network commands and stable vehicle-part IDs.
Resolution scans at most 4,096 loaded vehicles, then requires the exact part's
current item container. Streamed-out vehicles and removed parts fail closed.

Version 0.18.0 adds corpse references only when Build 42 supplies a nonnegative
object ID. The reference includes square coordinates and authority scans at
most 1,024 loaded static-moving objects on that exact square before verifying
the corpse's current container. Moved, removed, or streamed corpses fail closed.

### EXT-36 — CSR provenance audit

Map every inactive CSR behavior to its present owner, implementation, config/save
migration, duplicate-hook risk, and retirement state. Do not resurrect duplicate
handlers or error-masking compatibility shields. The complete audit is recorded
in `CSR_PROVENANCE_AUDIT.md`: no configuration migration is safe, four areas have
partial/current overlap, cross-domain behaviors are routed to their owners, and
the Lua/context compatibility shields are denied.

### EXT-37 — Version-gated fixes

Every compatibility fix requires a reproducible defect, affected Build range,
narrow owner/hook, capability probe, regression, conflict list, safe degradation,
and removal condition. No miscellaneous compatibility bundle is authorized. The
coordinated schema, verifier, tests, and lifecycle process are implemented in the
workspace `docs/generated/COMPATIBILITY_FIX_REGISTRY.json`,
`tools/verify_compatibility_fixes.py`, and `docs/COMPATIBILITY_FIX_PROCESS.md`.

## Proof order

1. Prove a reversible, listener-local Build 42 audio path for ear protectors; do
   not mutate persistent volume options.
2. Finish the CSR ownership/provenance matrix.
3. Specify read-only capability/traversal contracts.
4. Prove one canonical transaction/batch-action vertical slice.
5. Test interruption, stale targets, cycles, provider removal, and MP authority.
6. Add UI adapters only after stable read models exist.
