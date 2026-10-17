# B47ANCE'd Essentials Master Roadmap

Current version: `0.19.0`, governed by root `VERSION`.

## Implemented

- Proximity and equipped inventory views, device-owned menus, independent-hand
  classification, key filing, bounded sorting, bulk magazines, craft-output
  routing, hotbar ordering, map-symbol defaults, literature tracking, context-
  menu cleanup, exact watch clock, and realistic ladder interaction.
- powerWorks multi-cell device presentation and failure-isolated callbacks.
- CSR ownership/provenance audit.
- Version-gated compatibility-fix registry, verifier, and lifecycle process.
- Guided/in-game test and console session-boundary infrastructure.
- Bounded cycle-safe recursive inventory traversal with stable identities,
  deterministic ordering, access facts, and depth/container/item budgets.
- Canonical server batch-transfer transaction with revalidation, deduplication,
  rollback of uncertain native mutations, and committed ownership replication;
  existing sorting consumes this transaction.
- Exact actor-root and bounded nested-path inventory references for uiWorks
  storage presentation and authoritative item resolution without client-owned
  inventory state.
- A read-only nearby-root seam reusing only the real container buttons already
  admitted by vanilla's bounded loot-window discovery.
- Bounded loaded-vehicle container references using vanilla network vehicle IDs
  and stable part IDs, with streamed-out resolution failure.
- Corpse-container references using square coordinates plus synchronized object
  IDs and exact bounded static-object re-resolution.
- Bounded heavy-object capability observations and provider-owned,
  server-authoritative reserve/start/complete/cancel transaction phases with
  stable identity resolution, replay safety, persistence, and client transport.

## Still to add

- Camera/visibility behavior remains blocked pending a verified Lua-only path.
  The historical Java-bridge proposal is superseded by current policy and is
  not authorized implementation work. StairCast and PeekAView remain behavioral
  references only, not code or asset sources.

- Ear-protector listener effect that muffles only diegetic world audio after an
  isolated reversible Build 42 audio bus/filter is proven. The 42.20.3 audit is
  complete; implementation is blocked because the candidate bus/filter controls
  are Java-internal and neither Lua access nor the required routing exclusions
  are established.
- Production heavy-object providers and native movement/collision vertical slices;
  the orchestration contract deliberately implements no generic physics.
- Additional reference providers and uiWorks rendering of nearby, nested,
  categorized, equipped, expanded, and sorting views.

## Validation and release gates

- Prove audio exclusions, no AI-hearing/emission changes, transaction interruption,
  stale targets, cycles, provider removal, large inventories, save/load, hosted,
  and dedicated behavior.
